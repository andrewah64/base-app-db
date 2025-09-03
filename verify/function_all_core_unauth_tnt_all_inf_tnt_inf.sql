do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'all_core_unauth_tnt_all_inf' and routine_name = 'tnt_inf');
end$$
