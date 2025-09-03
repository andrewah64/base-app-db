do $$
begin
        assert(select true from pg_tables where schemaname = 'app_data' and tablename = 'app_user');
end$$;
