do $$
begin

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'atn_endpoint'
                  and constraint_name = 'fk_auell_aep');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'app_user'
                  and constraint_name = 'fk_auell_aur');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'log_level'
                  and constraint_name = 'fk_auell_lvl');

end $$
