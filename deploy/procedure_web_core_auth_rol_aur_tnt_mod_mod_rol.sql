create or replace procedure web_core_auth_rol_aur_tnt_mod.mod_rol
(
        p_tnt_id     app_data.app_user.tnt_id%type
,       p_cur_aur_id app_data.app_user.aur_id%type
,       p_tgt_aur_id app_data.app_user.aur_id%type
,       p_exp_ts     app_data.app_user_db_role.audr_exp_ts%type
,       p_dbrl_id    bigint[]
,       p_by         app_data.app_user.aur_nm%type
)
as
$$
declare
        v_dbrl_id bigint[];

        r record;
begin
           insert
             into
                  app_data.app_user_db_role
                (
                        aur_id
                ,       dbrl_id
                ,       audr_exp_ts
                ,       cby
                ,       uby
                )
           select
                  p_tgt_aur_id
                , dbrl.dbrl_id
                , p_exp_ts
                , p_by
                , p_by
             from
                  app_data.db_role dbrl
            where
                  dbrl.dbrl_id = any(p_dbrl_id)
              and     exists (
                                 select
                                        null
                                   from
                                             pg_catalog.pg_auth_members pam
                                        join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                        join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                        join app_data.app_user          aur  on pau.rolname = aur.rolname
                                  where
                                        aur.tnt_id  = p_tnt_id
                                    and aur.aur_id  = p_cur_aur_id
                                    and rol.rolname = dbrl.dbrl_nm
                             )
              and not exists (
                                 select
                                        null
                                   from
                                             app_data.app_user         aur
                                        join app_data.app_user_db_role audr on aur.aur_id = audr.aur_id
                                  where
                                        aur.tnt_id       = p_tnt_id
                                    and aur.aur_id       = p_tgt_aur_id
                                    and audr.dbrl_id     = dbrl.dbrl_id
                                    and audr.audr_exp_ts > now ()
                             )
        returning
                  dbrl.dbrl_id
                               into
                                    v_dbrl_id
                ;

        update
               app_data.app_user_db_role audr
           set
               audr_exp_ts = now()
             , uby         = p_by
             , uts         = now()
         where
               audr.dbrl_id     != any(p_dbrl_id)
           and audr.aur_id       = p_tgt_aur_id
           and audr.audr_exp_ts  > now()
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = audr.aur_id
                      )
           and exists (
                          select
                                 null
                            from
                                      pg_catalog.pg_auth_members pam
                                 join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                 join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                 join app_data.db_role           dbrl on rol.rolname = dbrl.dbrl_nm
                                 join app_data.app_user          aur  on pau.rolname = aur.rolname
                           where
                                 aur.tnt_id   = p_tnt_id
                             and aur.aur_id   = p_cur_aur_id
                             and dbrl.dbrl_id = audr.dbrl_id
                      );

        for r in select
                        quote_ident(dbrl.dbrl_nm) dbrl_nm
                      , quote_ident(aur.rolname)  rolname
                   from
                                   app_data.db_role  dbrl
                        cross join app_data.app_user aur
                  where
                        dbrl_id    = any(v_dbrl_id)
                    and aur.tnt_id = p_tnt_id
                    and aur.aur_id = p_tgt_aur_id
        loop
                execute 'grant ' || r.dbrl_nm || ' to ' || r.rolname || ' with inherit true';
        end loop;

end;
$$
language plpgsql
security definer;
