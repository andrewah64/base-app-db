do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'web_core_unauth_otp_aur_mod' and schema_owner = 'base_owner');
end$$
