create or replace procedure web_core_auth_grp_tnt_mod.row_mod_grp
(
        p_tnt_id app_data.app_group.tnt_id%type
,       p_grp_id app_data.app_group.grp_id%type
,       p_grp_nm app_data.app_group.grp_nm%type
,       p_by     app_data.app_user.aur_nm%type
,       p_uts    app_data.app_group.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.app_group grp
           set
               grp_nm = p_grp_nm
             , uby    = p_by
             , uts    = now()
         where
               grp.tnt_id  = p_tnt_id
           and grp.grp_id  = p_grp_id
           and grp.uts     = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.app_group grp
                               where
                                     grp.tnt_id  = p_tnt_id
                                 and grp.grp_id  = p_grp_id
                                 and grp.grp_nm != p_grp_nm
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_grp_tnt_mod.row_mod_grp' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_grp_tnt_mod.row_mod_grp' using errcode = 'OLOKD';
                end if;
        end if;

end;
$$
language plpgsql
security definer;
