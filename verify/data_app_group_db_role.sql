do $$
begin
        assert((select count(*) from app_data.app_group_db_role) > 0);
end $$
