do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'tenant'
                  and constraint_name = 'fk_ell_tnt');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'endpoint'
                  and constraint_name = 'fk_ell_ep');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'log_level'
                  and constraint_name = 'fk_ell_lvl');

end $$
