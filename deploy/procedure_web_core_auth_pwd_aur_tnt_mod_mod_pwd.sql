create or replace procedure web_core_auth_pwd_aur_tnt_mod.mod_pwd
(
        p_tnt_id     app_data.app_user.tnt_id%type
,       p_aur_id     app_data.app_user.aur_id%type
,       p_aur_hsh_pw app_data.web_app_user_password.aur_hsh_pw%type
,       p_by         app_data.app_user.aur_nm%type
)
as
$$
begin

        merge
         into
              app_data.web_app_user_password tgt
        using (
                  select
                         aur.aur_id
                       , p_aur_hsh_pw aur_hsh_pw
                    from
                         app_data.app_user aur
                   where
                         aur.tnt_id = p_tnt_id
                     and aur.aur_id = p_aur_id
              ) src
           on (
                  tgt.aur_id = src.aur_id
              )
         when
              not matched
         then
              insert (aur_id, aur_hsh_pw, cby, uby) values (src.aur_id, src.aur_hsh_pw, p_by, p_by)
         when
              matched
         then
              update
                 set
                     aur_hsh_pw = src.aur_hsh_pw
                   , uby        = p_by
                   , uts        = now()
            ;

end;
$$
language plpgsql
security definer;
