do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'all_core_unauth_spc_all_reg'
                  and routine_name   = 's2g_inf');
end$$
