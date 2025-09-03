do $$
begin
        insert into app_data.home_page (pg_id, pg_aur_dflt)
        select pg_id, true from app_data.page where pg_nm = 'Home page';

        insert into app_data.home_page (pg_id)
        select pg_id from app_data.page where pg_nm = 'Search users';

        insert into app_data.home_page (pg_id)
        select pg_id from app_data.page where pg_nm = 'Manage API keys';

        insert into app_data.home_page (pg_id)
        select pg_id from app_data.page where pg_nm = 'Manage user''s logging levels';

        insert into app_data.home_page (pg_id)
        select pg_id from app_data.page where pg_nm = 'Manage user''s http sessions';

        insert into app_data.home_page (pg_id)
        select pg_id from app_data.page where pg_nm = 'Manage groups';

        insert into app_data.home_page (pg_id)
        select pg_id from app_data.page where pg_nm = 'Manage authentication configuration';

end $$
