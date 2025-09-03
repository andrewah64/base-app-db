do $$
begin
        delete from app_data.web_app_user_passkey_config_atn_hint;
        delete from app_data.web_app_user_passkey_config_public_key_algorithm;
        delete from app_data.web_app_user_passkey_config_registration_hint;
        delete from app_data.web_app_user_passkey_config;
        commit;
end $$
