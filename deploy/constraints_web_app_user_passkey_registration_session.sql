alter table if exists app_data.web_app_user_passkey_registration_session add constraint fk_prs_tnt foreign key (tnt_id) references app_data.tenant (tnt_id);
