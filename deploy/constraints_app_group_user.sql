alter table if exists app_data.app_group_user add constraint fk_agu_aur foreign key (aur_id) references app_data.app_user  (aur_id);
alter table if exists app_data.app_group_user add constraint fk_agu_grp foreign key (grp_id) references app_data.app_group (grp_id);
