alter table if exists app_data.web_app_user_passkey_config_atn_hint add constraint fk_pah_aukc foreign key (tnt_id) references app_data.web_app_user_passkey_config (tnt_id);
alter table if exists app_data.web_app_user_passkey_config_atn_hint add constraint fk_pah_pkh foreign key (pkh_id) references app_data.passkey_hint (pkh_id);
