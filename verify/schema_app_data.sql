do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'app_data' and schema_owner = 'base_owner');
end$$
