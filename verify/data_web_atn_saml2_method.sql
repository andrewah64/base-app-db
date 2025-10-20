do $$
begin
        assert((select count(*)
                  from app_data.web_atn_saml2_method) = (select count(*)
                                                           from app_data.web_atn_method wam
                                                          where wam.wam_s2i or wam.wam_s2s));
end $$
