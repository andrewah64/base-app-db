create table if not exists app_data.passkey_attachment
(
        pkt_id        bigint                   generated always as identity not null
,       pkt_nm        text                                                  not null
,       pkt_aukc_dflt boolean                  default false                not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_pkt    primary key (pkt_id)
,       constraint uk_pkt_nm unique      (pkt_nm)
);
