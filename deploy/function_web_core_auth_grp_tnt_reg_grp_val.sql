create or replace function web_core_auth_grp_tnt_reg.grp_val
(
        refcursor
,       p_tnt_id  app_data.app_group.tnt_id%type
,       p_grp_nm  app_data.app_group.grp_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select coalesce
                    (
                        (
                            select
                                   false
                              from
                                   app_data.app_group grp
                             where
                                   grp.tnt_id = p_tnt_id
                               and grp.grp_nm = p_grp_nm
                        )
                    ,   true
                    )
                    grp_nm_ok
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
