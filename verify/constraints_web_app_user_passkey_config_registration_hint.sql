do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'web_app_user_passkey_config'
                  and constraint_name = 'fk_prh_aukc');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_hint'
                  and constraint_name = 'fk_prh_pkh');

end $$
