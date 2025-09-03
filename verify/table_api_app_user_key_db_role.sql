do $$
begin
        assert(select true from pg_tables where schemaname = 'app_data' and tablename = 'api_app_user_key_db_role');
end$$;
