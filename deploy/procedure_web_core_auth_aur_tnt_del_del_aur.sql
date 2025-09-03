create or replace procedure web_core_auth_aur_tnt_del.del_aur
(
        p_tnt_id app_data.app_user.tnt_id%type
,       p_aur_id bigint[]
)
as
$$
declare
        i record;
begin

        for i in select
                        rolname
                   from
                        app_data.app_user
                  where
                        tnt_id = p_tnt_id
                    and aur_id = any(p_aur_id)
        loop
                execute 'drop role if exists ' || quote_ident(i.rolname);
        end loop;

        delete
          from
               app_data.app_user_db_role audr
         where
               audr.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = audr.aur_id
                      );

        delete
          from
               app_data.app_group_user agu
         where
               agu.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = agu.aur_id
                      );


        delete
          from
               app_data.app_user_endpoint_log_level auell
         where
               auell.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = auell.aur_id
                      );

        delete
          from
               app_data.app_user_email_address auea
         where
               auea.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = auea.aur_id
                      );

        delete
          from
               app_data.web_app_user_http_session wauhs
         where
               wauhs.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = wauhs.aur_id
                      );

        delete
          from
               app_data.web_app_user_home_page wauhp
         where
               wauhp.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = wauhp.aur_id
                      );

        delete
          from
               app_data.web_app_user_atn_method wauam
         where
               wauam.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = wauam.aur_id
                      );

        delete
          from
               app_data.web_app_user_password aup
         where
               aup.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = aup.aur_id
                      );

        delete
          from
               app_data.web_app_user_totp otp
         where
               otp.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = otp.aur_id
                      );

        delete
          from
               app_data.web_app_user_totp_nonce wautn
         where
               wautn.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = wautn.aur_id
                      );

        delete
          from
               app_data.web_app_user_passkey_login_session pls
         where
               pls.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = pls.aur_id
                      );

        delete
          from
               app_data.web_app_user_passkey_authenticator_transport kat
         where
               exists (
                          select
                                 null
                            from
                                 app_data.web_app_user_passkey pky
                           where
                                 pky.pky_id = kat.pky_id
                             and pky.aur_id = any(p_aur_id)
                      );

        delete
          from
               app_data.web_app_user_passkey pky
         where
               pky.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = pky.aur_id
                      );

        delete
          from
               app_data.web_app_user wau
         where
               wau.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = wau.aur_id
                      );

        delete
          from
               app_data.api_app_user_atn_method aauam
         where
               aauam.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = aauam.aur_id
                      );

        delete
          from
               app_data.api_app_user_key_db_role aaukdr
         where
               exists (
                          select
                                 null
                            from
                                      app_data.api_app_user_key aauk
                                 join app_data.api_app_user     aau  on aauk.aur_id = aau.aur_id
                                 join app_data.app_user         aur  on aau.aur_id  = aur.aur_id
                           where
                                 aur.tnt_id   = p_tnt_id
                             and aur.aur_id   = any(p_aur_id)
                             and aauk.aauk_id = aaukdr.aauk_id
                      );

        delete
          from
               app_data.api_app_user_key aauk
         where
               aauk.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = aauk.aur_id
                      );

        delete
          from
               app_data.api_app_user aau
         where
               aau.aur_id = any(p_aur_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = aau.aur_id
                      );

        delete
          from
               app_data.app_user
         where
               tnt_id = p_tnt_id
           and aur_id = any(p_aur_id)
             ;

end;
$$
language plpgsql
security definer;
