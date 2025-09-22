create or replace procedure web_core_auth_s2c_tnt_mod.del_spc
(
        p_tnt_id app_data.app_user.tnt_id%type
,       p_spc_id bigint[]
)
as
$$
begin

        delete
          from
               app_data.saml2_service_provider_certificate_pair spc
         where
               spc.tnt_id = p_tnt_id
           and spc.spc_id = any(p_spc_id)
             ;

end;
$$
language plpgsql
security definer;
