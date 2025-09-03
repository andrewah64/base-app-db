do $$
begin
        assert((select count(*) from app_data.oidc_provider) > 0);
end $$
