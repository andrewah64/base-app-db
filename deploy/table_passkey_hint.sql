create table if not exists app_data.passkey_hint
(
        pkh_id bigint                   generated always as identity not null
,       pkh_nm text                                                  not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_pkh    primary key (pkh_id)
,       constraint uk_pkh_nm unique      (pkh_nm)
,       constraint ck_pkh_nm check       (length(trim(pkh_nm)) > 0)
);
