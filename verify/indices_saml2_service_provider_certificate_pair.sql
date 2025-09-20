do $$
begin
        assert((select count(*)
                  from pg_indexes
                 where schemaname = 'app_data'
                   and tablename  = 'saml2_service_provider_certificate_pair'
                   and indexname  = 'uk_spc_enabled') = 1);
end$$;
