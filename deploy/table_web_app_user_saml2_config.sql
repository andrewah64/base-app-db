create table if not exists app_data.web_app_user_saml2_config
(
        tnt_id       bigint                                        not null
,       aum_id       bigint                                        not null
,       cby          text                     default current_user not null
,       cts          timestamp with time zone default now()        not null
,       uby          text                     default current_user not null
,       uts          timestamp with time zone default now()        not null
,       constraint pk_s2c primary key (tnt_id)
);
