create or replace function web_core_auth_atn_tnt_inf.ocp_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      ocp.ocp_nm
                 from
                      app_data.oidc_provider ocp
                where
                      exists (
                                 select
                                        null
                                   from
                                        app_data.oidc_client occ
                                  where
                                        occ.ocp_id = ocp.ocp_id
                                    and occ.tnt_id = p_tnt_id
                             )
             order by
                      ocp.ocp_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
