create or replace function web_core_unauth_aur_tnt_reg.aupc_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aupc.aupc_aur_nm_min_len
                  , aupc.aupc_aur_nm_max_len
                  , aupc.aupc_aur_pwd_min_len
                  , aupc.aupc_aur_pwd_max_len
                  , aupc.aupc_aur_pwd_inc_sym
                  , aupc.aupc_aur_pwd_inc_num
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
