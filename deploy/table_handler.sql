create table if not exists app_data.handler
(
        hdlr_id bigint                   generated always as identity   not null
,       hdlr_nm text                                                    not null
,       cby     text                     default current_user           not null
,       cts     timestamp with time zone default now()                  not null
,       uby     text                     default current_user           not null
,       uts     timestamp with time zone default now()                  not null
,       constraint pk_hdlr primary key (hdlr_id)
,       constraint uk_hdlr unique      (hdlr_nm)
);
