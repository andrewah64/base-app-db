alter table app_data.org_group_user add constraint fk_ogu_oag foreign key (oag_id) references app_data.org_app_group (oag_id);
alter table app_data.org_group_user add constraint fk_ogu_oau foreign key (oau_id) references app_data.org_app_user  (oau_id);
