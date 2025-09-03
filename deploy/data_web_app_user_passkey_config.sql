do $$
begin
        insert
          into
               app_data.web_app_user_passkey_config
             (
                 tnt_id
             ,   aukc_aur_nm_min_len
             ,   aukc_aur_nm_max_len
             ,   aukc_enabled
             ,   pka_id
             ,   pkt_id
             ,   pdc_id
             ,   puv_reg_id
             ,   puv_atn_id
             )
        select
               tnt.tnt_id
             , 1
             , 10
             , true
             , pka.pka_id
             , pkt.pkt_id
             , pdc.pdc_id
             , puv.puv_id
             , puv.puv_id
          from
                          app_data.tenant                          tnt
               cross join app_data.passkey_attachment              pkt
               cross join app_data.passkey_attestation             pka
               cross join app_data.passkey_discoverable_credential pdc
               cross join app_data.passkey_user_verification       puv
         where
               pkt.pkt_aukc_dflt = true
           and pka.pka_aukc_dflt = true
           and pdc.pdc_aukc_dflt = true
           and puv.puv_aukc_dflt = true
             ;
end $$
