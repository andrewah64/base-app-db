create table if not exists app_data.web_atn_saml2_method
(
        aum_id bigint                                        not null
,       cby    text                     default current_user not null
,       cts    timestamp with time zone default now()        not null
,       uby    text                     default current_user not null
,       uts    timestamp with time zone default now()        not null
,       constraint pk_asm primary key (aum_id)
);
