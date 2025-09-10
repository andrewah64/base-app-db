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
               ,   s2c_crt_dn
               ,   s2c_crt_cn
               ,   s2c_crt_org
               )
        select
               v_tnt_id
             , asm.aum_id
             , interval '1 year'
             , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                            when '443' then ''
                                                            when '80'  then ''
                                                            else ':' || tnt.tnt_port::text
                                                        end 
             , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                            when '443' then ''
                                                            when '80'  then ''
                                                            else ':' || tnt.tnt_port::text
                                                        end 
          from
                          app_data.tenant               tnt
               cross join app_data.web_atn_saml2_method asm
         where
               tnt.tnt_id       = v_tnt_id
           and asm.asm_s2c_dflt = true
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

end;
$$
language plpgsql
security definer;
