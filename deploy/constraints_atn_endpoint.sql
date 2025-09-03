alter table if exists app_data.atn_endpoint add constraint fk_aep_ep foreign key (ep_id) references app_data.endpoint (ep_id);
