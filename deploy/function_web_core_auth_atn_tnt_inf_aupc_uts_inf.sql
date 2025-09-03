create or replace function web_core_auth_atn_tnt_inf.aupc_uts_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_password_config.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aupc.uts
               from
                    app_data.web_app_user_password_config aupc
              where
                    aupc.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
