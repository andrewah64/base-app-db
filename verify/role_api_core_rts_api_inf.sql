do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_api_core_rts_api_inf') = 1);
end $$
