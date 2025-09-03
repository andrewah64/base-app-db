alter table if exists app_data.app_user_email_address add constraint fk_auea_aur foreign key (aur_id) references app_data.app_user (aur_id);
