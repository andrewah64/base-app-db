do $$
begin
        insert into app_data.middleware_chain (mwc_nm)
        select 'web/unauth'
         where not exists (select null
                             from app_data.middleware_chain mwc
                            where mwc.mwc_nm = 'web/unauth');

        insert into app_data.middleware_chain (mwc_nm)
        select 'web/auth'
         where not exists (select null
                             from app_data.middleware_chain mwc
                            where mwc.mwc_nm = 'web/auth');

        insert into app_data.middleware_chain (mwc_nm)
        select 'api/unauth'
         where not exists (select null
                             from app_data.middleware_chain mwc
                            where mwc.mwc_nm = 'api/unauth');

        insert into app_data.middleware_chain (mwc_nm)
        select 'api/auth'
         where not exists (select null
                             from app_data.middleware_chain mwc
                            where mwc.mwc_nm = 'api/auth');

        commit;
end $$
