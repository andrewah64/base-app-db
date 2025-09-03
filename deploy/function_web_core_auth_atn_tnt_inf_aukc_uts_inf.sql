create or replace function web_core_auth_atn_tnt_inf.aukc_uts_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_passkey_config.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aukc.uts
               from
                    app_data.web_app_user_passkey_config aukc
              where
                    aukc.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
