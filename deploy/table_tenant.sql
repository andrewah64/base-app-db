create table if not exists app_data.tenant (
        tnt_id          bigint                          generated always as identity    not null
,       tnt_nm          text                                                            not null
,       tnt_prtc        text                                                            not null
,       tnt_fqdn        text                                                            not null
,       tnt_port        integer                                                         not null
,       cby             name                            default current_user            not null
,       cts             timestamp with time zone        default now()                   not null
,       uby             name                            default current_user            not null
,       uts             timestamp with time zone        default now()                   not null
,       constraint pk_tnt_id   primary key (tnt_id)
,       constraint uk_tnt_nm   unique      (tnt_nm)
,       constraint uk_tnt_fqdn unique      (tnt_fqdn)
,       constraint ck_tnt_prtc check       (tnt_prtc = lower(tnt_prtc))
,       constraint ck_tnt_fqdn check       (tnt_fqdn = lower(tnt_fqdn))
);
