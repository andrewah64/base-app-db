create or replace procedure web_core_auth_atn_tnt_mod.reg_s2c
(
        p_tnt_id      app_data.tenant.tnt_id%type
,       p_s2c_enc_crt app_data.web_app_user_saml2_config.s2c_enc_crt%type
,       p_s2c_sgn_crt app_data.web_app_user_saml2_config.s2c_sgn_crt%type
,       p_by          app_data.app_user.aur_nm%type
)
as
$$
begin

           insert
             into
                  app_data.web_app_user_saml2_config
                  (
                      tnt_id
                  ,   aum_id
                  ,   s2c_enc_crt
                  ,   s2c_sgn_crt
                  ,   cby
                  ,   uby
                  )
           select
                  tnt.tnt_id
                , asm.aum_id
                , p_s2c_enc_crt
                , p_s2c_sgn_crt
                , p_by
                , p_by
             from
                             app_data.tenant               tnt
                  cross join app_data.web_atn_saml2_method asm
            where
                  tnt.tnt_id       = p_tnt_id
              and asm.asm_s2c_dflt = true
                ;

end;
$$
language plpgsql
security definer;
