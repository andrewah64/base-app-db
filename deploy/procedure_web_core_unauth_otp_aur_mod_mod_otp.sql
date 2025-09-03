create or replace procedure web_core_unauth_otp_aur_mod.mod_otp
(
        p_tnt_id app_data.app_user.tnt_id%type
,       p_aur_id app_data.app_user.aur_id%type
,       p_otp_id app_data.web_app_user_totp.otp_id%type
)
as
$$
begin

        update
               app_data.web_app_user_totp otp
           set
               otp_enabled = false
         where
               otp.aur_id       = p_aur_id
           and otp.otp_id      != p_otp_id
           and otp.otp_enabled  = true
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = otp.aur_id
                      );

        update
               app_data.web_app_user_totp otp
           set
               otp_enabled = true
         where
               otp.aur_id = p_aur_id
           and otp.otp_id = p_otp_id
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = otp.aur_id
                      );

end;
$$
language plpgsql
security definer;
