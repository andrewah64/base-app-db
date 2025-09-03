do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_unauth_aur_tnt_reg' and routine_name = 'reg_prs');
end$$
