alter table if exists app_data.web_app_user add constraint fk_waur_aur foreign key (aur_id) references app_data.app_user (aur_id);
