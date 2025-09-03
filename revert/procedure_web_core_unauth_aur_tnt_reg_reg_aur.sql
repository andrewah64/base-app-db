drop procedure if exists web_core_unauth_aur_tnt_reg.reg_aur
(
        p_tnt_id                      app_data.tenant.tnt_id%type
,       p_aur_nm                      app_data.app_user.aur_nm%type
,       p_aur_hsh_pw                  app_data.web_app_user_password.aur_hsh_pw%type
,       p_aur_ea                      app_data.app_user_email_address.aur_ea%type
,       p_otp_id                      app_data.web_app_user_totp.otp_id%type
,       p_otp_secret                  app_data.web_app_user_totp.otp_secret%type
);

drop procedure if exists web_core_unauth_aur_tnt_reg.reg_aur
(
        p_tnt_id                      app_data.tenant.tnt_id%type
,       p_aur_nm                      app_data.app_user.aur_nm%type
,       p_pky_enabled                 app_data.web_app_user_passkey.pky_enabled%type
,       p_pky_credential_id           app_data.web_app_user_passkey.pky_credential_id%type
,       p_pky_public_key              app_data.web_app_user_passkey.pky_public_key%type
,       p_pky_attestation_type        app_data.web_app_user_passkey.pky_attestation_type%type
,       p_pky_authenticator_transport text[]
,       p_pky_user_present            app_data.web_app_user_passkey.pky_user_present%type
,       p_pky_user_verified           app_data.web_app_user_passkey.pky_user_verified%type
,       p_pky_backup_eligible         app_data.web_app_user_passkey.pky_backup_eligible%type
,       p_pky_backup_state            app_data.web_app_user_passkey.pky_backup_state%type
,       p_pky_aaguid                  app_data.web_app_user_passkey.pky_aaguid%type
,       p_pky_sign_count              app_data.web_app_user_passkey.pky_sign_count%type
,       p_pky_clone_warning           app_data.web_app_user_passkey.pky_clone_warning%type
,       p_pky_attachment              app_data.web_app_user_passkey.pky_attachment%type
,       p_pky_client_data_json        app_data.web_app_user_passkey.pky_client_data_json%type
,       p_pky_client_data_hash        app_data.web_app_user_passkey.pky_client_data_hash%type
,       p_pky_authenticator_data      app_data.web_app_user_passkey.pky_authenticator_data%type
,       p_pky_public_key_algorithm    app_data.web_app_user_passkey.pky_public_key_algorithm%type
,       p_pky_object                  app_data.web_app_user_passkey.pky_object%type
);
