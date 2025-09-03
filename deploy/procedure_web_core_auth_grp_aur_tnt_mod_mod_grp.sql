create or replace procedure web_core_auth_grp_aur_tnt_mod.mod_grp
(
        p_tnt_id     app_data.app_user.tnt_id%type
,       p_cur_aur_id app_data.app_user.aur_id%type
,       p_tgt_aur_id app_data.app_user.aur_id%type
,       p_grp_id     bigint[]
,       p_by         app_data.app_user.aur_nm%type
)
as
$$
declare
        r record;
begin

        merge
         into
              app_data.app_group_user tgt
        using (
                  select
                         grp.grp_id
                       , p_tgt_aur_id aur_id
                    from
                         app_data.app_group grp
                   where
                         grp.tnt_id = p_tnt_id
                     and grp.grp_id = any(p_grp_id)
                     and not exists (
                                        select
                                               null
                                          from
                                               app_data.app_group_db_role grpdr
                                         where
                                               grpdr.grp_id = grp.grp_id
                                           and not exists (
                                                              select
                                                                     null
                                                                from
                                                                          app_data.app_group_user    agu
                                                                     join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id
                                                               where
                                                                     agu.aur_id     = p_cur_aur_id
                                                                 and igrpdr.dbrl_id = grpdr.dbrl_id
                                                          )
                                    )
              ) src
           on (
                      tgt.grp_id = src.grp_id
                  and tgt.aur_id = src.aur_id
              )
         when
              not matched by target
         then
              insert (grp_id, aur_id, cby, uby) values (src.grp_id, src.aur_id, p_by, p_by)
         when
              not matched by source and tgt.aur_id = p_tgt_aur_id
         then
              delete
            ;

        for r in select
                        quote_ident(dbrl.dbrl_nm) dbrl_nm
                      , quote_ident(aur.rolname)  rolname
                   from
                                   app_data.db_role  dbrl
                        cross join app_data.app_user aur
                  where
                        aur.tnt_id = p_tnt_id
                    and aur.aur_id = p_tgt_aur_id
                    and     exists (
                                       -- user has the role
                                       select
                                              null
                                         from
                                                   pg_catalog.pg_auth_members pam
                                              join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                              join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                        where
                                              pau.rolname = aur.rolname
                                          and rol.rolname = dbrl.dbrl_nm
                                   )
                    and not exists (
                                       -- role is not boosted
                                       select
                                              null
                                         from
                                              app_data.app_user_db_role audr
                                        where
                                              audr.aur_id      = aur.aur_id
                                          and audr.dbrl_id     = dbrl.dbrl_id
                                          and audr.audr_exp_ts > now()
                                   )
                    and not exists (
                                       -- absent from the user's groups
                                       select
                                              null
                                         from
                                                   app_data.app_group_user    agu
                                              join app_data.app_group_db_role grpdr on agu.grp_id = grpdr.grp_id
                                        where
                                              agu.aur_id    = aur.aur_id
                                          and grpdr.dbrl_id = dbrl.dbrl_id
                                   )
        loop
                execute 'revoke ' || r.dbrl_nm || ' from ' || r.rolname;
        end loop;

        for r in select
                        quote_ident(dbrl.dbrl_nm) dbrl_nm
                      , quote_ident(aur.rolname)  rolname
                   from
                                   app_data.db_role  dbrl
                        cross join app_data.app_user aur
                  where
                        aur.aur_id = p_tgt_aur_id
                    and not exists (
                                       -- user does not have the role
                                       select
                                              null
                                         from
                                                   pg_catalog.pg_auth_members pam
                                              join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                              join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                        where
                                              pau.rolname = aur.rolname
                                          and rol.rolname = dbrl.dbrl_nm
                                   )
                    and     exists (
                                       -- present in the user's groups
                                       select
                                              null
                                         from
                                                   app_data.app_group_user    agu
                                              join app_data.app_group_db_role grpdr on agu.grp_id = grpdr.grp_id
                                        where
                                              agu.aur_id    = aur.aur_id
                                          and grpdr.dbrl_id = dbrl.dbrl_id
                                   )
        loop
                execute 'grant ' || r.dbrl_nm || ' to ' || r.rolname || ' with inherit true';
        end loop;

end;
$$
language plpgsql
security definer;
