do $$
begin
        assert(select true from information_schema.schemata where schema_name = 'api_core_rts_api_inf' and schema_owner = 'base_owner');
end$$
