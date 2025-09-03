create or replace function web_core_unauth_aur_tnt_reg.mfa_inf
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
                    aupc.aupc_mfa_enabled
               from
                    app_data.web_app_user_password_config aupc
              where
                    aupc.tnt_id       = p_tnt_id
                and aupc.aupc_enabled = true
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
