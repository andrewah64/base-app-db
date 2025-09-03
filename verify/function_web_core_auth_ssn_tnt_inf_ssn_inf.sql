do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_auth_ssn_tnt_inf' and routine_name = 'ssn_inf');
end$$
