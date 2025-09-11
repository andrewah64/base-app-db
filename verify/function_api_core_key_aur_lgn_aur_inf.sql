do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'api_core_key_aur_lgn'
                  and routine_name   = 'aur_inf');
end$$
