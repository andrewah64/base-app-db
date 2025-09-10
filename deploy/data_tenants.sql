do $$
begin

        call api_core_auth_tnt_all_reg.reg_tnt
        (
                p_tnt_nm    => 'tenant-1'
        ,       p_tnt_prtc  => 'https'
        ,       p_tnt_fqdn  => 'tenant1.localhost'
        ,       p_tnt_port  => 8081
        );

        call api_core_auth_tnt_all_reg.reg_tnt
        (
                p_tnt_nm    => 'tenant-2'
        ,       p_tnt_prtc  => 'https'
        ,       p_tnt_fqdn  => 'tenant2.localhost'
        ,       p_tnt_port  => 8081
        );

        call api_core_auth_tnt_all_reg.reg_tnt
        (
                p_tnt_nm    => 'tenant-3'
        ,       p_tnt_prtc  => 'https'
        ,       p_tnt_fqdn  => 'localhost'
        ,       p_tnt_port  => 8081
        );

end $$
