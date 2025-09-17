create or replace function web_core_auth_s2c_tnt_inf.s2c_uts_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_saml2_config.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    s2c.uts
               from
                    app_data.web_app_user_saml2_config s2c
              where
                    s2c.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
