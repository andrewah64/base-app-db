do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'org_app_user'
                  and constraint_name = 'fk_ogu_oau');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'org_app_group'
                  and constraint_name = 'fk_ogu_oag');
end $$
