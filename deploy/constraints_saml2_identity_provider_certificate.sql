alter table if exists app_data.saml2_identity_provider_certificate add constraint fk_ipc_idp foreign key (idp_id) references app_data.saml2_identity_provider (idp_id);
alter table if exists app_data.saml2_identity_provider_certificate add constraint fk_ipc_cru foreign key (cru_id) references app_data.saml2_identity_provider_certificate_use (cru_id);
