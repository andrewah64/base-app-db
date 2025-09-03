do $$
begin
        assert((select count(*) from app_data.app_group) = (select count(distinct grp_nm) from app_data.app_group) * (select count(*) from app_data.tenant));
end $$
