do $$
begin
        assert(select true from pg_tables where schemaname = 'app_data' and tablename = 'oidc_client_provider_scope');
end$$;
