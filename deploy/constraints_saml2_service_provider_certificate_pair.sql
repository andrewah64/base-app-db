alter table if exists app_data.saml2_service_provider_certificate_pair add constraint fk_spc_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
