do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'web_atn_saml2_method'
                   and indexname  = 'uk_asm_s2c_dflt') = 1);
end$$;
