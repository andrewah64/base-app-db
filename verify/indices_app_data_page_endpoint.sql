do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'page_endpoint'
                   and indexname  = 'uk_pe_is_entry') = 1);
end$$;
