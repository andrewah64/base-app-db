do $$
begin
        insert
          into
               app_data.passkey_discoverable_credential
             (
                 pdc_nm
             ,   pdc_aukc_dflt
             )
        values
             (
                 'discouraged'
             ,   false
             );

        insert
          into
               app_data.passkey_discoverable_credential
             (
                 pdc_nm
             ,   pdc_aukc_dflt
             )
        values
             (
                 'preferred'
             ,   true
             );

        insert
          into
               app_data.passkey_discoverable_credential
             (
                 pdc_nm
             ,   pdc_aukc_dflt
             )
        values
             (
                 'required'
             ,   false
             );

end $$
