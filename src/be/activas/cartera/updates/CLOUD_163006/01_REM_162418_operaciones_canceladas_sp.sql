use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_operacion_cancelada') IS NOT NULL
	DROP table dbo.sb_operacion_cancelada
go

create table dbo.sb_operacion_cancelada
	(
	CC                       smallint not null,
	CONTRATO                 varchar (24) not null,
	[ID GRUPO]               int not null,
	[NOMBRE GRUPO]           varchar (64) not null,                                          
	[CLIENTE COBIS]          int not null,
	[APELLIDO PATERNO]       varchar (64) not null,
	[APELLIDO MATERNO]       varchar (64) not null,
	NOMBRE1                  varchar (64) not null,                                                                                              
	[CICLO INDIVIDUAL]       int not null,
	[PRODUCTO DE PRESTAMOS]  varchar (40) not null,
	[DIAS MAX ATRASO ANT]    int not null,
	[DIAS MAX ATRASO ACT]    int not null,
	[DIAS MORA]              int not null,
	[NIVEL DE RIESGO]        char (1) not null
	)
go
