create table if not exists app_data.passkey_authenticator_transport
(
        pat_id bigint                   generated always as identity not null
,       pat_nm text                                                  not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_pat    primary key (pat_id)
,       constraint uk_pat_nm unique      (pat_nm)
,       constraint ck_pat_nm check       (length(trim(pat_nm)) > 0)
);
