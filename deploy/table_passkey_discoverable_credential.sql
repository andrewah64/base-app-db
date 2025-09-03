create table if not exists app_data.passkey_discoverable_credential
(
        pdc_id        bigint                   generated always as identity not null
,       pdc_nm        text                                                  not null
,       pdc_aukc_dflt boolean                  default false                not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_pdc    primary key (pdc_id)
,       constraint uk_pdc_nm unique      (pdc_nm)
);
