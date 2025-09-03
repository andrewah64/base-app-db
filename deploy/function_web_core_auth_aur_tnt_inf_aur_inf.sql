create or replace function web_core_auth_aur_tnt_inf.aur_inf
(
        refcursor
,       p_tnt_id      app_data.tenant.tnt_id%type
,       p_aur_nm      app_data.app_user.aur_nm%type
,       p_aur_enabled app_data.web_app_user.aur_enabled%type
,       p_dbrl_id     app_data.db_role.dbrl_id%type
,       p_lng_id      app_data.language.lng_id%type
,       p_offset      int
,       p_limit       int
)
returns refcursor
as
$$
declare

        v_sql varchar :=    ' select '
                         || '        aur.aur_id         userid   '
                         || '      , aur.aur_nm         username '
                         || '      , aur.rolname        userrole '
                         || '      , waur.aur_enabled   userenabled '
                         || '      , lng.lng_nm         userlanguage '
                         || '      , pg.pg_nm           userhomepage '
                         || '   from '
                         || '             app_data.app_user               aur '
                         || '        join app_data.web_app_user           waur  on aur.aur_id  = waur.aur_id '
                         || '        join app_data.web_app_user_home_page wauhp on waur.aur_id = wauhp.aur_id '
                         || '        join app_data.language               lng   on aur.lng_id  = lng.lng_id '
                         || '        join app_data.page                   pg    on wauhp.pg_id = pg.pg_id '
                         || '  where '
                         || '        aur.tnt_id = $1 '
                          ;

begin

        if p_aur_nm is null or p_aur_nm = '' then
                v_sql := v_sql || ' and ( 1 = 1 or $2 is null or $2 = '''' ) ';
        else
                v_sql := v_sql || ' and aur.aur_nm like ''%%'' || $2 || ''%%'' ';
        end if;

        if p_aur_enabled is null then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null ) ';
        else
                v_sql := v_sql || ' and waur.aur_enabled = $3 ';
        end if;

        if p_dbrl_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null) ';
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
                               || '                   and dbrl.dbrl_id = $4 '
                               || '            ) ';
        end if;

        if p_lng_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $5 is null ) ';
        else
                v_sql := v_sql || ' and aur.lng_id = $5 ';
        end if;

        if p_offset is null or p_limit is null then
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $7 is null ) ';
                v_sql := v_sql || ' order by aur.aur_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by aur.aur_nm asc ';
                v_sql := v_sql || ' limit $6 offset $7 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_aur_nm , p_aur_enabled, p_dbrl_id , p_lng_id , p_limit , p_offset;

        return $1;
end;
$$
language plpgsql
security definer;
