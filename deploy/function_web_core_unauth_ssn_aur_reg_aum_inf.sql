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
                               ) d;

        return $1;
end;
$$
language plpgsql
security definer;
