create or replace procedure web_core_unauth_ssn_aur_reg.reg_ssn
(
        p_aur_id       app_data.web_app_user_http_session.aur_id%type
,       p_wauhs_ssn_tk app_data.web_app_user_http_session.wauhs_ssn_tk%type
,       p_wauhs_exp_ts app_data.web_app_user_http_session.wauhs_exp_ts%type
)
as
$$
begin

           insert
             into
                  app_data.web_app_user_http_session
                  (
                          aur_id
                  ,       wauhs_ssn_tk
                  ,       wauhs_exp_ts
                  )
           values (
                          p_aur_id
                  ,       p_wauhs_ssn_tk
                  ,       p_wauhs_exp_ts
                  );

end;
$$
language plpgsql
security definer;

