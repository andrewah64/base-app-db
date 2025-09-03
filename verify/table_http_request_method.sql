do $$
begin
        assert(select true from pg_tables where schemaname = 'app_data' and tablename = 'http_request_method');
end$$;
