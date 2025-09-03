create table if not exists app_data.middleware_chain
(
        mwc_id    bigint                   generated always as identity not null
,       mwc_nm    text                                                  not null
,       cby       name                     default current_user         not null
,       cts       timestamp with time zone default now()                not null
,       uby       name                     default current_user         not null
,       uts       timestamp with time zone default now()                not null
,       constraint pk_mwc    primary key (mwc_id)
,       constraint uk_mwc_nm unique      (mwc_nm)
,       constraint ck_mwc_nm check       (mwc_nm = lower(mwc_nm))
);
