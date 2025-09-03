create table if not exists app_data.api_app_user_atn_method
(
        aur_id bigint not null
,       aum_id bigint not null
,       constraint pk_aauam primary key (aur_id, aum_id)
);
