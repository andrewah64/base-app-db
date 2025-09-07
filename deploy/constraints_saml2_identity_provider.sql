alter table if exists app_data.saml2_identity_provider add constraint fk_idp_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
