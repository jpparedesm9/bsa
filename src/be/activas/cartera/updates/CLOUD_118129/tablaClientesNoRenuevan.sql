use cob_cartera
go

if object_id ('rpt_clientes_no_renuevan') is not null
	drop table rpt_clientes_no_renuevan
go

create table rpt_clientes_no_renuevan
	(
	Oficina                                varchar (255),
	Region                                 varchar (255),
	[Nombre del Gerente]                   varchar (255),
	[Nombre del Coordinador]               varchar (255),
	[Nombre del Asesor]                    varchar (255),
	[Id grupo]                             int,
	[Nombre del grupo]                     varchar (255),
	[Nombre del producto]                  varchar (255),
	[Ciclo individual]                     int,
	[Ciclo grupal]                         int,
	[Apellido Paterno]                     varchar (100),
	[Apellido Materno]                     varchar (100),
	Nombre                                 varchar (100),
	[Nombre 2]                             varchar (100),
	[No. de integrantes]                   int,
	RFC                                    varchar (20),
	BUC                                    varchar (20),
	[Cuenta de deposito]                   varchar (100),
	[Tipo de cuenta]                       varchar (20),
	Genero                                 varchar (30),
	Edad                                   int,
	[Estado civil]                         varchar (30),
	Escolaridad                            varchar (255),
	[Numero celular]                       varchar (20),
	[Nombre corto de la actividad economica] varchar (255),
	[Anios de antigüedad del negocio]      varchar (30),
	[Correo electronico]                   varchar (255),
	[Ingreso mensual]                      money,
	[Gastos mensuales]                     money,
	[Otros ingresos]                       money,
	[Capacidad de pago]                    money,
	[Monto del credito]                    money,
	[Fecha de desembolso]                  varchar (255),
	[Fecha de cancelacion]                 varchar (255),
	[Dias de atraso maximo durante el ciclo] int,
	[Dias de No Renovado]                  int
	)
go

