do $$
begin
        insert into app_data.http_request_method (hrm_nm)
        select 'GET'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'GET');

        insert into app_data.http_request_method (hrm_nm)
        select 'HEAD'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'HEAD');

        insert into app_data.http_request_method (hrm_nm)
        select 'POST'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'POST');

        insert into app_data.http_request_method (hrm_nm)
        select 'PUT'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'PUT');

        insert into app_data.http_request_method (hrm_nm)
        select 'DELETE'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'DELETE');

        insert into app_data.http_request_method (hrm_nm)
        select 'CONNECT'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'CONNECT');

        insert into app_data.http_request_method (hrm_nm)
        select 'OPTIONS'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'OPTIONS');

        insert into app_data.http_request_method (hrm_nm)
        select 'TRACE'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'TRACE');

        insert into app_data.http_request_method (hrm_nm)
        select 'PATCH'
         where not exists (select null 
                             from app_data.http_request_method hrm
                            where hrm.hrm_nm    = 'PATCH');

        commit;

end $$
