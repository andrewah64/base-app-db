create or replace function web_core_unauth_otp_ssn_aur_mod.nnc_inf
(
        refcursor
,       p_tnt_id    app_data.tenant.tnt_id%type
,       p_nnc_nonce app_data.web_app_user_totp_nonce.nnc_nonce%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    (
                        select
                               nnc.aur_id
                          from
                               app_data.web_app_user_totp_nonce nnc
                         where
                               nnc.nnc_nonce = p_nnc_nonce
                           and exists (
                                          select
                                                 null
                                            from
                                                 app_data.app_user aur
                                           where
                                                 aur.aur_id = nnc.aur_id
                                             and aur.tnt_id = p_tnt_id
                                      )
                    ) aur_id
                  , (
                        select
                               aur.aur_nm
                          from
                               app_data.app_user aur
                         where
                               aur.tnt_id = p_tnt_id
                           and exists (
                                          select
                                                 null
                                            from
                                                 app_data.web_app_user_totp_nonce nnc
                                           where
                                                 nnc.aur_id    = aur.aur_id
                                             and nnc.nnc_nonce = p_nnc_nonce
                                      )
                    ) aur_nm
                  , coalesce
                    (
                        (
                            select
                                   true
                              from
                                   app_data.web_app_user_totp_nonce nnc
                             where
                                   nnc.nnc_nonce   = p_nnc_nonce
                               and nnc.nnc_exp_ts >= now()
                               and exists (
                                              select
                                                     null
                                                from
                                                     app_data.app_user aur
                                               where
                                                     aur.aur_id = nnc.aur_id
                                                 and aur.tnt_id = p_tnt_id
                                          )
                        )
                    ,   false
                    ) nnc_enabled
                  , coalesce
                    (
                        (
                            select
                                   true
                              from
                                   app_data.web_app_user_totp_nonce nnc
                             where
                                   nnc.nnc_nonce = p_nnc_nonce
                               and exists (
                                              select
                                                     null
                                                from
                                                     app_data.app_user aur
                                               where
                                                     aur.aur_id = nnc.aur_id
                                                 and aur.tnt_id = p_tnt_id
                                          )
                               and exists (
                                              select
                                                     null
                                                from
                                                     app_data.web_app_user_totp otp
                                               where
                                                     otp.aur_id      = nnc.aur_id
                                                 and otp.otp_enabled = true
                                          )
                               and exists (
                                              select
                                                     null
                                                from
                                                     app_data.web_app_user_password_config waupc
                                               where
                                                     waupc.tnt_id           = p_tnt_id
                                                 and waupc.aupc_enabled     = true
                                                 and waupc.aupc_mfa_enabled = true
                                          )
                        )
                    ,   false
                    ) otp_enabled
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
