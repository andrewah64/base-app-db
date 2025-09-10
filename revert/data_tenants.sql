do $$
begin
        delete from app_data.endpoint_log_level;

        delete from app_data.app_group_db_role;

        delete from app_data.app_group;

        delete from app_data.web_app_user_passkey_config;

        delete from app_data.web_app_user_password_config;

        delete from app_data.web_app_user_saml2_config;

        delete from app_data.tenant;

        commit;
end $$
