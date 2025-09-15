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
                                                             end                                s2c_entity_id
               from
                         app_data.web_app_user_saml2_config s2c
                    join app_data.tenant                    tnt on s2c.tnt_id = tnt.tnt_id
              where
                    s2c.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
