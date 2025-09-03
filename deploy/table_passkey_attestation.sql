create table if not exists app_data.passkey_attestation
(
        pka_id        bigint                   generated always as identity not null
,       pka_nm        text                                                  not null
,       pka_aukc_dflt boolean                  default false                not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_pka    primary key (pka_id)
,       constraint uk_pka_nm unique      (pka_nm)
);
