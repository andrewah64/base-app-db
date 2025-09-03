do $$
begin
        insert
          into
               app_data.passkey_public_key_algorithm
             (
                 pkg_nm
             ,   pkg_cd
             )
        values
             (
                 'Ed25519'
             ,   -8
             );

        insert
          into
               app_data.passkey_public_key_algorithm
             (
                 pkg_nm
             ,   pkg_cd
             )
        values
             (
                 'ES256'
             ,   -7
             );

        insert
          into
               app_data.passkey_public_key_algorithm
             (
                 pkg_nm
             ,   pkg_cd
             )
        values
             (
                 'RS256'
             ,   -257
             );
end $$
