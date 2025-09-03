alter table if exists app_data.web_app_user_passkey_login_session add constraint fk_pls_waur foreign key (aur_id) references app_data.web_app_user (aur_id);
