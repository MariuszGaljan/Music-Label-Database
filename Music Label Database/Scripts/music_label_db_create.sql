/*==============================================================*/
/* DBMS name:      SAP SQL Anywhere 16                          */
/* Created on:     20.05.2020 20:38:59                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_ALBUM_FK_BAND_A_BAND') then
    alter table Album
       delete foreign key FK_ALBUM_FK_BAND_A_BAND
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ALBUM_FK_PRODUC_PRODUCER') then
    alter table Album
       delete foreign key FK_ALBUM_FK_PRODUC_PRODUCER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_ALBUM_FK_STUDIO_STUDIO') then
    alter table Album
       delete foreign key FK_ALBUM_FK_STUDIO_STUDIO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONCERT_FK_TOUR_C_TOUR') then
    alter table Concert
       delete foreign key FK_CONCERT_FK_TOUR_C_TOUR
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_CONTRACT_FK_BAND_C_BAND') then
    alter table Contract
       delete foreign key FK_CONTRACT_FK_BAND_C_BAND
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_EQUIPMEN_FK_BAND_E_BAND') then
    alter table Equipment
       delete foreign key FK_EQUIPMEN_FK_BAND_E_BAND
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_MUSICIAN_FK_BAND_M_BAND') then
    alter table Musician
       delete foreign key FK_MUSICIAN_FK_BAND_M_BAND
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_STUDIO_FK_BAND_S_BAND') then
    alter table Studio
       delete foreign key FK_STUDIO_FK_BAND_S_BAND
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TOUR_FK_BAND_T_BAND') then
    alter table Tour
       delete foreign key FK_TOUR_FK_BAND_T_BAND
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRACK_FK_ALBUM__ALBUM') then
    alter table Track
       delete foreign key FK_TRACK_FK_ALBUM__ALBUM
end if;

drop index if exists Album.FK_Studio_Album_FK;

drop index if exists Album.FK_Producer_Album_FK;

drop index if exists Album.FK_Band_Album_FK;

drop index if exists Album.Album_PK;

drop table if exists Album;

drop index if exists Band.Band_PK;

drop table if exists Band;

drop index if exists Concert.FK_Tour_Concert_FK;

drop index if exists Concert.Concert_PK;

drop table if exists Concert;

drop index if exists Contract.FK_Band_Contract_FK;

drop index if exists Contract.Contract_PK;

drop table if exists Contract;

drop index if exists Equipment.FK_Band_Equipment_FK;

drop index if exists Equipment.Equipment_PK;

drop table if exists Equipment;

drop index if exists Musician.FK_Band_Musician_FK;

drop index if exists Musician.Musician_PK;

drop table if exists Musician;

drop index if exists Producer.Producer_PK;

drop table if exists Producer;

drop index if exists Studio.FK_Band_Studio_FK;

drop index if exists Studio.Studio_PK;

drop table if exists Studio;

drop index if exists Tour.FK_Band_Tour_FK;

drop index if exists Tour.Tour_PK;

drop table if exists Tour;

drop index if exists Track.FK_Album_Track_FK;

drop index if exists Track.Track_PK;

drop table if exists Track;

/*==============================================================*/
/* Table: Album                                                 */
/*==============================================================*/
create table Album 
(
   ID_BAND              integer                        not null,
   ID_ALBUM             integer                        not null,
   ID_STUDIO            integer                        not null,
   ID_PRODUCER          integer                        null,
   Album_name           varchar(40)                    not null,
   Number_of_tracks     integer                        not null,
   constraint PK_ALBUM primary key  (ID_BAND, ID_ALBUM)
);

comment on table Album is 
'The band releases an album.
The producer is working on the album.
The album consists of tracks.
The album is recorded in the studio.

';

/*==============================================================*/
/* Index: Album_PK                                              */
/*==============================================================*/
create unique  index Album_PK on Album (
ID_BAND ASC,
ID_ALBUM ASC
);

/*==============================================================*/
/* Index: FK_Band_Album_FK                                      */
/*==============================================================*/
create index FK_Band_Album_FK on Album (
ID_BAND ASC
);

/*==============================================================*/
/* Index: FK_Producer_Album_FK                                  */
/*==============================================================*/
create index FK_Producer_Album_FK on Album (
ID_PRODUCER ASC
);

/*==============================================================*/
/* Index: FK_Studio_Album_FK                                    */
/*==============================================================*/
create index FK_Studio_Album_FK on Album (
ID_STUDIO ASC
);

/*==============================================================*/
/* Table: Band                                                  */
/*==============================================================*/
create table Band 
(
   ID_BAND              integer                        not null,
   Band_name            varchar(30)                    not null,
   constraint PK_BAND primary key  (ID_BAND)
);

