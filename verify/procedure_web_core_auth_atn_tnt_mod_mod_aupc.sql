do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_auth_atn_tnt_mod' and routine_name = 'mod_aupc');
end$$
