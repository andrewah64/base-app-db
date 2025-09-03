create or replace function web_core_auth_pwd_aur_tnt_mod.pwd_aur_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    pwd.aupc_aur_pwd_min_len
                  , pwd.aupc_aur_pwd_max_len
                  , pwd.aupc_aur_pwd_inc_sym
                  , pwd.aupc_aur_pwd_inc_num
                  , aur.aur_id
                  , aur.aur_nm
               from            (
                                   select
                                          aupc.aupc_aur_pwd_min_len
                                        , aupc.aupc_aur_pwd_max_len
                                        , aupc.aupc_aur_pwd_inc_sym
                                        , aupc.aupc_aur_pwd_inc_num
                                     from
                                          app_data.web_app_user_password_config aupc
                                    where
                                          aupc.tnt_id = p_tnt_id
                               ) pwd
                    cross join (
                                   select
                                          aur.aur_id
                                        , aur.aur_nm
                                     from
                                          app_data.app_user aur
                                    where
                                          aur.tnt_id = p_tnt_id
                                      and aur.aur_id = p_aur_id
                               ) aur;

        return $1;
end;
$$
language plpgsql
security definer;
