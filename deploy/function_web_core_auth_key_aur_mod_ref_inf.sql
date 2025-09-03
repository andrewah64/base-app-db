create or replace function web_core_auth_key_aur_mod.ref_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
,       p_aur_id app_data.app_user.aur_id%type
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
                                    'dbrl'       key
                                  , dbrl.dbrl_id id
                                  , dbrl.dbrl_nm value
                               from
                                         app_data.db_role     dbrl
                                    join app_data.api_db_role adbrl on dbrl.dbrl_id = adbrl.dbrl_id
                              where
                                    exists (
                                               select
                                                      null
                                                 from
                                                           app_data.app_user                 aur
                                                      join app_data.api_app_user_key         aauk   on aur.aur_id   = aauk.aur_id
                                                      join app_data.api_app_user_key_db_role aaukdr on aauk.aauk_id = aaukdr.aauk_id
                                                where
                                                      aaukdr.dbrl_id = adbrl.dbrl_id
                                                  and aur.tnt_id     = p_tnt_id
                                                  and aur.aur_id     = p_aur_id
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
