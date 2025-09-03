create table if not exists app_data.language
(
        lng_id        bigint                    generated always as identity    not null
,       lng_cd        text                                                      not null
,       lng_nm        text                                                      not null
,       lng_aur_dflt  boolean                   default false                   not null
,       cby           name                      default current_user            not null
,       cts           timestamp with time zone  default now()                   not null
,       uby           name                      default current_user            not null
,       uts           timestamp with time zone  default now()                   not null
,       constraint pk_lng_id      primary key (lng_id)
,       constraint uk_lng_cd      unique      (lng_cd)
,       constraint uk_lng_nm      unique      (lng_nm)
,       constraint ck_lng_cd      check       (lng_cd = lower(lng_cd))
);
