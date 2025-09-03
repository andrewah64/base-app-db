create table if not exists app_data.http_request_method
(
        hrm_id    bigint                   generated always as identity not null
,       hrm_nm    text                                                  not null
,       cby       name                     default current_user         not null
,       cts       timestamp with time zone default now()                not null
,       uby       name                     default current_user         not null
,       uts       timestamp with time zone default now()                not null
,       constraint pk_hrm    primary key (hrm_id)
,       constraint uk_hrm_nm unique      (hrm_nm)
,       constraint ck_hrm_nm check       (hrm_nm = upper(hrm_nm))
);
