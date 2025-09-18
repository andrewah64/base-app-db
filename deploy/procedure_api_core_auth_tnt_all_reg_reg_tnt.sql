create or replace procedure api_core_auth_tnt_all_reg.reg_tnt
(
        p_tnt_nm   app_data.tenant.tnt_nm%type
,       p_tnt_prtc app_data.tenant.tnt_prtc%type
,       p_tnt_fqdn app_data.tenant.tnt_fqdn%type
,       p_tnt_port app_data.tenant.tnt_port%type
)
as
$$
declare

        v_tnt_id app_data.tenant.tnt_id%type    := 0;
        v_grp_id app_data.app_group.grp_id%type := 0;
        v_lng_id app_data.language.lng_id%type  := 0;

begin

           insert
             into
                  app_data.tenant
                  (
                      tnt_nm
                  ,   tnt_prtc
                  ,   tnt_fqdn
                  ,   tnt_port
                  )
           values
                  (
                      p_tnt_nm
                  ,   p_tnt_prtc
                  ,   p_tnt_fqdn
                  ,   p_tnt_port
                  )
        returning
                  tnt_id
             into
                  v_tnt_id
                ;

        insert
          into
               app_data.web_app_user_saml2_config
               (
                   tnt_id
               ,   aum_id
               ,   s2c_entity_id
               ,   ep_acs_id
               ,   ep_mtd_id
               )
        select
               tnt.tnt_id                                                                  tnt_id
             , asm.aum_id                                                                  aum_id
             , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                            when '443' then ''
                                                            when '80'  then ''
                                                            else ':' || tnt.tnt_port::text
                                                        end                                s2c_entity_id
             , epacs.ep_id                                                                 ep_acs_id
             , epmtd.ep_id                                                                 ep_mtd_id
          from
                          app_data.tenant               tnt
               cross join app_data.web_atn_saml2_method asm
               cross join (
                                   app_data.endpoint            epacs
                              join app_data.endpoint_path       eppacs on epacs.epp_id = eppacs.epp_id
                              join app_data.http_request_method hrmacs on epacs.hrm_id = hrmacs.hrm_id
                          )
               cross join (
                                   app_data.endpoint            epmtd
                              join app_data.endpoint_path       eppmtd on epmtd.epp_id = eppmtd.epp_id
                              join app_data.http_request_method hrmmtd on epmtd.hrm_id = hrmmtd.hrm_id
                          )
         where
               tnt.tnt_id       = v_tnt_id
           and asm.asm_s2c_dflt = true
           and eppacs.epp_pt    = '/web/core/unauth/saml2/acs'
           and hrmacs.hrm_nm    = 'POST'
           and eppmtd.epp_pt    = '/web/core/unauth/saml2/metadata.xml'
           and hrmmtd.hrm_nm    = 'GET'
             ;

        insert
          into
               app_data.web_app_user_saml2_cert_config
               (
                   tnt_id
               ,   s2g_crt_dn
               ,   s2g_crt_cn
               ,   s2g_crt_org
               )
        select
               tnt.tnt_id        tnt_id
             , interval '1 year' s2g_crt_dn
             , tnt.tnt_fqdn      s2g_crt_cn
             , tnt.tnt_nm        s2g_crt_org
          from
               app_data.tenant               tnt
         where
               tnt.tnt_id = v_tnt_id
             ;

        insert
          into
               app_data.web_app_user_password_config
               (
                   tnt_id
               )
        values (
                   v_tnt_id
               );

        insert
          into
               app_data.web_app_user_passkey_config
             (
                 tnt_id
             ,   aukc_aur_nm_min_len
             ,   aukc_aur_nm_max_len
             ,   aukc_enabled
             ,   pka_id
             ,   pkt_id
             ,   pdc_id
             ,   puv_reg_id
             ,   puv_atn_id
             )
        select
               tnt.tnt_id
             , 1
             , 10
             , true
             , pka.pka_id
             , pkt.pkt_id
             , pdc.pdc_id
             , puv.puv_id
             , puv.puv_id
          from
                          app_data.tenant                          tnt
               cross join app_data.passkey_attachment              pkt
               cross join app_data.passkey_attestation             pka
               cross join app_data.passkey_discoverable_credential pdc
               cross join app_data.passkey_user_verification       puv
         where
               tnt.tnt_id        = v_tnt_id
           and pkt.pkt_aukc_dflt = true
           and pka.pka_aukc_dflt = true
           and pdc.pdc_aukc_dflt = true
           and puv.puv_aukc_dflt = true
             ;

           insert
             into
                  app_data.app_group
                  (
                      tnt_id
                  ,   grp_nm
                  ,   grp_can_edt
                  ,   grp_can_del
                  ,   grp_aur_dflt
                  )
           values (
                      v_tnt_id
                  ,   'Admin'
                  ,   false
                  ,   false
                  ,   true
                  )
        returning
                  grp_id
             into
                  v_grp_id
                ;

        insert into app_data.app_group_db_role (grp_id, dbrl_id)
        select
               grp.grp_id
             , adr.dbrl_id
          from
                          app_data.app_group   grp
               cross join app_data.atn_db_role adr
         where
               grp.grp_id = v_grp_id
           and not exists (
                              select
                                     null
                                from
                                     app_data.app_group_db_role grpdr
                               where
                                     grpdr.grp_id  = grp.grp_id
                                 and grpdr.dbrl_id = adr.dbrl_id
                          );

        insert
          into
               app_data.endpoint_log_level
             (
                 tnt_id
             ,   ep_id
             ,   lvl_id
             )
        select
               tnt.tnt_id
             , ep.ep_id
             , lvl.lvl_id
          from
                          app_data.tenant    tnt
               cross join app_data.log_level lvl
               cross join app_data.endpoint  ep
         where
               tnt.tnt_id      = v_tnt_id
           and lvl.lvl_ep_dflt = true
             ;

        insert
          into
               app_data.oidc_client
             (
                 tnt_id
             ,   ocp_id
             ,   occ_url
             ,   occ_client_id
             ,   occ_client_secret
             ,   ep_id
             )
        select
               tnt.tnt_id
             , ocp.ocp_id
             , '<placeholder-' || ocp.ocp_nm::text || '-' || v_tnt_id::text ||'>'
             , '<placeholder-' || ocp.ocp_nm::text || '-' || v_tnt_id::text ||'>'
             , '<placeholder-' || ocp.ocp_nm::text || '-' || v_tnt_id::text ||'>'
             , ep.ep_id
          from
                          app_data.tenant        tnt
               cross join app_data.oidc_provider ocp
               cross join (
                                   app_data.endpoint      ep
                              join app_data.endpoint_path epp on ep.epp_id = epp.epp_id
                          )
         where
               tnt.tnt_id = v_tnt_id
           and epp.epp_pt = '/web/core/oidc/callback/{nm}'
             ;

        insert
          into
               app_data.oidc_client_provider_scope
               (
                   occ_id
               ,   ocp_id
               ,   ocs_id
               )
          select
                 occ.occ_id
               , ocps.ocp_id
               , ocps.ocs_id
            from
                            app_data.oidc_client         occ
                 cross join app_data.oidc_provider_scope ocps
           where
                 occ.tnt_id = v_tnt_id
             and not exists (
                                select
                                       null
                                  from
                                       app_data.oidc_client_provider_scope occps
                                 where
                                       occps.occ_id = occ.occ_id
                                   and occps.ocp_id = ocps.ocp_id
                                   and occps.ocs_id = ocps.ocs_id
                            );

        select
               lng.lng_id
                          into
                               v_lng_id
          from
               app_data.language lng
         where
               lng.lng_aur_dflt = true
             ;

        call web_core_auth_aur_tnt_reg.reg_aur
        (
            p_tnt_id     => v_tnt_id
        ,   p_grp_id     => v_grp_id
        ,   p_aur_nm     => 'superuser'
        ,   p_aur_hsh_pw => '$2a$10$wE2aVRUCinnDOqEOMApSHuEFh6yEG0FKRb1x5z.MkDlF.Uw9XtFQ6'
        ,   p_lng_id     => v_lng_id
        ,   p_by         => current_user
        );

end;
$$
language plpgsql
security definer;
