create or replace procedure web_core_unauth_otp_ssn_aur_mod.reg_otp
(
        p_tnt_id     app_data.tenant.tnt_id%type
,       p_aur_id     app_data.app_user.aur_id%type
,       p_otp_id     app_data.web_app_user_totp.otp_id%type
,       p_otp_secret app_data.web_app_user_totp.otp_secret%type
)
as
$$
begin

        insert
          into
               app_data.web_app_user_totp
             (
                 otp_id
             ,   aur_id
             ,   otp_secret
             ,   otp_enabled
             )
        select
               p_otp_id     otp_id
             , p_aur_id     aur_id
             , p_otp_secret otp_secret
             , false        otp_enabled
          from
                    app_data.app_user     aur
               join app_data.web_app_user waur on aur.aur_id = waur.aur_id
         where
               aur.tnt_id = p_tnt_id
           and aur.aur_id = p_aur_id
             ;

end;
$$
language plpgsql
security definer;
