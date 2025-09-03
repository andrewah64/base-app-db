create table if not exists app_data.passkey_public_key_algorithm
(
        pkg_id bigint                   generated always as identity not null
,       pkg_nm text                                                  not null
,       pkg_cd integer                                               not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_pkg    primary key (pkg_id)
,       constraint uk_pkg_nm unique      (pkg_nm)
);
