/************************************************************************/
/*	Archivo:						 recoredi.sp						*/
/*	Stored procedure:				 sp_concilia_remesa_diaria			*/
/*	Base de datos:					 cob_remesas						*/
/*	Producto:						 REC								*/
/*	Fecha de escritura: 			 18-Mar-2011						*/
/************************************************************************/
/*				IMPORTANTE												*/
/*	Este programa es parte de los paquetes bancarios propiedad de		*/
/*	"COBISCORP".														*/
/*	Su uso no autorizado queda expresamente prohibido asi como			*/
/*	cualquier alteracion o agregado hecho por alguno de sus 			*/
/*	usuarios sin el debido consentimiento por escrito de la 			*/
/*	Presidencia Ejecutiva de COBISCORP o su representante. 				*/
/************************************************************************/
/*				PROPOSITO												*/
/* Genera Archivo para conciliacion remesas en linea y en batch 		*/
/* Proceso Diario														*/
/************************************************************************/
/*				MODIFICACIONES											*/
/*	FECHA		AUTOR					 RAZON							*/
/*	31/05/2011	SMolano 				Genera Archivo Conciliacion 	*/
/*										diaria remesas					*/
/************************************************************************/
use cob_remesas
go

if exists (SELECT 1 FROM sysobjects WHERE name = 'sp_concilia_remesa_diaria')
   drop proc sp_concilia_remesa_diaria
go

if exists (select 1 from tempdb..sysobjects where name = 'remesa_diaria')
		drop table tempdb..remesa_diaria
go
if exists (select 1 from tempdb..sysobjects where name = 'remesa_diaria_tmp')
		drop table tempdb..remesa_diaria_tmp
go

--CREAR TABLA DE TRABAJO  
create table tempdb..remesa_diaria(
Sucursal		smallint		not null,
Zona			smallint		not null,
Oficina 		smallint		not null,
Cuenta			cuenta			not null,
Fecha			datetime		not null,
Num_remesa		varchar(30) 	null,
Tipo_ced		char(2) 		null,
Num_doc 		numero			null,
Nombre			varchar(254)	null,
Vlr_abono		money			null,
Vlr_efectivo	money			null,
Usuario 		varchar(30) 	null
)
go

--CREAR TABLA DE TRABAJO 
create table tempdb..remesa_diaria_tmp(
Sucursal		varchar(10) 	null,
Zona			varchar(10) 	null,
Oficina 		varchar(10) 	null,
Cuenta			cuenta			null,
Fecha			varchar(25) 	null,
Num_remesa		varchar(30) 	null,
Tipo_ced		varchar(10) 	null,
Num_doc 		varchar(16) 	null,
Nombre			varchar(254)	null,
Vlr_abono		varchar(16) 	null,
Vlr_efectivo	varchar(16) 	null,
Usuario 		varchar(30) 	null
)
go

create procedure sp_concilia_remesa_diaria(
   @i_param1			varchar(255) -- Fecha Proceso
)
as	

declare 
   @i_fecha 			varchar(12),
   @w_sp_name			varchar(60),
   @w_error 			varchar(255),
--variables para bcp   
   @w_path_destino		varchar(100),
   @w_cmd				varchar(255),	
   @w_comando			varchar(255),
   @w_path_s_app		varchar(100),
   @w_msg				varchar(50),
   @w_s_app 			varchar(250),
   @w_sqr				varchar(100),
   @w_path				varchar(250),
   @w_archivo			varchar(255),
   @w_archivo_bcp		varchar(255),
   @w_nom_archivo		varchar(100),
   @w_anio				int,
   @w_mes				int,
   @w_dia				int,
   @w_fecha_reporte 	varchar(10),
   @w_total_err 		varchar(16),
   @w_total_pro 		varchar(16),
   @w_total 			varchar(16),
   @w_valor 			money

select @w_sp_name	  = 'sp_concilia_remesa_diaria',
	   @i_fecha   = convert(datetime, @i_param1)

--Limpia Tablas
truncate table tempdb..remesa_diaria
truncate table tempdb..remesa_diaria_tmp
   
--********************* **********************--
---> GENERAR BCP 
--*******************************************--
select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
	select @w_error = 999999, @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
	goto ERROR
end

select @w_path = pp_path_destino
from   cobis..ba_path_pro
where  pp_producto = 3

if @@rowcount = 0 
Begin
   select @w_msg = 'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_concilia_remesa_diaria'
   print  @w_msg
   return 1
End 

exec cobis..sp_datepart
	 @i_fecha = @i_fecha,
	 @o_dia   = @w_dia out,
	 @o_mes   = @w_mes out,
	 @o_anio  = @w_anio out
