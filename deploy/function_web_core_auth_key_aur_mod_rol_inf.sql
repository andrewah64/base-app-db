create or replace function web_core_auth_key_aur_mod.rol_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_aauk_id app_data.api_app_user_key.aauk_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      dbrl_id
                    , dbrl_ds
                    , assigned
                 from           (
                                    select
                                           dbrl.dbrl_id
                                         , dbrl.dbrl_ds
                                         , true         assigned
                                      from
                                                app_data.db_role     dbrl
                                           join app_data.atn_db_role adr   on dbrl.dbrl_id = adr.dbrl_id
                                           join app_data.api_db_role adbrl on dbrl.dbrl_id = adbrl.dbrl_id
                                     where
                                           exists (
                                                      select
                                                             null
                                                        from
                                                                  pg_catalog.pg_auth_members pam
                                                             join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                                             join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                                             join app_data.app_user          aur  on pau.rolname = aur.rolname
                                                       where
                                                             rol.rolname = dbrl.dbrl_nm
                                                         and aur.tnt_id  = p_tnt_id
                                                         and aur.aur_id  = p_aur_id
                                                  )
                                       and exists (
                                                      select
                                                             null
                                                        from
                                                                  app_data.api_app_user_key_db_role aaukdr
                                                             join app_data.api_app_user_key         aauk   on aaukdr.aauk_id = aauk.aauk_id
                                                             join app_data.app_user                 aur    on aauk.aur_id    = aur.aur_id
                                                       where
                                                             aaukdr.dbrl_id = dbrl.dbrl_id
                                                         and aauk.aauk_id   = p_aauk_id
                                                         and aur.tnt_id     = p_tnt_id
                                                         and aur.aur_id     = p_aur_id
                                                  )
                                )
                      union all
                                (
                                    select
                                           dbrl.dbrl_id
                                         , dbrl.dbrl_ds
                                         , false        assigned
                                      from
                                                app_data.db_role     dbrl
                                           join app_data.atn_db_role adr   on dbrl.dbrl_id = adr.dbrl_id
                                           join app_data.api_db_role adbrl on dbrl.dbrl_id = adbrl.dbrl_id
                                     where
                                               exists (
                                                          select
                                                                 null
                                                            from
                                                                      pg_catalog.pg_auth_members pam
                                                                 join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                                                 join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                                                 join app_data.app_user          aur  on pau.rolname = aur.rolname
                                                           where
                                                                 rol.rolname = dbrl.dbrl_nm
                                                             and aur.tnt_id  = p_tnt_id
                                                             and aur.aur_id  = p_aur_id
                                                      )
                                       and not exists (
                                                          select
                                                                 null
                                                            from
                                                                      app_data.api_app_user_key_db_role aaukdr
                                                                 join app_data.api_app_user_key         aauk   on aaukdr.aauk_id = aauk.aauk_id
                                                                 join app_data.app_user                 aur    on aauk.aur_id    = aur.aur_id
                                                           where
                                                                 aaukdr.dbrl_id = dbrl.dbrl_id
                                                             and aauk.aauk_id   = p_aauk_id
                                                             and aur.tnt_id     = p_tnt_id
                                                             and aur.aur_id     = p_aur_id
                                                      )

                                )
             order by
                      dbrl_ds asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
