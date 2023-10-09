/****************************************************************************/
/*   Archivo:             sb_conciliacion.sql                     			*/
/*   Base de datos:       cob_conta_super                               	*/
/*   Producto:            Cartera                                       	*/
/*   Disenado por:        Raymundo Picazo                               	*/
/****************************************************************************/
/*							      IMPORTANTE                                */
/* Este programa es parte de los paquetes bancarios propiedad de Cobis.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier     */
/* alteracion o agregado hecho por alguno de usuarios sin el debido         */
/* consentimiento por escrito de la Presidencia Ejecutiva de Cobis          */
/* o su representante.                                                      */
/****************************************************************************/
/*                                PROPOSITO                                 */
/*					Script para la creación de las tablas					*/
/*					para la conciliación de corresponsales 					*/
/****************************************************************************/
/*                              MODIFICACIONES                              */
/* 	  FECHA        AUTOR               RAZON                    			*/
/*  28/03/2019   R.Picazo          Emision Inicial  #107888           		*/
/*  11/04/2019   J.Sanchez   Cambio en la estructura de la tabla #107888	*/
/*  02/05/2019   J.Sanchez 	 	 Correcion de errores al ejecutar 			*/
/*  						 		     el script #107888					*/
/****************************************************************************/

use cob_conta_super
go

