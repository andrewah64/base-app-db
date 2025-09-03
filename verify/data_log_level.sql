do $$
begin
        assert((select count(*) from app_data.log_level) = (select count(distinct lvl_nm) from app_data.log_level));
end $$
