create or replace function web_core_auth_atn_tnt_inf.aukc_inf
(
        refcursor
,       p_tnt_id app_data.tenant.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aukc.tnt_id
                  , aukc.aukc_aur_nm_min_len
                  , aukc.aukc_aur_nm_max_len
                  , aukc.aukc_enabled
                  , aukc.pka_id
                  , aukc.pkt_id
                  , aukc.pdc_id
                  , aukc.puv_reg_id
                  , aukc.puv_atn_id
                  , aukc.uts
               from
                    app_data.web_app_user_passkey_config aukc
              where
                    aukc.tnt_id = p_tnt_id
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
