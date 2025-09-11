alter table if exists app_data.saml2_service_provider_certificate_pair add constraint fk_spc_s2c foreign key (tnt_id) references app_data.web_app_user_saml2_config (tnt_id);
