create or replace function web_core_auth_ssn_aur_inf.aur_inf
(
        refcursor
,       p_tnt_id       app_data.tenant.tnt_id%type
,       p_wauhs_ssn_tk app_data.web_app_user_http_session.wauhs_ssn_tk%type
,       p_epp_pt       app_data.endpoint_path.epp_pt%type
,       p_hrm_nm       app_data.http_request_method.hrm_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aur.aur_id
                  , aur.aur_nm
                  , lng.lng_cd
                  , aur.rolname
                  , array
                    (
                        select
                               dbrl.dbrl_nm
                          from
                                    pg_catalog.pg_auth_members pam
                               join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                               join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                               join app_data.db_role           dbrl on rol.rolname = dbrl.dbrl_nm
                         where
                               pau.rolname = aur.rolname
                    ) roles
                  , (
                        select
                               min ( lvl_nb ) lvl_nb
                          from (
                                   select
                                          lvl.lvl_nb
                                     from
                                               app_data.app_user_endpoint_log_level auell
                                          join app_data.atn_endpoint                aep    on auell.ep_id   = aep.ep_id
                                          join app_data.endpoint                    ep     on aep.ep_id     = ep.ep_id
                                          join app_data.endpoint_path               epp    on ep.epp_id     = epp.epp_id
                                          join app_data.http_request_method         hrm    on ep.hrm_id     = hrm.hrm_id
                                          join app_data.log_level                   lvl    on auell.lvl_id  = lvl.lvl_id
                                    where
                                          epp.epp_pt   = p_epp_pt
                                      and hrm.hrm_nm   = p_hrm_nm
                                      and auell.aur_id = (
                                                             select
                                                                    wauhs.aur_id
                                                               from
                                                                    app_data.web_app_user_http_session wauhs
                                                              where
                                                                    wauhs.wauhs_ssn_tk = p_wauhs_ssn_tk
                                                         )
                                    union
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
                               )
                    ) lvl_nb
                  , epp.epp_pt
                  , hrm.hrm_nm
               from
                         app_data.app_user                    aur
                    join app_data.language                    lng    on aur.lng_id    = lng.lng_id
                    join app_data.web_app_user                waur   on aur.aur_id    = waur.aur_id
                    join app_data.web_app_user_home_page      wauhp  on waur.aur_id   = wauhp.aur_id
                    join app_data.page_endpoint               pe     on wauhp.pg_id   = pe.pg_id
                    join app_data.endpoint                    ep     on pe.ep_id      = ep.ep_id
                    join app_data.endpoint_path               epp    on ep.epp_id     = epp.epp_id
                    join app_data.http_request_method         hrm    on ep.hrm_id     = hrm.hrm_id
                    join app_data.web_app_user_http_session   wauhs  on waur.aur_id   = wauhs.aur_id
                    join (
                               select
                                      wauhs.aur_id
                                    , max(wauhs_exp_ts) wauhs_exp_ts
                                 from
                                      app_data.web_app_user_http_session wauhs
                                where
                                      wauhs.wauhs_exp_ts >= current_timestamp
                                  and wauhs.aur_id        = (
                                                                select
                                                                       wauhs_il.aur_id
                                                                  from
                                                                       app_data.web_app_user_http_session wauhs_il
                                                                 where
                                                                       wauhs_il.wauhs_ssn_tk = p_wauhs_ssn_tk
                                                            )
                             group by
                                      wauhs.aur_id
                         )
                         mrs
                      on (
                                 wauhs.aur_id       = mrs.aur_id
                             and wauhs.wauhs_exp_ts = mrs.wauhs_exp_ts
                         )
              where
                    aur.tnt_id         = p_tnt_id
                and wauhs.wauhs_ssn_tk = p_wauhs_ssn_tk
                and waur.aur_enabled   = true
                and pe.pe_is_entry     = true
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
