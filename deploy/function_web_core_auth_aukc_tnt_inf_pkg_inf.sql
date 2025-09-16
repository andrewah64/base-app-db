create or replace function web_core_auth_aukc_tnt_inf.pkg_inf
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
                      pkg_id
                    , pkg_nm
                    , assigned
                 from           (
                                       select
                                              pkg.pkg_id
                                            , pkg.pkg_nm
                                            , true       assigned
                                         from
                                              app_data.passkey_public_key_algorithm pkg
                                        where
                                                  exists (
                                                             select
                                                                    null
                                                               from
                                                                    app_data.web_app_user_passkey_config_public_key_algorithm pra
                                                              where
                                                                    pra.tnt_id = p_tnt_id
                                                                and pra.pkg_id = pkg.pkg_id
                                                         )
                                    union all
                                       select
                                              pkg.pkg_id
                                            , pkg.pkg_nm
                                            , false      assigned
                                         from
                                              app_data.passkey_public_key_algorithm pkg
                                        where
                                              not exists (
                                                             select
                                                                    null
                                                               from
                                                                    app_data.web_app_user_passkey_config_public_key_algorithm pra
                                                              where
                                                                    pra.tnt_id = p_tnt_id
                                                                and pra.pkg_id = pkg.pkg_id
                                                         )
                                )
             order by
                      pkg_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
