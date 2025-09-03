do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_auth_grp_tnt_del' and routine_name = 'del_grp');
end$$
