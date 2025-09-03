do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'all_core_unauth_ep_all_reg' and schema_owner = 'base_owner');
end$$
