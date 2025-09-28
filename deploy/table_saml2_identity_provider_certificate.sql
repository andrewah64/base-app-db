create table if not exists app_data.saml2_identity_provider_certificate
(
        ipc_id      bigint                   generated always as identity not null
,       idp_id      bigint                                                not null
,       ipc_crt     bytea                                                 not null
,       ipc_crt_use text                                                  not null
,       ipc_inc_ts  timestamp with time zone                              not null
,       ipc_exp_ts  timestamp with time zone                              not null
,       cby         text                     default current_user         not null
,       cts         timestamp with time zone default now()                not null
,       uby         text                     default current_user         not null
,       uts         timestamp with time zone default now()                not null
,       constraint pk_ipc            primary key (ipc_id)
,       constraint uk_ipc            unique      (idp_id, ipc_crt_use, ipc_inc_ts)
,       constraint ck_ipc_inc_exp_ts check       (ipc_inc_ts <= ipc_exp_ts)
);
