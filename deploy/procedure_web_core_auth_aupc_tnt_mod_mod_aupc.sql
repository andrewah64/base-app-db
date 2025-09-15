create or replace procedure web_core_auth_aupc_tnt_mod.mod_aupc
(
        p_tnt_id               app_data.tenant.tnt_id%type
,       p_aupc_aur_nm_min_len  app_data.web_app_user_password_config.aupc_aur_nm_min_len%type
,       p_aupc_aur_nm_max_len  app_data.web_app_user_password_config.aupc_aur_nm_max_len%type
,       p_aupc_aur_pwd_min_len app_data.web_app_user_password_config.aupc_aur_pwd_min_len%type
,       p_aupc_aur_pwd_max_len app_data.web_app_user_password_config.aupc_aur_pwd_max_len%type
,       p_aupc_aur_pwd_inc_sym app_data.web_app_user_password_config.aupc_aur_pwd_inc_sym%type
,       p_aupc_aur_pwd_inc_num app_data.web_app_user_password_config.aupc_aur_pwd_inc_num%type
,       p_aupc_enabled         app_data.web_app_user_password_config.aupc_enabled%type
,       p_aupc_mfa_enabled     app_data.web_app_user_password_config.aupc_mfa_enabled%type
,       p_by                   app_data.app_user.aur_nm%type
,       p_uts                  app_data.web_app_user_password_config.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.web_app_user_password_config aupc
           set
               aupc_aur_nm_min_len  = p_aupc_aur_nm_min_len
             , aupc_aur_nm_max_len  = p_aupc_aur_nm_max_len
             , aupc_aur_pwd_min_len = p_aupc_aur_pwd_min_len
             , aupc_aur_pwd_max_len = p_aupc_aur_pwd_max_len
             , aupc_aur_pwd_inc_sym = p_aupc_aur_pwd_inc_sym
             , aupc_aur_pwd_inc_num = p_aupc_aur_pwd_inc_num
             , aupc_enabled         = p_aupc_enabled
             , aupc_mfa_enabled     = p_aupc_mfa_enabled
             , uby                  = p_by
             , uts                  = now()
         where
               aupc.tnt_id = p_tnt_id
           and aupc.uts    = p_uts
           and (
                      aupc.aupc_aur_nm_min_len  != p_aupc_aur_nm_min_len
                   or aupc.aupc_aur_nm_max_len  != p_aupc_aur_nm_max_len
                   or aupc.aupc_aur_pwd_min_len != p_aupc_aur_pwd_min_len
                   or aupc.aupc_aur_pwd_max_len != p_aupc_aur_pwd_max_len
                   or aupc.aupc_aur_pwd_inc_sym != p_aupc_aur_pwd_inc_sym
                   or aupc.aupc_aur_pwd_inc_num != p_aupc_aur_pwd_inc_num
                   or aupc.aupc_enabled         != p_aupc_enabled
                   or aupc.aupc_mfa_enabled     != p_aupc_mfa_enabled
               );

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 and not exists (
                                        select
                                               null
                                          from
                                               app_data.web_app_user_password_config aupc
                                         where
                                               aupc.tnt_id = p_tnt_id
                                           and aupc.uts    = p_uts
                                    )
        then
                raise exception 'Optimistic locking error : web_core_auth_atn_tnt_mod.mod_aupc' using errcode = 'OLOCK';
        end if;

end;
$$
language plpgsql
security definer;
