create table if not exists app_data.web_atn_method
(
        aum_id       bigint                                        not null
,       wam_pw       boolean                  default false        not null
,       wam_ocp      boolean                  default false        not null
,       wam_pky      boolean                  default false        not null
,       wam_s2i      boolean                  default false        not null
,       wam_s2s      boolean                  default false        not null
,       wam_s2u      boolean                  default false        not null
,       cby          text                     default current_user not null
,       cts          timestamp with time zone default now()        not null
,       uby          text                     default current_user not null
,       uts          timestamp with time zone default now()        not null
,       constraint pk_wam primary key (aum_id)
,       constraint ck_wam check       ((wam_pw::int + wam_ocp::int + wam_pky::int + wam_s2i::int + wam_s2s::int + wam_s2u::int) = 1)
);
