alter table if exists app_data.oidc_client drop constraint if exists fk_occ_tnt;
alter table if exists app_data.oidc_client drop constraint if exists fk_occ_ocp;
alter table if exists app_data.oidc_client drop constraint if exists fk_occ_ep;
