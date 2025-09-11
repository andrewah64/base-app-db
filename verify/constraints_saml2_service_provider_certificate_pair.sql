do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'web_app_user_saml2_config'
                  and constraint_name = 'fk_spc_s2c');
end $$
