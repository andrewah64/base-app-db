do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'saml2_identity_provider'
                   and indexname  = 'uk_idp_enabled') = 1);
end$$;
