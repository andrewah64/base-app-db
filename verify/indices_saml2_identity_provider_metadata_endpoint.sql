do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'saml2_identity_provider_metadata_endpoint'
                   and indexname  = 'uk_mde_enabled') = 1);
end$$;
