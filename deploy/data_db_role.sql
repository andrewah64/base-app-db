do $$
begin
        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_all_core_unauth_tnt_all_inf'
             , 'Manage tenant cache'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_all_core_unauth_tnt_all_inf');

        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_web_core_unauth_rts_web_inf'
             , 'Manage routes cache'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_web_core_unauth_rts_web_inf');

        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_web_core_unauth_ssn_ep_inf'
             , 'Retrieve unauth endpoint info'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_web_core_unauth_ssn_ep_inf');

        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_api_core_auth_tnt_all_reg'
             , 'Register new tenant'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_api_core_auth_tnt_all_reg');

        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_api_core_rts_api_inf'
             , 'Manage api routes cache'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_api_core_rts_api_inf');

        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_api_core_key_aur_lgn'
             , 'Configure API logins'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_api_core_key_aur_lgn');

        insert into app_data.db_role (dbrl_nm,dbrl_ds)
        select 'role_web_core_auth_ssn_aur_inf'
             , '???'
         where not exists (select null
                             from app_data.db_role d
                            where d.dbrl_nm   = 'role_web_core_auth_ssn_aur_inf');

commit;
end $$
