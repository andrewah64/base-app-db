create or replace function web_core_auth_grp_tnt_mod.row_grp_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
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
                  , grp.grp_can_del
                  , grp.grp_can_edt
                  , coalesce(c.num_roles, 0) num_roles
                  , coalesce(d.num_users, 0) num_users
               from
                              app_data.app_group grp
                    left join (
                                    select
                                           grpdr.grp_id
                                         , count(*)     num_roles
                                      from
                                           app_data.app_group_db_role grpdr
                                     where
                                           grpdr.grp_id = p_grp_id
                                  group by
                                           grpdr.grp_id
                              ) c
                           on (
                                  grp.grp_id = c.grp_id
                              )
                    left join (
                                    select
                                           agu.grp_id
                                         , count(*)     num_users
                                      from
                                           app_data.app_group_user agu
                                     where
                                           agu.grp_id = p_grp_id
                                  group by
                                           agu.grp_id
                              ) d
                           on (
                                  grp.grp_id = d.grp_id
                              )
              where
                    grp.tnt_id = p_tnt_id
                and grp.grp_id = p_grp_id
                  ;

        return $1;

end;
$$
language plpgsql
security definer;
