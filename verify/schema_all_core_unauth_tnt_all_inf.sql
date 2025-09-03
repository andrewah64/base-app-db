do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'all_core_unauth_tnt_all_inf' and schema_owner = 'base_owner');
end$$
