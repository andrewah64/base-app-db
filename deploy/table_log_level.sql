create table if not exists app_data.log_level
(
    lvl_id       bigint                   generated always as identity not null
,   lvl_nm       text                                                  not null
,   lvl_nb       int                                                   not null
,   lvl_aur_dflt boolean                  default false                not null
,   lvl_ep_dflt  boolean                  default false                not null
,   cby          name                     default current_user         not null
,   cts          timestamp with time zone default now()                not null
,   uby          name                     default current_user         not null
,   uts          timestamp with time zone default now()                not null
,   constraint pk_lvl         primary key (lvl_id)
,   constraint uk_lvl_nm      unique      (lvl_nm)
,   constraint uk_lvl_nb      unique      (lvl_nb)
,   constraint ck_lvl_nm_case check       (lvl_nm = lower(lvl_nm))
);
