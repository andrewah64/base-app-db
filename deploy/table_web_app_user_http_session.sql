create table if not exists app_data.web_app_user_http_session
(
        aur_id            bigint                                                          not null
,       wauhs_ssn_tk      text                                                            not null
,       wauhs_exp_ts      timestamp with time zone                                        not null
,       cby               name                            default current_user            not null
,       cts               timestamp with time zone        default now()                   not null
,       uby               name                            default current_user            not null
,       uts               timestamp with time zone        default now()                   not null
,       constraint pk_wauhs        primary key (aur_id, wauhs_exp_ts)
,       constraint uk_wauhs_ssn_tk unique      (wauhs_ssn_tk)
,       constraint ck_wauhs_exp_ts check       (wauhs_exp_ts > cts)
);
