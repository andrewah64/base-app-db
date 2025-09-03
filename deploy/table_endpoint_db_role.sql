create table if not exists app_data.endpoint_db_role
(
        ep_id   bigint not null
,       dbrl_id bigint not null
,       constraint pk_edr primary key (ep_id, dbrl_id)
);
