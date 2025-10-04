create or replace function web_core_auth_s2c_tnt_mod.row_idp_val
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_idp_id  app_data.saml2_identity_provider.idp_id%type
,       p_idp_nm  app_data.saml2_identity_provider.idp_nm%type
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
                                   app_data.saml2_identity_provider idp
                             where
                                   idp.tnt_id  = p_tnt_id
                               and idp.idp_id != p_idp_id
                               and idp.idp_nm  = p_idp_nm
                        )
                    ,   true
                    ) idp_nm_ok
                  ;

        return $1;

end;
$$
language plpgsql
security definer;
