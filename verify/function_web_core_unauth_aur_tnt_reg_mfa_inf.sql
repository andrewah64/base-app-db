do $$
begin
        assert((select count(*)
                  from information_schema.routines
                 where routine_schema = 'web_core_unauth_aur_tnt_reg'
                   and routine_name   = 'mfa_inf') = 1);
end$$
