create or replace function web_core_auth_rol_grp_tnt_inf.rol_inf
(
        refcursor
,       p_tnt_id app_data.app_group.tnt_id%type
,       p_aur_id app_data.app_user.aur_id%type
,       p_grp_id app_data.app_group.grp_id%type
)
returns refcursor
as
$$
begin

        open
             $1
         for
               select
                      dbrl_id
                    , dbrl_ds
                    , grp_has
                 from           (
                                    select
                                           dbrl.dbrl_id
                                         , dbrl.dbrl_ds
                                         , true         grp_has
                                      from
                                                app_data.db_role     dbrl
                                           join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
                                     where
                                           dbrl.dbrl_md = false
                                       and     exists (
                                                          select
                                                                 null
                                                            from
                                                                      app_data.app_group         grp
                                                                 join app_data.app_group_db_role grpdr on grp.grp_id = grpdr.grp_id
                                                           where
                                                                 grp.tnt_id    = p_tnt_id
                                                             and grp.grp_id    = p_grp_id
                                                             and grpdr.dbrl_id = dbrl.dbrl_id
                                                      )
                                       and     exists (
                                                          select
                                                                 null
                                                            from
                                                                      app_data.app_user          aur
                                                                 join app_data.app_group_user    agu   on aur.aur_id = agu.aur_id
                                                                 join app_data.app_group_db_role grpdr on agu.grp_id = grpdr.grp_id
                                                           where
                                                                 aur.tnt_id    = p_tnt_id
                                                             and aur.aur_id    = p_aur_id
                                                             and grpdr.dbrl_id = dbrl.dbrl_id
                                                      )
                                )
                      union all
                                (
                                    select
                                           dbrl.dbrl_id
                                         , dbrl.dbrl_ds
                                         , false        grp_has
                                      from
                                                app_data.db_role     dbrl
                                           join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
                                     where
                                           dbrl.dbrl_md = false
                                       and not exists (
                                                          select
                                                                 null
                                                            from
                                                                      app_data.app_group         grp
                                                                 join app_data.app_group_db_role grpdr on grp.grp_id = grpdr.grp_id
                                                           where
                                                                 grp.tnt_id    = p_tnt_id
                                                             and grp.grp_id    = p_grp_id
                                                             and grpdr.dbrl_id = dbrl.dbrl_id
                                                      )
                                       and     exists (
                                                          select
                                                                 null
                                                            from
                                                                      app_data.app_user          aur
                                                                 join app_data.app_group_user    agu   on aur.aur_id = agu.aur_id
                                                                 join app_data.app_group_db_role grpdr on agu.grp_id = grpdr.grp_id
                                                           where
                                                                 aur.tnt_id    = p_tnt_id
                                                             and aur.aur_id    = p_aur_id
                                                             and grpdr.dbrl_id = dbrl.dbrl_id
                                                      )
                                )
             order by
                      dbrl_ds asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
