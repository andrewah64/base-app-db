create or replace function web_core_unauth_ssn_aur_reg.aur_pwd_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_nm  app_data.app_user.aur_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aur.aur_id
                  , aup.aur_hsh_pw
                  , waur.aur_ssn_dn
                  , epp.epp_pt
                  , coalesce(aupc.aupc_mfa_enabled, false) aupc_mfa_enabled
               from
                              app_data.app_user                           aur
                         join app_data.web_app_user_password              aup   on aur.aur_id   = aup.aur_id
                         join app_data.web_app_user                       waur  on aur.aur_id   = waur.aur_id
                         join app_data.web_app_user_atn_method wauam on waur.aur_id  = wauam.aur_id
                         join app_data.web_atn_method          wam   on wauam.aum_id = wam.aum_id
                         join app_data.web_app_user_home_page             wauhp on waur.aur_id  = wauhp.aur_id
                         join app_data.page_endpoint                      pe    on wauhp.pg_id  = pe.pg_id
                         join app_data.endpoint                           ep    on pe.ep_id     = ep.ep_id
                         join app_data.endpoint_path                      epp   on ep.epp_id    = epp.epp_id
                    left join app_data.web_app_user_password_config       aupc  on (
                                                                                           aupc.tnt_id           = aur.tnt_id
                                                                                       and aupc.aupc_enabled     = true
                                                                                       and aupc.aupc_mfa_enabled = true
                                                                                   )
              where
                    aur.aur_nm            = p_aur_nm
                and aur.tnt_id            = p_tnt_id
                and pe.pe_is_entry        = true
                and wam.wam_pw            = true
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
