do $$
begin
        assert(select true
                 from information_schema.schemata
                where schema_name  = 'web_core_auth_occ_tnt_inf'
                  and schema_owner = 'base_owner');
end$$
