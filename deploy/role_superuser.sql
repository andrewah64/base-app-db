do $$
declare
        uname name := 'superuser';
        i     record;
begin
        for i in select
                        t.tnt_id
                      , l.lng_id
                      , grp.grp_id
                   from
                                   app_data.tenant    t
                        cross join app_data.language  l
                              join app_data.app_group grp on t.tnt_id = grp.tnt_id
                  where
                        grp.grp_nm = 'Admin' 
                    and l.lng_cd   = 'en-us'
                    and not exists (
                                       select
                                              null
                                         from
                                              app_data.app_user aur
                                        where
                                              aur.tnt_id = t.tnt_id
                                          and aur.aur_nm = uname
                                   )
        loop
                call web_core_auth_aur_tnt_reg.reg_aur(i.tnt_id, i.grp_id, uname, '$2a$10$wE2aVRUCinnDOqEOMApSHuEFh6yEG0FKRb1x5z.MkDlF.Uw9XtFQ6', i.lng_id, current_user);
        end loop;
        commit;
end $$
