do $$
begin
        assert((select count(*) from app_data.oidc_provider_scope) > 0);
end $$
