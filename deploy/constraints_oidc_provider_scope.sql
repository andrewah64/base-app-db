alter table if exists app_data.oidc_provider_scope add constraint fk_ocps_ocp foreign key (ocp_id) references app_data.oidc_provider (ocp_id);
alter table if exists app_data.oidc_provider_scope add constraint fk_ocps_ocs foreign key (ocs_id) references app_data.oidc_scope    (ocs_id);
