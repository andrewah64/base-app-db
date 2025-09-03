do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'page'  and constraint_name = 'fk_hpg_pg');

end $$
