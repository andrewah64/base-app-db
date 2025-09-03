do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'endpoint' and constraint_name = 'fk_edr_ep');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'db_role' and constraint_name = 'fk_edr_dbrl');
end $$
