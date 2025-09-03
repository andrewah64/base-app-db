alter table if exists app_data.app_user_db_role add constraint fk_audr_aur foreign key (aur_id)  references app_data.app_user    (aur_id);
alter table if exists app_data.app_user_db_role add constraint fk_audr_adr foreign key (dbrl_id) references app_data.atn_db_role (dbrl_id);
