do $$
begin
        --
        -- web
        --

        insert into app_data.atn_method (aum_nm)
        select 'OIDC'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'OIDC');

        insert into app_data.atn_method (aum_nm)
        select 'Username and password'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'Username and password');

        insert into app_data.atn_method (aum_nm)
        select 'Passkey'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'Passkey');

        insert into app_data.atn_method (aum_nm)
        select 'SAML2 : IdP initiated'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'SAML2 : IdP initiated');

        insert into app_data.atn_method (aum_nm)
        select 'SAML2 : SP initiated'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'SAML2 : SP initiated');

        insert into app_data.atn_method (aum_nm)
        select 'SAML2 : SP initiated (username)'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'SAML2 : SP initiated (username)');

        --
        -- api
        --

        insert into app_data.atn_method (aum_nm)
        select 'API key'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'API key');

        insert into app_data.atn_method (aum_nm)
        select 'Bearer token'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'Bearer token');

        commit;
end $$
