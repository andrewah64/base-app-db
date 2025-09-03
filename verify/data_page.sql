do $$
begin
        assert((select count(*) from app_data.page) = (select count(distinct pg_nm) from app_data.page));
end $$
