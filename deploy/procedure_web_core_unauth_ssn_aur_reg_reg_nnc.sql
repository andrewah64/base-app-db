create or replace procedure web_core_unauth_ssn_aur_reg.reg_nnc
(
        p_tnt_id     app_data.app_user.tnt_id%type
,       p_aur_id     app_data.web_app_user_totp_nonce.aur_id%type
,       p_nnc_nonce  app_data.web_app_user_totp_nonce.nnc_nonce%type
,       p_nnc_exp_ts app_data.web_app_user_totp_nonce.nnc_exp_ts%type
)
as
$$
begin

        merge
         into
              app_data.web_app_user_totp_nonce tgt
        using (
                  select
                         aur.aur_id
                       , p_nnc_nonce  nnc_nonce
                       , p_nnc_exp_ts nnc_exp_ts
                    from
                              app_data.app_user     aur
                         join app_data.web_app_user waur on aur.aur_id = waur.aur_id
                   where
                         aur.tnt_id = p_tnt_id
                     and aur.aur_id = p_aur_id
              )
              src
           on (
                  tgt.aur_id = src.aur_id
              )
         when
              not matched
         then
              insert (aur_id, nnc_nonce, nnc_exp_ts) values (src.aur_id, src.nnc_nonce, src.nnc_exp_ts)
         when
              matched
         then
              update
                 set
                     nnc_nonce  = src.nnc_nonce
                   , nnc_exp_ts = src.nnc_exp_ts
            ;

end;
$$
language plpgsql
security definer;
