do $$
begin
        insert into app_data.web_atn_method (aum_id, wam_ocp)
        select aum_id
             , true
          from app_data.atn_method
         where aum_nm in ('OIDC');

        insert into app_data.web_atn_method (aum_id, wam_pw)
        select aum_id
             , true
          from app_data.atn_method
         where aum_nm in ('Username and password');

        insert into app_data.web_atn_method (aum_id, wam_pky)
        select aum_id
             , true
          from app_data.atn_method
         where aum_nm in ('Passkey');

        insert into app_data.web_atn_method (aum_id, wam_s2i)
        select aum_id
             , true
          from app_data.atn_method
         where aum_nm in ('SAML2 : IdP initiated');

        insert into app_data.web_atn_method (aum_id, wam_s2s)
        select aum_id
             , true
          from app_data.atn_method
         where aum_nm in ('SAML2 : SP initiated');

end $$
