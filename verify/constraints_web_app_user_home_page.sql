do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'web_app_user' and constraint_name = 'fk_wauhp_waur');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'home_page'    and constraint_name = 'fk_wauhp_hpg');
end $$
