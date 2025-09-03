create or replace function web_core_auth_rol_aur_tnt_mod.rol_inf
(
        refcursor
,       p_tnt_id     app_data.app_user.tnt_id%type
,       p_cur_aur_id app_data.app_user.aur_id%type
,       p_tgt_aur_id app_data.app_user.aur_id%type
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
                    , boosted
                 from (
                             select
                                    dbrl.dbrl_id
                                  , dbrl.dbrl_ds
                                  , false        boosted
                               from
                                    app_data.db_role dbrl
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
                                                      and aur.aur_id  = p_cur_aur_id
                                               )
                                and not exists (
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
                                                      and aur.aur_id  = p_tgt_aur_id
                                               )
                          union all
                             select
                                    dbrl.dbrl_id
                                  , dbrl.dbrl_ds
                                  , true         boosted
                               from
                                    app_data.db_role dbrl
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
                                                  and aur.aur_id  = p_cur_aur_id
                                           )
                                and exists (
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
                                                  and aur.aur_id  = p_tgt_aur_id
                                           )
                                and exists (
                                               select
                                                      null
                                                 from
                                                           app_data.app_user         aur
                                                      join app_data.app_user_db_role audr on aur.aur_id = audr.aur_id
                                                where
                                                      aur.tnt_id       = p_tnt_id
                                                  and aur.aur_id       = p_aur_id
                                                  and audr.dbrl_id     = dbrl.dbrl_id
                                                  and audr.audr_exp_ts > now()
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
