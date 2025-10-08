create unique index uk_sso_enabled on app_data.saml2_identity_provider_sso_endpoint (idp_id, sso_enabled) where sso_enabled;
