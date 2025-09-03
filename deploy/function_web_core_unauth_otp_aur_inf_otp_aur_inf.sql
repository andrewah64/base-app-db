create or replace function web_core_unauth_otp_aur_inf.otp_aur_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
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
                    aur.aur_id
                  , aur.aur_nm
                  , otp.otp_secret
               from
                         app_data.app_user          aur
                    join app_data.web_app_user_totp otp on aur.aur_id = otp.aur_id
              where
                    aur.tnt_id      = p_tnt_id
                and otp.otp_id      = p_otp_id
                and otp.otp_enabled = false
                and not exists (
                                   select
                                          null
                                     from
                                          app_data.web_app_user_totp iotp
                                    where
                                          iotp.aur_id      = aur.aur_id
                                      and iotp.otp_enabled = true
                               );

        return $1;
end;
$$
language plpgsql
security definer;
