do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'passkey_attachment'
                   and indexname  = 'uk_pkt_aukc_dflt') = 1);
end$$;
