alter table if exists app_data.web_app_user_password_config add constraint fk_waupc_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
