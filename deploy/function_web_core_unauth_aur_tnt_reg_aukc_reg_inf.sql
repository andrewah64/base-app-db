create or replace function web_core_unauth_aur_tnt_reg.aukc_reg_inf
(
        refcursor
,       p_tnt_id  app_data.web_app_user_password_config.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      pka.pka_nm
                    , pkt.pkt_nm
                    , pdc.pdc_nm
                    , puv.puv_nm
                    , pkg.pkg_cd
                    , pkh.pkh_nm
                 from
                                 app_data.web_app_user_passkey_config     aukc
                            join app_data.passkey_attestation             pka  on aukc.pka_id     = pka.pka_id
                            join app_data.passkey_attachment              pkt  on aukc.pkt_id     = pkt.pkt_id
                            join app_data.passkey_discoverable_credential pdc  on aukc.pdc_id     = pdc.pdc_id
                            join app_data.passkey_user_verification       puv  on aukc.puv_reg_id = puv.puv_id
                      cross join (
                                     select
                                            coalesce(array_agg(pkg.pkg_cd order by pkg.pkg_cd asc), array[]::integer[]) pkg_cd
                                       from
                                                 app_data.web_app_user_passkey_config_public_key_algorithm pra
                                            join app_data.passkey_public_key_algorithm                     pkg on pra.pkg_id = pkg.pkg_id
                                      where
                                            pra.tnt_id = p_tnt_id
                                 ) pkg
                      cross join (
                                     select
                                            coalesce(array_agg(pkh.pkh_nm order by prh.prh_od asc), array[]::text[]) pkh_nm
                                       from
                                                 app_data.web_app_user_passkey_config_registration_hint prh
                                            join app_data.passkey_hint                                  pkh on prh.pkh_id = pkh.pkh_id
                                      where
                                            prh.tnt_id = p_tnt_id
                                 ) pkh
                where
                      aukc.tnt_id = p_tnt_id
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
