alter table if exists app_data.oidc_provider_scope drop constraint if exists fk_ocps_ocp;
alter table if exists app_data.oidc_provider_scope drop constraint if exists fk_ocps_ocs;
