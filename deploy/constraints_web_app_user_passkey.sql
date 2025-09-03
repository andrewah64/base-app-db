alter table if exists app_data.web_app_user_passkey add constraint fk_pky_waur foreign key (aur_id) references app_data.web_app_user (aur_id);
