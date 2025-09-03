create or replace function web_core_unauth_aur_tnt_reg.aukc_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    aukc.aukc_aur_nm_min_len
                  , aukc.aukc_aur_nm_max_len
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
