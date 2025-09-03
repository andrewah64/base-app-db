create or replace function web_core_auth_grp_tnt_inf.grp_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_grp_nm  app_data.app_group.grp_nm%type
,       p_aur_nm  app_data.app_user.aur_nm%type
,       p_dbrl_id app_data.db_role.dbrl_id%type
,       p_offset  int
,       p_limit   int
)
returns refcursor
as
$$
declare

        v_sql   varchar := '';

        v_sql_a varchar :=    ' select '
                           || '        grp.grp_id '
                           || '      , grp.grp_nm '
                           || '      , grp.grp_can_del '
                           || '      , grp.grp_can_edt '
                           || '      , coalesce(c.num_roles, 0) num_roles '
                           || '      , coalesce(d.num_users, 0) num_users '
                           || '   from '
                           || '             app_data.app_group grp '
                           || '        left join ( '
                           || '                        select '
                           || '                               grpdr.grp_id '
                           || '                             , count(*)     num_roles '
                           || '                          from '
                           || '                               app_data.app_group_db_role grpdr '
                           || '                      group by '
                           || '                               grpdr.grp_id '
                           || '                  ) c '
                           || '               on ( '
                           || '                      grp.grp_id = c.grp_id '
                           || '                  ) '
                           || '        left join ( '
                           || '                        select '
                           || '                               agu.grp_id '
                           || '                             , count(*)     num_users '
                           || '                          from '
                           || '                               app_data.app_group_user agu '
                           || '                      group by '
                           || '                               agu.grp_id '
                           || '                  ) d '
                           || '               on ( '
                           || '                      grp.grp_id = d.grp_id '
                           || '                  ) '
                           || '  where '
                           || '        grp.tnt_id = $1 '
                           || '    and not exists ( '
                           || '                       select '
                           || '                              null '
                           || '                         from '
                           || '                              app_data.app_group_db_role grpdr '
                           || '                        where '
                           || '                              grpdr.grp_id = grp.grp_id '
                           || '                          and not exists ( '
                           || '                                             select '
                           || '                                                    null '
                           || '                                               from '
                           || '                                                         app_data.app_group_user    agu '
                           || '                                                    join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id '
                           || '                                              where '
                           || '                                                    agu.aur_id     = $2 '
                           || '                                                and igrpdr.dbrl_id = grpdr.dbrl_id '
                           || '                                         ) '
                           || '                   ) '
                          ;

        v_sql_b varchar :=    ' select '
                           || '        grp.grp_id '
                           || '      , grp.grp_nm '
                           || '      , false                    grp_can_del '
                           || '      , false                    grp_can_edt '
                           || '      , coalesce(c.num_roles, 0) num_roles '
                           || '      , coalesce(d.num_users, 0) num_users '
                           || '   from '
                           || '             app_data.app_group grp '
                           || '        left join ( '
                           || '                        select '
                           || '                               grpdr.grp_id '
                           || '                             , count(*)     num_roles '
                           || '                          from '
                           || '                               app_data.app_group_db_role grpdr '
                           || '                      group by '
                           || '                               grpdr.grp_id '
                           || '                  ) c '
                           || '               on ( '
                           || '                      grp.grp_id = c.grp_id '
                           || '                  ) '
                           || '        left join ( '
                           || '                        select '
                           || '                               agu.grp_id '
                           || '                             , count(*)     num_users '
                           || '                          from '
                           || '                               app_data.app_group_user agu '
                           || '                      group by '
                           || '                               agu.grp_id '
                           || '                  ) d '
                           || '               on ( '
                           || '                      grp.grp_id = d.grp_id '
                           || '                  ) '
                           || '  where '
                           || '        grp.tnt_id = $1 '
                           || '    and     exists ( '
                           || '                       select '
                           || '                              null '
                           || '                         from '
                           || '                              app_data.app_group_db_role grpdr '
                           || '                        where '
                           || '                              grpdr.grp_id = grp.grp_id '
                           || '                          and not exists ( '
                           || '                                             select '
                           || '                                                    null '
                           || '                                               from '
                           || '                                                         app_data.app_group_user    agu '
                           || '                                                    join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id '
                           || '                                              where '
                           || '                                                    agu.aur_id     = $2 '
                           || '                                                and igrpdr.dbrl_id = grpdr.dbrl_id '
                           || '                                         ) '
                           || '                   ) '
                          ;

