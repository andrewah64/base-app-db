do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_web_core_auth_rol_grp_tnt_inf') = 1);
end $$
