do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'web_core_auth_s2c_tnt_inf'
                  and routine_name   = 's2g_uts_inf');
end$$
