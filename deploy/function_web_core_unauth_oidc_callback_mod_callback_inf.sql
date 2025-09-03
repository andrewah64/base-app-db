create or replace function web_core_unauth_oidc_callback_mod.callback_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_ocp_nm  app_data.oidc_provider.ocp_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    occ.occ_url
                  , occ.occ_client_id
                  , occ.occ_client_secret
                  , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || ':' || tnt.tnt_port::text || epp.epp_pt occ_cb_url
               from
                         app_data.oidc_provider ocp
                    join app_data.oidc_client   occ on ocp.ocp_id = occ.ocp_id
                    join app_data.tenant        tnt on occ.tnt_id = tnt.tnt_id
                    join app_data.endpoint      ep  on occ.ep_id  = ep.ep_id
                    join app_data.endpoint_path epp on ep.epp_id  = epp.epp_id
              where
                    occ.tnt_id      = p_tnt_id
                and ocp.ocp_nm      = p_ocp_nm
                and occ.occ_enabled = true
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
