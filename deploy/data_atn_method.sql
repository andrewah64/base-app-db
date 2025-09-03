do $$
begin
        insert into app_data.atn_method (aum_nm)
        select 'OIDC'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'OIDC');

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

        commit;
end $$
