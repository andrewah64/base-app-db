create or replace function web_core_auth_aukc_tnt_inf.pah_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      pkh_id
                    , pkh_nm
                    , assigned
                 from           (
                                       select
                                              pkh.pkh_id
                                            , pkh.pkh_nm
                                            , pah.pah_od
                                            , true       assigned
                                         from
                                                   app_data.passkey_hint                         pkh
                                              join app_data.web_app_user_passkey_config_atn_hint pah on pkh.pkh_id = pah.pkh_id
                                        where
                                              pah.tnt_id = p_tnt_id
                                    union all
                                       select
                                              pkh.pkh_id
                                            , pkh.pkh_nm
                                            , null
                                            , false      assigned
                                         from
                                              app_data.passkey_hint pkh
                                        where
                                              not exists (
                                                             select
                                                                    null
                                                               from
                                                                    app_data.web_app_user_passkey_config_atn_hint pah
                                                              where
                                                                    pah.tnt_id = p_tnt_id
                                                                and pah.pkh_id = pkh.pkh_id
                                                         )
                                )
             order by
                      pah_od asc nulls last
                    , pkh_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
