create table if not exists app_data.web_app_user_passkey_config_registration_hint
(
        tnt_id bigint                                                not null
,       pkh_id bigint                                                not null
,       prh_od int                                                   not null
,       cby    text                     default current_user         not null
,       cts    timestamp with time zone default now()                not null
,       uby    text                     default current_user         not null
,       uts    timestamp with time zone default now()                not null
,       constraint pk_prh primary key (tnt_id, pkh_id)
,       constraint uk_prh unique      (tnt_id, prh_od)
);
