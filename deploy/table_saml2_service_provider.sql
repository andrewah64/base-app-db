create table if not exists app_data.saml2_service_provider
(
        tnt_id       bigint                                        not null
,       sp_entity_id text                                          not null
,       sp_enc_crt   text                                          not null
,       sp_sgn_crt   text                                          not null
,       cby          text                     default current_user not null
,       cts          timestamp with time zone default now()        not null
,       uby          text                     default current_user not null
,       uts          timestamp with time zone default now()        not null
,       constraint pk_sp         primary key (tnt_id)
,       constraint ck_sp_enc_crt check       (length(trim(sp_enc_crt)) > 0)
,       constraint ck_sp_sgn_crt check       (length(trim(sp_sgn_crt)) > 0)
);
