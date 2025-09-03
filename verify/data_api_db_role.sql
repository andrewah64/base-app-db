do $$
begin
        assert((select count(*) from app_data.api_db_role) > 0);
end $$
