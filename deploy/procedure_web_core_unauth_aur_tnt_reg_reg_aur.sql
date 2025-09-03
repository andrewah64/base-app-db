create or replace procedure web_core_unauth_aur_tnt_reg.reg_aur
(
        p_tnt_id     app_data.tenant.tnt_id%type
,       p_aur_nm     app_data.app_user.aur_nm%type
,       p_aur_hsh_pw app_data.web_app_user_password.aur_hsh_pw%type
,       p_aur_ea     app_data.app_user_email_address.aur_ea%type
,       p_otp_id     app_data.web_app_user_totp.otp_id%type
,       p_otp_secret app_data.web_app_user_totp.otp_secret%type
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
                , p_aur_nm
                , c_rolname
                , lng.lng_id
             from
                  app_data.language lng
            where
                  lng.lng_aur_dflt = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'app_user record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user record not created';
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

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'app_user_email_address record not created';
        end if;

           insert
             into
                  app_data.web_app_user_password
                (
                    aur_id
                ,   aur_hsh_pw
                )
           select
                  aur.aur_id
                , p_aur_hsh_pw
             from
                  app_data.app_user aur
            where
                  aur.aur_id = c_aur_id
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user_password record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user_home_page record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'api_app_user record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'api_app_user_atn_method record not created';
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
                  wam.wam_pw = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user_atn_method record not created';
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

        if (select
                   aupc.aupc_mfa_enabled
              from
                   app_data.web_app_user_password_config aupc
             where
                   aupc.tnt_id = p_tnt_id) = true
        then
                if p_otp_id is null
                then
                        raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'p_otp_id cannot be null';
                end if;

                if p_otp_secret is null
                then
                        raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'p_otp_secret cannot be null';
                end if;

                insert
                  into
                       app_data.web_app_user_totp
                     (
                         otp_id
                     ,   aur_id
                     ,   otp_secret
                     ,   otp_enabled
                     )
                values
                     (
                         p_otp_id
                     ,   c_aur_id
                     ,   p_otp_secret
                     ,   false
                     );
        end if;

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
                                          dbrl.dbrl_id     = grpdr.dbrl_id
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

create or replace procedure web_core_unauth_aur_tnt_reg.reg_aur
(
        p_tnt_id                      app_data.tenant.tnt_id%type
,       p_aur_nm                      app_data.app_user.aur_nm%type
,       p_pky_enabled                 app_data.web_app_user_passkey.pky_enabled%type
,       p_pky_credential_id           app_data.web_app_user_passkey.pky_credential_id%type
,       p_pky_public_key              app_data.web_app_user_passkey.pky_public_key%type
,       p_pky_attestation_type        app_data.web_app_user_passkey.pky_attestation_type%type
,       p_pky_authenticator_transport text[]
,       p_pky_user_present            app_data.web_app_user_passkey.pky_user_present%type
,       p_pky_user_verified           app_data.web_app_user_passkey.pky_user_verified%type
,       p_pky_backup_eligible         app_data.web_app_user_passkey.pky_backup_eligible%type
,       p_pky_backup_state            app_data.web_app_user_passkey.pky_backup_state%type
,       p_pky_aaguid                  app_data.web_app_user_passkey.pky_aaguid%type
,       p_pky_sign_count              app_data.web_app_user_passkey.pky_sign_count%type
,       p_pky_clone_warning           app_data.web_app_user_passkey.pky_clone_warning%type
,       p_pky_attachment              app_data.web_app_user_passkey.pky_attachment%type
,       p_pky_client_data_json        app_data.web_app_user_passkey.pky_client_data_json%type
,       p_pky_client_data_hash        app_data.web_app_user_passkey.pky_client_data_hash%type
,       p_pky_authenticator_data      app_data.web_app_user_passkey.pky_authenticator_data%type
,       p_pky_public_key_algorithm    app_data.web_app_user_passkey.pky_public_key_algorithm%type
,       p_pky_object                  app_data.web_app_user_passkey.pky_object%type
)
as
$$
declare

        c_aur_id  constant app_data.app_user.aur_id%type  := nextval('app_data.app_user_aur_id_seq');
        c_rolname constant app_data.app_user.rolname%type := c_aur_id::name;

        v_pky_id  app_data.web_app_user_passkey.pky_id%type;
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
                , p_aur_nm
                , c_rolname
                , lng.lng_id
             from
                  app_data.language lng
            where
                  lng.lng_aur_dflt = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'app_user record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user record not created';
        end if;

         insert
           into
                app_data.web_app_user_passkey
                (
                    aur_id
                ,   pky_enabled
                ,   pky_credential_id
                ,   pky_public_key
                ,   pky_attestation_type
                ,   pky_user_present
                ,   pky_user_verified
                ,   pky_backup_eligible
                ,   pky_backup_state
                ,   pky_aaguid
                ,   pky_sign_count
                ,   pky_clone_warning
                ,   pky_attachment
                ,   pky_client_data_json
                ,   pky_client_data_hash
                ,   pky_authenticator_data
                ,   pky_public_key_algorithm
                ,   pky_object
                )
         values (
                    c_aur_id
                ,   p_pky_enabled
                ,   p_pky_credential_id
                ,   p_pky_public_key
                ,   p_pky_attestation_type
                ,   p_pky_user_present
                ,   p_pky_user_verified
                ,   p_pky_backup_eligible
                ,   p_pky_backup_state
                ,   p_pky_aaguid
                ,   p_pky_sign_count
                ,   p_pky_clone_warning
                ,   p_pky_attachment
                ,   p_pky_client_data_json
                ,   p_pky_client_data_hash
                ,   p_pky_authenticator_data
                ,   p_pky_public_key_algorithm
                ,   p_pky_object
                )
        returning
                  pky_id
             into
                  v_pky_id
                ;

        insert
          into
               app_data.web_app_user_passkey_authenticator_transport
             (
                 pky_id
             ,   pat_id
             )
        select
               v_pky_id
             , pat.pat_id 
          from
                    app_data.passkey_authenticator_transport pat
               join unnest(p_pky_authenticator_transport)    ppat (pat_nm) on pat.pat_nm = ppat.pat_nm
             ;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user_passkey record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user_home_page record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'api_app_user record not created';
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
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'api_app_user_atn_method record not created';
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
                  wam.wam_pky = true
                ;

        get diagnostics v_cnt = row_count;

        if v_cnt != 1 then
                raise exception 'Failure: web_core_unauth_aur_tnt_reg.reg_aur' using detail = 'web_app_user_atn_method record not created';
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
             , ep.ep_id
             , lvl.lvl_id
          from
                          app_data.endpoint  ep
               cross join app_data.log_level lvl
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
                                          dbrl.dbrl_id     = grpdr.dbrl_id
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
