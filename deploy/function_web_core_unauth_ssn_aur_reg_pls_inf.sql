create or replace function web_core_unauth_ssn_aur_reg.pls_inf
(
        refcursor
,       p_tnt_id        app_data.app_user.tnt_id%type
,       p_aur_nm        app_data.app_user.aur_nm%type
,       p_pls_challenge app_data.web_app_user_passkey_login_session.pls_challenge%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    pls.pls_js
               from
                    app_data.web_app_user_passkey_login_session pls
              where
                    pls.pls_challenge = p_pls_challenge
                and exists (
                               select
                                      null
                                 from
                                      app_data.app_user aur
                                where
                                      aur.tnt_id = p_tnt_id
                                  and aur.aur_id = pls.aur_id
                           );

        return $1;
end;
$$
language plpgsql
security definer;
