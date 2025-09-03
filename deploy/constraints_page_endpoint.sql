alter table if exists app_data.page_endpoint add constraint fk_pe_pg foreign key (pg_id) references app_data.page     (pg_id);
alter table if exists app_data.page_endpoint add constraint fk_pe_ep foreign key (ep_id) references app_data.endpoint (ep_id);
