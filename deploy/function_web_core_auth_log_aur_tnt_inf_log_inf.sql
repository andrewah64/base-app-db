create or replace function web_core_auth_log_aur_tnt_inf.log_inf
(
        refcursor
,       p_tnt_id   app_data.tenant.tnt_id%type
,       p_aur_nm   app_data.app_user.aur_nm%type
,       p_epp_pt   app_data.endpoint_path.epp_pt%type
,       p_hrm_id   app_data.http_request_method.hrm_id%type
,       p_lvl_id   app_data.log_level.lvl_id%type
,       p_offset   int
,       p_limit    int
)
returns refcursor
as
$$
declare

        v_sql varchar :=    ' select '
                         || '        auell.auell_id '
                         || '      , aur.aur_nm '
                         || '      , epp.epp_pt '
                         || '      , hrm.hrm_nm '
                         || '      , lvl.lvl_nm '
                         || '   from '
                         || '             app_data.app_user                    aur '
                         || '        join app_data.app_user_endpoint_log_level auell on aur.aur_id   = auell.aur_id '
                         || '        join app_data.atn_endpoint               aep   on auell.ep_id  = aep.ep_id '
                         || '        join app_data.endpoint                    ep    on aep.ep_id    = ep.ep_id '
                         || '        join app_data.endpoint_path               epp   on ep.epp_id    = epp.epp_id '
                         || '        join app_data.http_request_method         hrm   on ep.hrm_id    = hrm.hrm_id '
                         || '        join app_data.log_level                   lvl   on auell.lvl_id = lvl.lvl_id '
                         || '  where '
                         || '        aur.tnt_id = $1 '
                          ;

begin

        if p_aur_nm is null then
                v_sql := v_sql || ' and ( 1 = 1 or $2 is null or $2 = '''' ) ';
        else
                v_sql := v_sql || ' and aur.aur_nm like ''%%'' || $2 || ''%%'' ';
        end if;

        if p_epp_pt is null or p_epp_pt = '' then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null or $3 = '''' ) ';
        else
                v_sql := v_sql || ' and epp.epp_pt like ''%%'' || $3 || ''%%'' ';
        end if;

        if p_hrm_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null ) ';
        else
                v_sql := v_sql || ' and hrm.hrm_id = $4 ';
        end if;

        if p_lvl_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $5 is null ) ';
        else
                v_sql := v_sql || ' and lvl.lvl_id = $5 ';
        end if;

        if p_offset is null or p_limit is null then
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $7 is null ) ';
                v_sql := v_sql || ' order by aur.aur_nm asc, epp.epp_pt asc, hrm.hrm_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by aur.aur_nm asc, epp.epp_pt asc, hrm.hrm_nm asc ';
                v_sql := v_sql || ' limit $6 offset $7 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_aur_nm , p_epp_pt, p_hrm_id, p_lvl_id, p_limit, p_offset;

        return $1;
end;
$$
language plpgsql
security definer;
