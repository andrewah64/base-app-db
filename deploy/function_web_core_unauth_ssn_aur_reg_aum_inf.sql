create or replace function web_core_unauth_ssn_aur_reg.aum_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    c.aupc_enabled
                  , d.aukc_enabled
                  , e.saml2_s2i
                  , e.saml2_s2s
                  , e.saml2_s2u
                  , coalesce (a.google   , b.google   ) google_enabled
                  , coalesce (a.microsoft, b.microsoft) microsoft_enabled
               from            (
                                   select
                                          bool_and ( case when ocp.ocp_nm = 'google'    then occ.occ_enabled end ) google
                                        , bool_and ( case when ocp.ocp_nm = 'microsoft' then occ.occ_enabled end ) microsoft
                                     from
                                               app_data.oidc_client   occ
                                          join app_data.oidc_provider ocp on occ.ocp_id = ocp.ocp_id
                                    where
                                          occ.tnt_id = p_tnt_id
                               ) a
                    cross join (
                                   select 
                                          bool_and ( case when ocp.ocp_nm = 'google'    then false end ) google
                                        , bool_and ( case when ocp.ocp_nm = 'microsoft' then false end ) microsoft
                                     from
                                          app_data.oidc_provider ocp
                                    where
                                          not exists (
                                                         select
                                                                null
                                                           from
                                                                app_data.oidc_client occ
                                                          where
                                                                occ.ocp_id = ocp.ocp_id
                                                     )
                               ) b
                    cross join (
                                   select
                                          aupc.aupc_enabled
                                     from
                                          app_data.web_app_user_password_config aupc
                                    where
                                          aupc.tnt_id = p_tnt_id
                               ) c
                    cross join (
                                   select
                                          aukc.aukc_enabled and (pkg.cnt > 0) aukc_enabled
                                     from
                                                     app_data.web_app_user_passkey_config aukc
                                          cross join (
                                                         select
                                                                count(*) cnt
                                                           from
                                                                app_data.web_app_user_passkey_config_public_key_algorithm pkg
                                                          where
                                                                pkg.tnt_id = p_tnt_id
                                                     ) pkg
                                    where
                                          aukc.tnt_id = p_tnt_id
                               ) d
                    cross join (
                                   select
                                          coalesce(bool_and(case when wam.wam_s2i then true else false end),false) saml2_s2i
                                        , coalesce(bool_and(case when wam.wam_s2s then true else false end),false) saml2_s2s
                                        , coalesce(bool_and(case when wam.wam_s2u then true else false end),false) saml2_s2u
                                     from
                                               app_data.web_app_user_saml2_config s2c
                                          join app_data.web_atn_method            wam on s2c.aum_id = wam.aum_id
                                    where
                                          s2c.tnt_id      = p_tnt_id
                                      and s2c.s2c_enabled = true
                                      and exists (
                                                     select
                                                            null
                                                       from
                                                            app_data.saml2_service_provider_certificate_pair spc
                                                      where
                                                            spc.tnt_id      = s2c.tnt_id
                                                        and spc.spc_enabled = true
                                                        and now()
                                                                  between
                                                                          spc.spc_inc_ts
                                                                      and
                                                                          spc.spc_exp_ts
                                                 )
                                      and exists (
                                                     select
                                                            null
                                                       from
                                                                 app_data.saml2_identity_provider              idp
                                                            join app_data.saml2_identity_provider_certificate  ipc on idp.idp_id = ipc.idp_id
                                                            join app_data.saml2_identity_provider_sso_endpoint sso on idp.idp_id = sso.idp_id
                                                      where
                                                            idp.tnt_id      = s2c.tnt_id
                                                        and idp.idp_enabled = true
                                                        and now()
                                                                  between
                                                                          ipc.ipc_inc_ts
                                                                      and
                                                                          ipc.ipc_exp_ts
                                                 )
                               ) e;

        return $1;
end;
$$
language plpgsql
security definer;
