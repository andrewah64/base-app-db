create or replace function web_core_auth_aur_grp_tnt_inf.grp_inf
(
        refcursor
,       p_tnt_id  app_data.app_group.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_grp_id  app_data.app_group.grp_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    grp.grp_id
                  , grp.grp_nm
                  ,     grp.grp_can_edt
                    and coalesce (
                                     (
                                         select
                                                true
                                           from
                                                app_data.app_group grp
                                          where
                                                grp.tnt_id = p_tnt_id
                                            and grp.grp_id = p_grp_id
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
                                                                                            agu.aur_id     = p_aur_id
                                                                                        and igrpdr.dbrl_id = grpdr.dbrl_id
                                                                                 )
                                                           )
                                     )
                                 ,   false
                                 )
                                 grp_can_edt
               from
                    app_data.app_group grp
              where
                    grp.tnt_id = p_tnt_id
                and grp.grp_id = p_grp_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
