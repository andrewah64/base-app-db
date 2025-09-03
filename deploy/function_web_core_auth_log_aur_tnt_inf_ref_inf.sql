create or replace function web_core_auth_log_aur_tnt_inf.ref_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
                  select
                         key
                       , id
                       , value
                    from (
                                 select
                                        'hrm'           key
                                      , hrm.hrm_id      id
                                      , hrm.hrm_nm      value
                                   from
                                        app_data.http_request_method hrm
                                  where
                                        exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.endpoint ep
                                                    where
                                                          ep.hrm_id = hrm.hrm_id
                                               )
                              union all
                                 select
                                        'lvl'           key
                                      , lvl.lvl_id      id
                                      , lvl.lvl_nm      value
                                   from
                                        app_data.log_level lvl
                         )
                order by
                         key    asc
                       , value  asc
                       ;

        return $1;
end;
$$
language plpgsql
security definer;