if @@error <> 0 Begin
   select @w_msg = 'ERROR 3: ERROR EN EL SP_DATEPART'
   print @w_msg
   return 1
End 

--Selecciona datos de abono cob_ahorros..ah_tran_monet y pagos de remesas en efectivo cob_cuentas..cc_tsot_ingegre
insert into tempdb..remesa_diaria
select 'Sucursal' = isnull(of_regional,of_oficina),
	   of_zona,
	   tm_oficina, --(sucursal)
	   tm_cta_banco,
	   'Hora'= convert(char(25), tm_hora, 113),
	   tm_serial,
	   en_tipo_ced,
	   en_ced_ruc,
	   en_nomlar,
	   tm_valor,
	   '0.00',
	   tm_usuario
 from cob_ahorros..ah_tran_monet,
	  cobis..cl_ente,
	  cobis..cl_oficina
where tm_cliente = en_ente
and   tm_oficina = of_oficina
and   tm_causa	= 242
and   tm_fecha = @i_fecha

insert into tempdb..remesa_diaria
select 
'Sucursal' = of_regional,				--sucursal
of_zona,								--zona
oficina,								--oficina
'', 									--Cuenta
'Hora'= convert(char(25), hora, 113),	--Fecha
desc_referencia,						--Numero remesa
tipodoc_ben,							--Tipo_ced
numdoc_ben, 							--numero cedula 
beneficiario,							--nombre 
'0.00', 								--Valor abono
valor,									--Valor efectivo
usuario 								--Usuario	
 from cob_cuentas..cc_tsot_ingegre, cobis..cl_oficina
where causa = '031'
and estado_corr	is null
and correccion	= 'N'
and oficina = of_oficina
and fecha = @i_fecha

--INCLUIR CABECERA DEL ARCHIVO 
insert into tempdb..remesa_diaria_tmp values ('Sucursal','Zona','Oficina','Cuenta','Fecha','Nro_Remesa','Tipo_Doc','Num_doc','Nombre','Vlr_abono','Vlr_efectivo','Usuario')

insert into tempdb..remesa_diaria_tmp
select 
Sucursal,
Zona,
Oficina,
Cuenta,
'Fecha'= convert(char(25), Fecha, 113),
Num_remesa,
Tipo_ced,
Num_doc,
Nombre,
Vlr_abono,
Vlr_efectivo,
Usuario
from tempdb..remesa_diaria
if @@error <> 0 begin
   select @w_error	 = @@error,
		  @w_msg = ' ERROR TRASLADO A TABLA tempdb..remesa_diaria'
   print 'ERROR: '+@w_error+@w_msg
   return 1
end

--TOTALES DIARIOS
insert into tempdb..remesa_diaria_tmp
select null,null,null,'Total',null,count(*),null,null,null,sum(Vlr_abono),sum(Vlr_efectivo),null
from tempdb..remesa_diaria

-- Borra de la tabla fija mensual re_remesa_mensual para la fecha (Reprocesable)
delete from re_remesa_mensual
from re_remesa_mensual
where convert(varchar(10), rm_fecha, 101) = @i_fecha

-- Almacena registro en la tabla fija mensual
insert into re_remesa_mensual
select Sucursal,Oficina,Fecha,
'Cant_Efec'= sum(case when Vlr_abono = 0 then 1 else 0 end), 'Efectivo'= isnull (sum(case when Vlr_abono = 0 then convert(money, Vlr_efectivo) else 0 end),0),
'Cant_abo'= sum(case when Vlr_abono > 0 then 1 else 0 end), 'Abono'= isnull(sum(case when Vlr_abono > 0 then convert(money, Vlr_abono) else 0 end),0)
from tempdb..remesa_diaria
group by Sucursal,Oficina,Fecha
order by Sucursal,Oficina,Fecha

select @w_fecha_reporte = convert(varchar,@w_anio)+right((replicate('0', 2) + convert(varchar,@w_mes)),2)+right((replicate('0', 2) + convert(varchar,@w_dia)),2)
--GENERA BCP
select @w_nom_archivo = 'remesa_dia_' + @w_fecha_reporte + '.txt'
select @w_archivo = @w_path + @w_nom_archivo

select @w_cmd	  = @w_path_s_app + 's_app bcp -auto -login tempdb..remesa_diaria_tmp out ' 

select @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e' + @w_archivo + '.err' + ' -t"|" -config '+ @w_path_s_app + 's_app.ini'
exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin 
   select @w_msg = 'ERROR: '+@w_error+' ERROR GENERANDO BCP ' + @w_comando
   print @w_msg
   return 1
end


return 0

ERROR:

   insert into cob_remesas..re_error_batch
   values (@w_error,@w_msg)
   return @w_error 

go





