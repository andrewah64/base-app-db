do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'oidc_provider' and constraint_name = 'fk_ocps_ocp');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'oidc_scope'    and constraint_name = 'fk_ocps_ocs');

end $$
