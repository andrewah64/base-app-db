create or replace function web_core_auth_grp_aur_tnt_mod.grp_inf
(
        refcursor
,       p_tnt_id     app_data.app_user.tnt_id%type
,       p_cur_aur_id app_data.app_user.aur_id%type
,       p_tgt_aur_id app_data.app_user.aur_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
               select
                      grp_id
                    , grp_nm
                    , tgt_aur_has
                    , cur_aur_edt
                 from (
                             select
                                    grp.grp_id
                                  , grp.grp_nm
                                  , true       tgt_aur_has
                                  , true       cur_aur_edt
                               from
                                    app_data.app_group grp
                              where
                                    grp.tnt_id = p_tnt_id
                                and     exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_user agu
                                                    where
                                                          agu.grp_id = grp.grp_id
                                                      and agu.aur_id = p_tgt_aur_id
                                               )
                                and not exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_db_role grpdr
                                                    where
                                                          grpdr.grp_id = grp.grp_id
                                                      and not exists (
                                                                         select
                                                                                null
                                                                           from
                                                                                     app_data.app_group_user    agu
                                                                                join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id
                                                                          where
                                                                                agu.aur_id     = p_cur_aur_id
                                                                            and igrpdr.dbrl_id = grpdr.dbrl_id
                                                                     )
                                               )
                          union all
                             select
                                    grp.grp_id
                                  , grp.grp_nm
                                  , true       tgt_aur_has
                                  , false      cur_aur_edt
                               from
                                    app_data.app_group grp
                              where
                                    grp.tnt_id = p_tnt_id
                                and     exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_user agu
                                                    where
                                                          agu.grp_id = grp.grp_id
                                                      and agu.aur_id = p_tgt_aur_id
                                               )
                                and     exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_db_role grpdr
                                                    where
                                                          grpdr.grp_id = grp.grp_id
                                                      and not exists (
                                                                         select
                                                                                null
                                                                           from
                                                                                     app_data.app_group_user    agu
                                                                                join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id
                                                                          where
                                                                                agu.aur_id     = p_cur_aur_id
                                                                            and igrpdr.dbrl_id = grpdr.dbrl_id
                                                                     )
                                               )
                          union all
                             select
                                    grp.grp_id
                                  , grp.grp_nm
                                  , false      tgt_aur_has
                                  , true       cur_aur_edt
                               from
                                    app_data.app_group grp
                              where
                                    grp.tnt_id = p_tnt_id
                                and not exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_user agu
                                                    where
                                                          agu.grp_id = grp.grp_id
                                                      and agu.aur_id = p_tgt_aur_id
                                               )
                                and not exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_db_role grpdr
                                                    where
                                                          grpdr.grp_id = grp.grp_id
                                                      and not exists (
                                                                         select
                                                                                null
                                                                           from
                                                                                     app_data.app_group_user    agu
                                                                                join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id
                                                                          where
                                                                                agu.aur_id     = p_cur_aur_id
                                                                            and igrpdr.dbrl_id = grpdr.dbrl_id
                                                                     )
                                               )
                          union all
                             select
                                    grp.grp_id
                                  , grp.grp_nm
                                  , false      tgt_aur_has
                                  , false      cur_aur_edt
                               from
                                    app_data.app_group grp
                              where
                                    grp.tnt_id = p_tnt_id
                                and not exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_user agu
                                                    where
                                                          agu.grp_id = grp.grp_id
                                                      and agu.aur_id = p_tgt_aur_id
                                               )
                                and     exists (
                                                   select
                                                          null
                                                     from
                                                          app_data.app_group_db_role grpdr
                                                    where
                                                          grpdr.grp_id = grp.grp_id
                                                      and not exists (
                                                                         select
                                                                                null
                                                                           from
                                                                                     app_data.app_group_user    agu
                                                                                join app_data.app_group_db_role igrpdr on agu.grp_id = igrpdr.grp_id
                                                                          where
                                                                                agu.aur_id     = p_cur_aur_id
                                                                            and igrpdr.dbrl_id = grpdr.dbrl_id
                                                                     )
                                               )
                      )
             order by
                      grp_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
