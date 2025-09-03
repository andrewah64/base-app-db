create or replace procedure web_core_auth_aur_grp_tnt_mod.mod_aur
(
        p_tnt_id app_data.app_user.tnt_id%type
,       p_grp_id app_data.app_group.grp_id%type
,       p_aur_id bigint[]
)
as
$$
declare
        v_aur_id bigint[];
        r        record;
begin

        v_aur_id := array ( select
                                   agu.aur_id
                              from
                                        app_data.app_group      grp
                                   join app_data.app_group_user agu on grp.grp_id = agu.grp_id
                             where
                                   grp.tnt_id  = p_tnt_id
                               and grp.grp_id  = p_grp_id
                               and agu.aur_id != all(p_aur_id) );

        merge
         into
              app_data.app_group_user tgt
        using (
                  select
                         aur.aur_id
                       , p_grp_id   grp_id
                    from
                         app_data.app_user aur
                   where
                         aur.tnt_id = p_tnt_id
                     and aur.aur_id = any(p_aur_id)
              ) src
           on (
                      tgt.aur_id = src.aur_id
                  and tgt.grp_id = src.grp_id
              )
         when
              not matched by target
         then
              insert (aur_id, grp_id) values (src.aur_id, src.grp_id)
         when
              not matched by source and tgt.grp_id = p_grp_id
         then
              delete
            ;

        for r in select
                        quote_ident(dbrl.dbrl_nm) dbrl_nm
                      , quote_ident(aur.rolname)  rolname
                   from
                                   app_data.app_user aur
                        cross join app_data.db_role  dbrl
                  where
                        dbrl.dbrl_md = false
                    and aur.tnt_id   = p_tnt_id
                    and aur.aur_id   = any(v_aur_id)
                    and     exists (
                                       -- role is part of the affected group
                                       select
                                              null
                                         from
                                              app_data.app_group_db_role grpdr
                                        where
                                              grpdr.dbrl_id = dbrl.dbrl_id
                                          and grpdr.grp_id  = p_grp_id
                                   )
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
                                       -- role is absent from all of the user's groups
                                       select
                                              null
                                         from
                                                   app_data.app_group_user    agu
                                              join app_data.app_group_db_role grpdr on agu.grp_id = grpdr.grp_id
                                        where
                                              agu.aur_id    = aur.aur_id
                                          and grpdr.dbrl_id = dbrl.dbrl_id
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
        loop
                execute 'revoke ' || r.dbrl_nm || ' from ' || r.rolname;
        end loop;

        for r in select
                        quote_ident(dbrl.dbrl_nm) dbrl_nm
                      , quote_ident(aur.rolname)  rolname
                   from
                                   app_data.app_user aur
                        cross join app_data.db_role  dbrl
                  where
                        aur.tnt_id = p_tnt_id
                    and aur.aur_id = any(p_aur_id)
                    and     exists (
                                       -- user is a member of the affected group
                                       select
                                              null
                                         from
                                              app_data.app_group_user agu
                                        where
                                              agu.aur_id = aur.aur_id
                                          and agu.grp_id = p_grp_id
                                   )
                    and     exists (
                                       -- role is present in at least one of the user's groups
                                       select
                                              null
                                         from
                                                   app_data.app_group_user    agu
                                              join app_data.app_group_db_role grpdr on agu.grp_id = grpdr.grp_id
                                        where
                                              agu.aur_id    = aur.aur_id
                                          and grpdr.dbrl_id = dbrl.dbrl_id
                                   )
                    and not exists (
                                       -- user doesn't have the role
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
        loop
                execute 'grant ' || r.dbrl_nm || ' to ' || r.rolname || ' with inherit true';
        end loop;

end;
$$
language plpgsql
security definer;
