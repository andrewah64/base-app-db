do $$
begin
        insert into app_data.oidc_scope (ocs_nm)
        select 'email'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'email');

        insert into app_data.oidc_scope (ocs_nm)
        select 'openid'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'openid');

        insert into app_data.oidc_scope (ocs_nm)
        select 'profile'
         where not exists (select null
                             from app_data.atn_method aum
                            where aum.aum_nm = 'profile');

        commit;
end $$
