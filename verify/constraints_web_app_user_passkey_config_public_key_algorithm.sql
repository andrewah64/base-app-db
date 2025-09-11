do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'web_app_user_passkey_config'
                  and constraint_name = 'fk_pra_aukc');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_public_key_algorithm'
                  and constraint_name = 'fk_pra_pkg');
end $$
