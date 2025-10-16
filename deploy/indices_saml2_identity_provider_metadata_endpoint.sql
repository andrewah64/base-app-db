create unique index uk_mde_enabled on app_data.saml2_identity_provider_metadata_endpoint (idp_id, mde_enabled) where mde_enabled;
