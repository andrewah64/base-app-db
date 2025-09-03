create or replace function web_core_auth_aur_tnt_reg.ref_inf
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
                                        'lng'           key
                                      , lng.lng_id      id
                                      , lng.lng_nm      value
                                   from
                                        app_data.language lng
                              union all
                                 select
                                        'aut'           key
                                      , grp.grp_id      id
                                      , grp.grp_nm      value
                                   from
                                        app_data.app_group grp
                                  where
                                        grp.tnt_id = p_tnt_id
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