comment on table Band is 
'Entity describing the team.

The band has a contract signed.
The band releases an album.
The band plays a concert.
The band is asking for equipment.
';

/*==============================================================*/
/* Index: Band_PK                                               */
/*==============================================================*/
create unique  index Band_PK on Band (
ID_BAND ASC
);

/*==============================================================*/
/* Table: Concert                                               */
/*==============================================================*/
create table Concert 
(
   ID_CONCERT           integer                        not null,
   ID_TOUR              integer                        not null,
   Localization         varchar(20)                    null,
   "Date"               timestamp                      null,
   constraint PK_CONCERT primary key  (ID_CONCERT)
);

comment on table Concert is 
'Tour consists of concerts';

/*==============================================================*/
/* Index: Concert_PK                                            */
/*==============================================================*/
create unique  index Concert_PK on Concert (
ID_CONCERT ASC
);

/*==============================================================*/
/* Index: FK_Tour_Concert_FK                                    */
/*==============================================================*/
create index FK_Tour_Concert_FK on Concert (
ID_TOUR ASC
);

/*==============================================================*/
/* Table: Contract                                              */
/*==============================================================*/
create table Contract 
(
   ID_BAND              integer                        not null,
   ID_CONTRACT          integer                        not null,
   End_date             date                           not null,
   Start_date           date                           not null,
   constraint PK_CONTRACT primary key  (ID_BAND, ID_CONTRACT)
);

comment on table Contract is 
'A band has a signed contract.';

/*==============================================================*/
/* Index: Contract_PK                                           */
/*==============================================================*/
create unique  index Contract_PK on Contract (
ID_BAND ASC,
ID_CONTRACT ASC
);

/*==============================================================*/
/* Index: FK_Band_Contract_FK                                   */
/*==============================================================*/
create index FK_Band_Contract_FK on Contract (
ID_BAND ASC
);

/*==============================================================*/
/* Table: Equipment                                             */
/*==============================================================*/
create table Equipment 
(
   ID_EQUIPMENT         integer                        not null,
   ID_BAND              integer                        not null,
   Equipment_list       varchar(40)                    not null,
   Price                integer                        not null,
   constraint PK_EQUIPMENT primary key  (ID_EQUIPMENT)
);

comment on table Equipment is 
'A band requests equipment';

/*==============================================================*/
/* Index: Equipment_PK                                          */
/*==============================================================*/
create unique  index Equipment_PK on Equipment (
ID_EQUIPMENT ASC
);

/*==============================================================*/
/* Index: FK_Band_Equipment_FK                                  */
/*==============================================================*/
create index FK_Band_Equipment_FK on Equipment (
ID_BAND ASC
);

/*==============================================================*/
/* Table: Musician                                              */
/*==============================================================*/
create table Musician 
(
   ID_MUSICIAN          integer                        not null,
   ID_BAND              integer                        not null,
   Name                 varchar(30)                    not null,
   Salary               integer                        not null,
   constraint PK_MUSICIAN primary key  (ID_MUSICIAN)
);

comment on table Musician is 
'Entity describing a musician

Musician is a member of a band';

/*==============================================================*/
/* Index: Musician_PK                                           */
/*==============================================================*/
create unique  index Musician_PK on Musician (
ID_MUSICIAN ASC
);

/*==============================================================*/
/* Index: FK_Band_Musician_FK                                   */
/*==============================================================*/
create index FK_Band_Musician_FK on Musician (
ID_BAND ASC
);

/*==============================================================*/
/* Table: Producer                                              */
/*==============================================================*/
create table Producer 
(
   ID_PRODUCER          integer                        not null,
   Name                 varchar(30)                    null,
   constraint PK_PRODUCER primary key  (ID_PRODUCER)
);

comment on table Producer is 
'Producer works on an album';

/*==============================================================*/
/* Index: Producer_PK                                           */
/*==============================================================*/
create unique  index Producer_PK on Producer (
ID_PRODUCER ASC
);

/*==============================================================*/
/* Table: Studio                                                */
/*==============================================================*/
create table Studio 
(
   ID_STUDIO            integer                        not null,
   ID_BAND              integer                        null,
   Studio_name          varchar(30)                    not null,
   Price_per_hour       integer                        not null,
   constraint PK_STUDIO primary key  (ID_STUDIO)
);

comment on table Studio is 
'The album is recorded in the studio.
The team has a rented studio.
';

/*==============================================================*/
/* Index: Studio_PK                                             */
/*==============================================================*/
create unique  index Studio_PK on Studio (
ID_STUDIO ASC
);

