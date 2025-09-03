alter table if exists app_data.endpoint_log_level add constraint fk_ell_tnt foreign key (tnt_id) references app_data.tenant    (tnt_id);
alter table if exists app_data.endpoint_log_level add constraint fk_ell_ep  foreign key (ep_id)  references app_data.endpoint  (ep_id);
alter table if exists app_data.endpoint_log_level add constraint fk_ell_lvl foreign key (lvl_id) references app_data.log_level (lvl_id);
