create database otusfinalproj;
create user testuser with encrypted password '123456';
grant all privileges on database otusfinalproj to testuser;
\connect otusfinalproj;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to testuser;

create table banner (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descr text
);

create table slot (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descr text
);

create table slot_banner (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    slot_id int,
    banner_id int,
    add_date TIMESTAMP default CURRENT_TIMESTAMP
);

CREATE  UNIQUE  INDEX  ON slot_banner (slot_id, banner_id);


create table soc_group (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    descr text
);

create table banner_stat (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    slot_id int,
    banner_id int,
    soc_group_id int,
    stat_type text,  --"S"  показ; 'C'-переход
    rec_date TIMESTAMP default CURRENT_TIMESTAMP
);

CREATE INDEX ON banner_stat (slot_id, soc_group_id);

create table send_stat_max_id ( -- для опеределения отправленных данных
    banner_stat_id int
);
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to testuser;


insert into banner (descr) values ('banner 1') ;
insert into banner (descr) values ('banner 2') ;
insert into banner (descr) values ('banner 3') ;
insert into banner (descr) values ('banner 4') ;
insert into banner (descr) values ('banner 5') ;
insert into banner (descr) values ('banner 6') ;
insert into banner (descr) values ('banner 7') ;
insert into banner (descr) values ('banner 8') ;
insert into banner (descr) values ('banner 9') ;
insert into banner (descr) values ('banner 10') ;
insert into banner (descr) values ('banner 11') ;
insert into banner (descr) values ('banner 12') ;
insert into banner (descr) values ('banner 13') ;
insert into banner (descr) values ('banner 14') ;
insert into banner (descr) values ('banner 15') ;
insert into banner (descr) values ('banner 16') ;
insert into banner (descr) values ('banner 17') ;
insert into banner (descr) values ('banner 18') ;
insert into banner (descr) values ('banner 19') ;
insert into banner (descr) values ('banner 20') ;

insert into slot (descr) values ('slot 1') ;
insert into slot (descr) values ('slot 2') ;
insert into slot (descr) values ('slot 3') ;
insert into slot (descr) values ('slot 4') ;
insert into slot (descr) values ('slot 5') ;
insert into slot (descr) values ('slot 6') ;
insert into slot (descr) values ('slot 7') ;
insert into slot (descr) values ('slot 8') ;
insert into slot (descr) values ('slot 9') ;
insert into slot (descr) values ('slot 10') ;

insert into soc_group (descr) values ('Мальчики');
insert into soc_group (descr) values ('Мужчины до 30') ;
insert into soc_group (descr) values ('Мужчины до 30-45') ;
insert into soc_group (descr) values ('Мужчины до 46-60') ;
insert into soc_group (descr) values ('Мужчины старше 60') ;
insert into soc_group (descr) values ('Девочки');
insert into soc_group (descr) values ('Женщины до 30') ;
insert into soc_group (descr) values ('Женщины до 30-45') ;
insert into soc_group (descr) values ('Женщины до 46-60') ;
insert into soc_group (descr) values ('Женщины старше 60') ;

insert into send_stat_max_id values (0);