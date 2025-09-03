do $$
begin
        assert(select true from pg_tables where schemaname = 'app_data' and tablename = 'web_atn_method');
end$$;
