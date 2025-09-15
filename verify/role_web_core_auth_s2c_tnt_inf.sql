do $$
begin
        assert((select count(*)
                  from app_data.db_role
                 where dbrl_nm = 'role_web_core_auth_s2c_tnt_inf') = 1);
end $$
