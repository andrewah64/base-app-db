create table if not exists app_data.org
(
        tnt_id bigint                                                not null
,       org_id bigint                   generated always as identity not null
,       org_nm text                                                  not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_org    primary key (org_id)
,       constraint uk_org_nm unique      (tnt_id, org_nm)
,       constraint ck_org_nm check       (length(trim(org_nm)) > 0)
);
