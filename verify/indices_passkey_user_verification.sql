do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'passkey_user_verification'
                   and indexname  = 'uk_puv_aukc_dflt') = 1);
end$$;
