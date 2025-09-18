create or replace procedure web_core_auth_s2c_tnt_mod.mod_s2g
(
        p_tnt_id      app_data.tenant.tnt_id%type
,       p_s2g_crt_cn  app_data.web_app_user_saml2_cert_config.s2g_crt_cn%type
,       p_s2g_crt_org app_data.web_app_user_saml2_cert_config.s2g_crt_org%type
,       p_by          app_data.app_user.aur_nm%type
,       p_uts         app_data.web_app_user_saml2_cert_config.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.web_app_user_saml2_cert_config s2g
           set
               s2g_crt_cn  = p_s2g_crt_cn
             , s2g_crt_org = p_s2g_crt_org
             , uby         = p_by
             , uts         = now()
         where
               s2g.tnt_id = p_tnt_id
           and s2g.uts    = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 and not exists (
                                        select
                                               null
                                          from
                                               app_data.web_app_user_saml2_cert_config s2g
                                         where
                                               s2g.tnt_id = p_tnt_id
                                           and s2g.uts    = p_uts
                                    )
        then
                raise exception 'Optimistic locking error : web_core_auth_s2c_tnt_mod.mod_s2g' using errcode = 'OLOCK';
        end if;

end;
$$
language plpgsql
security definer;
