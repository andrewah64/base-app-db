create or replace function web_core_auth_s2c_tnt_mod.row_spc_mod
(
        refcursor
,       p_tnt_id  app_data.saml2_service_provider_certificate_pair.tnt_id%type
,       p_spc_id  app_data.saml2_service_provider_certificate_pair.spc_id%type
)
returns refcursor
as
$$
begin

        open
             $1
         for
             select
                    spc.spc_id
                  , spc.spc_nm
                  , spc.spc_cn_nm
                  , spc.spc_inc_ts
                  , spc.spc_exp_ts
                  , spc.spc_enabled
                  , spc.uts
               from
                    app_data.saml2_service_provider_certificate_pair spc
              where
                    spc.tnt_id = p_tnt_id
                and spc.spc_id = p_spc_id
                  ;

        return $1;

end;
$$
language plpgsql
security definer;
