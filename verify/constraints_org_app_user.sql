do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'org'
                  and constraint_name = 'fk_oau_org');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'app_user'
                  and constraint_name = 'fk_oau_aur');

end $$
