create or replace procedure web_core_auth_ssn_aur_end.end_ssn
(
        p_wauhs_ssn_tk app_data.web_app_user_http_session.wauhs_ssn_tk%type
)
as
$$
begin

        update
               app_data.web_app_user_http_session tgt
           set
               wauhs_exp_ts = src.now
             , uby          = src.aur_nm
             , uts          = src.now
          from (
                   select
                          aur.aur_nm
                        , wauhs.wauhs_ssn_tk
                        , now()              now
                     from
                               app_data.app_user                  aur
                          join app_data.web_app_user_http_session wauhs on aur.aur_id = wauhs.aur_id
                    where
                          wauhs.wauhs_ssn_tk = p_wauhs_ssn_tk
               ) src
         where
               tgt.wauhs_ssn_tk = src.wauhs_ssn_tk
             ;

end;
$$
language plpgsql
security definer;
