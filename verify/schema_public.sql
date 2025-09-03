do $$
begin
        assert((select count(*) from information_schema.schemata where schema_name = 'public') = 0);
end$$
