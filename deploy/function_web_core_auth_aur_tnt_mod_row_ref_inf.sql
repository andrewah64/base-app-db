create or replace function web_core_auth_aur_tnt_mod.row_ref_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
                  select
                         key
                       , id
                       , value
                    from (
                                select
                                       'lng'           key
                                     , lng.lng_id      id
                                     , lng.lng_nm      value
                                  from
                                       app_data.language lng
                             union all
                                select
                                       'pg'            key
                                     , pg.pg_id        id
                                     , pg.pg_nm        value
                                  from
                                            app_data.page      pg
                                       join app_data.home_page hpg on pg.pg_id = hpg.pg_id
                                 where
                                       exists (
                                                  select
                                                         null
                                                    from
                                                              app_data.page_endpoint    pe
                                                         join app_data.endpoint_db_role edr  on pe.ep_id    = edr.ep_id
                                                         join app_data.db_role          dbrl on edr.dbrl_id = dbrl.dbrl_id
                                                   where
                                                         pe.pg_id       = pg.pg_id
                                                     and pe.pe_is_entry = true
                                                     and exists (
                                                                    select
                                                                           null
                                                                      from
                                                                                pg_catalog.pg_auth_members pam
                                                                           join pg_catalog.pg_authid       pau  on pam.member  = pau.oid
                                                                           join pg_catalog.pg_authid       rol  on pam.roleid  = rol.oid
                                                                           join app_data.app_user          aur  on pau.rolname = aur.rolname
                                                                     where
                                                                           aur.tnt_id  = p_tnt_id
                                                                       and aur.aur_id  = p_aur_id
                                                                       and rol.rolname = dbrl.dbrl_nm
                                                                )
                                              )
                         )
                order by
                         key    asc
                       , value  asc
                       ;

        return $1;
end;
$$
language plpgsql
security definer;
