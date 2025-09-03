do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'api_core_key_aur_lgn' and schema_owner = 'base_owner');
end$$
