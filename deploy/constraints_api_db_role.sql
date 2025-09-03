alter table if exists app_data.api_db_role add constraint fk_adbrl_dbrl foreign key (dbrl_id) references app_data.db_role (dbrl_id);
