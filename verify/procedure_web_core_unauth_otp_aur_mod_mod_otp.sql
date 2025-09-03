do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_unauth_otp_aur_mod' and routine_name = 'mod_otp');
end$$
