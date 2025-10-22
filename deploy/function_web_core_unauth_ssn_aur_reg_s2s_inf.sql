create or replace function web_core_unauth_ssn_aur_reg.s2s_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    sso.sso_url
                  , s2c.s2c_entity_id
               from
                         app_data.web_app_user_saml2_config            s2c
                    join app_data.saml2_identity_provider              idp on s2c.tnt_id = idp.tnt_id
                    join app_data.saml2_identity_provider_sso_endpoint sso on idp.idp_id = sso.idp_id
              where
                    s2c.tnt_id      = p_tnt_id
                and s2c.s2c_enabled = true
                and idp.idp_enabled = true
                and sso.sso_enabled = true
                  ;

        return $1;

end;
$$
language plpgsql
security definer;
