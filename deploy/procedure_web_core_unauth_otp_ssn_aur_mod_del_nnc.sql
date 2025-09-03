create or replace procedure web_core_unauth_otp_ssn_aur_mod.del_nnc
(
        p_tnt_id     app_data.app_user.tnt_id%type
,       p_aur_id     app_data.web_app_user_totp_nonce.aur_id%type
,       p_nnc_nonce  app_data.web_app_user_totp_nonce.nnc_nonce%type
)
as
$$
begin

        delete
          from
               app_data.web_app_user_totp_nonce nnc
         where
               nnc.aur_id    = p_aur_id
           and nnc.nnc_nonce = p_nnc_nonce
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.aur_id = nnc.aur_id
                             and aur.tnt_id = p_tnt_id
                      );

end;
$$
language plpgsql
security definer;
