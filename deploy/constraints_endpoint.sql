alter table if exists app_data.endpoint add constraint fk_ep_mwc  foreign key (mwc_id)  references app_data.middleware_chain    (mwc_id);
alter table if exists app_data.endpoint add constraint fk_ep_hrm  foreign key (hrm_id)  references app_data.http_request_method (hrm_id);
alter table if exists app_data.endpoint add constraint fk_ep_hdlr foreign key (hdlr_id) references app_data.handler (hdlr_id);
alter table if exists app_data.endpoint add constraint fk_ep_epp  foreign key (epp_id)  references app_data.endpoint_path (epp_id);
