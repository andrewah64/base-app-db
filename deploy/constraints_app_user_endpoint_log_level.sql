alter table if exists app_data.app_user_endpoint_log_level add constraint fk_auell_aur foreign key (aur_id) references app_data.app_user (aur_id);
alter table if exists app_data.app_user_endpoint_log_level add constraint fk_auell_aep foreign key (ep_id) references app_data.atn_endpoint (ep_id);
alter table if exists app_data.app_user_endpoint_log_level add constraint fk_auell_lvl foreign key (lvl_id) references app_data.log_level (lvl_id);
