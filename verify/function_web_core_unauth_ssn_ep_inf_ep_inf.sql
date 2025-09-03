do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'web_core_unauth_ssn_ep_inf'
                  and routine_name   = 'ep_inf');
end$$
