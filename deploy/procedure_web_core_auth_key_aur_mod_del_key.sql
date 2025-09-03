create or replace procedure web_core_auth_key_aur_mod.del_key
(
        p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_id  app_data.app_user.aur_id%type
,       p_aauk_id bigint[]
)
as
$$
begin

        delete
          from
               app_data.api_app_user_key_db_role aaukdr
         where
               aaukdr.aauk_id = any(p_aauk_id)
           and exists (
                          select
                                 null
                            from
                                      app_data.api_app_user_key aauk
                                 join app_data.app_user         aur  on aauk.aur_id = aur.aur_id
                           where
                                 aauk.aauk_id = aaukdr.aauk_id
                             and aur.tnt_id   = p_tnt_id
                             and aur.aur_id   = p_aur_id
                      );

        delete
          from
               app_data.api_app_user_key aauk
         where
               aauk.aauk_id = any(p_aauk_id)
           and exists (
                          select
                                 null
                            from
                                 app_data.app_user aur
                           where
                                 aur.aur_id = aauk.aur_id
                             and aur.tnt_id = p_tnt_id
                             and aur.aur_id = p_aur_id
                      );

end;
$$
language plpgsql
security definer;
