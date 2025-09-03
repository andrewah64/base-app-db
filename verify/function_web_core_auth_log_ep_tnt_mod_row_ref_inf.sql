do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'web_core_auth_log_ep_tnt_mod'
                  and routine_name   = 'row_ref_inf');
end$$
