do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_web_core_auth_aur_tnt_mod') = 1);
end $$
