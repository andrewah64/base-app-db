alter table if exists app_data.saml2_service_provider add constraint fk_sp_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
