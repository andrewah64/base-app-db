create or replace function web_core_auth_grp_tnt_inf.ref_inf
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
                                  where
                                        exists (
                                                   select
                                                          null
                                                     from
                                                               app_data.app_group         grp
                                                          join app_data.app_group_db_role grpdr on grp.grp_id = grpdr.grp_id
                                                    where
                                                          grp.tnt_id    = p_tnt_id
                                                      and grpdr.dbrl_id = dbrl.dbrl_id
                                               )
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
