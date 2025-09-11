create or replace function web_core_unauth_spc_tnt_inf.spc_inf
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
                    s2c.s2c_entity_id
                  , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                                 when '443' then ''
                                                                 when '80'  then ''
                                                                 else ':' || tnt.tnt_port::text
                                                             end
                                                          || epp.epp_pt                         s2c_acs_url
                  , spc.spc_enc_crt
                  , spc.spc_sgn_crt
               from
                         app_data.tenant                                  tnt
                    join app_data.web_app_user_saml2_config               s2c on tnt.tnt_id = s2c.tnt_id
                    join app_data.endpoint                                ep  on s2c.ep_id  = ep.ep_id
                    join app_data.endpoint_path                           epp on ep.epp_id  = epp.epp_id
                    join app_data.saml2_service_provider_certificate_pair spc on s2c.tnt_id = spc.tnt_id
              where
                    tnt.tnt_id      = p_tnt_id
                and spc.spc_enabled = true
                and spc.spc_exp_ts  > now()
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