/*==============================================================*/
/* Index: FK_Band_Studio_FK                                     */
/*==============================================================*/
create index FK_Band_Studio_FK on Studio (
ID_BAND ASC
);

/*==============================================================*/
/* Table: Tour                                                  */
/*==============================================================*/
create table Tour 
(
   ID_TOUR              integer                        not null,
   ID_BAND              integer                        null,
   constraint PK_TOUR primary key  (ID_TOUR)
);

comment on table Tour is 
'A band plays a tour
';

/*==============================================================*/
/* Index: Tour_PK                                               */
/*==============================================================*/
create unique  index Tour_PK on Tour (
ID_TOUR ASC
);

/*==============================================================*/
/* Index: FK_Band_Tour_FK                                       */
/*==============================================================*/
create index FK_Band_Tour_FK on Tour (
ID_BAND ASC
);

/*==============================================================*/
/* Table: Track                                                 */
/*==============================================================*/
create table Track 
(
   ID_TRACK             integer                        not null,
   ID_BAND              integer                        not null,
   ID_ALBUM             integer                        not null,
   Title                varchar(40)                    not null,
   Duration             time                           not null,
   constraint PK_TRACK primary key  (ID_TRACK)
);

comment on table Track is 
'Album consists of tracks';

/*==============================================================*/
/* Index: Track_PK                                              */
/*==============================================================*/
create unique  index Track_PK on Track (
ID_TRACK ASC
);

/*==============================================================*/
/* Index: FK_Album_Track_FK                                     */
/*==============================================================*/
create index FK_Album_Track_FK on Track (
ID_BAND ASC,
ID_ALBUM ASC
);

alter table Album
   add constraint FK_ALBUM_FK_BAND_A_BAND foreign key (ID_BAND)
      references Band (ID_BAND)
      on update restrict
      on delete restrict;

comment on foreign key Album.FK_ALBUM_FK_BAND_A_BAND is 
'Band releases an album.';

alter table Album
   add constraint FK_ALBUM_FK_PRODUC_PRODUCER foreign key (ID_PRODUCER)
      references Producer (ID_PRODUCER)
      on update restrict
      on delete restrict;

alter table Album
   add constraint FK_ALBUM_FK_STUDIO_STUDIO foreign key (ID_STUDIO)
      references Studio (ID_STUDIO)
      on update restrict
      on delete restrict;

comment on foreign key Album.FK_ALBUM_FK_STUDIO_STUDIO is 
'Album is recorded in a studio.';

alter table Concert
   add constraint FK_CONCERT_FK_TOUR_C_TOUR foreign key (ID_TOUR)
      references Tour (ID_TOUR)
      on update restrict
      on delete restrict;

comment on foreign key Concert.FK_CONCERT_FK_TOUR_C_TOUR is 
'Tour consists of concerts.';

alter table Contract
   add constraint FK_CONTRACT_FK_BAND_C_BAND foreign key (ID_BAND)
      references Band (ID_BAND)
      on update restrict
      on delete restrict;

comment on foreign key Contract.FK_CONTRACT_FK_BAND_C_BAND is 
'Band has a signed contract.';

alter table Equipment
   add constraint FK_EQUIPMEN_FK_BAND_E_BAND foreign key (ID_BAND)
      references Band (ID_BAND)
      on update restrict
      on delete restrict;

comment on foreign key Equipment.FK_EQUIPMEN_FK_BAND_E_BAND is 
'Band requests equipment.';

alter table Musician
   add constraint FK_MUSICIAN_FK_BAND_M_BAND foreign key (ID_BAND)
      references Band (ID_BAND)
      on update restrict
      on delete restrict;

comment on foreign key Musician.FK_MUSICIAN_FK_BAND_M_BAND is 
'Band consists of musicians.';

alter table Studio
   add constraint FK_STUDIO_FK_BAND_S_BAND foreign key (ID_BAND)
      references Band (ID_BAND)
      on update restrict
      on delete restrict;

comment on foreign key Studio.FK_STUDIO_FK_BAND_S_BAND is 
'Band has a rented studio.';

alter table Tour
   add constraint FK_TOUR_FK_BAND_T_BAND foreign key (ID_BAND)
      references Band (ID_BAND)
      on update restrict
      on delete restrict;

comment on foreign key Tour.FK_TOUR_FK_BAND_T_BAND is 
'Band plays a tour.';

alter table Track
   add constraint FK_TRACK_FK_ALBUM__ALBUM foreign key (ID_BAND, ID_ALBUM)
      references Album (ID_BAND, ID_ALBUM)
      on update restrict
      on delete restrict;

comment on foreign key Track.FK_TRACK_FK_ALBUM__ALBUM is 
'Album consists of tracks';

