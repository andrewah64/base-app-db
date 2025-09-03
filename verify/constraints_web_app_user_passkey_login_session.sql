do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'web_app_user'
                  and constraint_name = 'fk_pls_waur');

end $$
