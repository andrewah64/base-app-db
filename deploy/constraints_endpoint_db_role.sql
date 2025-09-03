alter table if exists app_data.endpoint_db_role add constraint fk_edr_dbrl foreign key (dbrl_id) references app_data.db_role  (dbrl_id);
alter table if exists app_data.endpoint_db_role add constraint fk_edr_ep   foreign key (ep_id)   references app_data.endpoint (ep_id);
