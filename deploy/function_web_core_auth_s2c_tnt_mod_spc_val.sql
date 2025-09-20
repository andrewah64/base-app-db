create or replace function web_core_auth_s2c_tnt_mod.spc_val
(
        refcursor
,       p_tnt_id  app_data.saml2_service_provider_certificate_pair.tnt_id%type
,       p_spc_nm  app_data.saml2_service_provider_certificate_pair.spc_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select coalesce
                    (
                        (
                            select
                                   false
                              from
                                   app_data.saml2_service_provider_certificate_pair spc
                             where
                                   spc.tnt_id = p_tnt_id
                               and spc.spc_nm = p_spc_nm
                        )
                    ,   true
                    )
                    spc_nm_ok
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
