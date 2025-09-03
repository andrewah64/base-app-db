do $$
begin
        insert into app_data.api (api_nm)
        select 'Health check'
         where not exists (select null 
                             from app_data.api a
                            where a.api_nm = 'Health check');

        insert into app_data.api (api_nm)
        select 'Register new users'
         where not exists (select null 
                             from app_data.api a
                            where a.api_nm = 'Register new users');
end $$
