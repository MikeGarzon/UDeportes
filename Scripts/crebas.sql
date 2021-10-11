/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     6/10/2021 12:34:45 p.m.                      */
/*==============================================================*/


alter table AREA
   drop constraint FK_AREA_SEDEAREA_SEDE;

alter table COMISARIOEVENTO
   drop constraint FK_COMISARI_COMISARIO_PERSONA;

alter table COMISARIOEVENTO
   drop constraint FK_COMISARI_EVENTO_EVENTO;

alter table COMISARIOEVENTO
   drop constraint FK_COMISARI_TAREACOMI_TAREA;

alter table DEPORTEPERSONA
   drop constraint FK_DEPORTEP_DEPORTE_D_DEPORTE;

alter table DEPORTEPERSONA
   drop constraint FK_DEPORTEP_PERSONA_D_PERSONA;

alter table EQUIPODEPORTE
   drop constraint FK_EQUIPODE_DEPORTE_DEPORTE;

alter table EQUIPODEPORTE
   drop constraint FK_EQUIPODE_EQUIPO_EQUIPO;

alter table EVENTO
   drop constraint FK_EVENTO_ADMINISTR_PERSONA;

alter table EVENTO
   drop constraint FK_EVENTO_AREAEVENT_AREA;

alter table EVENTO
   drop constraint FK_EVENTO_DEPORTEEV_DEPORTE;

alter table EVENTO
   drop constraint FK_EVENTO_SEDEEVENT_SEDE;

alter table INVENTARIO
   drop constraint FK_INVENTAR_EQUIPOINV_EQUIPO;

alter table INVENTARIO
   drop constraint FK_INVENTAR_ESTADOINV_ESTADO;

alter table INVENTARIO
   drop constraint FK_INVENTAR_RELATIONS_INVENTAR;

alter table INVENTARIO
   drop constraint FK_INVENTAR_SEDEINVEN_SEDE;

alter table PERSONA
   drop constraint FK_PERSONA_TIPOPERSO_TIPOPERS;

alter table POLIDEPORTIVO
   drop constraint FK_POLIDEPO_AREAPOLI_AREA;

alter table POLIDEPORTIVO
   drop constraint FK_POLIDEPO_POLIDEPOR_DEPORTE;

alter table PRESTAMO
   drop constraint FK_PRESTAMO_ADMINISTR_PERSONA;

alter table PRESTAMO
   drop constraint FK_PRESTAMO_ESTADOPRE_ESTADO;

alter table PRESTAMO
   drop constraint FK_PRESTAMO_INVENTARI_INVENTAR;

alter table RELATIONSHIP_13
   drop constraint FK_RELATION_DEPORTE2_DEPORTE2;

alter table RELATIONSHIP_13
   drop constraint FK_RELATION_PERSONA_PERSONA;

alter table SEDE
   drop constraint FK_SEDE_SEDEUNICO_UNICO;

alter table UNICO
   drop constraint FK_UNICO_DEPORTEUN_DEPORTE;

drop index SEDEAREA_FK;

drop table AREA cascade constraints;

drop index COMISARIO_FK;

drop index TAREACOMISARIO_FK;

drop index EVENTO_FK;

drop table COMISARIOEVENTO cascade constraints;

drop table DEPORTE cascade constraints;

drop table DEPORTE2 cascade constraints;

drop index PERSONA_DEPORTEPERSONA_FK;

drop index DEPORTE_DEPORTEPERSONA_FK;

drop table DEPORTEPERSONA cascade constraints;

drop table EQUIPO cascade constraints;

drop index EQUIPO_FK;

drop index DEPORTE_FK;

drop table EQUIPODEPORTE cascade constraints;

drop table ESTADO cascade constraints;

drop index ADMINISTRADOR_FK;

drop index AREAEVENTO_FK;

drop index SEDEEVENTO_FK;

drop index DEPORTEEVENTO_FK;

