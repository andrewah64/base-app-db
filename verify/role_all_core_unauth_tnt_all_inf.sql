do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_all_core_unauth_tnt_all_inf') = 1);
end $$
