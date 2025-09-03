do $$
begin
        assert((select count(*) from app_data.home_page) > 0);
end $$
