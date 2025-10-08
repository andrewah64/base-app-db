do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'saml2_identity_provider_slo_endpoint'
                   and indexname  = 'uk_slo_enabled') = 1);
end$$;
