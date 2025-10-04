create or replace function web_core_auth_s2c_tnt_mod.row_idp_mod
(
        refcursor
,       p_tnt_id  app_data.saml2_identity_provider.tnt_id%type
,       p_idp_id  app_data.saml2_identity_provider.idp_id%type
)
returns refcursor
as
$$
begin

        open
             $1
         for
             select
                    idp.idp_id
                  , idp.idp_nm
                  , idp.idp_entity_id
                  , idp.idp_enabled
                  , coalesce(mde.num_mde, 0) num_mde
                  , coalesce(sso.num_sso, 0) num_sso
                  , coalesce(slo.num_slo, 0) num_slo
                  , idp.uts
               from
                              app_data.saml2_identity_provider idp
                    left join (
                                    select
                                           mde.idp_id
                                         , count(*)   num_mde
                                      from
                                           app_data.saml2_identity_provider_metadata_endpoint mde
                                     where
                                           mde.idp_id = p_idp_id
                                  group by
                                           mde.idp_id
                              ) mde
                           on (
                                  idp.idp_id = mde.idp_id
                              )
                    left join (
                                    select
                                           sso.idp_id
                                         , count(*)   num_sso
                                      from
                                           app_data.saml2_identity_provider_sso_endpoint sso
                                     where
                                           sso.idp_id = p_idp_id
                                  group by
                                           sso.idp_id
                              ) sso
                           on (
                                  idp.idp_id = sso.idp_id
                              )
                    left join (
                                    select
                                           slo.idp_id
                                         , count(*)   num_slo
                                      from
                                           app_data.saml2_identity_provider_slo_endpoint slo
                                     where
                                           slo.idp_id = p_idp_id
                                  group by
                                           slo.idp_id
                              ) slo
                           on (
                                  idp.idp_id = slo.idp_id
                              )
              where
                    idp.tnt_id = p_tnt_id
                and idp.idp_id = p_idp_id
                  ;

        return $1;

end;
$$
language plpgsql
security definer;
