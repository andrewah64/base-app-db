create or replace function web_core_auth_occ_tnt_inf.occ_inf
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
                      occ.occ_id
                    , ocp.ocp_nm
                    , occ.occ_enabled
                    , occ.occ_client_id
                    , occ.occ_client_secret
                    , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || ':' || tnt.tnt_port::text || replace(epp.epp_pt, '{nm}', ocp.ocp_nm) occ_cb_url
                    , occ.occ_url
                    , occ.uts
                 from
                           app_data.oidc_client   occ
                      join app_data.oidc_provider ocp on occ.ocp_id = ocp.ocp_id
                      join app_data.tenant        tnt on occ.tnt_id = tnt.tnt_id
                      join app_data.endpoint      ep  on occ.ep_id  = ep.ep_id
                      join app_data.endpoint_path epp on ep.epp_id  = epp.epp_id
                where
                      occ.tnt_id = p_tnt_id
             order by
                      ocp.ocp_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
