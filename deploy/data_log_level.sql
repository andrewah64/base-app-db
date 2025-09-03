do $$
begin
        insert into app_data.log_level (lvl_nm, lvl_nb)
        select 'debug'
             , -4
         where not exists (select null
                             from app_data.log_level ll
                            where ll.lvl_nm    = 'debug');

        insert into app_data.log_level (lvl_nm, lvl_nb)
        select 'info'
             , 0
         where not exists (select null
                             from app_data.log_level ll
                            where ll.lvl_nm    = 'info');

        insert into app_data.log_level (lvl_nm, lvl_nb)
        select 'warn'
             , 4
         where not exists (select null
                             from app_data.log_level ll
                            where ll.lvl_nm    = 'warn');

        insert into app_data.log_level (lvl_nm, lvl_nb)
        select 'error'
             , 8
         where not exists (select null
                             from app_data.log_level ll
                            where ll.lvl_nm    = 'error');

        insert into app_data.log_level (lvl_nm, lvl_nb, lvl_aur_dflt, lvl_ep_dflt)
        select 'off'
             , 12
             , true
             , true
         where not exists (select null
                             from app_data.log_level ll
                            where ll.lvl_nm    = 'off');

        commit;
end $$
