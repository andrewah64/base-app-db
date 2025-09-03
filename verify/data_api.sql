do $$
begin
        assert((select count(*) from app_data.api) > 0);
end $$
