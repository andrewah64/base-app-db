do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'web_app_user_passkey'
                  and constraint_name = 'fk_kat_pky');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_authenticator_transport'
                  and constraint_name = 'fk_kat_pat');

end $$
