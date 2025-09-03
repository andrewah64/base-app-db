do $$
begin
        insert into app_data.api_atn_method (aum_id)
        select aum_id
          from app_data.atn_method
         where aum_nm in ('Bearer token');

        insert into app_data.api_atn_method (aum_id, aum_aur_dflt)
        select aum_id, true
          from app_data.atn_method
         where aum_nm in ('API key');
end $$
