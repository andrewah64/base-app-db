create or replace function web_core_auth_aur_grp_tnt_inf.aur_inf
(
        refcursor
,       p_tnt_id app_data.app_group.tnt_id%type
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
                      aur_id
                    , aur_nm
                    , aur_has
                 from           (
                                    select
                                           aur.aur_id
                                         , aur.aur_nm
                                         , true       aur_has
                                      from
                                           app_data.app_user aur
                                     where
                                           aur.tnt_id = p_tnt_id
                                       and     exists (
                                                          select
                                                                 null
                                                            from
                                                                 app_data.app_group_user agu
                                                           where
                                                                 agu.aur_id = aur.aur_id
                                                             and agu.grp_id = p_grp_id
                                                      )
                                )
                      union all
                                (
                                    select
                                           aur.aur_id
                                         , aur.aur_nm
                                         , false      aur_has
                                      from
                                           app_data.app_user aur
                                     where
                                           aur.tnt_id = p_tnt_id
                                       and not exists (
                                                          select
                                                                 null
                                                            from
                                                                 app_data.app_group_user agu
                                                           where
                                                                 agu.aur_id = aur.aur_id
                                                             and agu.grp_id = p_grp_id
                                                      )
                                )
             order by
                      aur_nm asc
                    ;

        return $1;
end;
$$
language plpgsql
security definer;
