alter table if exists app_data.web_app_user_password add constraint fk_waup_aur  foreign key (aur_id)  references app_data.web_app_user (aur_id);
