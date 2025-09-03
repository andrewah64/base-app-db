create or replace procedure web_core_auth_log_ep_tnt_mod.row_mod_log
(
        p_tnt_id app_data.tenant.tnt_id%type
,       p_ell_id app_data.endpoint_log_level.ell_id%type
,       p_lvl_id app_data.log_level.lvl_id%type
,       p_by     app_data.app_user.aur_nm%type
,       p_uts    app_data.endpoint_log_level.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.endpoint_log_level ell
           set
               lvl_id = p_lvl_id
             , uby    = p_by
             , uts    = now()
         where
               ell.ell_id = p_ell_id
           and ell.uts    = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.endpoint_log_level ell
                               where
                                     ell.ell_id  = p_ell_id
                                 and ell.lvl_id != p_lvl_id
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_log_ep_tnt_mod.row_mod_log' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_log_ep_tnt_mod.row_mod_log' using errcode = 'OLOKD';
                end if;
        end if;

end;
$$
language plpgsql
security definer;
