create unique index uk_spc_enabled on app_data.saml2_service_provider_certificate_pair (tnt_id, spc_enabled) where spc_enabled;
