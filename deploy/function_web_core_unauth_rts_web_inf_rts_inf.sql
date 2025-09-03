create or replace function web_core_unauth_rts_web_inf.rts_inf
(
        refcursor
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      epp_pt
                    , hdlr_nm
                    , mwc_nm
                    , hrm_nm
                    , array_agg(dbrl_nm) dbrl_nms
                 from (
                                select
                                       epp.epp_pt
                                     , hdlr.hdlr_nm
                                     , mwc.mwc_nm
                                     , hrm.hrm_nm
                                     , dbrl.dbrl_nm
                                  from
                                            app_data.endpoint            ep
                                       join app_data.endpoint_path       epp   on ep.epp_id    = epp.epp_id
                                       join app_data.middleware_chain    mwc   on ep.mwc_id    = mwc.mwc_id
                                       join app_data.http_request_method hrm   on ep.hrm_id    = hrm.hrm_id
                                       join app_data.handler             hdlr  on ep.hdlr_id   = hdlr.hdlr_id
                                       join app_data.endpoint_db_role    edr   on ep.ep_id     = edr.ep_id
                                       join app_data.db_role             dbrl  on edr.dbrl_id  = dbrl.dbrl_id
                                       join app_data.web_db_role         wdbrl on dbrl.dbrl_id = wdbrl.dbrl_id
                                 where
                                       exists (
                                                  select
                                                         null
                                                    from
                                                         app_data.page_endpoint pe
                                                   where
                                                         pe.ep_id = ep.ep_id
                                              )
                             union all
                                select
                                       epp.epp_pt
                                     , hdlr.hdlr_nm
                                     , mwc.mwc_nm
                                     , hrm.hrm_nm
                                     , null::text
                                  from
                                            app_data.endpoint            ep
                                       join app_data.endpoint_path       epp  on ep.epp_id   = epp.epp_id
                                       join app_data.middleware_chain    mwc  on ep.mwc_id   = mwc.mwc_id
                                       join app_data.http_request_method hrm  on ep.hrm_id   = hrm.hrm_id
                                       join app_data.handler             hdlr on ep.hdlr_id  = hdlr.hdlr_id
                                 where
                                           exists (
                                                      select
                                                             null
                                                        from
                                                             app_data.page_endpoint pe
                                                       where
                                                             pe.ep_id = ep.ep_id
                                                  )
                                   and not exists (
                                                      select
                                                             null
                                                        from
                                                                  app_data.endpoint_db_role edr
                                                             join app_data.db_role          dbrl  on edr.dbrl_id  = dbrl.dbrl_id
                                                             join app_data.web_db_role      wdbrl on dbrl.dbrl_id = wdbrl.dbrl_id
                                                       where
                                                             edr.ep_id = ep.ep_id
                                                  )
                      )
             group by
                      epp_pt
                    , hdlr_nm
                    , mwc_nm
                    , hrm_nm

             order by
                      mwc_nm asc
                    , epp_pt asc
                    , hrm_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
