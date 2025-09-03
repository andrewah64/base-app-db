create or replace procedure web_core_auth_rol_grp_tnt_mod.mod_rol
(
        p_tnt_id  app_data.app_user.tnt_id%type
,       p_grp_id  app_data.app_group.grp_id%type
,       p_dbrl_id bigint[]
,       p_by      app_data.app_user.aur_nm%type
)
as
$$
declare
        r record;
begin

        merge
         into
              app_data.app_group_db_role tgt
        using (
                     select
                            p_grp_id     grp_id
                          , adr.dbrl_id
                       from
                                 app_data.db_role     dbrl
                            join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
                      where
                            dbrl.dbrl_md = false
                        and adr.dbrl_id  = any(p_dbrl_id)
                        and exists (
                                       select
                                              null
                                         from
                                              app_data.app_group grp
                                        where
                                              grp.tnt_id = p_tnt_id
                                          and grp.grp_id = p_grp_id
                                   )
                  union all
                     select
                            p_grp_id     grp_id
                          , adr.dbrl_id
                       from
                                 app_data.db_role     dbrl
                            join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
                      where
                            dbrl.dbrl_md = true
              ) src
           on (
                      tgt.grp_id  = src.grp_id
                  and tgt.dbrl_id = src.dbrl_id
              )
         when
              not matched by target
         then
              insert (grp_id, dbrl_id, cby, uby) values (src.grp_id, src.dbrl_id, p_by, p_by)
         when
              not matched by source and tgt.grp_id = p_grp_id
         then
              delete
            ;

       update
              app_data.web_app_user_home_page tgt
          set
              pg_id = src.pg_id
            , uby   = p_by
            , uts   = now()
         from
              (
                  select
                         aur_id
                       , pg_id
                    from (
                             select
                                    waur.aur_id
                                  , hpg.pg_id
                                  , row_number() over (partition by
                                                                    waur.aur_id
                                                           order by
                                                                    hpg.pg_id)   rn
                               from
                                               app_data.app_user     aur
                                          join app_data.web_app_user waur on aur.aur_id = waur.aur_id
                                    cross join app_data.home_page    hpg
                              where
                                    aur.tnt_id = p_tnt_id
                                and     exists (
                                                   -- user is a member of the affected group
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_user agu
                                                    where
                                                          agu.aur_id = waur.aur_id
                                                      and agu.grp_id = p_grp_id
                                               )
                                and     exists (
                                                   -- the user has the role required to acccess the page
                                                   select
                                                          null
                                                     from
                                                               app_data.app_group_user    agu
                                                          join app_data.app_group_db_role grpdr on agu.grp_id    = grpdr.grp_id
                                                          join app_data.endpoint_db_role  edr   on grpdr.dbrl_id = edr.dbrl_id
                                                          join app_data.page_endpoint     pe    on edr.ep_id     = pe.ep_id
                                                    where
                                                          agu.aur_id     = waur.aur_id
                                                      and pe.pg_id       = hpg.pg_id
                                                      and pe.pe_is_entry = true
                                               )
                                and not exists (
                                                   -- the role to access to the user's home page absent from the user's groups
                                                   select
                                                          null
                                                     from
                                                               app_data.web_app_user_home_page wauhp
                                                          join app_data.page_endpoint          pe    on wauhp.pg_id = pe.pg_id
                                                          join app_data.endpoint_db_role       edr   on pe.ep_id    = edr.ep_id
                                                          join app_data.app_group_user         agu   on wauhp.aur_id = agu.aur_id
                                                          join app_data.app_group_db_role      grpdr on (
                                                                                                                agu.grp_id    = grpdr.grp_id
                                                                                                            and grpdr.dbrl_id = edr.dbrl_id
                                                                                                        )
                                                    where
                                                          pe.pe_is_entry = true
                                                      and wauhp.aur_id   = waur.aur_id
                                               )
                         )
                   where
                         rn = 1
              ) src
        where
              tgt.aur_id = src.aur_id
            ;

        for r in select
                        quote_ident(dbrl.dbrl_nm) dbrl_nm
                      , quote_ident(aur.rolname)  rolname
                   from
                                   app_data.app_user aur
                        cross join (
                                            app_data.db_role     dbrl
                                       join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
                                   )
                  where
                        dbrl.dbrl_md = false
                    and aur.tnt_id   = p_tnt_id
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
                        cross join (
                                            app_data.db_role     dbrl
                                       join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
                                   )
                  where
                        aur.tnt_id = p_tnt_id
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
