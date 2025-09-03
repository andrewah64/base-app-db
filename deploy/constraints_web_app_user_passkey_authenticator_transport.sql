alter table if exists app_data.web_app_user_passkey_authenticator_transport add constraint fk_kat_pky foreign key (pky_id) references app_data.web_app_user_passkey (pky_id);
alter table if exists app_data.web_app_user_passkey_authenticator_transport add constraint fk_kat_pat foreign key (pat_id) references app_data.passkey_authenticator_transport (pat_id);