if exists(select 1 from sys.indexes
	where name = 'idx_1' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_1
go

if exists(select 1 from sys.indexes
	where name = 'idx_2' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_2
go

if exists(select 1 from sys.indexes
	where name = 'idx_3' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_3
go

if exists(select 1 from sys.indexes
	where name = 'idx_4' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_4
go

if exists(select 1 from sys.indexes
	where name = 'idx_5' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_5
go

if exists(select 1 from sys.indexes
	where name = 'idx_6' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_6
go

if exists(select 1 from sys.indexes
	where name = 'idx_7' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_7
go

if exists(select 1 from sys.indexes
	where name = 'idx_8' and object_id = OBJECT_ID('sb_conciliacion_corresponsal'))
	drop index sb_conciliacion_corresponsal.idx_8
go

if exists(select 1 from sysobjects
	where name = 'sb_conciliacion_corresponsal')
	drop table sb_conciliacion_corresponsal
go

create table sb_conciliacion_corresponsal
(
   co_id		      int 			  not null identity(1,1),
   co_aplicativo	  int			  not null, -- 5 - Cartera
   co_corresponsal    varchar(25)     not null,
   co_secuencial      int             null,     --co_relacionados
   co_relacionados    int             null,     -- ocupamos este campo para la opcion conciliar sin accion 
   co_id_trn_corresp  int			  not null,
   co_id_cobis_trn    int		      null, 	-- Secuencial de ca_corresponsal_trn
   co_tipo_trn        varchar(10)     not null, -- Esto indica si es pago grupal(pg),pago garantía(pg), pi, cg, 
   co_referencia_pago varchar(25)     not null,
   co_fecha_registro  datetime 		  not null,
   co_usuario_trn     varchar(10)     not null,
   co_fecha_valor     datetime        not null,
   co_monto           money		      not null,
   co_reverso         char(1)         not null, -- Si/NO (S/N)
   co_trn_reverso     int             null,
   co_cliente		  int			  null,
   co_grupo			  int             null,
   co_estado_trn      char(2)         null, 	-- (Procesado / Pendiente /Anulado / Reversado / Error 
   co_estado_conci    char(1)         null, 	-- Si/NO (S/N)
   co_usuario_conci   login           null,
   co_razon_no_conci  char(1)		  null, 	-- Huerfano COBIS (C) / Huerfano Archivo (A)
   co_fecha_conci     datetime        null,
   co_accion_conci    char(2)         null, 	-- Aclarado (AC) / Aplicado (AP) / Reversado (RV)
   co_observaciones   varchar(255)    null,
   co_archivo		  varchar(255)	  not null,
   co_linea			  int			  null,
   co_texto_linea	  varchar(500)	  null
)

create index idx_1 on sb_conciliacion_corresponsal(co_corresponsal)
create index idx_2 on sb_conciliacion_corresponsal(co_tipo_trn)
create index idx_3 on sb_conciliacion_corresponsal(co_fecha_valor)
create index idx_4 on sb_conciliacion_corresponsal(co_id_trn_corresp)
create index idx_5 on sb_conciliacion_corresponsal(co_id_cobis_trn)
create index idx_6 on sb_conciliacion_corresponsal(co_cliente)
create index idx_7 on sb_conciliacion_corresponsal(co_grupo)
create index idx_8 on sb_conciliacion_corresponsal(co_estado_conci)

if exists(select 1 from sys.indexes
	where name = 'idx_1' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_1
go

if exists(select 1 from sys.indexes
	where name = 'idx_2' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_2
go

if exists(select 1 from sys.indexes
	where name = 'idx_3' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_3
go

if exists(select 1 from sys.indexes
	where name = 'idx_4' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_4
go

if exists(select 1 from sys.indexes
	where name = 'idx_5' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_5
go

if exists(select 1 from sys.indexes
	where name = 'idx_6' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_6
go

if exists(select 1 from sys.indexes
	where name = 'idx_7' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_7
go

if exists(select 1 from sys.indexes
	where name = 'idx_8' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_8
go

if exists(select 1 from sys.indexes
	where name = 'idx_9' and object_id = OBJECT_ID('sb_conciliacion_corresponsal_temp'))
	drop index sb_conciliacion_corresponsal_temp.idx_9
go

if exists(select 1 from sysobjects
	where name = 'sb_conciliacion_corresponsal_temp')
	drop table sb_conciliacion_corresponsal_temp
go

create table sb_conciliacion_corresponsal_temp
(
   co_id		      int             not null identity(1,1),
   co_corresponsal    varchar(25)     null,
   co_secuencial      int             null, 
   co_relacionados    int             null,
   co_usuario         login           null,
   co_id_trn_corresp  int			  null,
   co_id_cobis_trn    int		      null, -- Secuencial de ca_corresponsal_trn
   co_tipo_trn        varchar(10)     null, -- Esto indica si es pago grupal(pg),pago garantía(pg), pi, cg, 
   co_referencia_pago varchar(25)     null,
   co_fecha_registro  datetime        null,
   co_usuario_trn     varchar(10)     null,
   co_fecha_valor     datetime        null,
   co_monto           money		      null,
   co_reverso         char(1)         null, -- Si/NO (S/N)
   co_trn_reverso     int			  null,
   co_cliente         int			  null,
   co_grupo			  int             null,
   co_estado_trn      char(2)		  null, -- Todos / Aplicados / Ingresados / Error
   co_estado_conci    char(1)	      null, -- Si/NO (S/N)
   co_usuario_conci   login           null,
   co_razon_no_conci  char(1)		  null, -- Huerfano COBIS (C) / Huerfano Archivo (A)
   co_fecha_conci     datetime        null,
   co_accion_conci    char(2)         null, -- Aclarado (AC) / Aplicado (AP) / Reversado (RV)
   co_observaciones   varchar(255)    null
)

create index idx_1 on sb_conciliacion_corresponsal_temp(co_corresponsal)
create index idx_2 on sb_conciliacion_corresponsal_temp(co_tipo_trn)
create index idx_3 on sb_conciliacion_corresponsal_temp(co_fecha_valor)
create index idx_4 on sb_conciliacion_corresponsal_temp(co_id_trn_corresp)
create index idx_5 on sb_conciliacion_corresponsal_temp(co_id_cobis_trn)
create index idx_6 on sb_conciliacion_corresponsal_temp(co_cliente)
create index idx_7 on sb_conciliacion_corresponsal_temp(co_grupo)
create index idx_8 on sb_conciliacion_corresponsal_temp(co_estado_conci)
create index idx_9 on sb_conciliacion_corresponsal_temp(co_usuario)

if exists(select 1 from sys.sequences
	where object_id = OBJECT_ID('sb_conciliacion_corresponsal_sq'))
	drop sequence sb_conciliacion_corresponsal_sq
go

-- secuencia para ligar consiliaciones entre si 
CREATE SEQUENCE sb_conciliacion_corresponsal_sq
INCREMENT BY 1
START WITH 1;

go