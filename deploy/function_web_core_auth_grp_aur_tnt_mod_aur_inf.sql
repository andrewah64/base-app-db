create or replace function web_core_auth_grp_aur_tnt_mod.aur_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
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
                    aur.aur_id
                  , aur.aur_nm
               from
                    app_data.app_user aur
              where
                    aur.tnt_id = p_tnt_id
                and aur.aur_id = p_aur_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
