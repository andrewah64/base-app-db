create or replace procedure web_core_auth_key_aur_mod.mod_rol
(
        p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_aauk_id app_data.api_app_user_key.aauk_id%type
,       p_dbrl_id bigint[]
,       p_by      app_data.app_user.aur_nm%type
)
as
$$
begin

        merge
         into
              app_data.api_app_user_key_db_role tgt
        using (
                  select
                         p_aauk_id    aauk_id
                       , dbrl.dbrl_id
                    from
                              app_data.db_role     dbrl
                         join app_data.api_db_role adbrl on dbrl.dbrl_id = adbrl.dbrl_id
                   where
                         dbrl.dbrl_id = any (p_dbrl_id)
                     and exists (
                                    select
                                           null
                                      from
                                                pg_catalog.pg_auth_members pam
                                           join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                           join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                           join app_data.app_user          aur  on pau.rolname = aur.rolname
                                           join app_data.api_app_user_key  aauk on aur.aur_id  = aauk.aur_id
                                     where
                                           rol.rolname  = dbrl.dbrl_nm
                                       and aur.tnt_id   = p_tnt_id
                                       and aur.aur_id   = p_aur_id
                                       and aauk.aauk_id = p_aauk_id
                                )
              ) src
           on (
                      tgt.aauk_id = src.aauk_id
                  and tgt.dbrl_id = src.dbrl_id
              )
         when
              not matched by target
         then
              insert (aauk_id, dbrl_id, cby, uby) values (src.aauk_id, src.dbrl_id, p_by, p_by)
         when
              not matched by source and tgt.aauk_id = p_aauk_id
         then
              delete
            ;

end;
$$
language plpgsql
security definer;