begin

        if p_grp_nm is null or p_grp_nm = '' then
                v_sql_a := v_sql_a || ' and ( 1 = 1 or $3 is null or $3 = '''' ) ';
                v_sql_b := v_sql_b || ' and ( 1 = 1 or $3 is null or $3 = '''' ) ';
        else
                v_sql_a := v_sql_a || ' and grp.grp_nm like ''%%'' || $3 || ''%%'' ';
                v_sql_b := v_sql_b || ' and grp.grp_nm like ''%%'' || $3 || ''%%'' ';
        end if;

        if p_aur_nm is null or p_aur_nm = '' then
                v_sql_a := v_sql_a || ' and ( 1 = 1 or $4 is null or $4 = '''' ) ';
                v_sql_b := v_sql_b || ' and ( 1 = 1 or $4 is null or $4 = '''' ) ';
        else
                v_sql_a := v_sql_a || ' and exists ( '
                                   || '                select '
                                   || '                       null '
                                   || '                  from '
                                   || '                            app_data.app_user       aur '
                                   || '                       join app_data.app_group_user agu on aur.aur_id = agu.aur_id '
                                   || '                 where '
                                   || '                       agu.grp_id = grp.grp_id '
                                   || '                   and aur.aur_nm like ''%%'' || $4 || ''%%'' '
                                   || '            ) ';

                v_sql_b := v_sql_b || ' and exists ( '
                                   || '                select '
                                   || '                       null '
                                   || '                  from '
                                   || '                            app_data.app_user       aur '
                                   || '                       join app_data.app_group_user agu on aur.aur_id = agu.aur_id '
                                   || '                 where '
                                   || '                       agu.grp_id = grp.grp_id '
                                   || '                   and aur.aur_nm like ''%%'' || $4 || ''%%'' '
                                   || '            ) ';
        end if;

        if p_dbrl_id is null then
                v_sql_a := v_sql_a || ' and ( 1 = 1 or $5 is null) ';
                v_sql_b := v_sql_b || ' and ( 1 = 1 or $5 is null) ';
        else
                v_sql_a := v_sql_a || ' and exists ( '
                                   || '                select '
                                   || '                       null '
                                   || '                  from '
                                   || '                            pg_catalog.pg_auth_members pam '
                                   || '                       join pg_catalog.pg_authid       pau   on pam.member   = pau.oid '
                                   || '                       join pg_catalog.pg_authid       rol   on pam.roleid   = rol.oid '
                                   || '                       join app_data.db_role           dbrl  on rol.rolname  = dbrl.dbrl_nm '
                                   || '                       join app_data.app_group_db_role grpdr on dbrl.dbrl_id = grpdr.dbrl_id '
                                   || '                 where '
                                   || '                       grpdr.grp_id = grp.grp_id '
                                   || '                   and dbrl.dbrl_id = $5 '
                                   || '            ) ';

                v_sql_b := v_sql_b || ' and exists ( '
                                   || '                select '
                                   || '                       null '
                                   || '                  from '
                                   || '                            pg_catalog.pg_auth_members pam '
                                   || '                       join pg_catalog.pg_authid       pau   on pam.member   = pau.oid '
                                   || '                       join pg_catalog.pg_authid       rol   on pam.roleid   = rol.oid '
                                   || '                       join app_data.db_role           dbrl  on rol.rolname  = dbrl.dbrl_nm '
                                   || '                       join app_data.app_group_db_role grpdr on dbrl.dbrl_id = grpdr.dbrl_id '
                                   || '                 where '
                                   || '                       grpdr.grp_id = grp.grp_id '
                                   || '                   and dbrl.dbrl_id = $5 '
                                   || '            ) ';
        end if;

        v_sql :=    ' select '
                 || '        grp_id '
                 || '      , grp_nm '
                 || '      , grp_can_del '
                 || '      , grp_can_edt '
                 || '      , num_roles '
                 || '      , num_users '
                 || '   from ( '
                 ||                      v_sql_a
                 || '          union all '
                 ||                      v_sql_b
                 || '        ) '
                 || '  where '
                 || '        1 = 1 '
                  ;

        if p_offset is null or p_limit is null then
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $7 is null ) ';
                v_sql := v_sql || ' order by grp_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by grp_nm asc ';
                v_sql := v_sql || ' limit $6 offset $7 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_aur_id, p_grp_nm , p_aur_nm, p_dbrl_id , p_limit , p_offset;

        return $1;
end;
$$
language plpgsql
security definer;
