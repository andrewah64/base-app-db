do $$
begin
        insert into app_data.app_group_db_role (grp_id, dbrl_id)
        select
               grp.grp_id
             , adr.dbrl_id
          from
                          app_data.app_group   grp
               cross join app_data.atn_db_role adr
         where
               grp.grp_nm = 'Admin'
           and not exists (
                              select
                                     null
                                from
                                     app_data.app_group_db_role grpdr
                               where
                                     grpdr.grp_id  = grp.grp_id
                                 and grpdr.dbrl_id = adr.dbrl_id
                          );

        commit;
end $$
