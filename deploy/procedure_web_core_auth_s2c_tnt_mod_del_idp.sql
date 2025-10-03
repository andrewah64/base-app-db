create or replace procedure web_core_auth_s2c_tnt_mod.del_idp
(
        p_tnt_id app_data.saml2_identity_provider.tnt_id%type
,       p_idp_id bigint[]
)
as
$$
begin

        delete
          from
               app_data.saml2_identity_provider_sso_endpoint sso
         where
               sso.idp_id = any(p_idp_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.saml2_identity_provider idp
                           where
                                 idp.idp_id = sso.idp_id
                             and idp.tnt_id = p_tnt_id
                      );

        delete
          from
               app_data.saml2_identity_provider_slo_endpoint slo
         where
               slo.idp_id = any(p_idp_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.saml2_identity_provider idp
                           where
                                 idp.idp_id = slo.idp_id
                             and idp.tnt_id = p_tnt_id
                      );

        delete
          from
               app_data.saml2_identity_provider_metadata_endpoint mde
         where
               mde.idp_id = any(p_idp_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.saml2_identity_provider idp
                           where
                                 idp.idp_id = mde.idp_id
                             and idp.tnt_id = p_tnt_id
                      );

        delete
          from
               app_data.saml2_identity_provider_certificate ipc
         where
               ipc.idp_id = any(p_idp_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.saml2_identity_provider idp
                           where
                                 idp.idp_id = ipc.idp_id
                             and idp.tnt_id = p_tnt_id
                      );

        delete
          from
               app_data.saml2_identity_provider idp
         where
               idp.tnt_id = p_tnt_id
           and idp.idp_id = any(p_idp_id)
             ;

end;
$$
language plpgsql
security definer;
