alter table if exists app_data.web_app_user_totp add constraint fk_otp_waur foreign key (aur_id) references app_data.web_app_user (aur_id);
