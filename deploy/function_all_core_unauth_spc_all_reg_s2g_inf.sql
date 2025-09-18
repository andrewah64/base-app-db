create or replace function all_core_unauth_spc_all_reg.s2g_inf
(
        refcursor
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    s2g.tnt_id
                  , s2g.s2g_crt_cn
                  , s2g.s2g_crt_dn
                  , s2g.s2g_crt_org
               from
                    app_data.web_app_user_saml2_cert_config s2g
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
