create or replace function web_core_auth_s2c_tnt_inf.spc_inf
(
        refcursor
,       p_tnt_id      app_data.saml2_service_provider_certificate_pair.tnt_id%type
,       p_spc_nm      app_data.saml2_service_provider_certificate_pair.spc_nm%type
,       p_spc_inc_ts  app_data.saml2_service_provider_certificate_pair.spc_inc_ts%type
,       p_spc_exp_ts  app_data.saml2_service_provider_certificate_pair.spc_exp_ts%type
,       p_spc_enabled app_data.saml2_service_provider_certificate_pair.spc_enabled%type
,       p_offset      int
,       p_limit       int
)
returns refcursor
as
$$
declare

        v_sql varchar :=    ' select '
                         || '        spc.spc_id '
                         || '      , spc.spc_nm '
                         || '      , spc.spc_cn_nm '
                         || '      , spc.spc_inc_ts '
                         || '      , spc.spc_exp_ts '
                         || '      , spc.spc_enabled '
                         || '   from '
                         || '        app_data.saml2_service_provider_certificate_pair spc '
                         || '  where '
                         || '        spc.tnt_id = $1 '
                         ;

begin

        if p_spc_nm is null or p_spc_nm = '' then
                v_sql := v_sql || ' and ( 1 = 1 or $2 is null or $2 = '''' ) ';
        else
                v_sql := v_sql || ' and spc.spc_nm like ''%%'' || $2 || ''%%'' ';
        end if;

        if p_spc_inc_ts is     null and p_spc_exp_ts is     null then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null ) ';
        end if;

        if p_spc_inc_ts is not null and p_spc_exp_ts is     null then
                v_sql := v_sql || ' and spc.spc_inc_ts >= $3 ';
                v_sql := v_sql || ' and ( 1 = 1 or $4 is null ) ';
        end if;

        if p_spc_inc_ts is     null and p_spc_exp_ts is not null then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null ) ';
                v_sql := v_sql || ' and spc.spc_exp_ts <= $4 ';
        end if;

        if p_spc_inc_ts is not null and p_spc_exp_ts is not null then
                v_sql := v_sql || ' and spc.spc_inc_ts >= $3 ';
                v_sql := v_sql || ' and spc.spc_exp_ts <= $4 ';
        end if;

        if p_spc_enabled is null then
                v_sql := v_sql || ' and ( 1 = 1 or $5 ) ';
        else
                v_sql := v_sql || ' and spc.spc_enabled = $5 ';
        end if;

        if p_offset is     null and p_limit is     null then
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $7 is null ) ';
                v_sql := v_sql || ' order by spc_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by spc_enabled desc, spc_nm asc ';
                v_sql := v_sql || ' limit $6 offset $7 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_spc_nm , p_spc_inc_ts, p_spc_exp_ts , p_spc_enabled , p_limit , p_offset;

        return $1;
end;
$$
language plpgsql
security definer;
