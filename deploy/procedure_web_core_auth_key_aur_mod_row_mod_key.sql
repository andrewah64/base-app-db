create or replace procedure web_core_auth_key_aur_mod.row_mod_key
(
        p_tnt_id       app_data.app_user.tnt_id%type
,       p_aur_id       app_data.app_user.aur_id%type
,       p_aauk_id      app_data.api_app_user_key.aauk_id%type
,       p_aauk_nm      app_data.api_app_user_key.aauk_nm%type
,       p_aauk_enabled app_data.api_app_user_key.aauk_enabled%type
,       p_by           app_data.app_user.aur_nm%type
,       p_uts          app_data.app_user.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.api_app_user_key aauk
           set
               aauk_nm      = p_aauk_nm
             , aauk_enabled = p_aauk_enabled
             , uby          = p_by
             , uts          = now()
         where
               aauk.aur_id  = p_aur_id
           and aauk.aauk_id = p_aauk_id
           and aauk.uts     = p_uts
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.aur_id = aauk.aur_id
                             and aur.tnt_id = p_tnt_id
                      );

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.api_app_user_key aauk
                               where
                                     aauk.aur_id  = p_aur_id
                                 and aauk.aauk_id = p_aauk_id
                                 and (
                                            aauk.aauk_nm      != p_aauk_nm
                                         or aauk.aauk_enabled != p_aauk_enabled
                                     )
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_key_aur_mod.row_mod_key' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_key_aur_mod.row_mod_key' using errcode = 'OLOKD';
                end if;
        end if;

end;
$$
language plpgsql
security definer;
