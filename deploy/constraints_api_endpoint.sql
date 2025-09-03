alter table if exists app_data.api_endpoint add constraint fk_apie_api foreign key (api_id) references app_data.api      (api_id);
alter table if exists app_data.api_endpoint add constraint fk_apie_ep  foreign key (ep_id)  references app_data.endpoint (ep_id);
