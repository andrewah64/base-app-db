do $$
begin
        assert((select count(*) from app_data.api_endpoint) > 0);
end $$
