create or replace function web_core_unauth_oidc_call_inf.call_inf
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
                      occ_url
                    , occ_client_id
                    , occ_cb_url
                    , array_agg(ocs_nm) ocs_nm
                 from (
                         select
                                occ.occ_url
                              , occ.occ_client_id
                              , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || ':' || tnt.tnt_port::text || epp.epp_pt occ_cb_url
                              , ocs.ocs_nm
                           from
                                     app_data.oidc_provider              ocp
                                join app_data.oidc_client                occ   on ocp.ocp_id = occ.ocp_id
                                join app_data.tenant                     tnt   on occ.tnt_id = tnt.tnt_id
                                join app_data.endpoint                   ep    on occ.ep_id  = ep.ep_id
                                join app_data.endpoint_path              epp   on ep.epp_id  = epp.epp_id
                                join app_data.oidc_client_provider_scope occps on (
                                                                                          occ.ocp_id = occps.ocp_id
                                                                                      and occ.occ_id = occps.occ_id
                                                                                  )
                                join app_data.oidc_scope                 ocs   on occps.ocs_id = ocs.ocs_id
                          where
                                occ.tnt_id      = p_tnt_id
                            and ocp.ocp_nm      = p_ocp_nm
                            and occ.occ_enabled = true
                      )
             group by
                      occ_url
                    , occ_client_id
                    , occ_cb_url
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
