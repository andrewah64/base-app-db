create or replace procedure web_core_auth_atn_tnt_mod.mod_aukc
(
        p_tnt_id               app_data.tenant.tnt_id%type
,       p_aukc_aur_nm_min_len  app_data.web_app_user_passkey_config.aukc_aur_nm_min_len%type
,       p_aukc_aur_nm_max_len  app_data.web_app_user_passkey_config.aukc_aur_nm_max_len%type
,       p_aukc_enabled         app_data.web_app_user_passkey_config.aukc_enabled%type
,       p_pka_id               app_data.passkey_attestation.pka_id%type
,       p_pkt_id               app_data.passkey_attachment.pkt_id%type
,       p_pdc_id               app_data.passkey_discoverable_credential.pdc_id%type
,       p_puv_reg_id           app_data.passkey_user_verification.puv_id%type
,       p_puv_atn_id           app_data.passkey_user_verification.puv_id%type
,       p_pkg_id               bigint[]
,       p_prh_id               bigint[]
,       p_pah_id               bigint[]
,       p_by                   app_data.app_user.aur_nm%type
,       p_uts                  app_data.web_app_user_passkey_config.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.web_app_user_passkey_config aukc
           set
               aukc_aur_nm_min_len  = p_aukc_aur_nm_min_len
             , aukc_aur_nm_max_len  = p_aukc_aur_nm_max_len
             , aukc_enabled         = p_aukc_enabled
             , pka_id               = p_pka_id
             , pkt_id               = p_pkt_id
             , pdc_id               = p_pdc_id
             , puv_reg_id           = p_puv_reg_id
             , puv_atn_id           = p_puv_atn_id
             , uby                  = p_by
             , uts                  = now()
         where
               aukc.tnt_id = p_tnt_id
           and aukc.uts    = p_uts
           and (
                      aukc.aukc_aur_nm_min_len  != p_aukc_aur_nm_min_len
                   or aukc.aukc_aur_nm_max_len  != p_aukc_aur_nm_max_len
                   or aukc.aukc_enabled         != p_aukc_enabled
                   or aukc.pka_id               != p_pka_id
                   or aukc.pkt_id               != p_pkt_id
                   or aukc.pdc_id               != p_pdc_id
                   or aukc.puv_reg_id           != p_puv_reg_id
                   or aukc.puv_atn_id           != p_puv_atn_id
               );

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 and not exists (
                                        select
                                               null
                                          from
                                               app_data.web_app_user_passkey_config aukc
                                         where
                                               aukc.tnt_id = p_tnt_id
                                           and aukc.uts    = p_uts
                                    )
        then
                raise exception 'Optimistic locking error : web_core_auth_atn_tnt_mod.mod_aukc' using errcode = 'OLOCK';
        end if;

         merge
          into
               app_data.web_app_user_passkey_config_public_key_algorithm tgt
         using (
                   select
                          pkg.pkg_id
                        , p_tnt_id   tnt_id
                     from
                          app_data.passkey_public_key_algorithm pkg
                    where
                          pkg.pkg_id = any (p_pkg_id)
               ) src
            on (
                       tgt.tnt_id = src.tnt_id
                   and tgt.pkg_id = src.pkg_id
               )
          when
               not matched by target
          then
               insert (tnt_id, pkg_id, cby, uby) values (src.tnt_id, src.pkg_id, p_by, p_by)
          when
               not matched by source and tgt.tnt_id = p_tnt_id
          then
               delete
             ;

        update
               app_data.web_app_user_passkey_config_registration_hint prh
           set
               prh_od = prh.prh_od + (select count(*) from app_data.passkey_hint)
             , uby    = p_by
             , uts    = now()
         where
               prh.tnt_id = p_tnt_id
             ;

         merge
          into
               app_data.web_app_user_passkey_config_registration_hint tgt
         using (
                   select
                          prh.pkh_id
                        , prh.prh_od
                        , p_tnt_id   tnt_id
                     from
                          unnest(p_prh_id) with ordinality prh (pkh_id, prh_od)
               ) src
            on (
                       tgt.tnt_id = src.tnt_id
                   and tgt.pkh_id = src.pkh_id
               )
          when
               matched and tgt.prh_od != src.prh_od
          then
               update
                  set
                      prh_od = src.prh_od
                    , uby    = p_by
                    , uts    = now()
          when
               not matched by target
          then
               insert (tnt_id, pkh_id, prh_od, cby, uby) values (src.tnt_id, src.pkh_id, src.prh_od, p_by, p_by)
          when
               not matched by source and tgt.tnt_id = p_tnt_id
          then
               delete
             ;

        update
               app_data.web_app_user_passkey_config_atn_hint pah
           set
               pah_od = pah.pah_od + (select count(*) from app_data.passkey_hint)
             , uby    = p_by
             , uts    = now()
         where
               pah.tnt_id = p_tnt_id
             ;

         merge
          into
               app_data.web_app_user_passkey_config_atn_hint tgt
         using (
                   select
                          pah.pkh_id
                        , pah.pah_od
                        , p_tnt_id   tnt_id
                     from
                          unnest(p_pah_id) with ordinality pah (pkh_id, pah_od)
               ) src
            on (
                       tgt.tnt_id = src.tnt_id
                   and tgt.pkh_id = src.pkh_id
               )
          when
               matched and tgt.pah_od != src.pah_od
          then
               update
                  set
                      pah_od = src.pah_od
                    , uby    = p_by
                    , uts    = now()
          when
               not matched by target
          then
               insert (tnt_id, pkh_id, pah_od, cby, uby) values (src.tnt_id, src.pkh_id, src.pah_od, p_by, p_by)
          when
               not matched by source and tgt.tnt_id = p_tnt_id
          then
               delete
             ;

end;
$$
language plpgsql
security definer;
