create or replace function web_core_auth_s2c_tnt_inf.s2g_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_saml2_cert_config.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    s2g.s2g_crt_cn
                  , s2g.s2g_crt_org
                  , s2g.uts
               from
                    app_data.web_app_user_saml2_cert_config s2g
              where
                    s2g.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
