alter table if exists app_data.api_app_user_key_db_role add constraint fk_aaukdr_aauk foreign key (aauk_id) references app_data.api_app_user_key (aauk_id);
alter table if exists app_data.api_app_user_key_db_role add constraint fk_aaukdr_adbrl foreign key (dbrl_id) references app_data.api_db_role (dbrl_id);
