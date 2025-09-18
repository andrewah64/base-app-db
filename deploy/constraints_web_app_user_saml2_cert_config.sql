alter table if exists app_data.web_app_user_saml2_cert_config add constraint fk_s2g_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
