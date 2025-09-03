create or replace procedure web_core_auth_log_ep_tnt_mod.mod_log
(
        p_tnt_id     app_data.app_user.tnt_id%type
,       p_epp_pt     app_data.endpoint_path.epp_pt%type
,       p_hrm_id     app_data.http_request_method.hrm_id%type
,       p_lvl_id     app_data.log_level.lvl_id%type
,       p_tgt_lvl_id app_data.log_level.lvl_id%type
,       p_by         app_data.app_user.aur_nm%type
)
as
$$
declare

        v_sql varchar :=    ' update '
                         || '        app_data.endpoint_log_level ell '
                         || '    set '
                         || '        lvl_id = $1 '
                         || '      , uby    = $2 '
                         || '      , uts    = now() '
                         || '  where '
                         || '        ell.tnt_id = $3 '
                         ;

begin

        if p_epp_pt is null then
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null or $4 = '''' ) ';
        else
                v_sql := v_sql || ' and exists ( '
                               || '                select '
                               || '                        null '
                               || '                  from '
                               || '                            app_data.endpoint      ep '
                               || '                       join app_data.endpoint_path epp on ep.epp_id = epp.epp_id '
                               || '                 where '
                               || '                       ell.ep_id = ep.ep_id '
                               || '                   and epp.epp_pt like ''%%'' || $4 || ''%%'' '
                               || '            ) '
                                ;
        end if;

        if p_hrm_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $5 is null ) ';
        else
                v_sql := v_sql || ' and exists ( '
                               || '                select '
                               || '                        null '
                               || '                  from '
                               || '                       app_data.endpoint ep '
                               || '                 where '
                               || '                       ell.ep_id = ep.ep_id '
                               || '                   and ep.hrm_id = $5 '
                               || '            ) '
                                ;
        end if;

        if p_lvl_id is null then
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
        else
                v_sql := v_sql || ' and ell.lvl_id = $6 ';
        end if;

        execute v_sql using p_tgt_lvl_id, p_by, p_tnt_id, p_epp_pt, p_hrm_id, p_lvl_id;

end;
$$
language plpgsql
security definer;
