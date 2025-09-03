do $$
begin
        insert
          into
               app_data.passkey_authenticator_transport
             (
                 pat_nm
             )
        values
             (
                 'usb'
             );

        insert
          into
               app_data.passkey_authenticator_transport
             (
                 pat_nm
             )
        values
             (
                 'nfc'
             );

        insert
          into
               app_data.passkey_authenticator_transport
             (
                 pat_nm
             )
        values
             (
                 'ble'
             );

        insert
          into
               app_data.passkey_authenticator_transport
             (
                 pat_nm
             )
        values
             (
                 'smart-card'
             );

        insert
          into
               app_data.passkey_authenticator_transport
             (
                 pat_nm
             )
        values
             (
                 'hybrid'
             );

        insert
          into
               app_data.passkey_authenticator_transport
             (
                 pat_nm
             )
        values
             (
                 'internal'
             );

end $$
