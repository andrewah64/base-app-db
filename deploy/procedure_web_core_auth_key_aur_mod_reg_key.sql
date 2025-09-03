create or replace procedure web_core_auth_key_aur_mod.reg_key
(
        p_tnt_id       app_data.app_user.tnt_id%type
,       p_aur_id       app_data.api_app_user_key.aur_id%type
,       p_aauk_key     app_data.api_app_user_key.aauk_key%type
,       p_aauk_enabled app_data.api_app_user_key.aauk_enabled%type
,       p_aauk_nm      app_data.api_app_user_key.aauk_nm%type
,       p_by           app_data.app_user.aur_nm%type
)
as
$$
begin

           insert
             into
                  app_data.api_app_user_key
                  (
                      aur_id
                  ,   aauk_key
                  ,   aauk_enabled
                  ,   aauk_nm
                  ,   cby
                  ,   uby
                  )
           select
                  aur.aur_id
                , p_aauk_key
                , p_aauk_enabled
                , p_aauk_nm
                , p_by
                , p_by
             from
                  app_data.app_user aur
            where
                  aur.tnt_id = p_tnt_id
              and aur.aur_id = p_aur_id
                ;

end;
$$
language plpgsql
security definer;
