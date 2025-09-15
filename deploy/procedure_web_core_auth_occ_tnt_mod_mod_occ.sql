create or replace procedure web_core_auth_occ_tnt_mod.mod_occ
(
        p_tnt_id            app_data.tenant.tnt_id%type
,       p_occ_id            app_data.oidc_client.occ_id%type
,       p_occ_enabled       app_data.oidc_client.occ_enabled%type
,       p_occ_url           app_data.oidc_client.occ_url%type
,       p_occ_client_id     app_data.oidc_client.occ_client_id%type
,       p_occ_client_secret app_data.oidc_client.occ_client_secret%type
,       p_by                app_data.app_user.aur_nm%type
,       p_uts               app_data.oidc_client.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.oidc_client occ
           set
               occ_enabled       = p_occ_enabled
             , occ_url           = p_occ_url
             , occ_client_id     = p_occ_client_id
             , occ_client_secret = p_occ_client_secret
             , uby               = p_by
             , uts               = now()
         where
               occ.occ_id = p_occ_id
           and occ.uts    = p_uts
           and (
                      occ.occ_enabled       != p_occ_enabled
                   or occ.occ_url           != p_occ_url
                   or occ.occ_client_id     != p_occ_client_id
                   or occ.occ_client_secret != p_occ_client_secret
               );

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 and not exists (
                                        select
                                               null
                                          from
                                               app_data.oidc_client occ
                                         where
                                               occ.tnt_id = p_tnt_id
                                           and occ.uts    = p_uts
                                    )
        then
                raise exception 'Optimistic locking error : web_core_auth_atn_tnt_mod.mod_occ' using errcode = 'OLOCK';
        end if;

end;
$$
language plpgsql
security definer;
