do $$
declare
        i record;
begin
        delete from app_data.web_app_user_passkey_registration_session;

        for i in select
                        tnt_id
                      , aur_id
                   from
                        app_data.app_user
        loop
                call web_core_auth_aur_tnt_del.del_aur(i.tnt_id, ARRAY[i.aur_id]);
        end loop;

        delete from app_data.oidc_client_provider_scope;

        delete from app_data.oidc_client;

        delete from app_data.endpoint_log_level;

        delete from app_data.app_group_db_role;

        delete from app_data.app_group;

        delete from app_data.web_app_user_passkey_config;

        delete from app_data.web_app_user_password_config;

        delete from app_data.web_app_user_saml2_config;

        delete from app_data.tenant;

        commit;
end $$
