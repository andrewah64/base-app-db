do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_auth_log_aur_tnt_mod' and routine_name = 'row_log_inf');
end$$
