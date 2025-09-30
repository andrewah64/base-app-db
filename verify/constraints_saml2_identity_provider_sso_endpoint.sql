do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'saml2_identity_provider'
                  and constraint_name = 'fk_sso_idp');

        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'saml2_endpoint_binding'
                  and constraint_name = 'fk_sso_bnd');
end $$
