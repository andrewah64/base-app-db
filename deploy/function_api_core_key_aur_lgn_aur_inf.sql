create or replace function api_core_key_aur_lgn.aur_inf
(
        refcursor
,       p_tnt_id   app_data.tenant.tnt_id%type
,       p_aauk_key app_data.api_app_user_key.aauk_key%type
,       p_epp_pt   app_data.endpoint_path.epp_pt%type
,       p_hrm_nm   app_data.http_request_method.hrm_nm%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aur.rolname
                  , lvl.lvl_nb
               from
                         app_data.app_user                    aur
                    join app_data.app_user_endpoint_log_level auell on aur.aur_id   = auell.aur_id
                    join app_data.endpoint                    ep    on auell.ep_id  = ep.ep_id
                    join app_data.endpoint_path               epp   on ep.epp_id    = epp.epp_id
                    join app_data.endpoint_db_role            edr   on ep.ep_id     = edr.ep_id
                    join app_data.http_request_method         hrm   on ep.hrm_id    = hrm.hrm_id
                    join app_data.db_role                     dbrl  on edr.dbrl_id  = dbrl.dbrl_id
                    join app_data.api_db_role                 adbrl on dbrl.dbrl_id = adbrl.dbrl_id
                    join app_data.log_level                   lvl   on auell.lvl_id = lvl.lvl_id
                    join app_data.api_app_user                aaur  on aur.aur_id   = aaur.aur_id
                    join app_data.api_app_user_key            aauk  on aaur.aur_id  = aauk.aur_id
              where
                    aur.tnt_id        = p_tnt_id
                and aaur.aur_enabled  = true
                and epp.epp_pt        = p_epp_pt
                and hrm.hrm_nm        = p_hrm_nm
                and aauk.aauk_enabled = true
                and aauk.aauk_key     = p_aauk_key
                and exists (
                               select
                                      null
                                 from
                                           pg_catalog.pg_auth_members pam
                                      join pg_catalog.pg_authid       pau   on pam.member  = pau.oid
                                      join pg_catalog.pg_authid       rol   on pam.roleid  = rol.oid
                                      join app_data.db_role           dbrol on rol.rolname = dbrol.dbrl_nm
                                where
                                      pau.rolname   = aur.rolname
                                  and dbrol.dbrl_id = dbrl.dbrl_id
                           )
                and exists (
                               select
                                      null
                                 from
                                      app_data.api_app_user_key_db_role aaukdr
                                where
                                      aaukdr.aauk_id = aauk.aauk_id
                                  and aaukdr.dbrl_id = dbrl.dbrl_id
                           )
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
