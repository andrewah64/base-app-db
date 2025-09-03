create table if not exists app_data.endpoint_path
(
        epp_id bigint                   generated always as identity not null
,       epp_pt text                                                  not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_epp           primary key (epp_id)
,       constraint uk_epp_pt        unique      (epp_pt)
,       constraint ck_epp_pt        check       (epp_pt = lower(epp_pt))
,       constraint ck_epp_pt_format check       (epp_pt like '/%')
);
