create or replace procedure web_core_auth_s2c_tnt_mod.row_mod_spc
(
        p_tnt_id      app_data.saml2_service_provider_certificate_pair.tnt_id%type
,       p_spc_id      app_data.saml2_service_provider_certificate_pair.spc_id%type
,       p_spc_nm      app_data.saml2_service_provider_certificate_pair.spc_nm%type
,       p_spc_enabled app_data.saml2_service_provider_certificate_pair.spc_enabled%type
,       p_by          app_data.app_user.aur_nm%type
,       p_uts         app_data.saml2_service_provider_certificate_pair.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.saml2_service_provider_certificate_pair spc
           set
               spc_nm      = p_spc_nm
             , spc_enabled = p_spc_enabled
             , uby         = p_by
             , uts         = now()
         where
               spc.tnt_id  = p_tnt_id
           and spc.spc_id  = p_spc_id
           and spc.uts     = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.saml2_service_provider_certificate_pair spc
                               where
                                     spc.tnt_id  = p_tnt_id
                                 and spc.spc_id  = p_spc_id
                                 and (
                                            spc.spc_nm      != p_spc_nm
                                         or spc.spc_enabled != p_spc_enabled
                                     )
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_s2c_tnt_mod.row_mod_spc' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_s2c_tnt_mod.row_mod_spc' using errcode = 'OLOKD';
                end if;
        end if;

end;
$$
language plpgsql
security definer;