drop table EVENTO cascade constraints;

drop index RELATIONSHIP_23_FK;

drop index EQUIPOINVENTARIO_FK;

drop index SEDEINVENTARIO_FK;

drop index ESTADOINVENTARIO_FK;

drop table INVENTARIO cascade constraints;

drop index TIPOPERSONA_FK;

drop table PERSONA cascade constraints;

drop index POLIDEPORTE_FK;

drop index AREAPOLI_FK;

drop table POLIDEPORTIVO cascade constraints;

drop index ADMINISTRAPRESTA_FK;

drop index INVENTARIOPRESTAMO_FK;

drop index ESTADOPRESTAMO_FK;

drop table PRESTAMO cascade constraints;

drop index PERSONA_FK;

drop index DEPORTE2_FK;

drop table RELATIONSHIP_13 cascade constraints;

drop index SEDEUNICO_FK;

drop table SEDE cascade constraints;

drop table TAREA cascade constraints;

drop table TIPOPERSONA cascade constraints;

drop index DEPORTEUNICO_FK;

drop table UNICO cascade constraints;

drop sequence S_EVENTO;

drop sequence S_INVENTARIO;

create sequence S_EVENTO;

create sequence S_INVENTARIO;

/*==============================================================*/
/* Table: AREA                                                  */
/*==============================================================*/
create table AREA 
(
   IDAREA               VARCHAR2(3)          not null,
   IDCOMPLEJO           CHAR(5)              not null,
   NOMAREA              VARCHAR2(10)         not null,
   UBICACION            VARCHAR2(30)         not null,
   constraint PK_AREA primary key (IDAREA, IDCOMPLEJO)
);

/*==============================================================*/
/* Index: SEDEAREA_FK                                           */
/*==============================================================*/
create index SEDEAREA_FK on AREA (
   IDCOMPLEJO ASC
);

/*==============================================================*/
/* Table: COMISARIOEVENTO                                       */
/*==============================================================*/
create table COMISARIOEVENTO 
(
   CONSECCOMISARIO      NUMBER(3,0)          not null,
   CONSEC               INTEGER              not null,
   IDTAREA              VARCHAR2(3)          not null,
   CODPERSONA           VARCHAR2(4)          not null,
   FECHA                DATE                 not null,
   constraint PK_COMISARIOEVENTO primary key (CONSECCOMISARIO)
);

/*==============================================================*/
/* Index: EVENTO_FK                                             */
/*==============================================================*/
create index EVENTO_FK on COMISARIOEVENTO (
   CONSEC ASC
);

/*==============================================================*/
/* Index: TAREACOMISARIO_FK                                     */
/*==============================================================*/
create index TAREACOMISARIO_FK on COMISARIOEVENTO (
   IDTAREA ASC
);

/*==============================================================*/
/* Index: COMISARIO_FK                                          */
/*==============================================================*/
create index COMISARIO_FK on COMISARIOEVENTO (
   CODPERSONA ASC
);

/*==============================================================*/
/* Table: DEPORTE                                               */
/*==============================================================*/
create table DEPORTE 
(
   IDDEPORTE            VARCHAR2(4)          not null,
   NOMDEPORTE           VARCHAR2(30)         not null,
   NMAXINTEGRANTES      NUMBER(2,0)          not null,
   constraint PK_DEPORTE primary key (IDDEPORTE)
);

/*==============================================================*/
/* Table: DEPORTE2                                              */
/*==============================================================*/
create table DEPORTE2 
(
   IDDEPORTE2           VARCHAR2(4)          not null,
   NOMDEPORTE           VARCHAR2(30)         not null,
   NMAXINTEGRANTES      NUMBER(2,0)          not null,
   constraint PK_DEPORTE2 primary key (IDDEPORTE2)
);

