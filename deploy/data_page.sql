do $$
begin
        insert into app_data.page (pg_nm)
        select 'Login'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Login');

        insert into app_data.page (pg_nm)
        select 'Login/MFA'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Login/MFA');

        insert into app_data.page (pg_nm)
        select 'Register user'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Register user');

        insert into app_data.page (pg_nm)
        select 'Register OTP'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Register OTP');

        insert into app_data.page (pg_nm)
        select 'Home page'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Home page');

        insert into app_data.page (pg_nm)
        select 'Search users'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Search users');

        insert into app_data.page (pg_nm)
        select 'Manage API keys'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage API keys');

        insert into app_data.page (pg_nm)
        select 'Manage API key roles'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage API key roles');

        insert into app_data.page (pg_nm)
        select 'Manage user''s logging levels'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage user''s logging levels');

        insert into app_data.page (pg_nm)
        select 'Manage user''s http sessions'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage user''s http sessions');

        insert into app_data.page (pg_nm)
        select 'Change user''s password'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Change user''s password');

        insert into app_data.page (pg_nm)
        select 'Manage user''s groups'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage user''s groups');

        insert into app_data.page (pg_nm)
        select 'Boost user''s privileges'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Boost user''s privileges');

        insert into app_data.page (pg_nm)
        select 'Manage groups'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage groups');

        insert into app_data.page (pg_nm)
        select 'Manage a group''s roles'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage a group''s roles');

        insert into app_data.page (pg_nm)
        select 'Manage a group''s users'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage a group''s users');

        insert into app_data.page (pg_nm)
        select 'Manage authentication configuration'
         where not exists (select null
                             from app_data.page pg
                            where pg.pg_nm     = 'Manage authentication configuration');

        commit;
end $$
