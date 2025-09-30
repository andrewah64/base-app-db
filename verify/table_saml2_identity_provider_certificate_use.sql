do $$
begin
        assert(select true
                 from pg_tables
                where schemaname = 'app_data'
                  and tablename  = 'saml2_identity_provider_certificate_use');
end$$;
