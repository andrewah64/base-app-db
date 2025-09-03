alter table if exists app_data.app_group_db_role add constraint fk_grpdr_grp foreign key (grp_id)  references app_data.app_group   (grp_id);
alter table if exists app_data.app_group_db_role add constraint fk_grpdr_adr foreign key (dbrl_id) references app_data.atn_db_role (dbrl_id);
