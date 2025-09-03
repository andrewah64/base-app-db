create or replace function web_core_unauth_otp_ssn_aur_mod.aur_inf
(
        refcursor
,       p_tnt_id    app_data.app_user.tnt_id%type
,       p_aur_id    app_data.app_user.aur_id%type
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
                    waur.aur_ssn_dn
                  , epp.epp_pt
                  , otp.otp_secret
               from
                         app_data.app_user                aur
                    join app_data.web_app_user            waur  on aur.aur_id  = aur.aur_id
                    join app_data.web_app_user_home_page  wauhp on waur.aur_id = wauhp.aur_id
                    join app_data.page_endpoint           pe    on wauhp.pg_id = pe.pg_id
                    join app_data.endpoint                ep    on pe.ep_id    = ep.ep_id
                    join app_data.endpoint_path           epp   on ep.epp_id   = epp.epp_id
                    join app_data.web_app_user_totp       otp   on waur.aur_id = otp.aur_id
                    join app_data.web_app_user_totp_nonce nnc   on waur.aur_id = nnc.aur_id
              where
                    aur.tnt_id      = p_tnt_id
                and aur.aur_id      = p_aur_id
                and pe.pe_is_entry  = true
                and otp.otp_enabled = true
                and nnc.nnc_nonce   = p_nnc_nonce
                and nnc.nnc_exp_ts >= now()
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
