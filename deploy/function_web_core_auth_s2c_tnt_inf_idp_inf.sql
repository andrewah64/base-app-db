create or replace function web_core_auth_s2c_tnt_inf.idp_inf
(
        refcursor
,       p_tnt_id        app_data.saml2_identity_provider.tnt_id%type
,       p_idp_nm        app_data.saml2_identity_provider.idp_nm%type
,       p_idp_entity_id app_data.saml2_identity_provider.idp_entity_id%type
,       p_idp_enabled   app_data.saml2_identity_provider.idp_enabled%type
,       p_offset        int
,       p_limit         int
)
returns refcursor
as
$$
declare

        v_sql varchar :=    ' select '
                         || '        idp.idp_id '
                         || '      , idp.idp_nm '
                         || '      , idp.idp_entity_id '
                         || '      , idp.idp_enabled '
                         || '      , coalesce(mde.num_mde, 0) num_mde '
                         || '      , coalesce(sso.num_sso, 0) num_sso '
                         || '      , coalesce(slo.num_slo, 0) num_slo '
                         || '   from '
                         || '                  app_data.saml2_identity_provider idp '
                         || '        left join ( '
                         || '                        select '
                         || '                               mde.idp_id '
                         || '                             , count(*)   num_mde '
                         || '                          from '
                         || '                                app_data.saml2_identity_provider_metadata_endpoint mde '
                         || '                      group by '
                         || '                               mde.idp_id '
                         || '                  ) mde '
                         || '               on ( '
                         || '                      idp.idp_id = mde.idp_id '
                         || '                  ) '
                         || '        left join ( '
                         || '                        select '
                         || '                               sso.idp_id '
                         || '                             , count(*)   num_sso '
                         || '                          from '
                         || '                               app_data.saml2_identity_provider_sso_endpoint sso '
                         || '                      group by '
                         || '                               sso.idp_id '
                         || '                  ) sso '
                         || '               on ( '
                         || '                      idp.idp_id = sso.idp_id '
                         || '                  ) '
                         || '        left join ( '
                         || '                        select '
                         || '                               slo.idp_id '
                         || '                             , count(*)   num_slo '
                         || '                          from '
                         || '                               app_data.saml2_identity_provider_slo_endpoint slo '
                         || '                      group by '
                         || '                               slo.idp_id '
                         || '                  ) slo '
                         || '               on ( '
                         || '                      idp.idp_id = slo.idp_id '
                         || '                  ) '
                         || '  where '
                         || '        idp.tnt_id = $1 '
                         ;

begin

        if p_idp_nm is null or p_idp_nm = '' then
                v_sql := v_sql || ' and ( 1 = 1 or $2 is null or $2 = '''' ) ';
        else
                v_sql := v_sql || ' and idp.idp_nm like ''%%'' || $2 || ''%%'' ';
        end if;

        if p_idp_entity_id is null or p_idp_entity_id = '' then
                v_sql := v_sql || ' and ( 1 = 1 or $3 is null or $3 = '''' ) ';
        else
                v_sql := v_sql || ' and idp.idp_identity_id like ''%%'' || $3 || ''%%'' ';
        end if;

        if p_idp_enabled is null then
                v_sql := v_sql || ' and ( 1 = 1 or $4 ) ';
        else
                v_sql := v_sql || ' and idp.idp_enabled = $4 ';
        end if;

        if p_offset is     null and p_limit is     null then
                v_sql := v_sql || ' and ( 1 = 1 or $5 is null ) ';
                v_sql := v_sql || ' and ( 1 = 1 or $6 is null ) ';
                v_sql := v_sql || ' order by spc_nm asc ';
        end if;

        if p_offset is not null and p_limit is not null then
                v_sql := v_sql || ' order by idp_enabled desc, idp_nm asc ';
                v_sql := v_sql || ' limit $5 offset $6 ';
        end if;

        open $1 for execute format ( v_sql ) using p_tnt_id , p_idp_nm , p_idp_entity_id, p_idp_enabled , p_limit , p_offset;

        return $1;
end;
$$
language plpgsql
security definer;
