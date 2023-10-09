/******************************************************/
--Fecha Creación del Script: 2016/Jul/08               */
--Historial  Dependencias:                            */
--Creacion de Tipos de Datos y de Tablas de PERSON */
--Modulo :MIS CTA_AHO                                 */

use cob_remesas_his
go

print '******** CREACION DE TIPOS DE DATOS *********'
/*	
	Creacion de tipos de datos de usuario 
*/

print 'Tipo de dato:  cuenta'
if exists (select * from systypes where name = 'cuenta')
    exec sp_droptype cuenta
go
    exec sp_addtype cuenta, 'varchar(24)', 'null'
go

print 'Tipo de dato:  mensaje'
if not exists (select * from systypes where name = 'mensaje')
    exec sp_addtype mensaje, 'varchar(240)', 'null'
go

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

print 'Creando tabla pe_his_ts'
IF EXISTS (select 1 from sysobjects where name = 'pe_his_ts')
   DROP TABLE pe_his_ts
go
Create table pe_his_ts (
		hts_secuencial		int 		not null,
		hts_tipo_transaccion	smallint 	not null,
		hts_oficina		smallint 	null,
		hts_usuario		descripcion	null,
		hts_terminal		descripcion	null,
		hts_reentry		char(1)		null,
		hts_cod_alterno		int 		null,
		hts_servicio_per	smallint	null,
		hts_categoria		catalogo	null,
		hts_tipo_rango		tinyint		null,
		hts_grupo_rango		smallint	null,
		hts_rango		tinyint		null,
		hts_operacion		char(1)		null,
		hts_tipo		char(1)		null,
		hts_minimo		real		null,
		hts_maximo		real		null,
		hts_val_medio		real		null,
		hts_en_linea		char(1)		null,
		hts_tipo_default	char(1)		null,
		hts_rol			char(1)		null,
		hts_producto		tinyint		null,
		hts_codigo		int		null,
		hts_cuenta		cuenta		null,
		hts_valor_con		real		null,
		hts_tipo_variacion	char(1)		null,
		hts_fecha_cambio	smalldatetime	null,
		hts_fecha_vigencia	smalldatetime	null,
		hts_fecha		smalldatetime	null,
		hts_fecha_batch		smalldatetime	null)
go

-----------------------------------------------------------------------------------------
--•   Falta parametría en  ve_version
use cobis
go
print '---------> Parametros Generales de Ahorros -- ve_version'
delete from ve_version 
 where ve_producto = 4 
   and ve_archivo  = 'Tadmin.exe' 
   and ve_oficina in (1,7020)
insert into ve_version (ve_producto, ve_archivo, ve_oficina, ve_numero1, ve_numero2, ve_numero3, ve_fecha_mod, ve_usuario, ve_proposito) 
values (4, 'Tadmin.exe', 1, 3, 6, 42, getdate(), 'admuser', 'PRU') 
insert into ve_version (ve_producto, ve_archivo, ve_oficina, ve_numero1, ve_numero2, ve_numero3, ve_fecha_mod, ve_usuario, ve_proposito)
values (4, 'Tadmin.exe', 7020, 3, 6, 42, getdate(), 'admuser', 'PRU') 
go

----------------------------------------------------------------------------------------------------------


