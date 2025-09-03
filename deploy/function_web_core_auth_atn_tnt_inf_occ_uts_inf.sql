create or replace function web_core_auth_atn_tnt_inf.occ_uts_inf
(
        refcursor
,       p_tnt_id  app_data.oidc_client.tnt_id%type
,       p_occ_id  app_data.oidc_client.occ_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    occ.uts
               from
                    app_data.oidc_client occ
              where
                    occ.tnt_id = p_tnt_id
                and occ.occ_id = p_occ_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
