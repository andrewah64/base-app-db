do $$
begin
        insert into app_data.oidc_provider (ocp_nm)
        select 'google'
         where not exists (select null
                             from app_data.oidc_provider ocp
                            where ocp.ocp_nm = 'google');

        insert into app_data.oidc_provider (ocp_nm)
        select 'microsoft'
         where not exists (select null
                             from app_data.oidc_provider ocp
                            where ocp.ocp_nm = 'microsoft');

        commit;
end $$
