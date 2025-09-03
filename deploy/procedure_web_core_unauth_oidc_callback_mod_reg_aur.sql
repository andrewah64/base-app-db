create or replace procedure web_core_unauth_oidc_callback_mod.reg_aur
(
        p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_ea  app_data.app_user_email_address.aur_ea%type
,       p_ocp_nm  app_data.oidc_provider.ocp_nm%type
)
as
$$
declare

        c_aur_id  constant app_data.app_user.aur_id%type  := nextval('app_data.app_user_aur_id_seq');
        c_rolname constant app_data.app_user.rolname%type := c_aur_id::name;

        v_cnt int := 0;

        r record;

begin

           insert
             into
                  app_data.app_user
                  (
                      aur_id
                  ,   tnt_id
                  ,   aur_nm
                  ,   rolname
                  ,   lng_id
                  )
           select
                  c_aur_id
                , p_tnt_id
                , c_rolname
                , c_rolname
                , lng.lng_id
             from
                  app_data.language  lng
            where
                  lng.lng_aur_dflt = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'app_user record not created';
        end if;

        insert
          into
               app_data.app_user_email_address
               (
                   aur_id
               ,   aur_ea
               )
        values (
                   c_aur_id
               ,   p_aur_ea
               );

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'app_user_email_address record not created';
        end if;

           insert
             into
                  app_data.web_app_user
                  (
                      aur_id
                  )
           values (
                      c_aur_id
                  );

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'web_app_user record not created';
        end if;

           insert
             into
                  app_data.web_app_user_home_page
                  (
                      aur_id
                  ,   pg_id
                  )
           select
                  c_aur_id
                , hpg.pg_id
             from
                  app_data.home_page hpg
            where
                  hpg.pg_aur_dflt = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'web_app_user_home_page record not created';
        end if;

           insert
             into
                  app_data.api_app_user
                  (
                      aur_id
                  )
           select
                  aur.aur_id
             from
                  app_data.app_user aur
            where
                  aur.aur_id = c_aur_id
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'api_app_user record not created';
        end if;

           insert
             into
                  app_data.api_app_user_atn_method
                  (
                      aur_id
                  ,   aum_id
                  )
           select
                  c_aur_id
                , aum.aum_id
             from
                  app_data.api_atn_method aum
            where
                  aum.aum_aur_dflt = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'api_app_user_atn_method record not created';
        end if;

           insert
             into
                  app_data.web_app_user_atn_method
                  (
                      aur_id
                  ,   aum_id
                  )
           select
                  c_aur_id
                , wam.aum_id
             from
                  app_data.web_atn_method wam
            where
                  wam.wam_ocp = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_oidc_callback_mod.reg_aur' using detail = 'web_app_user_atn_method record not created';
        end if;

        insert
          into
               app_data.app_user_endpoint_log_level
             (
                 aur_id
             ,   ep_id
             ,   lvl_id
             )
        select
               c_aur_id
             , aep.ep_id
             , lvl.lvl_id
          from
                          app_data.atn_endpoint aep
               cross join app_data.log_level     lvl
         where
               lvl.lvl_aur_dflt = true
             ;

        execute 'create role ' || quote_ident(c_rolname) || ' nologin noinherit';

        for r in select
                        quote_ident( dbrl.dbrl_nm ) dbrl_nm
                   from
                        app_data.db_role dbrl
                  where
                        exists (
                                   select
                                          null
                                     from
                                               app_data.app_group         grp
                                          join app_data.app_group_db_role grpdr on grp.grp_id = grpdr.grp_id
                                    where
                                          grpdr.dbrl_id    = dbrl.dbrl_id
                                      and grp.tnt_id       = p_tnt_id
                                      and grp.grp_aur_dflt = true
                               )
                  union
                 select
                        quote_ident( dbrl.dbrl_nm ) dbrl_nm
                   from
                        app_data.db_role dbrl
                  where
                        dbrl.dbrl_md = true
        loop
                execute 'grant ' || r.dbrl_nm || ' to ' || quote_ident(c_rolname) || ' with inherit true';
        end loop;

        insert
          into
               app_data.app_group_user
             (
                 grp_id
             ,   aur_id
             )
        select
               grp.grp_id
             , c_aur_id
          from
               app_data.app_group grp
         where
               grp.tnt_id       = p_tnt_id
           and grp.grp_aur_dflt = true
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'app_group_user record not created';
        end if;

end;
$$
language plpgsql
security definer;
