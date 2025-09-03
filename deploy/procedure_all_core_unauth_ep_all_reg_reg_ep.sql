create or replace procedure all_core_unauth_ep_all_reg.reg_ep
(
        p_dbrl_nm   app_data.db_role.dbrl_nm%type
,       p_dbrl_ds   app_data.db_role.dbrl_ds%type
,       p_dbrl_md   app_data.db_role.dbrl_md%type
,       p_dbrl_type text
,       p_hdlr_nm   app_data.handler.hdlr_nm%type
,       p_epp_pt    app_data.endpoint_path.epp_pt%type
,       p_ep_ds     app_data.endpoint.ep_ds%type
,       p_mwc_nm    app_data.middleware_chain.mwc_nm%type
,       p_hrm_nm    app_data.http_request_method.hrm_nm%type
,       p_pg_nm     app_data.page.pg_nm%type
,       pe_is_entry app_data.page_endpoint.pe_is_entry%type
)
as
$$
declare
        v_dbrl_id app_data.db_role.dbrl_id%type;
        v_ep_id   app_data.endpoint.ep_id%type;
begin
        if p_dbrl_nm is not null then

                   insert
                     into
                          app_data.db_role
                        (
                            dbrl_nm
                        ,   dbrl_ds
                        ,   dbrl_md
                        )
                   select
                          p_dbrl_nm
                        , p_dbrl_ds
                        , p_dbrl_md
                    where
                          not exists (
                                         select
                                                null
                                           from
                                                app_data.db_role d
                                          where
                                                d.dbrl_nm = p_dbrl_nm
                                     )
                returning
                          dbrl_id
                     into
                          v_dbrl_id;

                case
                     p_dbrl_type
                when
                     'web'
                then
                     insert
                       into
                            app_data.web_db_role
                          (
                              dbrl_id
                          )
                     select
                            dbrl.dbrl_id
                       from
                            app_data.db_role dbrl
                      where
                            dbrl.dbrl_nm = p_dbrl_nm
                        and not exists (
                                           select
                                                  null
                                             from
                                                  app_data.web_db_role wdr
                                            where
                                                  wdr.dbrl_id = dbrl.dbrl_id
                                       );
                when
                     'api'
                then
                     insert
                       into
                            app_data.api_db_role
                          (
                              dbrl_id
                          )
                     select
                            dbrl.dbrl_id
                       from
                            app_data.db_role dbrl
                      where
                            dbrl.dbrl_nm = p_dbrl_nm
                        and not exists (
                                           select
                                                  null
                                             from
                                                  app_data.api_db_role adr
                                            where
                                                  adr.dbrl_id = dbrl.dbrl_id
                                       );
                end case;

                if p_mwc_nm in ('web/auth', 'api/auth') and v_dbrl_id is not null then
                    insert
                      into
                           app_data.atn_db_role
                         (
                             dbrl_id
                         )
                    values
                         (
                             v_dbrl_id
                         );
                end if;

        end if;

        insert
          into
               app_data.handler
             (
                 hdlr_nm
             )
        select
               p_hdlr_nm
         where
               not exists (
                              select
                                     null
                                from
                                     app_data.handler
                               where
                                     hdlr_nm = p_hdlr_nm
                          );

        insert
          into
               app_data.endpoint_path
             (
                 epp_pt
             )
        select
               p_epp_pt
         where
               not exists (
                              select
                                     null 
                                from
                                     app_data.endpoint_path epp
                               where
                                     epp.epp_pt = p_epp_pt
                          );

           insert
             into
                  app_data.endpoint
                (
                    epp_id
                ,   ep_ds
                ,   mwc_id
                ,   hrm_id
                ,   hdlr_id
                )
           select
                  (
                      select
                             epp_id
                        from
                             app_data.endpoint_path epp
                       where
                             epp_pt = p_epp_pt
                  )
                , p_ep_ds
                , (
                      select
                             mwc_id
                        from
                             app_data.middleware_chain mwc
                       where
                             mwc_nm  = p_mwc_nm
                  )
                , (
                      select
                             hrm_id
                        from
                             app_data.http_request_method hrm
                       where
                             hrm_nm  = p_hrm_nm
                  )
                , (
                      select
                             hdlr_id
                        from
                             app_data.handler hdlr
                       where
                             hdlr_nm = p_hdlr_nm
                  )
            where
                  not exists (
                                 select
                                        null
                                   from
                                        app_data.endpoint ep
                                  where
                                        ep.epp_id = (
                                                        select
                                                               epp.epp_id
                                                          from
                                                               app_data.endpoint_path epp
                                                         where
                                                               epp.epp_pt = p_epp_pt
                                                    )
                                    and ep.hrm_id = (
                                                        select
                                                               hrm.hrm_id
                                                          from
                                                               app_data.http_request_method hrm
                                                         where
                                                               hrm.hrm_nm = p_hrm_nm
                                                    )
                             )
        returning
                  ep_id
             into
                  v_ep_id;

        if v_ep_id is not null and p_mwc_nm in ('web/auth', 'api/auth') then

                insert
                  into
                       app_data.atn_endpoint
                     (
                         ep_id
                     )
                values
                     (
                         v_ep_id
                     );

        end if;

        if v_ep_id is null then
                select
                       ep.ep_id into v_ep_id
                  from
                            app_data.endpoint            ep
                       join app_data.endpoint_path       epp on ep.epp_id = epp.epp_id
                       join app_data.http_request_method hrm on ep.hrm_id = hrm.hrm_id
                 where
                       epp.epp_pt = p_epp_pt
                   and hrm.hrm_nm = p_hrm_nm
                     ;

        end if;

        insert
          into
               app_data.endpoint_log_level
             (
                 tnt_id
             ,   ep_id
             ,   lvl_id
             )
        select
               tnt.tnt_id
             , v_ep_id
             , lvl.lvl_id
          from
                          app_data.tenant    tnt
               cross join app_data.log_level lvl
         where
               lvl.lvl_ep_dflt = true
           and not exists (
                              select
                                     null
                                from
                                     app_data.endpoint_log_level ell
                               where
                                     ell.tnt_id = tnt.tnt_id
                                 and ell.ep_id  = v_ep_id
                          );

        if p_pg_nm is not null then

                insert
                  into
                       app_data.page
                     (
                         pg_nm
                     )
                select 
                       p_pg_nm
                 where
                       not exists (
                                      select
                                             null
                                        from
                                             app_data.page pg
                                       where
                                             pg.pg_nm = p_pg_nm
                                  );

                insert
                  into
                       app_data.page_endpoint
                     (
                         pg_id
                     ,   ep_id
                     ,   pe_is_entry
                     )
                select
                       (
                           select
                                  pg_id
                             from
                                  app_data.page
                            where
                                  pg_nm = p_pg_nm
                       )
                     , (
                           select
                                  ep_id
                             from
                                  app_data.endpoint
                            where
                                  epp_id = (
                                               select
                                                      epp_id
                                                 from
                                                      app_data.endpoint_path
                                                where
                                                      epp_pt = p_epp_pt
                                           )
                              and hrm_id = (
                                               select
                                                      hrm_id
                                                 from
                                                      app_data.http_request_method
                                                where
                                                      hrm_nm = p_hrm_nm
                                           )
                       )
                     , pe_is_entry
               where
                     not exists (
                                    select
                                           null
                                      from
                                           app_data.page_endpoint pe
                                     where
                                           pe.pg_id = (
                                                          select
                                                                 pg_id
                                                            from
                                                                 app_data.page
                                                           where
                                                                 pg_nm = p_pg_nm
                                                      )
                                       and pe.ep_id = (
                                                          select
                                                                 ep_id
                                                            from
                                                                 app_data.endpoint
                                                           where
                                                                 epp_id = (
                                                                              select
                                                                                     epp_id
                                                                                from
                                                                                     app_data.endpoint_path
                                                                               where
                                                                                     epp_pt = p_epp_pt
                                                                          )
                                                             and hrm_id = (
                                                                              select
                                                                                     hrm_id
                                                                                from
                                                                                     app_data.http_request_method
                                                                               where
                                                                                     hrm_nm = p_hrm_nm
                                                                          )
                                                      )
                                );

        end if;

        if p_mwc_nm in ('web/auth', 'api/auth') and p_dbrl_nm is not null then

            insert
              into
                   app_data.endpoint_db_role
                 (
                     ep_id
                 ,   dbrl_id
                 )
            select
                   ep.ep_id
                 , dbrl.dbrl_id
              from (
                              app_data.endpoint            ep
                         join app_data.endpoint_path       epp on ep.epp_id = epp.epp_id
                         join app_data.http_request_method hrm on ep.hrm_id = hrm.hrm_id
                   )
                   cross join app_data.db_role  dbrl
             where
                   epp.epp_pt   = p_epp_pt
               and hrm.hrm_nm   = p_hrm_nm
               and dbrl.dbrl_nm = p_dbrl_nm
               and not exists (
                                  select
                                         null
                                    from
                                         app_data.endpoint_db_role edr
                                   where
                                         edr.ep_id   = ep.ep_id
                                     and edr.dbrl_id = dbrl.dbrl_id
                              );

        end if;

end;
$$
language plpgsql
security definer;
