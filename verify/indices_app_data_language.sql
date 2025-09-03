do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'language'
                   and indexname  = 'uk_lng_aur_dflt') = 1);
end$$;
