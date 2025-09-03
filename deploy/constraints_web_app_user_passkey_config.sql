alter table if exists app_data.web_app_user_passkey_config add constraint fk_aukc_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
alter table if exists app_data.web_app_user_passkey_config add constraint fk_aukc_pka foreign key (pka_id) references app_data.passkey_attestation (pka_id);
alter table if exists app_data.web_app_user_passkey_config add constraint fk_aukc_pkt foreign key (pkt_id) references app_data.passkey_attachment (pkt_id);
alter table if exists app_data.web_app_user_passkey_config add constraint fk_aukc_pdc foreign key (pdc_id) references app_data.passkey_discoverable_credential (pdc_id);
alter table if exists app_data.web_app_user_passkey_config add constraint fk_aukc_puv_reg foreign key (puv_reg_id) references app_data.passkey_user_verification (puv_id);
alter table if exists app_data.web_app_user_passkey_config add constraint fk_aukc_puv_atn foreign key (puv_atn_id) references app_data.passkey_user_verification (puv_id);
