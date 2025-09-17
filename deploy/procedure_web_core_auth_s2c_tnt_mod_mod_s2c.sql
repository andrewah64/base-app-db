create or replace procedure web_core_auth_s2c_tnt_mod.mod_s2c
(
        p_tnt_id app_data.tenant.tnt_id%type
,       p_aum_id app_data.web_app_user_saml2_config.aum_id%type
,       p_by     app_data.app_user.aur_nm%type
,       p_uts    app_data.web_app_user_saml2_config.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.web_app_user_saml2_config s2c
           set
               aum_id = p_aum_id
             , uby    = p_by
             , uts    = now()
         where
               s2c.tnt_id = p_tnt_id
           and s2c.uts    = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 and not exists (
                                        select
                                               null
                                          from
                                               app_data.web_app_user_saml2_config s2c
                                         where
                                               s2c.tnt_id = p_tnt_id
                                           and s2c.uts    = p_uts
                                    )
        then
                raise exception 'Optimistic locking error : web_core_auth_s2c_tnt_mod.mod_s2c' using errcode = 'OLOCK';
        end if;

end;
$$
language plpgsql
security definer;
