do $$
declare
        i record;
begin
        delete from app_data.web_app_user_passkey_registration_session;

        for i in select
                        tnt_id
                      , aur_id
                   from
                        app_data.app_user
        loop
                call web_core_auth_aur_tnt_del.del_aur(i.tnt_id, ARRAY[i.aur_id]);
        end loop;
        commit;
end $$
