create or replace procedure web_core_auth_s2c_tnt_mod.reg_idp
(
        p_tnt_id        app_data.saml2_identity_provider.tnt_id%type
,       p_idp_entity_id app_data.saml2_identity_provider.idp_entity_id%type
,       p_ipc_crt       bytea[]
,       p_ipc_crt_use   text[]
,       p_ipc_inc_ts    timestamp with time zone[]
,       p_ipc_exp_ts    timestamp with time zone[]
,       p_mde_url       text
,       p_slo_url       text[]
,       p_sso_url       text[]
,       p_by            app_data.app_user.aur_nm%type
)
as
$$
declare

        v_now    app_data.saml2_identity_provider.cts%type     := now();
        v_idp_id app_data.saml2_identity_provider.idp_id%type;

begin

           insert
             into
                  app_data.saml2_identity_provider
                  (
                      tnt_id
                  ,   idp_entity_id
                  ,   cby
                  ,   cts
                  ,   uby
                  ,   uts
                  )
           select
                  p_tnt_id        tnt_id
                , p_idp_entity_id idp_entity_id
                , p_by            cby
                , v_now           cts
                , p_by            uby
                , v_now           uts
            where
                  not exists (
                                 select
                                        null
                                   from
                                        app_data.saml2_identity_provider idp
                                  where
                                        idp.tnt_id        = p_tnt_id
                                    and idp.idp_entity_id = p_idp_entity_id
                             )
        returning
                  idp_id
             into
                  v_idp_id
                ;

        if v_idp_id is null then

            select
                   idp.idp_id
                              into
                                   v_idp_id
              from
                   app_data.saml2_identity_provider idp
             where
                   idp.tnt_id        = p_tnt_id
               and idp.idp_entity_id = p_idp_entity_id
                 ;

            delete
              from
                   app_data.saml2_identity_provider_certificate ipc
             where
                   ipc.idp_id = v_idp_id
                 ;

            delete
              from
                   app_data.saml2_identity_provider_metadata_endpoint mde
             where
                   mde.idp_id = v_idp_id
                 ;

            delete
              from
                   app_data.saml2_identity_provider_slo_endpoint slo
             where
                   slo.idp_id = v_idp_id
                 ;

            delete
              from
                   app_data.saml2_identity_provider_sso_endpoint sso
             where
                   sso.idp_id = v_idp_id
                 ;

        end if;

        insert
          into
               app_data.saml2_identity_provider_certificate
             (
                 idp_id
             ,   ipc_crt
             ,   ipc_crt_use
             ,   ipc_inc_ts
             ,   ipc_exp_ts
             ,   cby
             ,   cts
             ,   uby
             ,   uts
             )
        select
               v_idp_id
             , crt.ipc_crt
             , use.ipc_crt_use
             , its.ipc_inc_ts
             , ets.ipc_exp_ts
             , p_by
             , v_now
             , p_by
             , v_now
          from
                    unnest(p_ipc_crt)     with ordinality crt (ipc_crt    , id)
               join unnest(p_ipc_crt_use) with ordinality use (ipc_crt_use, id) on crt.id = use.id
               join unnest(p_ipc_inc_ts)  with ordinality its (ipc_inc_ts , id) on crt.id = its.id
               join unnest(p_ipc_exp_ts)  with ordinality ets (ipc_exp_ts , id) on crt.id = ets.id
             ;

        insert
          into
               app_data.saml2_identity_provider_metadata_endpoint
             (
                 idp_id
             ,   mde_url
             ,   cby
             ,   cts
             ,   uby
             ,   uts
             )
        values
             (
               v_idp_id
             , p_mde_url
             , p_by
             , v_now
             , p_by
             , v_now
             );

        insert
          into
               app_data.saml2_identity_provider_slo_endpoint
             (
                 idp_id
             ,   slo_url
             ,   cby
             ,   cts
             ,   uby
             ,   uts
             )
        select
               v_idp_id    idp_id
             , slo.slo_url slo_url
             , p_by
             , v_now
             , p_by
             , v_now
          from
               unnest(p_slo_url) slo (slo_url)
             ;

        insert
          into
               app_data.saml2_identity_provider_sso_endpoint
             (
                 idp_id
             ,   sso_url
             ,   cby
             ,   cts
             ,   uby
             ,   uts
             )
        select
               v_idp_id    idp_id
             , sso.sso_url sso_url
             , p_by
             , v_now
             , p_by
             , v_now
          from
               unnest(p_sso_url) sso (sso_url)
             ;

end;
$$
language plpgsql
security definer;
