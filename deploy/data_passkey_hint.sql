do $$
begin
        insert
          into
               app_data.passkey_hint
             (
                 pkh_nm
             )
        values
             (
                 'client-device'
             );

        insert
          into
               app_data.passkey_hint
             (
                 pkh_nm
             )
        values
             (
                 'hybrid'
             );

        insert
          into
               app_data.passkey_hint
             (
                 pkh_nm
             )
        values
             (
                 'security-key'
             );
end $$
