create table if not exists app_data.api_endpoint
(
        api_id bigint not null
,       ep_id  bigint not null
,       constraint pk_apie primary key (api_id, ep_id)
);
