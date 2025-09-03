create table if not exists app_data.api
(
        api_id bigint                   generated always as identity not null
,       api_nm text                                                  not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_api    primary key (api_id)
,       constraint uk_api_nm unique      (api_nm)
);
