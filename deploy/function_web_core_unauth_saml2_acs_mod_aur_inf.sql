create or replace function web_core_unauth_saml2_acs_mod.aur_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_ea  app_data.app_user_email_address.aur_ea%type
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
                  , waur.aur_ssn_dn
                  , epp.epp_pt
               from
                         app_data.app_user               aur
                    join app_data.web_app_user           waur  on aur.aur_id   = waur.aur_id
                    join app_data.web_app_user_home_page wauhp on waur.aur_id  = wauhp.aur_id
                    join app_data.page_endpoint          pe    on wauhp.pg_id  = pe.pg_id
                    join app_data.endpoint               ep    on pe.ep_id     = ep.ep_id
                    join app_data.endpoint_path          epp   on ep.epp_id    = epp.epp_id
              where
                    aur.tnt_id     = p_tnt_id
                and pe.pe_is_entry = true
                and exists (
                               select
                                      null
                                 from
                                           app_data.web_app_user_atn_method wauam
                                      join app_data.web_atn_method          wam   on wauam.aum_id = wam.aum_id
                                where
                                      wauam.aur_id = waur.aur_id
                                  and (
                                             wam.wam_s2i = true
                                          or wam.wam_s2s = true
                                      )
                           )
                and exists (
                               select
                                      null
                                 from
                                      app_data.app_user_email_address auea
                                where
                                      auea.aur_id = aur.aur_id
                                  and auea.aur_ea = p_aur_ea
                           );

        return $1;
end;
$$
language plpgsql
security definer;
