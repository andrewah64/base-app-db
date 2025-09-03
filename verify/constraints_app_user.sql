do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'language'  and constraint_name = 'fk_aur_lng');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema = 'app_data' and table_name = 'tenant'    and constraint_name = 'fk_aur_tnt');

end $$
