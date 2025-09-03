do $$
begin
        assert(select true from pg_tables where schemaname = 'app_data' and tablename = 'web_app_user_passkey');
end$$;
