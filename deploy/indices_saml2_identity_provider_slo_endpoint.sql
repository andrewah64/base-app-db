create unique index uk_slo_enabled on app_data.saml2_identity_provider_slo_endpoint (idp_id, slo_enabled) where slo_enabled;
