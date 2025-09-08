alter table if exists app_data.web_atn_saml2_method add constraint fk_asm_wam foreign key (aum_id) references app_data.web_atn_method (aum_id);
