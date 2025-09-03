create table if not exists app_data.db_role
(
        dbrl_id         bigint                          generated always as identity    not null
,       dbrl_nm         name                                                            not null
,       dbrl_ds         text                                                            not null
,       dbrl_md         boolean                         default false                   not null
,       cby             name                            default current_user            not null
,       cts             timestamp with time zone        default now()                   not null
,       uby             name                            default current_user            not null
,       uts             timestamp with time zone        default now()                   not null
,       constraint pk_dbrl_id      primary key (dbrl_id)
,       constraint uk_dbrl_nm      unique      (dbrl_nm)
,       constraint uk_dbrl_ds      unique      (dbrl_ds)
,       constraint ck_dbrl_nm_case check       (dbrl_nm = lower(dbrl_nm))
,       constraint ck_dbrl_nm      check       (dbrl_nm like 'role_%')
);
