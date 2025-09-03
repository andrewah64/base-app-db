do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_unauth_ssn_aur_reg' and routine_name = 'aum_inf');
end$$
