alter table if exists app_data.web_app_user_totp_nonce add constraint fk_waur_wautn foreign key (aur_id) references app_data.web_app_user  (aur_id);
