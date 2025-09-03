create or replace procedure web_core_unauth_ssn_aur_reg.reg_pls
(
        p_tnt_id        app_data.tenant.tnt_id%type
,       p_aur_nm        app_data.app_user.aur_nm%type
,       p_pls_challenge app_data.web_app_user_passkey_login_session.pls_challenge%type
,       p_pls_js        app_data.web_app_user_passkey_login_session.pls_js%type
)
as
$$
begin

        insert
          into
               app_data.web_app_user_passkey_login_session
             (
                 aur_id
             ,   pls_challenge
             ,   pls_js
             )
        select
               aur.aur_id
             , p_pls_challenge pls_challenge
             , p_pls_js        pls_js
          from
                    app_data.app_user     aur
               join app_data.web_app_user waur on aur.aur_id = waur.aur_id
         where
               aur.tnt_id = p_tnt_id
           and aur.aur_nm = p_aur_nm
             ;

end;
$$
language plpgsql
security definer;
