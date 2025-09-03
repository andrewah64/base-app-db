create table if not exists app_data.endpoint
(
    ep_id           bigint                          generated always as identity    not null
,   epp_id          bigint                                                          not null
,   ep_ds           text                                                            not null
,   mwc_id          bigint                                                          not null
,   hrm_id          bigint                                                          not null
,   hdlr_id         bigint                                                          not null
,   cby             name                            default current_user            not null
,   cts             timestamp with time zone        default now()                   not null
,   uby             name                            default current_user            not null
,   uts             timestamp with time zone        default now()                   not null
,   constraint pk_ep         primary key (ep_id)
,   constraint uk_ep         unique      (epp_id, hrm_id)
,   constraint uk_ep_hdlr_id unique      (hdlr_id)
);
