create or replace function web_core_unauth_ssn_ep_inf.ep_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
,       p_epp_pt app_data.endpoint_path.epp_pt%type
,       p_hrm_nm app_data.http_request_method.hrm_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    lvl.lvl_nb
               from
                         app_data.endpoint_log_level  ell
                    join app_data.endpoint            ep  on ell.ep_id  = ep.ep_id
                    join app_data.endpoint_path       epp on ep.epp_id  = epp.epp_id
                    join app_data.http_request_method hrm on ep.hrm_id  = hrm.hrm_id
                    join app_data.log_level           lvl on ell.lvl_id = lvl.lvl_id       
              where
                    ell.tnt_id = p_tnt_id
                and epp.epp_pt = p_epp_pt
                and hrm.hrm_nm = p_hrm_nm
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
