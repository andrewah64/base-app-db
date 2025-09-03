do $$
begin
        insert
          into
               app_data.passkey_user_verification
             (
                 puv_nm
             ,   puv_aukc_dflt
             )
        values
             (
                 'discouraged'
             ,   false
             );

        insert
          into
               app_data.passkey_user_verification
             (
                 puv_nm
             ,   puv_aukc_dflt
             )
        values
             (
                 'preferred'
             ,   true
             );

        insert
          into
               app_data.passkey_user_verification
             (
                 puv_nm
             ,   puv_aukc_dflt
             )
        values
             (
                 'required'
             ,   false
             );

end $$
