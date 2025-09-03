do $$
begin
        insert
          into
               app_data.web_app_user_password_config
             (
                 tnt_id
             ,   aupc_aur_nm_min_len
             ,   aupc_aur_nm_max_len
             ,   aupc_aur_pwd_min_len
             ,   aupc_aur_pwd_max_len
             ,   aupc_enabled
             ,   aupc_mfa_enabled
             )
        select
               tnt.tnt_id
             , 1
             , 10
             , 8
             , 30
             , true
             , true
          from
               app_data.tenant tnt
             ;

end $$
