do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'web_core_auth_ssn_aur_inf'
                  and routine_name   = 'aur_inf');
end$$
