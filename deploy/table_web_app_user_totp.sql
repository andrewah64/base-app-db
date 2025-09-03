create table if not exists app_data.web_app_user_totp
(
        otp_id      text                                          not null
,       aur_id      bigint                                        not null
,       otp_secret  text                                          not null
,       otp_enabled boolean                  default false        not null
,       cby         name                     default current_user not null
,       cts         timestamp with time zone default now()        not null
,       uby         name                     default current_user not null
,       uts         timestamp with time zone default now()        not null
,       constraint pk_otp        primary key (otp_id)
,       constraint uk_otp        unique      (aur_id, cts)
,       constraint ck_otp_id     check       (length(trim(otp_id))     > 0)
,       constraint ck_otp_secret check       (length(trim(otp_secret)) > 0)
);
