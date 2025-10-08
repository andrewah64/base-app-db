create unique index uk_idp_enabled on app_data.saml2_identity_provider (tnt_id, idp_enabled) where idp_enabled;
