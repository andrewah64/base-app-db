alter table if exists app_data.web_app_user_passkey_config_registration_hint add constraint fk_prh_aukc foreign key (tnt_id) references app_data.web_app_user_passkey_config (tnt_id);
alter table if exists app_data.web_app_user_passkey_config_registration_hint add constraint fk_prh_pkh foreign key (pkh_id) references app_data.passkey_hint (pkh_id);
