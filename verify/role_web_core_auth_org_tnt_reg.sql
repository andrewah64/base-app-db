do $$
begin
        assert((select count(*)
                  from app_data.db_role
                 where dbrl_nm = 'role_web_core_auth_org_tnt_reg') = 1);
end $$
