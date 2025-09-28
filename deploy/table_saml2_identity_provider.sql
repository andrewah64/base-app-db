create table if not exists app_data.saml2_identity_provider
(
        idp_id        bigint                   generated always as identity not null
,       tnt_id        bigint                                                not null
,       idp_entity_id text                                                  not null
,       idp_enabled   boolean                  default true                 not null
,       cby           text                     default current_user         not null
,       cts           timestamp with time zone default now()                not null
,       uby           text                     default current_user         not null
,       uts           timestamp with time zone default now()                not null
,       constraint pk_idp           primary key (idp_id)
,       constraint uk_idp           unique      (tnt_id, idp_entity_id)
,       constraint ck_idp_entity_id check       (length(trim(idp_entity_id)) > 0 and idp_entity_id = trim(idp_entity_id))
);
