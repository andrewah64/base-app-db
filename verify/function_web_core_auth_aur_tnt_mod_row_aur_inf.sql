do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_auth_aur_tnt_mod' and routine_name = 'row_aur_inf');
end$$
