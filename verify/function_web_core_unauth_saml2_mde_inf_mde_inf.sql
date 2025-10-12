do $$
begin
        assert(select true
                 from information_schema.routines
                where routine_schema = 'web_core_unauth_saml2_mde_inf'
                  and routine_name   = 'mde_inf');
end$$
