do $$
begin
        assert((select count(*) from app_data.db_role where dbrl_nm = 'role_web_core_auth_key_aur_mod') = 1);
end $$
