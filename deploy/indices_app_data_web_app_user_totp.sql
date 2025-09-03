create unique index uk_otp_enabled on app_data.web_app_user_totp (aur_id, otp_enabled) where otp_enabled;
