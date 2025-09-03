alter table if exists app_data.web_app_user_passkey_config_public_key_algorithm add constraint fk_pra_aukc foreign key (tnt_id) references app_data.web_app_user_passkey_config (tnt_id);
alter table if exists app_data.web_app_user_passkey_config_public_key_algorithm add constraint fk_pra_pkg foreign key (pkg_id) references app_data.passkey_public_key_algorithm (pkg_id);
