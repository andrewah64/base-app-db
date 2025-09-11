do $$
begin
        assert((select count(*)
                  from app_data.db_role
                 where dbrl_nm = 'role_web_core_unauth_spc_tnt_inf') = 1);
end $$
