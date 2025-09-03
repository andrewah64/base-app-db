create table if not exists app_data.app_user_db_role
(
        aur_id      bigint                                                not null
,       dbrl_id     bigint                                                not null
,       audr_exp_ts timestamp with time zone                              not null
,       cby         text                     default current_user         not null
,       cts         timestamp with time zone default now()                not null
,       uby         text                     default current_user         not null
,       uts         timestamp with time zone default now()                not null
,       constraint pk_audr        primary key (aur_id, dbrl_id, audr_exp_ts)
,       constraint ck_audr_exp_ts check       (audr_exp_ts > cts)
);
