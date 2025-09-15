create or replace function web_core_auth_aupc_tnt_inf.ref_inf
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
                         key
                       , id
                       , value
                    from (
                                 select
                                        'pka'      key
                                      , pka.pka_id id
                                      , pka.pka_nm value
                                   from
                                        app_data.passkey_attestation pka
                              union all
                                 select
                                        'pkt'      key
                                      , pkt.pkt_id id
                                      , pkt.pkt_nm value
                                   from
                                        app_data.passkey_attachment pkt
                              union all
                                 select
                                        'pdc'      key
                                      , pdc.pdc_id id
                                      , pdc.pdc_nm value
                                   from
                                        app_data.passkey_discoverable_credential pdc
                              union all
                                 select
                                        'puv'      key
                                      , puv.puv_id id
                                      , puv.puv_nm value
                                   from
                                        app_data.passkey_user_verification puv
                         )
                order by
                         key   asc
                       , value asc
                       ;

        return $1;
end;
$$
language plpgsql
security definer;
