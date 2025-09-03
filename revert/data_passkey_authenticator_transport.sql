do $$
begin
        delete from app_data.web_app_user_passkey_authenticator_transport;
        delete from app_data.passkey_authenticator_transport;
        commit;
end $$
