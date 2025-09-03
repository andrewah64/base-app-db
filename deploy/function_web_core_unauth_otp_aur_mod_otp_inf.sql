create or replace function web_core_unauth_otp_aur_mod.otp_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_id  app_data.web_app_user_totp.aur_id%type
,       p_otp_id  app_data.web_app_user_totp.otp_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    otp.otp_secret
               from
                    app_data.web_app_user_totp otp
              where
                    otp.aur_id      = p_aur_id
                and otp.otp_id      = p_otp_id
                and otp.otp_enabled = false
                and     exists (
                                   select
                                          null
                                     from
                                          app_data.app_user aur
                                    where
                                          aur.aur_id = otp.aur_id
                                      and aur.tnt_id = p_tnt_id
                               )
                and not exists (
                                   select
                                          null
                                     from
                                          app_data.web_app_user_totp iotp
                                    where
                                          iotp.aur_id      = otp.aur_id
                                      and iotp.otp_enabled = true
                               );

        return $1;
end;
$$
language plpgsql
security definer;
