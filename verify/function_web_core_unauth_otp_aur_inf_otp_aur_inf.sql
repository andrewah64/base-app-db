do $$
begin
        assert(select true from information_schema.routines where routine_schema = 'web_core_unauth_otp_aur_inf' and routine_name = 'otp_aur_inf');
end$$
