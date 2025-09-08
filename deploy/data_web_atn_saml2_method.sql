do $$
begin
        insert
          into
               app_data.web_atn_saml2_method
             (
                 aum_id
             )
        select
               wam.aum_id
          from
               app_data.web_atn_method wam
         where
               wam.wam_s2i = true
            or wam.wam_s2s = true
             ;

        insert
          into
               app_data.web_atn_saml2_method
             (
                 aum_id
             ,   asm_s2c_dflt
             )
        select
               wam.aum_id
             , true
          from
               app_data.web_atn_method wam
         where
               wam.wam_s2u = true
             ;

        commit;
end $$
