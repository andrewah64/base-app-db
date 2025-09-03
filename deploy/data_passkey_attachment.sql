do $$
begin
        insert
          into
               app_data.passkey_attachment
             (
                 pkt_nm
             ,   pkt_aukc_dflt
             )
        values
             (
                 'cross-platform'
             ,   false
             );

        insert
          into
               app_data.passkey_attachment
             (
                 pkt_nm
             ,   pkt_aukc_dflt
             )
        values
             (
                 'platform'
             ,   false
             );

        insert
          into
               app_data.passkey_attachment
             (
                 pkt_nm
             ,   pkt_aukc_dflt
             )
        values
             (
                 'all supported'
             ,   true
             );

end $$
