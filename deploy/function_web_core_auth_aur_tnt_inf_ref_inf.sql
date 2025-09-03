create or replace function web_core_auth_aur_tnt_inf.ref_inf
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
                                        'dbrl'          key
                                      , dbrl.dbrl_id    id
                                      , dbrl.dbrl_ds    value
                                   from
                                        app_data.db_role dbrl
                              union all
                                 select
                                        'lng'           key
                                      , lng.lng_id      id
                                      , lng.lng_nm      value
                                   from
                                        app_data.language lng
                         )
                order by
                         key   asc
                       , value asc
                       ;

        return $1;
end;
$$
language plpgsql
security definer;
