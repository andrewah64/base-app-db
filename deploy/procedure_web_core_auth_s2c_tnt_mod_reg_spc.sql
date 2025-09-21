create or replace procedure web_core_auth_s2c_tnt_mod.reg_spc
(
        p_tnt_id      app_data.saml2_service_provider_certificate_pair.tnt_id%type
,       p_spc_nm      app_data.saml2_service_provider_certificate_pair.spc_nm%type
,       p_spc_cn_nm   app_data.saml2_service_provider_certificate_pair.spc_cn_nm%type
,       p_spc_org_nm  app_data.saml2_service_provider_certificate_pair.spc_org_nm%type
,       p_spc_enc_crt app_data.saml2_service_provider_certificate_pair.spc_enc_crt%type
,       p_spc_enc_pvk app_data.saml2_service_provider_certificate_pair.spc_enc_pvk%type
,       p_spc_sgn_crt app_data.saml2_service_provider_certificate_pair.spc_sgn_crt%type
,       p_spc_sgn_pvk app_data.saml2_service_provider_certificate_pair.spc_sgn_pvk%type
,       p_spc_inc_ts  app_data.saml2_service_provider_certificate_pair.spc_inc_ts%type
,       p_spc_exp_ts  app_data.saml2_service_provider_certificate_pair.spc_exp_ts%type
,       p_by          app_data.saml2_service_provider_certificate_pair.cby%type
)
as
$$
begin

        insert
          into
               app_data.saml2_service_provider_certificate_pair
             (
                 tnt_id
             ,   spc_nm
             ,   spc_cn_nm
             ,   spc_org_nm
             ,   spc_enc_crt
             ,   spc_enc_pvk
             ,   spc_sgn_crt
             ,   spc_sgn_pvk
             ,   spc_inc_ts
             ,   spc_exp_ts
             ,   spc_enabled
             ,   cby
             ,   uby
             )
        values
             (
                 p_tnt_id
             ,   p_spc_nm
             ,   p_spc_cn_nm
             ,   p_spc_org_nm
             ,   p_spc_enc_crt
             ,   p_spc_enc_pvk
             ,   p_spc_sgn_crt
             ,   p_spc_sgn_pvk
             ,   p_spc_inc_ts
             ,   p_spc_exp_ts
             ,   false
             ,   p_by
             ,   p_by
             );

end;
$$
language plpgsql
security definer;
