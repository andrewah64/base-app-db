alter table if exists app_data.oidc_client add constraint fk_occ_tnt foreign key (tnt_id) references app_data.tenant        (tnt_id);
alter table if exists app_data.oidc_client add constraint fk_occ_ocp foreign key (ocp_id) references app_data.oidc_provider (ocp_id);
alter table if exists app_data.oidc_client add constraint fk_occ_ep  foreign key (ep_id)  references app_data.endpoint      (ep_id);
