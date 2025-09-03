create or replace function web_core_unauth_aur_tnt_reg.ea_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_ea  app_data.app_user_email_address.aur_ea%type
)
returns refcursor
as
$$
begin
        open
             $1
         for
             select
                    coalesce
                    (
                        (
                            select
                                   false
                              from
                                        app_data.app_user               aur
                                   join app_data.app_user_email_address auea on aur.aur_id = auea.aur_id
                             where
                                   aur.tnt_id  = p_tnt_id
                               and auea.aur_ea = p_aur_ea
                        )
                    ,   true
                    ) aupc_aur_ea_avb_pass
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
