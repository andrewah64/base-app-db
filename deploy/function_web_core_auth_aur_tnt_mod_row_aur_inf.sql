create or replace function web_core_auth_aur_tnt_mod.row_aur_inf
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
                    aur.aur_id         userid
                  , aur.aur_nm         username
                  , aur.rolname        userrole
                  , waur.aur_enabled   userenabled
                  , lng.lng_nm         userlanguage
                  , pg.pg_nm           userhomepage
               from
                         app_data.app_user               aur
                    join app_data.web_app_user           waur  on aur.aur_id  = waur.aur_id
                    join app_data.web_app_user_home_page wauhp on waur.aur_id = wauhp.aur_id
                    join app_data.language               lng   on aur.lng_id  = lng.lng_id
                    join app_data.page                   pg    on wauhp.pg_id = pg.pg_id
              where
                    aur.tnt_id = p_tnt_id
                and aur.aur_id = p_aur_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
