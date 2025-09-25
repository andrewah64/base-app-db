create or replace function web_core_auth_s2c_tnt_mod.row_spc_val
(
        refcursor
,       p_tnt_id      app_data.tenant.tnt_id%type
,       p_spc_id      app_data.saml2_service_provider_certificate_pair.spc_id%type
,       p_spc_nm      app_data.saml2_service_provider_certificate_pair.spc_nm%type
,       p_spc_enabled app_data.saml2_service_provider_certificate_pair.spc_enabled%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    coalesce
                    (
                        (
                            select
                                   false
                              from
                                   app_data.saml2_service_provider_certificate_pair spc
                             where
                                   spc.tnt_id  = p_tnt_id
                               and spc.spc_id != p_spc_id
                               and spc.spc_nm  = p_spc_nm
                        )
                    ,   true
                    ) spc_nm_ok
                  , case
                        when p_spc_enabled
                        then coalesce
                             (
                                 (
                                     select
                                            false
                                       from
                                            app_data.saml2_service_provider_certificate_pair spc
                                      where
                                            spc.tnt_id       = p_tnt_id
                                        and spc.spc_id      != p_spc_id
                                        and spc.spc_enabled  = true
                                 )
                             ,   true
                             )
                        else true
                    end spc_enabled_ok
                  , case
                        when p_spc_enabled
                        then coalesce
                             (
                                 (
                                     select
                                            true
                                       from
                                            app_data.saml2_service_provider_certificate_pair spc
                                      where
                                            spc.tnt_id = p_tnt_id
                                        and spc.spc_id = p_spc_id
                                        and now() between
                                                          spc.spc_inc_ts
                                                      and
                                                          spc.spc_exp_ts
                                 )
                             ,   false
                             )
                        else true
                    end spc_ts_ok
                  ;

        return $1;

end;
$$
language plpgsql
security definer;
