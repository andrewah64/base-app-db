do $$
begin

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'tenant'
                  and constraint_name = 'fk_aukc_tnt');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_attestation'
                  and constraint_name = 'fk_aukc_pka');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_attachment'
                  and constraint_name = 'fk_aukc_pkt');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_discoverable_credential'
                  and constraint_name = 'fk_aukc_pdc');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_user_verification'
                  and constraint_name = 'fk_aukc_puv_reg');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'passkey_user_verification'
                  and constraint_name = 'fk_aukc_puv_atn');

end $$
