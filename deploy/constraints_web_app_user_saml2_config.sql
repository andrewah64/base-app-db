alter table if exists app_data.web_app_user_saml2_config add constraint fk_s2c_tnt    foreign key (tnt_id)    references app_data.tenant (tnt_id);
alter table if exists app_data.web_app_user_saml2_config add constraint fk_s2c_aum    foreign key (aum_id)    references app_data.web_atn_saml2_method (aum_id);
alter table if exists app_data.web_app_user_saml2_config add constraint fk_s2c_ep_acs foreign key (ep_acs_id) references app_data.endpoint (ep_id);
alter table if exists app_data.web_app_user_saml2_config add constraint fk_s2c_ep_mtd foreign key (ep_mtd_id) references app_data.endpoint (ep_id);
