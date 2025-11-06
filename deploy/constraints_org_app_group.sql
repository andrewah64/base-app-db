alter table app_data.org_app_group add constraint fk_oag_org foreign key (org_id) references app_data.org       (org_id);
alter table app_data.org_app_group add constraint fk_oag_grp foreign key (grp_id) references app_data.app_group (grp_id);
