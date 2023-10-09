/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Vistas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_sbancarios
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '********************************'
print '*****  CREACION DE VISTAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Vista: ts_impresion_lotes'
if exists (select 1 from sysobjects where name = 'ts_impresion_lotes' and type = 'V')
   drop view ts_impresion_lotes
go

create view ts_impresion_lotes as
select 
secuencial		     = sb_tran_servicio.ts_secuencial, 
cod_alterno		     = sb_tran_servicio.ts_cod_alterno,
tipo_transaccion     = sb_tran_servicio.ts_tipo_transaccion, 
clase 			     = sb_tran_servicio.ts_clase, 
fecha			     = sb_tran_servicio.ts_fecha,
hora			     = sb_tran_servicio.ts_hora,
usuario 		     = sb_tran_servicio.ts_usuario, 
terminal		     = sb_tran_servicio.ts_terminal, 
oficina			     = sb_tran_servicio.ts_oficina, 
tabla			     = sb_tran_servicio.ts_tabla, 
lsrv			     = sb_tran_servicio.ts_lsrv, 
srv				     = sb_tran_servicio.ts_srv,
idlote			     = sb_tran_servicio.ts_int01,
sec				     = sb_tran_servicio.ts_int02,
estado			     = sb_tran_servicio.ts_char101,
funcimprime		     = sb_tran_servicio.ts_smallint01,
fechaimp		     = sb_tran_servicio.ts_fecha01,
funcautoriza	     = sb_tran_servicio.ts_smallint02,
serielit		     = sb_tran_servicio.ts_vchar1001,
serienum		     = sb_tran_servicio.ts_money01
from  sb_tran_servicio
where sb_tran_servicio.ts_tipo_transaccion = 29300
or    sb_tran_servicio.ts_tipo_transaccion = 29301
or    sb_tran_servicio.ts_tipo_transaccion = 29315
go

print '-->Vista: ts_inventario_ins'
if exists (select 1 from sysobjects where name = 'ts_inventario_ins' and type = 'V')
   drop view ts_inventario_ins
go

create view ts_inventario_ins as
select 
secuencial		     = sb_tran_servicio.ts_secuencial, 
cod_alterno		     = sb_tran_servicio.ts_cod_alterno,
tipo_transaccion     = sb_tran_servicio.ts_tipo_transaccion, 
clase 			     = sb_tran_servicio.ts_clase, 
fecha			     = sb_tran_servicio.ts_fecha,
hora			     = sb_tran_servicio.ts_hora,
usuario 		     = sb_tran_servicio.ts_usuario, 
terminal 		     = sb_tran_servicio.ts_terminal, 
oficina			     = sb_tran_servicio.ts_oficina, 
tabla			     = sb_tran_servicio.ts_tabla, 
lsrv 			     = sb_tran_servicio.ts_lsrv, 
srv				     = sb_tran_servicio.ts_srv,
producto		     = sb_tran_servicio.ts_tinyint01, 
instrumento		     = sb_tran_servicio.ts_smallint01,
sub_tipo	         = sb_tran_servicio.ts_int01,	
serie_literal        = sb_tran_servicio.ts_vchar1001,
serie_desde	         = sb_tran_servicio.ts_money01,
serie_hasta	         = sb_tran_servicio.ts_money02,
area		         = sb_tran_servicio.ts_smallint02,
func_area	         = sb_tran_servicio.ts_smallint03,
asignacion           = sb_tran_servicio.ts_char101
from  sb_tran_servicio
where sb_tran_servicio.ts_tipo_transaccion = 29289
or    sb_tran_servicio.ts_tipo_transaccion = 29294
or    sb_tran_servicio.ts_tipo_transaccion = 29300
or    sb_tran_servicio.ts_tipo_transaccion = 29315
or    sb_tran_servicio.ts_tipo_transaccion = 29293
go

print '-->Vista: ts_invet_utl'
if exists (select 1 from sysobjects where name = 'ts_invet_utl' and type = 'V')
   drop view ts_invet_utl
go

create view ts_invet_utl as
select
secuencial           = sb_tran_servicio.ts_secuencial, 
tipo_transaccion     = sb_tran_servicio.ts_tipo_transaccion, 
clase 			     = sb_tran_servicio.ts_clase, 
fecha			     = sb_tran_servicio.ts_fecha,
hora			     = sb_tran_servicio.ts_hora,
usuario 		     = sb_tran_servicio.ts_usuario, 
terminal 		     = sb_tran_servicio.ts_terminal, 
oficina			     = sb_tran_servicio.ts_oficina, 
tabla			     = sb_tran_servicio.ts_tabla, 
lsrv 			     = sb_tran_servicio.ts_lsrv, 
srv				     = sb_tran_servicio.ts_srv,
cod_secuencial	     = sb_tran_servicio.ts_int01,
cont  			     = sb_tran_servicio.ts_int02,
prod_destino	     = sb_tran_servicio.ts_tinyint01,
instrumento 	     = sb_tran_servicio.ts_smallint01,
subtipo			     = sb_tran_servicio.ts_int03,
cod_func		     = sb_tran_servicio.ts_smallint02
from  sb_tran_servicio
where sb_tran_servicio.ts_tipo_transaccion = 29350
go

print '-->Vista: ts_puntos_reorden'
if exists (select 1 from sysobjects where name = 'ts_puntos_reorden' and type = 'V')
   drop view ts_puntos_reorden
go

create view ts_puntos_reorden as 
select
secuencial           = sb_tran_servicio.ts_secuencial, 
cod_alterno		     = sb_tran_servicio.ts_cod_alterno,
tipo_transaccion     = sb_tran_servicio.ts_tipo_transaccion, 
clase 			     = sb_tran_servicio.ts_clase, 
fecha			     = sb_tran_servicio.ts_fecha,
hora			     = sb_tran_servicio.ts_hora,
usuario 		     = sb_tran_servicio.ts_usuario, 
terminal 		     = sb_tran_servicio.ts_terminal, 
oficina			     = sb_tran_servicio.ts_oficina, 
tabla			     = sb_tran_servicio.ts_tabla, 
lsrv 			     = sb_tran_servicio.ts_lsrv, 
srv				     = sb_tran_servicio.ts_srv,
area			     = sb_tran_servicio.ts_smallint01,
func_area		     = sb_tran_servicio.ts_smallint02,
fecha_modif		     = sb_tran_servicio.ts_fecha01,
func_modif		     = sb_tran_servicio.ts_smallint04,
producto		     = sb_tran_servicio.ts_tinyint01,
instrumento		     = sb_tran_servicio.ts_smallint03,
sub_tipo		     = sb_tran_servicio.ts_int01,
maximo			     = sb_tran_servicio.ts_int02,
minimo			     = sb_tran_servicio.ts_int03,
actual			     = sb_tran_servicio.ts_int04,
cant_fin_dia	     = sb_tran_servicio.ts_int05,
fecha_conta		     = sb_tran_servicio.ts_fecha02
from  sb_tran_servicio
where sb_tran_servicio.ts_tipo_transaccion = 29294
or    sb_tran_servicio.ts_tipo_transaccion = 29298
or    sb_tran_servicio.ts_tipo_transaccion = 29289
or    sb_tran_servicio.ts_tipo_transaccion = 29300
or    sb_tran_servicio.ts_tipo_transaccion = 29315
or    sb_tran_servicio.ts_tipo_transaccion = 29301
go

print ''
print 'Fin Ejecucion Creacion de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''