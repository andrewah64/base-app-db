do $$
begin
        assert(select true
                 from information_schema.constraint_table_usage
                where table_schema    = 'app_data'
                  and table_name      = 'saml2_identity_provider'
                  and constraint_name = 'fk_ipc_idp');
end $$
