do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'tenant'
                  and constraint_name = 'fk_s2c_tnt');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'web_atn_saml2_method'
                  and constraint_name = 'fk_s2c_aum');


        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'endpoint'
                  and constraint_name = 'fk_s2c_ep_acs');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'endpoint'
                  and constraint_name = 'fk_s2c_ep_mtd');

end $$
