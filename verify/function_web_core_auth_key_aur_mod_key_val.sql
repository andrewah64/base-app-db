do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_auth_key_aur_mod' and routine_name = 'key_val');
end$$
