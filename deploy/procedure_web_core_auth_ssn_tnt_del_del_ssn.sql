create or replace procedure web_core_auth_ssn_tnt_del.del_ssn
(
        p_tnt_id       app_data.app_user.tnt_id%type
,       p_wauhs_ssn_tk text[]
,       p_by           app_data.app_user.aur_nm%type
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
                          wauhs.aur_id
                        , wauhs.wauhs_ssn_tk
                        , aur.aur_nm
                        , now()              now
                     from
                               app_data.app_user                  aur
                          join app_data.web_app_user_http_session wauhs on aur.aur_id = wauhs.aur_id
                    where
                          aur.tnt_id         = p_tnt_id
                      and wauhs.wauhs_ssn_tk = any(p_wauhs_ssn_tk)
               ) src
         where
               src.aur_id       = tgt.aur_id
           and src.wauhs_ssn_tk = tgt.wauhs_ssn_tk
             ;
end;
$$
language plpgsql
security definer;
