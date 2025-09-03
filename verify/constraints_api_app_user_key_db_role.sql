do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'api_app_user_key' and constraint_name = 'fk_aaukdr_aauk');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'api_db_role'      and constraint_name = 'fk_aaukdr_adbrl');

end $$
