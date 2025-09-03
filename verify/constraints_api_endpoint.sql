do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'api'
                  and constraint_name = 'fk_apie_api');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'endpoint'
                  and constraint_name = 'fk_apie_ep');

end $$
