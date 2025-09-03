do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_api_core_aur_tnt_reg') = 1);
end $$
