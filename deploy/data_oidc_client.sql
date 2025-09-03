do $$
begin

        insert
          into
               app_data.oidc_client
             (
                 tnt_id
             ,   ocp_id
             ,   occ_url
             ,   occ_client_id
             ,   occ_client_secret
             ,   ep_id
             )
        select
               tnt.tnt_id
             , ocp.ocp_id
             , 'https://accounts.google.com'
             , '385608571046-gfc3pc1j31i01d0cf3ushqdgg7q9ciuu.apps.googleusercontent.com'
             , '<placeholder>'
             , ep.ep_id
          from
                          app_data.tenant        tnt
               cross join app_data.oidc_provider ocp
               cross join (
                                   app_data.endpoint      ep
                              join app_data.endpoint_path epp on ep.epp_id = epp.epp_id
                          )
         where
               ocp.ocp_nm = 'google'
           and epp.epp_pt = '/web/core/oidc/callback/{nm}'
             ;

        insert
          into
               app_data.oidc_client
             (
                 tnt_id
             ,   ocp_id
             ,   occ_url
             ,   occ_client_id
             ,   occ_client_secret
             ,   ep_id
             )
        select
               tnt.tnt_id
             , ocp.ocp_id
             , 'https://login.microsoftonline.com/043e4b44-cddc-47e7-90fe-f80e27d22ef9/v2.0'
             , '38860376-005b-435c-a667-f15c096b743a'
             , '<placeholder>'
             , ep.ep_id
          from
                          app_data.tenant        tnt
               cross join app_data.oidc_provider ocp
               cross join (
                                   app_data.endpoint      ep
                              join app_data.endpoint_path epp on ep.epp_id = epp.epp_id
                          )
         where
               ocp.ocp_nm = 'microsoft'
           and epp.epp_pt = '/web/core/oidc/callback/{nm}'
             ;

        commit;

end $$
