create or replace function web_core_auth_s2c_tnt_inf.s2c_inf
(
        refcursor
,       p_tnt_id  app_data.app_group.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    s2c.aum_id
                  , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                                 when '443' then ''
                                                                 when '80'  then ''
                                                                 else ':' || tnt.tnt_port::text
                                                             end || eppacs.epp_pt               epp_acs_pt
                  , tnt.tnt_prtc || '://' || tnt.tnt_fqdn || case tnt.tnt_port::text
                                                                 when '443' then ''
                                                                 when '80'  then ''
                                                                 else ':' || tnt.tnt_port::text
                                                             end || eppmtd.epp_pt               epp_mtd_pt
                  , s2c.uts
               from
                         app_data.tenant                    tnt
                    join app_data.web_app_user_saml2_config s2c   on tnt.tnt_id    = s2c.tnt_id
                    join (
                                  app_data.endpoint      epacs
                             join app_data.endpoint_path eppacs on epacs.epp_id = eppacs.epp_id
                         )
                      on s2c.ep_acs_id = epacs.ep_id
                    join (
                                  app_data.endpoint      epmtd
                             join app_data.endpoint_path eppmtd on epmtd.epp_id = eppmtd.epp_id
                         )
                      on s2c.ep_mtd_id = epmtd.ep_id
              where
                    s2c.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
