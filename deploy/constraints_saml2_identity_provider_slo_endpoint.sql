alter table if exists app_data.saml2_identity_provider_slo_endpoint add constraint fk_slo_idp foreign key (idp_id) references app_data.saml2_identity_provider (idp_id);
