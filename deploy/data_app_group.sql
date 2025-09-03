do $$
begin
        insert into app_data.app_group (tnt_id, grp_nm, grp_can_edt, grp_can_del, grp_aur_dflt)
        select
               tnt_id
             , 'Admin'
             , false
             , false
             , true
          from
               app_data.tenant tnt
             ;

        commit;
end $$
