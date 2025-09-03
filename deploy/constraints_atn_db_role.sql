alter table if exists app_data.atn_db_role add constraint fk_adr_dbrl foreign key (dbrl_id) references app_data.db_role (dbrl_id);
