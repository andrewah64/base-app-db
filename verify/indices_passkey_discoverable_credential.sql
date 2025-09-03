do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'passkey_discoverable_credential'
                   and indexname  = 'uk_pdc_aukc_dflt') = 1);
end$$;
