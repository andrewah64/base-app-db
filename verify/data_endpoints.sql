do $$
begin
        assert((select count(*) from app_data.endpoint) > 0);
end $$
