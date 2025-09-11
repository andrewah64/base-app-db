create or replace procedure all_core_unauth_spc_all_reg.reg_spc
(
        p_tnt_id      app_data.saml2_service_provider_certificate_pair.tnt_id%type
,       p_spc_cn_nm   app_data.saml2_service_provider_certificate_pair.spc_cn_nm%type
,       p_spc_org_nm  app_data.saml2_service_provider_certificate_pair.spc_org_nm%type
,       p_spc_enc_crt app_data.saml2_service_provider_certificate_pair.spc_enc_crt%type
,       p_spc_enc_pvk app_data.saml2_service_provider_certificate_pair.spc_enc_pvk%type
,       p_spc_sgn_crt app_data.saml2_service_provider_certificate_pair.spc_sgn_crt%type
,       p_spc_sgn_pvk app_data.saml2_service_provider_certificate_pair.spc_sgn_pvk%type
,       p_spc_exp_ts  app_data.saml2_service_provider_certificate_pair.spc_exp_ts%type
,       p_spc_enabled app_data.saml2_service_provider_certificate_pair.spc_enabled%type
)
as
$$
begin

        update
               app_data.saml2_service_provider_certificate_pair spc
           set
               spc_enabled = false
         where
               spc.tnt_id      = p_tnt_id
           and spc.spc_exp_ts <= now()
             ;

        insert
          into
               app_data.saml2_service_provider_certificate_pair
             (
                 tnt_id
             ,   spc_cn_nm
             ,   spc_org_nm
             ,   spc_enc_crt
             ,   spc_enc_pvk
             ,   spc_sgn_crt
             ,   spc_sgn_pvk
             ,   spc_exp_ts
             ,   spc_enabled
             )
        select
               p_tnt_id
             , p_spc_cn_nm
             , p_spc_org_nm
             , p_spc_enc_crt
             , p_spc_enc_pvk
             , p_spc_sgn_crt
             , p_spc_sgn_pvk
             , p_spc_exp_ts
             , p_spc_enabled
         where
               not exists (
                              select
                                     null
                                from
                                     app_data.saml2_service_provider_certificate_pair spc
                               where
                                     spc.tnt_id     = p_tnt_id
                                 and spc.spc_exp_ts > now()
                          );

end;
$$
language plpgsql
security definer;
