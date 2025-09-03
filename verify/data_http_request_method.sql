do $$
begin
        assert((select count(*) from app_data.http_request_method) = (select count(distinct hrm_nm) from app_data.http_request_method));
end $$
