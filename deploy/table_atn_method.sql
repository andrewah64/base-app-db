create table if not exists app_data.atn_method
(
        aum_id bigint                   generated always as identity not null
,       aum_nm text                                                  not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_aum    primary key (aum_id)
,       constraint uk_aum_nm unique      (aum_nm)
);
