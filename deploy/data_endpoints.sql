do $$
declare
        r record;
begin

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_ssn_aur_reg'
        ,       p_dbrl_ds   => 'Start a HTTP session'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.ssn.aur.Get'
        ,       p_epp_pt    => '/{$}'
        ,       p_ep_ds     => 'Screen: login'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Login'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_ssn_aur_reg'
        ,       p_dbrl_ds   => 'Start a HTTP session'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.ssn.aur.Post'
        ,       p_epp_pt    => '/web/core/unauth/ssn/aur/{aum...}'
        ,       p_ep_ds     => 'Action: validate username, password'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Login'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_otp_ssn_aur_mod'
        ,       p_dbrl_ds   => 'Start a HTTP session using 2FA'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.otp.ssn.aur.Get'
        ,       p_epp_pt    => '/web/core/unauth/otp/ssn/aur/{id}'
        ,       p_ep_ds     => 'Screen: 2FA TOTP entry'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Login/MFA'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_otp_ssn_aur_mod'
        ,       p_dbrl_ds   => 'Start a HTTP session using 2FA'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.otp.ssn.aur.Post'
        ,       p_epp_pt    => '/web/core/unauth/otp/ssn/aur/{id}'
        ,       p_ep_ds     => 'Action: validate 2FA TOTP code'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Login/MFA'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_saml2_mde_inf'
        ,       p_dbrl_ds   => 'View SAML2 metadata'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.saml2.mde.Get'
        ,       p_epp_pt    => '/web/core/unauth/saml2/metadata.xml'
        ,       p_ep_ds     => 'Screen: SAML2 metadata'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'SAML2 metadata'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_saml2_acs_inf'
        ,       p_dbrl_ds   => 'SAML2 ACS'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.saml2.acs.Post'
        ,       p_epp_pt    => '/web/core/unauth/saml2/acs'
        ,       p_ep_ds     => 'Action: manage IDP requests'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'SAML2 metadata'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_oidc_call_inf'
        ,       p_dbrl_ds   => 'Get OIDC provider information'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.oidc.Call'
        ,       p_epp_pt    => '/web/core/unauth/oidc/{nm}'
        ,       p_ep_ds     => 'Action: initiate OIDC flow'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Login'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_oidc_callback_mod'
        ,       p_dbrl_ds   => 'Handle OIDC callback'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.oidc.Callback'
        ,       p_epp_pt    => '/web/core/unauth/oidc/callback/{nm}'
        ,       p_ep_ds     => 'Action: handle OIDC callback'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Login'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_aur_tnt_reg'
        ,       p_dbrl_ds   => 'Register user'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/unauth/aur/tnt'
        ,       p_ep_ds     => 'Screen: register user'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Register user'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_aur_tnt_reg'
        ,       p_dbrl_ds   => 'Register user'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.aur.tnt.Post'
        ,       p_epp_pt    => '/web/core/unauth/aur/tnt/{aum...}'
        ,       p_ep_ds     => 'Action: register user'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Register user'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_aur_tnt_reg'
        ,       p_dbrl_ds   => 'Register user'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.aur.tnt.val.Get'
        ,       p_epp_pt    => '/web/core/unauth/aur/tnt/val/{id}'
        ,       p_ep_ds     => 'Action: validate username, password, email address'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Register user'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_otp_aur_inf'
        ,       p_dbrl_ds   => 'Register 2FA OTP'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.otp.aur.Get'
        ,       p_epp_pt    => '/web/core/unauth/otp/aur/{id}'
        ,       p_ep_ds     => 'Screen: register 2FA OTP'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Register OTP'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_unauth_otp_aur_mod'
        ,       p_dbrl_ds   => 'Finalise 2FA registration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.unauth.otp.aur.Post'
        ,       p_epp_pt    => '/web/core/unauth/otp/aur/{id}'
        ,       p_ep_ds     => 'Action: finalise 2FA registration'
        ,       p_mwc_nm    => 'web/unauth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Register OTP'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_ssn_aur_end'
        ,       p_dbrl_ds   => 'End HTTP session'
        ,       p_dbrl_md   => true
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.home.Index'
        ,       p_epp_pt    => '/web/core/auth/home'
        ,       p_ep_ds     => 'Screen: home'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Home page'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_inf'
        ,       p_dbrl_ds   => 'Manage users'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt'
        ,       p_ep_ds     => 'Screen: manage users'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_del'
        ,       p_dbrl_ds   => 'Delete users'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.Delete'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt'
        ,       p_ep_ds     => 'Action: delete users'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'DELETE'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_reg'
        ,       p_dbrl_ds   => 'Register users'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt'
        ,       p_ep_ds     => 'Screen: register user'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_reg'
        ,       p_dbrl_ds   => 'Register users'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.Post'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt'
        ,       p_ep_ds     => 'Action: register user'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_reg'
        ,       p_dbrl_ds   => 'Register users'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.val.Get'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt/val'
        ,       p_ep_ds     => 'Action: validate new user''s information'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Modify user''s details'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.id.Get'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt/{id}'
        ,       p_ep_ds     => 'Screen: refresh user''s details'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Modify user''s details'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.tnt.id.Patch'
        ,       p_epp_pt    => '/web/core/auth/aur/tnt/{id}'
        ,       p_ep_ds     => 'Action: modify user''s details'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Search users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_pwd_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Modify user''s password'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.pwd.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/pwd/aur/tnt/{id}'
        ,       p_ep_ds     => 'Screen: modify user''s password'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Change user''s password'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_pwd_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Modify user''s password'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.pwd.aur.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/pwd/aur/tnt/{id}'
        ,       p_ep_ds     => 'Action: modify user''s password'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Change user''s password'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_pwd_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Modify user''s password'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.pwd.aur.tnt.val.Get'
        ,       p_epp_pt    => '/web/core/auth/pwd/aur/tnt/val'
        ,       p_ep_ds     => 'Action: validate user''s password'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Change user''s password'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_aur_tnt_inf'
        ,       p_dbrl_ds   => 'View user logging levels'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/log/aur/tnt'
        ,       p_ep_ds     => 'Screen: view user logging levels'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage user''s logging levels'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Bulk update user''s logging levels'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.aur.tnt.Put'
        ,       p_epp_pt    => '/web/core/auth/log/aur/tnt'
        ,       p_ep_ds     => 'Action: bulk update logging levels'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PUT'
        ,       p_pg_nm     => 'Manage user''s logging levels'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Refresh user log level'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.aur.tnt.id.Get'
        ,       p_epp_pt    => '/web/core/auth/log/aur/tnt/{id}'
        ,       p_ep_ds     => 'Screen: refresh user log level'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage user''s logging levels'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Modify user log level'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.aur.tnt.id.Patch'
        ,       p_epp_pt    => '/web/core/auth/log/aur/tnt/{id}'
        ,       p_ep_ds     => 'Action: modify user log level'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage user''s logging levels'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_ep_tnt_inf'
        ,       p_dbrl_ds   => 'View endpoint logging levels'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.ep.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/log/ep/tnt'
        ,       p_ep_ds     => 'Screen: view endpoint logging levels'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage endpoint''s logging levels'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_ep_tnt_mod'
        ,       p_dbrl_ds   => 'Bulk update endpoint''s logging levels'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.ep.tnt.Put'
        ,       p_epp_pt    => '/web/core/auth/log/ep/tnt'
        ,       p_ep_ds     => 'Action: bulk update endpoint''s logging levels'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PUT'
        ,       p_pg_nm     => 'Manage endpoint''s logging levels'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_ep_tnt_mod'
        ,       p_dbrl_ds   => 'Refresh endpoint log level'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.ep.tnt.id.Get'
        ,       p_epp_pt    => '/web/core/auth/log/ep/tnt/{id}'
        ,       p_ep_ds     => 'Screen: refresh endpoint log level'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage endpoint''s logging levels'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_log_ep_tnt_mod'
        ,       p_dbrl_ds   => 'Modify endpoint log level'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.log.ep.tnt.id.Patch'
        ,       p_epp_pt    => '/web/core/auth/log/ep/tnt/{id}'
        ,       p_ep_ds     => 'Action: modify endpoint log level'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage endpoint''s logging levels'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aukc_tnt_inf'
        ,       p_dbrl_ds   => 'View username/password configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aukc.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/aukc/tnt'
        ,       p_ep_ds     => 'Screen: username/password configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage username/password configuration'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aukc_tnt_mod'
        ,       p_dbrl_ds   => 'Manage username/password configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aukc.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/aukc/tnt'
        ,       p_ep_ds     => 'Screen: username/password configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage username/password configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aupc_tnt_inf'
        ,       p_dbrl_ds   => 'View passkey configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aupc.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/aupc/tnt'
        ,       p_ep_ds     => 'Screen: passkey configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage passkey configuration'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aupc_tnt_mod'
        ,       p_dbrl_ds   => 'Manage passkey configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aupc.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/aupc/tnt'
        ,       p_ep_ds     => 'Screen: passkey configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage passkey configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_occ_tnt_inf'
        ,       p_dbrl_ds   => 'View OIDC configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.occ.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/occ/tnt'
        ,       p_ep_ds     => 'Screen: OIDC configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage OIDC configuration'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_occ_tnt_mod'
        ,       p_dbrl_ds   => 'Manage OIDC configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.occ.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/occ/tnt/{id}'
        ,       p_ep_ds     => 'Screen: OIDC configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage OIDC configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_inf'
        ,       p_dbrl_ds   => 'View SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt'
        ,       p_ep_ds     => 'Screen: SAML2 configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_mod'
        ,       p_dbrl_ds   => 'Manage SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.Delete'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt/{nm}'
        ,       p_ep_ds     => 'Screen: SAML2 configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'DELETE'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_mod'
        ,       p_dbrl_ds   => 'Manage SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt/{nm}'
        ,       p_ep_ds     => 'Screen: SAML2 configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_mod'
        ,       p_dbrl_ds   => 'Manage SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.Post'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt/{nm}'
        ,       p_ep_ds     => 'Screen: SAML2 configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_mod'
        ,       p_dbrl_ds   => 'Manage SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.val.Get'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt/val/{nm}'
        ,       p_ep_ds     => 'Screen: SAML2 configuration management'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_mod'
        ,       p_dbrl_ds   => 'Manage SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.id.Get'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt/id/{nm}/{id}'
        ,       p_ep_ds     => 'Action: refresh SAML2-related record'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_s2c_tnt_mod'
        ,       p_dbrl_ds   => 'Manage SAML2 configuration'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.s2c.tnt.id.Patch'
        ,       p_epp_pt    => '/web/core/auth/s2c/tnt/id/{nm}/{id}'
        ,       p_ep_ds     => 'Action: modify SAML2-related record'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage SAML2 configuration'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_grp_tnt_inf'
        ,       p_dbrl_ds   => 'View a group''s users'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.grp.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/aur/grp/tnt/{id}'
        ,       p_ep_ds     => 'Screen: manage a group''s users'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage a group''s users'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_aur_grp_tnt_mod'
        ,       p_dbrl_ds   => 'Assign a user to a group'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.aur.grp.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/aur/grp/tnt/{id}'
        ,       p_ep_ds     => 'Action: assign a user to a group'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage a group''s users'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_tnt_inf'
        ,       p_dbrl_ds   => 'View groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/grp/tnt'
        ,       p_ep_ds     => 'Screen: manage groups'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage groups'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_tnt_reg'
        ,       p_dbrl_ds   => 'Register groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.tnt.Post'
        ,       p_epp_pt    => '/web/core/auth/grp/tnt'
        ,       p_ep_ds     => 'Action: register group'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Manage groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_tnt_del'
        ,       p_dbrl_ds   => 'Delete groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.tnt.Delete'
        ,       p_epp_pt    => '/web/core/auth/grp/tnt'
        ,       p_ep_ds     => 'Action: delete groups'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'DELETE'
        ,       p_pg_nm     => 'Manage groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_aur_tnt_mod'
        ,       p_dbrl_ds   => 'View a user''s groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/grp/aur/tnt/{id}'
        ,       p_ep_ds     => 'Screen: view a user''s groups'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage user''s groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_aur_tnt_mod'
        ,       p_dbrl_ds   => 'View a user''s groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.aur.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/grp/aur/tnt/{id}'
        ,       p_ep_ds     => 'Action: assign a group to a user'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage user''s groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_tnt_reg'
        ,       p_dbrl_ds   => 'Register groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.tnt.val.Get'
        ,       p_epp_pt    => '/web/core/auth/grp/tnt/val'
        ,       p_ep_ds     => 'Action: validate group names'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_tnt_mod'
        ,       p_dbrl_ds   => 'Modify groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.tnt.id.Get'
        ,       p_epp_pt    => '/web/core/auth/grp/tnt/{id}'
        ,       p_ep_ds     => 'Action: refresh group information'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_grp_tnt_mod'
        ,       p_dbrl_ds   => 'Modify groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.grp.tnt.id.Patch'
        ,       p_epp_pt    => '/web/core/auth/grp/tnt/{id}'
        ,       p_ep_ds     => 'Action: modify a group'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage groups'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.key.aur.Get'
        ,       p_epp_pt    => '/web/core/auth/key/aur'
        ,       p_ep_ds     => 'Screen: view user''s API keys'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage API keys'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.key.aur.Post'
        ,       p_epp_pt    => '/web/core/auth/key/aur'
        ,       p_ep_ds     => 'Action: register an API key for a user'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => 'Manage API keys'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.key.aur.Delete'
        ,       p_epp_pt    => '/web/core/auth/key/aur'
        ,       p_ep_ds     => 'Action: delete user''s API key'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'DELETE'
        ,       p_pg_nm     => 'Manage API keys'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.key.aur.val.Get'
        ,       p_epp_pt    => '/web/core/auth/key/aur/val'
        ,       p_ep_ds     => 'Action: validate user''s API key name'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage API keys'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.key.aur.id.Get'
        ,       p_epp_pt    => '/web/core/auth/key/aur/{id}'
        ,       p_ep_ds     => 'Screen: refresh key''s details'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage API keys'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.key.aur.id.Patch'
        ,       p_epp_pt    => '/web/core/auth/key/aur/{id}'
        ,       p_ep_ds     => 'Action: modify a user''s API key'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage API keys'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.rol.key.aur.Get'
        ,       p_epp_pt    => '/web/core/auth/rol/key/aur/{id}'
        ,       p_ep_ds     => 'Screen: view an API key''s roles'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage API key roles'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_key_aur_mod'
        ,       p_dbrl_ds   => 'Manage user''s API keys'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.rol.key.aur.Patch'
        ,       p_epp_pt    => '/web/core/auth/rol/key/aur/{id}'
        ,       p_ep_ds     => 'Action: view an API key''s roles'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage API key roles'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_rol_grp_tnt_inf'
        ,       p_dbrl_ds   => 'View group''s roles'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.rol.grp.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/rol/grp/tnt/{id}'
        ,       p_ep_ds     => 'Screen: view a group''s roles'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage a group''s roles'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_rol_grp_tnt_mod'
        ,       p_dbrl_ds   => 'Assign roles to groups'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.rol.grp.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/rol/grp/tnt/{id}'
        ,       p_ep_ds     => 'Action: assign roles to groups'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Manage a group''s roles'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_rol_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Boost user''s roles'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.rol.aur.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/rol/aur/tnt/{id}'
        ,       p_ep_ds     => 'Screen: boost user''s roles'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Boost user''s privileges'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_rol_aur_tnt_mod'
        ,       p_dbrl_ds   => 'Boost user''s roles'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.rol.aur.tnt.Patch'
        ,       p_epp_pt    => '/web/core/auth/rol/aur/tnt/{id}'
        ,       p_ep_ds     => 'Action: boost user''s roles'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'PATCH'
        ,       p_pg_nm     => 'Boost user''s privileges'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_ssn_tnt_inf'
        ,       p_dbrl_ds   => 'View active HTTP sessions'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.ssn.tnt.Get'
        ,       p_epp_pt    => '/web/core/auth/ssn/tnt'
        ,       p_ep_ds     => 'Screen: view active HTTP sessions'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => 'Manage user''s http sessions'
        ,       pe_is_entry => true
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_web_core_auth_ssn_tnt_del'
        ,       p_dbrl_ds   => 'End active HTTP sessions'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'web'
        ,       p_hdlr_nm   => 'web.core.auth.ssn.tnt.Delete'
        ,       p_epp_pt    => '/web/core/auth/ssn/tnt'
        ,       p_ep_ds     => 'Action: end active HTTP sessions'
        ,       p_mwc_nm    => 'web/auth'
        ,       p_hrm_nm    => 'DELETE'
        ,       p_pg_nm     => 'Manage user''s http sessions'
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => null
        ,       p_dbrl_ds   => null
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'api'
        ,       p_hdlr_nm   => 'api.core.unauth.health.Check'
        ,       p_epp_pt    => '/api/v1/healthcheck'
        ,       p_ep_ds     => 'Action: health check'
        ,       p_mwc_nm    => 'api/unauth'
        ,       p_hrm_nm    => 'GET'
        ,       p_pg_nm     => null
        ,       pe_is_entry => false
        );

        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => 'role_api_core_aur_tnt_reg'
        ,       p_dbrl_ds   => 'API: register user'
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => 'api'
        ,       p_hdlr_nm   => 'api.core.auth.aur.tnt.reg.Register'
        ,       p_epp_pt    => '/api/v1/users'
        ,       p_ep_ds     => 'Action: register user'
        ,       p_mwc_nm    => 'api/auth'
        ,       p_hrm_nm    => 'POST'
        ,       p_pg_nm     => null
        ,       pe_is_entry => false
        );

        /*
        call all_core_unauth_ep_all_reg.reg_ep
        (
                p_dbrl_nm   => ''
        ,       p_dbrl_ds   => ''
        ,       p_dbrl_md   => false
        ,       p_dbrl_type => ''
        ,       p_hdlr_nm   => ''
        ,       p_epp_pt    => ''
        ,       p_ep_ds     => ''
        ,       p_mwc_nm    => ''
        ,       p_hrm_nm    => ''
        ,       p_pg_nm     => ''
        ,       pe_is_entry => false
        );
        */

        for r in select
                        pg.pg_nm
                   from
                        app_data.page pg
                  where
                        exists (
                                   select
                                          null
                                     from
                                               app_data.page_endpoint       pe
                                          join app_data.endpoint            ep  on pe.ep_id  = ep.ep_id
                                          join app_data.http_request_method hrm on ep.hrm_id = hrm.hrm_id
                                          join app_data.middleware_chain    mwc on ep.mwc_id = mwc.mwc_id
                                    where
                                          pe.pe_is_entry = true
                                      and hrm.hrm_nm     = 'GET'
                                      and mwc.mwc_nm     = 'web/auth'
                                      and pe.pg_id       = pg.pg_id
                               )
        loop
                call all_core_unauth_ep_all_reg.reg_ep
                (
                        p_dbrl_nm   => 'role_web_core_auth_ssn_aur_end'
                ,       p_dbrl_ds   => 'Logout'
                ,       p_dbrl_md   => true
                ,       p_dbrl_type => 'web'
                ,       p_hdlr_nm   => 'web.core.auth.ssn.aur.Delete'
                ,       p_epp_pt    => '/web/core/auth/ssn/aur'
                ,       p_ep_ds     => 'Action: logout'
                ,       p_mwc_nm    => 'web/auth'
                ,       p_hrm_nm    => 'DELETE'
                ,       p_pg_nm     => r.pg_nm
                ,       pe_is_entry => false
                );
        end loop;
end $$
