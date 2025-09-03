do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'home_page'
                   and indexname  = 'uk_pg_aur_dflt') = 1);
end$$;
