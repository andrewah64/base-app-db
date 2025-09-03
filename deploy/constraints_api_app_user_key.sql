alter table if exists app_data.api_app_user_key add constraint fk_aauk_aaur foreign key (aur_id) references app_data.api_app_user (aur_id);
