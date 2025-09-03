create or replace function web_core_auth_key_aur_mod.row_key_inf
(
        refcursor
,       p_tnt_id  app_data.tenant.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_aauk_id app_data.api_app_user_key.aauk_id%type
)
returns refcursor
as
$$
begin

        open
             $1
         for
             select
                    aauk.aauk_id
                  , aauk.aauk_nm
                  , aauk.aauk_enabled
                  , coalesce( c.num_roles , 0 ) num_roles
               from
                              app_data.api_app_user_key aauk
                         join app_data.app_user         aur  on aauk.aur_id = aur.aur_id
                    left join (
                                    select
                                           aaukdr.aauk_id
                                         , count(*)       num_roles
                                      from
                                           app_data.api_app_user_key_db_role aaukdr
                                     where
                                           aaukdr.aauk_id = p_aauk_id
                                       and exists (
                                                      select
                                                             null
                                                        from
                                                                  app_data.api_app_user_key iaauk
                                                             join app_data.app_user         iaur  on iaauk.aur_id = iaur.aur_id
                                                       where
                                                             iaur.tnt_id   = p_tnt_id
                                                         and iaur.aur_id   = p_aur_id
                                                         and iaauk.aauk_id = aaukdr.aauk_id
                                                  )
                                  group by
                                           aaukdr.aauk_id
                              ) c
                           on (
                                  aauk.aauk_id = c.aauk_id
                              )
              where
                    aur.tnt_id   = p_tnt_id
                and aur.aur_id   = p_aur_id
                and aauk.aauk_id = p_aauk_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
