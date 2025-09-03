do $$
begin
        assert((select count(*) from app_data.middleware_chain) = (select count(distinct mwc_nm) from app_data.middleware_chain));
end $$
