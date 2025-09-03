create or replace function web_core_auth_log_ep_tnt_mod.row_ref_inf
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
