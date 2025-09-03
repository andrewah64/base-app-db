create or replace function web_core_auth_log_ep_tnt_mod.row_log_mod
(
        refcursor
,       p_tnt_id   app_data.tenant.tnt_id%type
,       p_ell_id   app_data.endpoint_log_level.ell_id%type
)
returns refcursor
as
$$
begin

        open
             $1
         for
             select
                    ell.ell_id
                  , epp.epp_pt
                  , hrm.hrm_nm
                  , lvl.lvl_id
                  , ell.uts
               from
                         app_data.endpoint_log_level  ell
                    join app_data.endpoint            ep  on ell.ep_id  = ep.ep_id
                    join app_data.endpoint_path       epp on ep.epp_id  = epp.epp_id
                    join app_data.http_request_method hrm on ep.hrm_id  = hrm.hrm_id
                    join app_data.log_level           lvl on ell.lvl_id = lvl.lvl_id
              where
                    ell.tnt_id = p_tnt_id
                and ell.ell_id = p_ell_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
