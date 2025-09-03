create or replace function web_core_auth_aur_tnt_reg.aur_val
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_nm  app_data.app_user.aur_nm%type
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
                                   app_data.app_user aur
                             where
                                   aur.tnt_id = p_tnt_id
                               and aur.aur_nm = p_aur_nm
                        )
                    ,   true
                    )
                    aur_nm_ok
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
