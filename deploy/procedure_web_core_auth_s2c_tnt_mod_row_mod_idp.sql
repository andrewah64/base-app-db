create or replace procedure web_core_auth_s2c_tnt_mod.row_mod_idp
(
        p_tnt_id      app_data.saml2_identity_provider.tnt_id%type
,       p_idp_id      app_data.saml2_identity_provider.idp_id%type
,       p_idp_nm      app_data.saml2_identity_provider.idp_nm%type
,       p_idp_enabled app_data.saml2_identity_provider.idp_enabled%type
,       p_by          app_data.app_user.aur_nm%type
,       p_uts         app_data.saml2_identity_provider.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.saml2_identity_provider idp
           set
               idp_nm      = p_idp_nm
             , idp_enabled = p_idp_enabled
             , uby         = p_by
             , uts         = now()
         where
               idp.tnt_id  = p_tnt_id
           and idp.idp_id  = p_idp_id
           and idp.uts     = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.saml2_identity_provider idp
                               where
                                     idp.tnt_id  = p_tnt_id
                                 and idp.idp_id  = p_idp_id
                                 and (
                                            idp.idp_nm      != p_idp_nm
                                         or idp.idp_enabled != p_idp_enabled
                                     )
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_s2c_tnt_mod.row_mod_idp' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_s2c_tnt_mod.row_mod_idp' using errcode = 'OLOKD';
                end if;
        end if;

end;
$$
language plpgsql
security definer;
