create or replace function web_core_unauth_aur_tnt_reg.prs_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_passkey_registration_session.tnt_id%type
,       p_aur_nm  app_data.web_app_user_passkey_registration_session.aur_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    prs.prs_js
               from
                    app_data.web_app_user_passkey_registration_session prs
              where
                    prs.tnt_id = p_tnt_id
                and prs.aur_nm = p_aur_nm
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
