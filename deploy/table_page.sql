create table if not exists app_data.page
(
    pg_id           bigint                          generated always as identity    not null
,   pg_nm           text                                                            not null
,   cby             name                            default current_user            not null
,   cts             timestamp with time zone        default now()                   not null
,   uby             name                            default current_user            not null
,   uts             timestamp with time zone        default now()                   not null
,   constraint pk_pg    primary key (pg_id)
,   constraint uk_pg_nm unique      (pg_nm)
,   constraint ck_pg_nm check       (length(trim(pg_nm)) > 0)
);
