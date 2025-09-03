do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'api_atn_method'
                   and indexname  = 'uk_aum_aur_dflt') = 1);
end$$;
