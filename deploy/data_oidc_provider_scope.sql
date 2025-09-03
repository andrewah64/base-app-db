do $$
begin
        insert into app_data.oidc_provider_scope (ocp_id, ocs_id)
        select
               ocp.ocp_id
             , ocs.ocs_id
          from
                          app_data.oidc_provider ocp
               cross join app_data.oidc_scope    ocs
         where
               ocp.ocp_nm =  'google'
           and ocs.ocs_nm in ('email', 'openid', 'profile')
           and not exists (select null
                             from app_data.oidc_provider_scope ocps
                            where
                                  ocps.ocp_id = ocp.ocp_id
                              and ocps.ocs_id = ocs.ocs_id
                              and ocps.ocp_id =  (select ocp_id from app_data.oidc_provider where ocp_nm = 'google')
                              and ocps.ocs_id in (select ocs_id from app_data.oidc_provider where ocs_nm in ('email', 'openid', 'profile')));

        insert into app_data.oidc_provider_scope (ocp_id, ocs_id)
        select
               ocp.ocp_id
             , ocs.ocs_id
          from
                          app_data.oidc_provider ocp
               cross join app_data.oidc_scope    ocs
         where
               ocp.ocp_nm =  'microsoft'
           and ocs.ocs_nm in ('email', 'openid', 'profile')
           and not exists (select null
                             from app_data.oidc_provider_scope ocps
                            where
                                  ocps.ocp_id = ocp.ocp_id
                              and ocps.ocs_id = ocs.ocs_id
                              and ocps.ocp_id =  (select ocp_id from app_data.oidc_provider where ocp_nm = 'microsoft')
                              and ocps.ocs_id in (select ocs_id from app_data.oidc_provider where ocs_nm in ('openid')));

        commit;
end $$
