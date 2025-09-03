do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'oidc_provider_scope' and constraint_name = 'fk_occps_ocps');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'oidc_client'         and constraint_name = 'fk_occps_occ');
end $$
