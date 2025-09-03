create or replace procedure web_core_unauth_aur_tnt_reg.reg_prs
(
        p_tnt_id app_data.web_app_user_passkey_registration_session.tnt_id%type
,       p_aur_nm app_data.web_app_user_passkey_registration_session.aur_nm%type
,       p_prs_js app_data.web_app_user_passkey_registration_session.prs_js%type
)
as
$$
begin

        merge
         into
              app_data.web_app_user_passkey_registration_session tgt
        using (
                  select
                         p_tnt_id tnt_id
                       , p_aur_nm aur_nm
                       , p_prs_js prs_js
              ) src
           on (
                      tgt.tnt_id = src.tnt_id
                  and tgt.aur_nm = src.aur_nm
              )
         when
              matched
         then
              update
                 set
                     prs_js = src.prs_js
         when
              not matched
         then
              insert
              (
                  tnt_id
              ,   aur_nm
              ,   prs_js
              )
              values
              (
                  src.tnt_id
              ,   src.aur_nm
              ,   src.prs_js
              );

end;
$$
language plpgsql
security definer;
