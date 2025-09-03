do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'web_core_auth_grp_tnt_del' and schema_owner = 'base_owner');
end$$
