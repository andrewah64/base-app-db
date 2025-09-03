create table if not exists app_data.home_page
(
        pg_id       bigint                not null
,       pg_aur_dflt boolean default false not null
,       constraint pk_hpg primary key (pg_id)
);
