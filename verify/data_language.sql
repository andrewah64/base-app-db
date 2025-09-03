do $$
begin
        assert((select count(*) from app_data.language) = (select count(distinct lng_nm) from app_data.language));
end $$
