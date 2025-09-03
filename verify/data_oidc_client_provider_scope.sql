do $$
begin
        assert((select count(*) from app_data.oidc_client_provider_scope) > 0);
end $$
