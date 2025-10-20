create or replace function web_core_auth_s2c_tnt_inf.s2c_inf
(
        refcursor
,       p_tnt_id  app_data.app_group.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    s2c.s2c_entity_id
                  , s2c.s2c_enabled
                  , s2c.aum_id
                  , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                                 when '443' then ''
                                                                 when '80'  then ''
                                                                 else ':' || tnt.tnt_port::text
                                                             end || eppacs.epp_pt               epp_acs_pt
                  , idp.idp_ok
                  , s2c.uts
               from
                               app_data.tenant                    tnt
                          join app_data.web_app_user_saml2_config s2c on tnt.tnt_id = s2c.tnt_id
                          join (
                                        app_data.endpoint      epacs
                                   join app_data.endpoint_path eppacs on epacs.epp_id = eppacs.epp_id
                               )
                            on s2c.ep_acs_id = epacs.ep_id
                    cross join (
                                   select
                                          coalesce
                                          (
                                              (
                                                  select
                                                         true
                                                    from
                                                         app_data.saml2_identity_provider idp
                                                   where
                                                         idp.tnt_id      = p_tnt_id
                                                     and idp.idp_enabled = true
                                                     and     exists (
                                                                        select
                                                                               null
                                                                          from
                                                                               app_data.saml2_identity_provider_sso_endpoint sso
                                                                         where
                                                                               sso.idp_id      = idp.idp_id
                                                                           and sso.sso_enabled = true
                                                                    )
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
                                                                                                     app_data.saml2_identity_provider_certificate ipc
                                                                                               where
                                                                                                     ipc.cru_id = cru.cru_id
                                                                                                 and ipc.idp_id = idp.idp_id
                                                                                                 and now()
                                                                                                           between
                                                                                                                   ipc.ipc_inc_ts
                                                                                                               and
                                                                                                                   ipc.ipc_exp_ts
                                                                                          )
                                                                    )
                                              )
                                          ,   false
                                          ) idp_ok
                               ) idp
              where
                    s2c.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
