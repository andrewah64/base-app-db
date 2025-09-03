alter table if exists app_data.oidc_client_provider_scope drop constraint if exists fk_occps_ocps;
alter table if exists app_data.oidc_client_provider_scope drop constraint if exists fk_occps_occ;
