create or replace function all_core_unauth_spc_all_reg.s2c_inf
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
                    s2c.tnt_id
                  , s2c.s2c_crt_cn
                  , s2c.s2c_crt_dn
                  , s2c.s2c_crt_org
               from
                    app_data.web_app_user_saml2_config s2c
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
