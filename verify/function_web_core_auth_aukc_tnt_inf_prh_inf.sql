do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'web_core_auth_aukc_tnt_inf'
                  and routine_name   = 'prh_inf');
end$$
