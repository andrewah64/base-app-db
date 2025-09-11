do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'api_core_rts_api_inf'
                  and routine_name   = 'rts_inf');
end$$
