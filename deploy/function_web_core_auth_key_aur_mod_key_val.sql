create or replace function web_core_auth_key_aur_mod.key_val
(
        refcursor
,       p_tnt_id  app_data.app_group.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_aauk_nm app_data.app_group.grp_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select coalesce
                    (
                        (
                            select
                                   false
                              from
                                        app_data.app_user         aur
                                   join app_data.api_app_user_key aauk on aur.aur_id = aauk.aur_id
                             where
                                   aur.tnt_id   = p_tnt_id
                               and aur.aur_id   = p_aur_id
                               and aauk.aauk_nm = p_aauk_nm
                        )
                    ,   true
                    )
                    aauk_nm_ok
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
