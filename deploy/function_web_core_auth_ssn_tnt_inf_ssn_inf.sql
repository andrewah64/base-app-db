create or replace function web_core_auth_ssn_tnt_inf.ssn_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_nm  app_data.app_user.aur_nm%type
,       p_offset  int
,       p_limit   int
)
returns refcursor
as
$$
declare

        v_sql varchar :=    ' select '
                         || '        aur.aur_nm '
                         || '      , aur.rolname '
                         || '      , wauhs.wauhs_ssn_tk '
                         || '      , wauhs.cts '
                         || '      , wauhs.wauhs_exp_ts '
                         || '   from '
                         || '             app_data.app_user                  aur '
                         || '        join app_data.web_app_user_http_session wauhs on aur.aur_id = wauhs.aur_id '
                         || '        join ( '
                         || '                   select '
                         || '                          wauhs.aur_id '
                         || '                        , max(wauhs_exp_ts) wauhs_exp_ts '
                         || '                     from '
                         || '                          app_data.web_app_user_http_session wauhs '
                         || '                    where '
                         || '                          wauhs.wauhs_exp_ts >= current_timestamp '
                         || '                 group by '
                         || '                          wauhs.aur_id '
                         || '             ) '
                         || '             mrs on ( '
                         || '                            wauhs.aur_id       = mrs.aur_id '
                         || '                        and wauhs.wauhs_exp_ts = mrs.wauhs_exp_ts '
                         || '                    ) '
                         || '  where '
                         || '        aur.tnt_id = $1 '
                          ;

begin

        if p_aur_nm is null then
                v_sql := v_sql || ' and ( 1 = 1 or $2 is null or $2 = '''' ) ';
        else
                v_sql := v_sql || ' and aur.aur_nm like ''%%'' || $2 || ''%%'' ';
        end if;

        if p_offset is null or p_limit is null then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null ) ';
                v_sql := v_sql || ' order by aur.aur_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by aur.aur_nm asc ';
                v_sql := v_sql || ' limit $3 offset $4 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_aur_nm, p_limit, p_offset;

        return $1;

end;
$$
language plpgsql
security definer;
