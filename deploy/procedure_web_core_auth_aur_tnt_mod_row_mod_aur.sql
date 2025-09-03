create or replace procedure web_core_auth_aur_tnt_mod.row_mod_aur
(
        p_tnt_id      app_data.tenant.tnt_id%type
,       p_aur_id      app_data.app_user.aur_id%type
,       p_aur_nm      app_data.app_user.aur_nm%type
,       p_aur_enabled app_data.web_app_user.aur_enabled%type
,       p_lng_id      app_data.app_user.lng_id%type
,       p_pg_id       app_data.web_app_user_home_page.pg_id%type
,       p_by          app_data.app_user.aur_nm%type
,       p_uts         app_data.app_user.uts%type
)
as
$$
declare

        v_cnt int := 0;

begin

        update
               app_data.app_user aur
           set
               aur_nm = p_aur_nm
             , lng_id = p_lng_id
             , uby    = p_by
             , uts    = now()
         where
               aur.tnt_id = p_tnt_id
           and aur.aur_id = p_aur_id
           and aur.uts    = p_uts
             ;

        get diagnostics v_cnt = row_count;

        if v_cnt = 0 then
                if exists (
                              select
                                     null
                                from
                                     app_data.app_user aur
                               where
                                     aur.tnt_id = p_tnt_id
                                 and aur.aur_id = p_aur_id
                                 and (
                                            aur.aur_nm != p_aur_nm
                                         or aur.lng_id != p_lng_id
                                         or exists (
                                                       select
                                                              null
                                                         from
                                                              app_data.web_app_user_home_page wauhp
                                                        where
                                                              wauhp.aur_id  = aur.aur_id
                                                          and wauhp.pg_id  != p_pg_id
                                                   )
                                     )
                          )
                then
                        raise exception 'Optimistic locking error : web_core_auth_aur_tnt_mod.row_mod_aur' using errcode = 'OLOKU';
                else
                        raise exception 'Optimistic locking error : web_core_auth_aur_tnt_mod.row_mod_aur' using errcode = 'OLOKD';
                end if;
        end if;

        update
               app_data.web_app_user waur
           set
               aur_enabled = p_aur_enabled
             , uby         = p_by
             , uts         = now()
         where
               waur.aur_id       = p_aur_id
           and waur.aur_enabled != p_aur_enabled
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.tnt_id = p_tnt_id
                             and aur.aur_id = waur.aur_id
                      );

         merge
          into
               app_data.web_app_user_home_page tgt
         using (
                   select
                          hpg.pg_id
                        , p_aur_id  aur_id
                     from
                          app_data.home_page hpg
                    where
                          hpg.pg_id = p_pg_id
               ) src
            on (
                   tgt.aur_id = src.aur_id
               )
          when
               not matched by target and src.pg_id is not null
          then
               insert (aur_id, pg_id, cby, uby) values (src.aur_id, src.pg_id, p_by, p_by)
          when
               matched and src.pg_id is not null
          then
               update
                  set
                      pg_id = src.pg_id
                    , uby   = p_by
                    , uts   = now()
          when
               matched and src.pg_id is null
          then
               delete
             ;
end;
$$
language plpgsql
security definer;
