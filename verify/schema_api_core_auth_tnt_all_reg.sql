do $$
begin
        assert(select true
                 from information_schema.schemata
                where schema_name  = 'api_core_auth_tnt_all_reg'
                  and schema_owner = 'base_owner');
end$$
