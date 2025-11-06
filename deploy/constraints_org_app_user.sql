alter table if exists app_data.org_app_user add constraint fk_oau_org foreign key (org_id) references app_data.org      (org_id);
alter table if exists app_data.org_app_user add constraint fk_oau_aur foreign key (aur_id) references app_data.app_user (aur_id);
