do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'tenant'        and constraint_name = 'fk_occ_tnt');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'oidc_provider' and constraint_name = 'fk_occ_ocp');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'endpoint'      and constraint_name = 'fk_occ_ep');

end $$
