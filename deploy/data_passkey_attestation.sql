do $$
begin
        insert
          into
               app_data.passkey_attestation
             (
                 pka_nm
             ,   pka_aukc_dflt
             )
        values
             (
                 'none'
             ,   true
             );

        insert
          into
               app_data.passkey_attestation
             (
                 pka_nm
             ,   pka_aukc_dflt
             )
        values
             (
                 'direct'
             ,   false
             );

end $$
