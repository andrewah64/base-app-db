create table if not exists app_data.passkey_user_verification
(
        puv_id        bigint                   generated always as identity not null
,       puv_nm        text                                                  not null
,       puv_aukc_dflt boolean                  default false                not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_puv    primary key (puv_id)
,       constraint uk_puv_nm unique      (puv_nm)
);
