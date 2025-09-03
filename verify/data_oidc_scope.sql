do $$
begin
        assert((select count(*) from app_data.oidc_scope) > 0);
end $$
