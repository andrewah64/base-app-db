do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'web_app_user_passkey'
                   and indexname  = 'uk_pky_enabled') = 1);
end$$;
