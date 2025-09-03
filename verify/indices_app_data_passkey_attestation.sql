do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'passkey_attestation'
                   and indexname  = 'uk_pka_aukc_dflt') = 1);
end$$;