/*==============================================================*/
/* Table: DEPORTEPERSONA                                        */
/*==============================================================*/
create table DEPORTEPERSONA 
(
   CODPERSONA           VARCHAR2(4)          not null,
   IDDEPORTE            VARCHAR2(4)          not null,
   constraint PK_DEPORTEPERSONA primary key (CODPERSONA, IDDEPORTE)
);

/*==============================================================*/
/* Index: DEPORTE_DEPORTEPERSONA_FK                             */
/*==============================================================*/
create index DEPORTE_DEPORTEPERSONA_FK on DEPORTEPERSONA (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Index: PERSONA_DEPORTEPERSONA_FK                             */
/*==============================================================*/
create index PERSONA_DEPORTEPERSONA_FK on DEPORTEPERSONA (
   CODPERSONA ASC
);

/*==============================================================*/
/* Table: EQUIPO                                                */
/*==============================================================*/
create table EQUIPO 
(
   IDEQUIPO             VARCHAR2(3)          not null,
   NOMEQUIPO            VARCHAR2(30)         not null,
   NPARTES              NUMBER(4,0)          not null,
   constraint PK_EQUIPO primary key (IDEQUIPO)
);

/*==============================================================*/
/* Table: EQUIPODEPORTE                                         */
/*==============================================================*/
create table EQUIPODEPORTE 
(
   IDEQUIPO             VARCHAR2(3)          not null,
   IDDEPORTE            VARCHAR2(4)          not null,
   constraint PK_EQUIPODEPORTE primary key (IDEQUIPO, IDDEPORTE)
);

/*==============================================================*/
/* Index: DEPORTE_FK                                            */
/*==============================================================*/
create index DEPORTE_FK on EQUIPODEPORTE (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Index: EQUIPO_FK                                             */
/*==============================================================*/
create index EQUIPO_FK on EQUIPODEPORTE (
   IDEQUIPO ASC
);

/*==============================================================*/
/* Table: ESTADO                                                */
/*==============================================================*/
create table ESTADO 
(
   IDESTADO             VARCHAR2(2)          not null,
   DESCESTADO           VARCHAR2(30)         not null,
   constraint PK_ESTADO primary key (IDESTADO)
);

/*==============================================================*/
/* Table: EVENTO                                                */
/*==============================================================*/
create table EVENTO 
(
   CONSEC               NUMBER(5)            not null,
   IDDEPORTE            VARCHAR2(4)          not null,
   IDCOMPLEJO           CHAR(5)              not null,
   IDAREA               VARCHAR2(3),
   ARE_IDCOMPLEJO       CHAR(5),
   CODPERSONA           VARCHAR2(4),
   FECHAHORA            DATE                 not null,
   DURACION             DATE                 not null,
   NPARTICIPANTE        NUMBER(2,0)          not null,
   constraint PK_EVENTO primary key (CONSEC)
);

/*==============================================================*/
/* Index: DEPORTEEVENTO_FK                                      */
/*==============================================================*/
create index DEPORTEEVENTO_FK on EVENTO (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Index: SEDEEVENTO_FK                                         */
/*==============================================================*/
create index SEDEEVENTO_FK on EVENTO (
   IDCOMPLEJO ASC
);

/*==============================================================*/
/* Index: AREAEVENTO_FK                                         */
/*==============================================================*/
create index AREAEVENTO_FK on EVENTO (
   IDAREA ASC,
   ARE_IDCOMPLEJO ASC
);

/*==============================================================*/
/* Index: ADMINISTRADOR_FK                                      */
/*==============================================================*/
create index ADMINISTRADOR_FK on EVENTO (
   CODPERSONA ASC
);

/*==============================================================*/
/* Table: INVENTARIO                                            */
/*==============================================================*/
create table INVENTARIO 
(
   CONSECINVE           NUMBER(3)            not null,
   IDESTADO             VARCHAR2(2)          not null,
   IDCOMPLEJO           CHAR(5)              not null,
   IDEQUIPO             VARCHAR2(3)          not null,
   INV_CONSECINVE       INTEGER,
   INV_IDCOMPLEJO       CHAR(5),
   INV_IDEQUIPO         VARCHAR2(3),
   NPIEZAS              NUMBER(3,0)          not null,
   constraint PK_INVENTARIO primary key (CONSECINVE, IDCOMPLEJO, IDEQUIPO)
);

/*==============================================================*/
/* Index: ESTADOINVENTARIO_FK                                   */
/*==============================================================*/
create index ESTADOINVENTARIO_FK on INVENTARIO (
   IDESTADO ASC
);

/*==============================================================*/
/* Index: SEDEINVENTARIO_FK                                     */
/*==============================================================*/
create index SEDEINVENTARIO_FK on INVENTARIO (
   IDCOMPLEJO ASC
);

/*==============================================================*/
/* Index: EQUIPOINVENTARIO_FK                                   */
/*==============================================================*/
create index EQUIPOINVENTARIO_FK on INVENTARIO (
   IDEQUIPO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_23_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_23_FK on INVENTARIO (
   INV_CONSECINVE ASC,
   INV_IDCOMPLEJO ASC,
   INV_IDEQUIPO ASC
);

/*==============================================================*/
/* Table: PERSONA                                               */
/*==============================================================*/
create table PERSONA 
(
   CODPERSONA           VARCHAR2(4)          not null,
   IDTIPOPERSONA        VARCHAR2(3)          not null,
   NOMPERSONA           VARCHAR2(30)         not null,
   APEPERSONA           VARCHAR2(30)         not null,
   USERPER              VARCHAR2(6)          not null,
   CORREOPER            VARCHAR2(50)         not null,
   PASSWORD             VARCHAR2(5)          not null,
   constraint PK_PERSONA primary key (CODPERSONA)
);

/*==============================================================*/
/* Index: TIPOPERSONA_FK                                        */
/*==============================================================*/
create index TIPOPERSONA_FK on PERSONA (
   IDTIPOPERSONA ASC
);

/*==============================================================*/
/* Table: POLIDEPORTIVO                                         */
/*==============================================================*/
create table POLIDEPORTIVO 
(
   IDPOLI               VARCHAR2(4)          not null,
   IDAREA               VARCHAR2(3)          not null,
   IDCOMPLEJO           CHAR(5)              not null,
   IDDEPORTE            VARCHAR2(4)          not null,
   constraint PK_POLIDEPORTIVO primary key (IDPOLI)
);

/*==============================================================*/
/* Index: AREAPOLI_FK                                           */
/*==============================================================*/
create index AREAPOLI_FK on POLIDEPORTIVO (
   IDAREA ASC,
   IDCOMPLEJO ASC
);

/*==============================================================*/
/* Index: POLIDEPORTE_FK                                        */
/*==============================================================*/
create index POLIDEPORTE_FK on POLIDEPORTIVO (
   IDDEPORTE ASC
);

/*==============================================================*/
/* Table: PRESTAMO                                              */
/*==============================================================*/
create table PRESTAMO 
(
   CONSECPRESTA         NUMBER(3,0)          not null,
   IDESTADO             VARCHAR2(2)          not null,
   CONSECINVE           INTEGER              not null,
   IDCOMPLEJO           CHAR(5)              not null,
   IDEQUIPO             VARCHAR2(3)          not null,
   CODPERSONA           VARCHAR2(4)          not null,
   FECHAPREST           DATE                 not null,
   constraint PK_PRESTAMO primary key (CONSECPRESTA)
);

/*==============================================================*/
/* Index: ESTADOPRESTAMO_FK                                     */
/*==============================================================*/
create index ESTADOPRESTAMO_FK on PRESTAMO (
   IDESTADO ASC
);

/*==============================================================*/
/* Index: INVENTARIOPRESTAMO_FK                                 */
/*==============================================================*/
create index INVENTARIOPRESTAMO_FK on PRESTAMO (
   CONSECINVE ASC,
   IDCOMPLEJO ASC,
   IDEQUIPO ASC
);

/*==============================================================*/
/* Index: ADMINISTRAPRESTA_FK                                   */
/*==============================================================*/
create index ADMINISTRAPRESTA_FK on PRESTAMO (
   CODPERSONA ASC
);

/*==============================================================*/
/* Table: RELATIONSHIP_13                                       */
/*==============================================================*/
create table RELATIONSHIP_13 
(
   CODPERSONA           VARCHAR2(4)          not null,
   IDDEPORTE2           VARCHAR2(4)          not null,
   constraint PK_RELATIONSHIP_13 primary key (CODPERSONA, IDDEPORTE2)
);

/*==============================================================*/
/* Index: DEPORTE2_FK                                           */
/*==============================================================*/
create index DEPORTE2_FK on RELATIONSHIP_13 (
   IDDEPORTE2 ASC
);

/*==============================================================*/
/* Index: PERSONA_FK                                            */
/*==============================================================*/
create index PERSONA_FK on RELATIONSHIP_13 (
   CODPERSONA ASC
);

/*==============================================================*/
/* Table: SEDE                                                  */
/*==============================================================*/
create table SEDE 
(
   IDCOMPLEJO           CHAR(5)              not null,
   IDUNICO              VARCHAR2(4)          not null,
   NOMCOMPLEJO          VARCHAR2(30)         not null,
   PRESUPUESTO          NUMBER(7,2)          not null,
   DIRECCION            VARCHAR2(30)         not null,
   constraint PK_SEDE primary key (IDCOMPLEJO)
);

/*==============================================================*/
/* Index: SEDEUNICO_FK                                          */
/*==============================================================*/
create index SEDEUNICO_FK on SEDE (
   IDUNICO ASC
);

/*==============================================================*/
/* Table: TAREA                                                 */
/*==============================================================*/
create table TAREA 
(
   IDTAREA              VARCHAR2(3)          not null,
   DESCTAREA            VARCHAR2(30)         not null,
   constraint PK_TAREA primary key (IDTAREA)
);

/*==============================================================*/
/* Table: TIPOPERSONA                                           */
/*==============================================================*/
create table TIPOPERSONA 
(
   IDTIPOPERSONA        VARCHAR2(3)          not null,
   DESCTIPOPERSONA      VARCHAR2(30)         not null,
   constraint PK_TIPOPERSONA primary key (IDTIPOPERSONA)
);

/*==============================================================*/
/* Table: UNICO                                                 */
/*==============================================================*/
create table UNICO 
(
   IDUNICO              VARCHAR2(4)          not null,
   IDDEPORTE            VARCHAR2(4)          not null,
   AREAUNICO            NUMBER(4,2)          not null,
   constraint PK_UNICO primary key (IDUNICO)
);

/*==============================================================*/
/* Index: DEPORTEUNICO_FK                                       */
/*==============================================================*/
create index DEPORTEUNICO_FK on UNICO (
   IDDEPORTE ASC
);

alter table AREA
   add constraint FK_AREA_SEDEAREA_SEDE foreign key (IDCOMPLEJO)
      references SEDE (IDCOMPLEJO);

alter table COMISARIOEVENTO
   add constraint FK_COMISARI_COMISARIO_PERSONA foreign key (CODPERSONA)
      references PERSONA (CODPERSONA);

alter table COMISARIOEVENTO
   add constraint FK_COMISARI_EVENTO_EVENTO foreign key (CONSEC)
      references EVENTO (CONSEC);

alter table COMISARIOEVENTO
   add constraint FK_COMISARI_TAREACOMI_TAREA foreign key (IDTAREA)
      references TAREA (IDTAREA);

alter table DEPORTEPERSONA
   add constraint FK_DEPORTEP_DEPORTE_D_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table DEPORTEPERSONA
   add constraint FK_DEPORTEP_PERSONA_D_PERSONA foreign key (CODPERSONA)
      references PERSONA (CODPERSONA);

alter table EQUIPODEPORTE
   add constraint FK_EQUIPODE_DEPORTE_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table EQUIPODEPORTE
   add constraint FK_EQUIPODE_EQUIPO_EQUIPO foreign key (IDEQUIPO)
      references EQUIPO (IDEQUIPO);

alter table EVENTO
   add constraint FK_EVENTO_ADMINISTR_PERSONA foreign key (CODPERSONA)
      references PERSONA (CODPERSONA);

alter table EVENTO
   add constraint FK_EVENTO_AREAEVENT_AREA foreign key (IDAREA, ARE_IDCOMPLEJO)
      references AREA (IDAREA, IDCOMPLEJO);

alter table EVENTO
   add constraint FK_EVENTO_DEPORTEEV_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table EVENTO
   add constraint FK_EVENTO_SEDEEVENT_SEDE foreign key (IDCOMPLEJO)
      references SEDE (IDCOMPLEJO);

alter table INVENTARIO
   add constraint FK_INVENTAR_EQUIPOINV_EQUIPO foreign key (IDEQUIPO)
      references EQUIPO (IDEQUIPO);

alter table INVENTARIO
   add constraint FK_INVENTAR_ESTADOINV_ESTADO foreign key (IDESTADO)
      references ESTADO (IDESTADO);

alter table INVENTARIO
   add constraint FK_INVENTAR_RELATIONS_INVENTAR foreign key (INV_CONSECINVE, INV_IDCOMPLEJO, INV_IDEQUIPO)
      references INVENTARIO (CONSECINVE, IDCOMPLEJO, IDEQUIPO);

alter table INVENTARIO
   add constraint FK_INVENTAR_SEDEINVEN_SEDE foreign key (IDCOMPLEJO)
      references SEDE (IDCOMPLEJO);

alter table PERSONA
   add constraint FK_PERSONA_TIPOPERSO_TIPOPERS foreign key (IDTIPOPERSONA)
      references TIPOPERSONA (IDTIPOPERSONA);

alter table POLIDEPORTIVO
   add constraint FK_POLIDEPO_AREAPOLI_AREA foreign key (IDAREA, IDCOMPLEJO)
      references AREA (IDAREA, IDCOMPLEJO);

alter table POLIDEPORTIVO
   add constraint FK_POLIDEPO_POLIDEPOR_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

alter table PRESTAMO
   add constraint FK_PRESTAMO_ADMINISTR_PERSONA foreign key (CODPERSONA)
      references PERSONA (CODPERSONA);

alter table PRESTAMO
   add constraint FK_PRESTAMO_ESTADOPRE_ESTADO foreign key (IDESTADO)
      references ESTADO (IDESTADO);

alter table PRESTAMO
   add constraint FK_PRESTAMO_INVENTARI_INVENTAR foreign key (CONSECINVE, IDCOMPLEJO, IDEQUIPO)
      references INVENTARIO (CONSECINVE, IDCOMPLEJO, IDEQUIPO);

alter table RELATIONSHIP_13
   add constraint FK_RELATION_DEPORTE2_DEPORTE2 foreign key (IDDEPORTE2)
      references DEPORTE2 (IDDEPORTE2);

alter table RELATIONSHIP_13
   add constraint FK_RELATION_PERSONA_PERSONA foreign key (CODPERSONA)
      references PERSONA (CODPERSONA);

alter table SEDE
   add constraint FK_SEDE_SEDEUNICO_UNICO foreign key (IDUNICO)
      references UNICO (IDUNICO);

alter table UNICO
   add constraint FK_UNICO_DEPORTEUN_DEPORTE foreign key (IDDEPORTE)
      references DEPORTE (IDDEPORTE);

