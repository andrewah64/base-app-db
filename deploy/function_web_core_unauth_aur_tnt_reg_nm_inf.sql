create or replace function web_core_unauth_aur_tnt_reg.nm_inf
(
        refcursor
,       p_tnt_id  app_data.app_user.tnt_id%type
,       p_aur_nm  app_data.app_user.aur_nm%type
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
                                   true
                              from
                                   app_data.web_app_user_password_config aupc
                             where
                                   aupc.tnt_id           = p_tnt_id
                               and char_length(p_aur_nm)
                                                         between
                                                                 aupc.aupc_aur_nm_min_len
                                                             and
                                                                 aupc.aupc_aur_nm_max_len
                        )
                    ,   false
                    ) aupc_aur_nm_len_pass
                  , coalesce
                    (
                        (
                            select
                                   false
                              from
                                   app_data.app_user aur
                             where
                                   aur.tnt_id = p_tnt_id
                               and aur.aur_nm = p_aur_nm
                        )
                    ,   true
                    ) aupc_aur_nm_avb_pass
                  ;

        return $1;
end;
$$
language plpgsql
security definer;
