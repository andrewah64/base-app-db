create or replace function web_core_auth_key_aur_mod.key_inf
(
        refcursor
,       p_tnt_id       app_data.tenant.tnt_id%type
,       p_aur_id       app_data.api_app_user_key.aur_id%type
,       p_aauk_nm      app_data.api_app_user_key.aauk_nm%type
,       p_aauk_enabled app_data.api_app_user_key.aauk_enabled%type
,       p_dbrl_id      app_data.db_role.dbrl_id%type
,       p_offset       int
,       p_limit        int
)
returns refcursor
as
$$
declare

        v_sql varchar :=    ' select '
                         || '        aauk.aauk_id '
                         || '      , aauk.aauk_nm '
                         || '      , aauk.aauk_enabled '
                         || '      , coalesce( c.num_roles , 0 ) num_roles '
                         || '   from '
                         || '                  app_data.api_app_user_key aauk '
                         || '             join app_data.app_user         aur  on aauk.aur_id = aur.aur_id '
                         || '        left join ( '
                         || '                        select '
                         || '                               aaukdr.aauk_id '
                         || '                             , count(*)       num_roles '
                         || '                          from '
                         || '                               app_data.api_app_user_key_db_role aaukdr '
                         || '                         where '
                         || '                               exists ( '
                         || '                                          select '
                         || '                                                 null '
                         || '                                            from '
                         || '                                                      app_data.api_app_user_key iaauk '
                         || '                                                 join app_data.app_user         iaur  on iaauk.aur_id = iaur.aur_id '
                         || '                                           where '
                         || '                                                 iaur.tnt_id = $1 '
                         || '                                             and iaur.aur_id = $2 '
                         || '                                      ) '
                         || '                      group by '
                         || '                               aaukdr.aauk_id '
                         || '                  ) c '
                         || '               on ( '
                         || '                      aauk.aauk_id = c.aauk_id '
                         || '                  ) '
                         || '  where '
                         || '        aur.tnt_id = $1 '
                         || '    and aur.aur_id = $2 '
                          ;

begin

        if p_aauk_nm is null then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null or $3 = '''' ) ';
        else
                v_sql := v_sql || ' and aauk.aauk_nm like ''%%'' || $3 || ''%%'' ';
        end if;

        if p_aauk_enabled is null then
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null ) ';
        else
                v_sql := v_sql || ' and aauk.aauk_enabled = $4 ';
        end if;

        if p_dbrl_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $5 is null) ';
        else
                v_sql := v_sql || ' and exists ( '
                               || '                select '
                               || '                       null '
                               || '                  from '
                               || '                            pg_catalog.pg_auth_members pam '
                               || '                       join pg_catalog.pg_authid       pau  on pam.member  = pau.oid '
                               || '                       join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid '
                               || '                       join app_data.db_role           dbrl on rol.rolname = dbrl.dbrl_nm '
                               || '                 where '
                               || '                       pau.rolname  = aur.rolname '
                               || '                   and dbrl.dbrl_id = $5 '
                               || '            ) '
                               || ' and exists ( '
                               || '                select '
                               || '                       null '
                               || '                  from '
                               || '                       app_data.api_app_user_key_db_role aaukdr '
                               || '                 where '
                               || '                       aauk.aauk_id   = aaukdr.aauk_id '
                               || '                   and aaukdr.dbrl_id = $5 '
                               || '            ) ';
        end if;

        if p_offset is null or p_limit is null then
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $7 is null ) ';
                v_sql := v_sql || ' order by aauk.aauk_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by aauk.aauk_nm asc ';
                v_sql := v_sql || ' limit $6 offset $7 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_aur_id , p_aauk_nm, p_aauk_enabled, p_dbrl_id , p_limit , p_offset;

        return $1;

end;
$$
language plpgsql
security definer;

create or replace function web_core_auth_key_aur_mod.key_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
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
                    aauk.aauk_id
                  , aauk.aauk_nm
               from
                    app_data.api_app_user_key aauk
              where
                    aauk.aauk_id = p_aauk_id
                and exists (
                               select
                                      null
                                 from
                                      app_data.app_user aur
                                where
                                      aur.aur_id = aauk.aur_id
                                  and aur.tnt_id = p_tnt_id
                           );

        return $1;

end;
$$
language plpgsql
security definer;
