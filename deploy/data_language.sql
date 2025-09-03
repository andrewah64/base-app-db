do $$
begin
        insert into app_data.language (lng_cd,lng_nm)
        select 'pt'
             , 'Portuguese'
         where not exists (select null
                             from app_data.language l
                            where l.lng_cd = 'pt');

        insert into app_data.language (lng_cd,lng_nm,lng_aur_dflt)
        select 'en-us'
             , 'English (US)'
             , true
         where not exists (select null
                             from app_data.language l
                            where l.lng_cd = 'en-us');

        commit;
end $$
