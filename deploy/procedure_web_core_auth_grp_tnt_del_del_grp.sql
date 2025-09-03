create or replace procedure web_core_auth_grp_tnt_del.del_grp
(
        p_tnt_id app_data.app_user.tnt_id%type
,       p_grp_id bigint[]
)
as
$$
begin

        delete
          from
               app_data.app_group_user agu
         where
               agu.grp_id = any(p_grp_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_group grp
                           where
                                 grp.tnt_id      = p_tnt_id
                             and grp.grp_id      = agu.grp_id
                             and grp.grp_can_del = true
                      );


        delete
          from
               app_data.app_group_db_role grpdr
         where
               grpdr.grp_id = any(p_grp_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_group grp
                           where
                                 grp.tnt_id      = p_tnt_id
                             and grp.grp_id      = grpdr.grp_id
                             and grp.grp_can_del = true
                      );

        delete
          from
               app_data.app_group grp
         where
               grp.tnt_id      = p_tnt_id
           and grp.grp_id      = any(p_grp_id)
           and grp.grp_can_del = true
             ;

end;
$$
language plpgsql
security definer;
