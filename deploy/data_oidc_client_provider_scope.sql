do $$
begin
    insert
      into
           app_data.oidc_client_provider_scope
         (
             occ_id
         ,   ocp_id
         ,   ocs_id
         )
    select
           occ.occ_id
         , ocps.ocp_id
         , ocps.ocs_id
      from
                      app_data.oidc_client         occ
           cross join app_data.oidc_provider_scope ocps
     where
           not exists (
                          select
                                 null
                            from
                                 app_data.oidc_client_provider_scope occps
                           where
                                 occps.occ_id = occ.occ_id
                             and occps.ocp_id = ocps.ocp_id
                             and occps.ocs_id = ocps.ocs_id
                      );

    commit;
end $$
