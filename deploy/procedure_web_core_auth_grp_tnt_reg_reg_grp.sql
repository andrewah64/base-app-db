create or replace procedure web_core_auth_grp_tnt_reg.reg_grp
(
        p_tnt_id app_data.tenant.tnt_id%type
,       p_grp_nm app_data.app_group.grp_nm%type
,       p_by     app_data.app_user.aur_nm%type
)
as
$$
declare
        v_grp_id app_data.app_group.grp_id%type;
begin

           insert
             into
                  app_data.app_group
                (
                     tnt_id
                ,    grp_nm
                ,    cby
                ,    uby
                )
           values
                (
                     p_tnt_id
                ,    p_grp_nm
                ,    p_by
                ,    p_by
                )
        returning
                  grp_id
             into
                  v_grp_id
                ;

        insert
          into
               app_data.app_group_db_role
             (
                  grp_id
             ,    dbrl_id
             ,    cby
             ,    uby
             )
        select
               v_grp_id
             , dbrl.dbrl_id
             , p_by
             , p_by
          from
                    app_data.db_role     dbrl
               join app_data.atn_db_role adr  on dbrl.dbrl_id = adr.dbrl_id
         where
               dbrl.dbrl_md = true
             ;

end;
$$
language plpgsql
security definer;
