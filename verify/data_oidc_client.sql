do $$
begin
        assert((select count(*) from app_data.oidc_client) > 0);
end $$
