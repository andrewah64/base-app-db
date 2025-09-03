create table if not exists app_data.page_endpoint
(
    pg_id       bigint                              not null
,   ep_id       bigint                              not null
,   pe_is_entry boolean default false               not null
,   constraint pk_pe primary key (pg_id, ep_id)
);
