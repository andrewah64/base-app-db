create or replace procedure web_core_auth_log_aur_tnt_mod.row_mod_log
(
        p_tnt_id   app_data.tenant.tnt_id%type
,       p_auell_id app_data.app_user_endpoint_log_level.auell_id%type
,       p_lvl_id   app_data.log_level.lvl_id%type
,       p_by       app_data.app_user.aur_nm%type
,       p_uts      app_data.app_user_endpoint_log_level.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.app_user_endpoint_log_level auell
           set
               lvl_id = p_lvl_id
             , uby    = p_by
             , uts    = now()
         where
               auell.auell_id = p_auell_id
           and auell.uts      = p_uts
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.aur_id = auell.aur_id
                             and aur.tnt_id = p_tnt_id
                      );

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.app_user_endpoint_log_level auell
                               where
                                     auell.auell_id  = p_auell_id
                                 and auell.lvl_id   != p_lvl_id
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_log_aur_tnt_mod.row_mod_log' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_log_aur_tnt_mod.row_mod_log' using errcode = 'OLOKD';
                end if;
        end if;

end;
$$
language plpgsql
security definer;
