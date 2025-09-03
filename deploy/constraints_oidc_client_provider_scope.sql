alter table if exists app_data.oidc_client_provider_scope add constraint fk_occps_ocps foreign key (ocp_id, ocs_id) references app_data.oidc_provider_scope (ocp_id, ocs_id);
alter table if exists app_data.oidc_client_provider_scope add constraint fk_occps_occ  foreign key (occ_id)         references app_data.oidc_client (occ_id);
