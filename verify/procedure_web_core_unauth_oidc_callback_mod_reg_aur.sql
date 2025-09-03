do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_unauth_oidc_callback_mod' and routine_name = 'reg_aur');
end$$
