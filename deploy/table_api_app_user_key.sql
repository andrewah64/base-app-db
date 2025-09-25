create table app_data.api_app_user_key
(
        aauk_id      bigint                   generated always as identity not null
,       aur_id       bigint                                                not null
,       aauk_nm      text                                                  not null
,       aauk_key     bytea                                                 not null
,       aauk_enabled boolean                  default false                not null
,       cby          text                     default current_user         not null
,       cts          timestamp with time zone default now()                not null
,       uby          text                     default current_user         not null
,       uts          timestamp with time zone default now()                not null
,       constraint pk_aauk     primary key (aauk_id)
,       constraint uk_aauk_key unique      (aauk_key)
,       constraint uk_aauk_nm  unique      (aur_id, aauk_nm)
,       constraint ck_aauk_nm  check       (length(trim(aauk_nm)) > 0 and aauk_nm = trim(aauk_nm))
);
