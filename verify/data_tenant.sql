do $$
begin
        assert(select true from app_data.tenant where tnt_nm = 'tenant-1');
        assert(select true from app_data.tenant where tnt_nm = 'tenant-2');
end $$
