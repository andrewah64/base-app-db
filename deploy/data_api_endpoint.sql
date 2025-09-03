do $$
begin
        insert into app_data.api_endpoint (api_id, ep_id)
        select
               a.api_id
             , e.ep_id
          from
                          app_data.api a
               cross join (
                                   app_data.endpoint            e
                              join app_data.endpoint_path       epp on e.epp_id = epp.epp_id
                              join app_data.http_request_method hrm on e.hrm_id = hrm.hrm_id
                          )
         where
               a.api_nm   = 'Health check'
           and epp.epp_pt = '/api/v1/healthcheck'
           and hrm.hrm_nm = 'GET'
           and not exists (select null
                             from app_data.api_endpoint i
                            where i.api_id = a.api_id
                              and i.ep_id  = e.ep_id);

        insert into app_data.api_endpoint (api_id, ep_id)
        select
               a.api_id
             , e.ep_id
          from
                          app_data.api a
               cross join (
                                   app_data.endpoint            e
                              join app_data.endpoint_path       epp on e.epp_id = epp.epp_id
                              join app_data.http_request_method hrm on e.hrm_id = hrm.hrm_id
                          )
         where
               a.api_nm   = 'Register new users'
           and epp.epp_pt = '/api/v1/users'
           and hrm.hrm_nm = 'POST'
           and not exists (select null
                             from app_data.api_endpoint i
                            where i.api_id = a.api_id
                              and i.ep_id  = e.ep_id);
        commit;
end $$
