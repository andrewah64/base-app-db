do $$
begin
        assert((select count(*) from app_data.api_atn_method) > 0);
end $$
