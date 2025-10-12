create or replace function web_core_unauth_saml2_acs_inf.acs_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      sso_url
                    , sso_bnd_nm
                    , slo_url
                    , slo_bnd_nm
                    , idp_entity_id
                    , tnt_origin || acs_epp_pt acs_epp_pt
                    , s2c_entity_id
                    , array_agg(ipc_crt)       ipc_crt
                 from (
                          select
                                 sso.sso_url
                               , sso_bnd.bnd_nm                                                              sso_bnd_nm
                               , slo.slo_url
                               , slo_bnd.bnd_nm                                                              slo_bnd_nm
                               , idp.idp_entity_id
                               , acs_epp.epp_pt                                                              acs_epp_pt
                               , s2c.s2c_entity_id
                               , ipc.ipc_crt
                               , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                                              when '443' then ''
                                                                              when '80'  then ''
                                                                              else ':' || tnt.tnt_port::text
                                                                          end                                tnt_origin
                            from
                                           app_data.tenant                               tnt
                                      join app_data.web_app_user_saml2_config            s2c     on tnt.tnt_id    = s2c.tnt_id
                                      join app_data.endpoint                             acs_ep  on s2c.ep_acs_id = acs_ep.ep_id
                                      join app_data.endpoint_path                        acs_epp on acs_ep.epp_id = acs_epp.epp_id
                                      join app_data.saml2_identity_provider              idp     on tnt.tnt_id    = idp.tnt_id
                                      join app_data.saml2_identity_provider_sso_endpoint sso     on idp.idp_id    = sso.idp_id
                                      join app_data.saml2_endpoint_binding               sso_bnd on sso.bnd_id    = sso_bnd.bnd_id
                                      join app_data.saml2_identity_provider_certificate  ipc     on idp.idp_id    = ipc.idp_id
                                 left join (
                                                    app_data.saml2_identity_provider_slo_endpoint slo
                                               join app_data.saml2_endpoint_binding               slo_bnd on slo.bnd_id = slo_bnd.bnd_id
                                           )
                                        on (
                                                   slo.idp_id      = idp.idp_id
                                               and slo.slo_enabled = true
                                           )
                           where
                                 tnt.tnt_id      = p_tnt_id
                             and idp.idp_enabled = true
                             and sso.sso_enabled = true
                             and now()
                                       between
                                               ipc.ipc_inc_ts
                                           and
                                               ipc.ipc_exp_ts
                             and not exists (
                                                select
                                                       null
                                                  from
                                                       app_data.saml2_identity_provider_certificate_use cru
                                                 where
                                                       not exists (
                                                                      select
                                                                             null
                                                                        from
                                                                             app_data.saml2_identity_provider_certificate ipcil
                                                                       where
                                                                             ipcil.idp_id = idp.idp_id
                                                                         and ipcil.cru_id = cru.cru_id
                                                                         and now()
                                                                                   between
                                                                                           ipcil.ipc_inc_ts
                                                                                       and
                                                                                           ipcil.ipc_exp_ts
                                                                  )
                                            )
                      )
             group by
                      sso_url
                    , sso_bnd_nm
                    , slo_url
                    , slo_bnd_nm
                    , idp_entity_id
                    , tnt_origin
                    , acs_epp_pt
                    , s2c_entity_id
                    ;

        return $1;

end;
$$
language plpgsql
security definer;
