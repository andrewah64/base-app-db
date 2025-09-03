create or replace function web_core_auth_log_aur_tnt_mod.row_log_inf
(
        refcursor
,       p_tnt_id   app_data.tenant.tnt_id%type
,       p_auell_id app_data.app_user_endpoint_log_level.auell_id%type
)
returns refcursor
as
$$
begin

        open
             $1
         for
             select
                    auell.auell_id
                  , aur.aur_nm
                  , epp.epp_pt
                  , hrm.hrm_nm
                  , lvl.lvl_nm
               from
                         app_data.app_user                    aur
                    join app_data.app_user_endpoint_log_level auell on aur.aur_id   = auell.aur_id
                    join app_data.atn_endpoint               aep   on auell.ep_id  = aep.ep_id
                    join app_data.endpoint                    ep    on aep.ep_id    = ep.ep_id
                    join app_data.endpoint_path               epp   on ep.epp_id    = epp.epp_id
                    join app_data.http_request_method         hrm   on ep.hrm_id    = hrm.hrm_id
                    join app_data.log_level                   lvl   on auell.lvl_id = lvl.lvl_id
              where
                    aur.tnt_id     = p_tnt_id
                and auell.auell_id = p_auell_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
