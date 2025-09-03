create or replace function web_core_unauth_ssn_aur_reg.aukc_atn_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_password_config.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      puv.puv_nm
                    , pkh.pkh_nm
                 from
                                 app_data.web_app_user_passkey_config aukc
                            join app_data.passkey_user_verification   puv  on aukc.puv_atn_id = puv.puv_id
                      cross join (
                                     select
                                            coalesce(array_agg(pkh.pkh_nm order by pah.pah_od asc), array[]::text[]) pkh_nm
                                       from
                                                 app_data.web_app_user_passkey_config_atn_hint pah
                                            join app_data.passkey_hint                                    pkh on pah.pkh_id = pkh.pkh_id
                                      where
                                            pah.tnt_id = p_tnt_id
                                 ) pkh
                where
                      aukc.tnt_id = p_tnt_id
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
