/************************************************************************/
/*   Archivo:                 rptgeob2c.sp                              */
/*   Stored procedure:        sp_rpt_geolocaliza_b2c                    */
/*   Base de Datos:           cob_conta_super                           */
/*   Producto:                BANCAMOVIL                                */
/*   Disenado por:            Walther Toledo                            */
/*   Fecha de Documentacion:  21-Sep-2021                               */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCORP'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante              */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Generar reporte de registro de datos de Geolocalizacion de todos    */
/*	los clientes. La frecuencia del reporte es Diaria y al final de día.*/
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   Fecha      Nombre          Proposito                               */
/* 28/06/2022   WTO/KVI   Emision Inicial - Caso 158406 - 168293 F2     */
/************************************************************************/

use cob_conta_super
go

if not object_id('sp_rpt_geolocaliza_b2c') is null
   drop proc sp_rpt_geolocaliza_b2c
go

create proc sp_rpt_geolocaliza_b2c
   @i_param1   datetime    = null,   --FECHA
   @i_param2   varchar(10) = null    --FORMATO FECHA
as
declare 
   @w_ciudad_nacional int,
   @w_comando         varchar(6000),
   @w_error           int,
   @w_fecha           datetime,
   @w_fecha_lectura   datetime,
   @w_formato_fecha   int,
   @w_mensaje         varchar(255),
   @w_msg             varchar(255),
   @w_nombre_arch     varchar(255),
   @w_nombre_log         varchar(270),
   @w_operacion       int,
   @w_return          int,
   @w_ruta_arch       varchar(255),
   @w_ruta_reporte    varchar(550),
   @w_ruta_errores    varchar(550),
   @w_s_app           varchar(30),
   @w_sp_name         varchar(30),
   @w_sql             varchar(1000)

select @w_sp_name = 'sp_rpt_geolocaliza_b2c'

select
@w_fecha_lectura = @i_param1,
@w_formato_fecha = convert(int, @i_param2)

if @i_param1 is null
   select @w_fecha_lectura = fp_fecha from cobis..ba_fecha_proceso
if @i_param2 is null
   select @w_formato_fecha = 103

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM' 

/* Fecha de lectura Consolidador */
select @w_fecha = dateadd(day, -1, @w_fecha_lectura)         
while exists(select 1 from cobis..cl_dias_feriados where df_ciudad = @w_ciudad_nacional 
             and df_fecha  = @w_fecha) 
begin
   select @w_fecha = dateadd(day,-1, @w_fecha) 
end

select @w_s_app = pa_char from cobis..cl_parametro
where  pa_producto = 'ADM' and pa_nemonico = 'S_APP'

if @@error != 0 or @@rowcount != 1 
begin
   select 
   @w_error = 70135,
   @w_mensaje = 'Error Al consultar informacion de parametro S_APP'
   goto ERROR_PROCESO
end

/* GENERAR LA TABLA DE TRABAJO EN BASE A LOS DATOS DE LA TABLA BV_GEOLOCALIZA_OPERACION */
select 
fecha	     =  convert(varchar(10), isnull(go_fecha, @w_fecha), @w_formato_fecha),	  
tipo_trans	 =	(select ad_valor from cob_bvirtual..bv_trans_api_detalles where ad_codigo=go_tipo_tran),
buc			 =  convert(varchar(20),null),
operacion	 =	convert(varchar(20),null),
cuenta		 =  convert(varchar(24),null),
producto	 =	convert(varchar(15),null),
subproducto	 =	convert(varchar(15),null),
aplicativo	 =	go_aplicativo,
longitud	 =	ltrim(str(go_longitud, 21, 8)),
latitud		 =	ltrim(str(go_latitud, 21, 8)),
login		 =	go_login	 ,
tipo_serv	 =	go_tipo_serv ,
ssn			 =	convert(varchar(10), go_ssn),		  
ente         =  go_ente,
monto        =  convert(varchar(8),null),
hora         =  convert(varchar(10), isnull(go_fecha, @w_fecha), 108),
clasif_oper  =  convert(varchar(29),null),
estatus_oper =  go_estado,
id_operacion =  convert(varchar(20),null)
into #geolocaliza_b2c
from cob_bvirtual..bv_geolocaliza_operacion
where convert(varchar, go_fecha_proceso, 103)  = convert(varchar, @w_fecha, 103)

if @@error <> 0 begin
   print 'Error en generacion de data base'
   return 1
end
create index idx1 on #geolocaliza_b2c(login)
create index idx2 on #geolocaliza_b2c(ente)
create index idx3 on #geolocaliza_b2c(operacion,producto)

-- =========================================================================

update #geolocaliza_b2c 
set operacion = do_operacion,                          
    producto  = do_tipo_operacion,                      
    cuenta    = do_banco,
	monto     = do_monto                                
from sb_dato_operacion
where ente = do_codigo_cliente
and do_fecha = @w_fecha
and do_aplicativo = 7

update #geolocaliza_b2c 
set buc = en_banco
from cobis..cl_ente
where ente = en_ente

update #geolocaliza_b2c 
set subproducto = (case op_promocion 
                   when 'S' then 'PROMOCION'
                   when 'N' then 'TRADICIONAL' 
                   else 'TRADICIONAL' end)
from #geolocaliza_b2c, cob_cartera..ca_operacion
where operacion = op_operacion
and producto = op_toperacion
and op_toperacion = 'GRUPAL'
-- and do_fecha = @w_fecha

update #geolocaliza_b2c 
set subproducto = 'REVOLVENTE'
where producto = 'REVOLVENTE'

update #geolocaliza_b2c 
set subproducto = 'INDIVIDUAL'
where producto = 'INDIVIDUAL'

-- =========================================================================
truncate table cob_conta_super..sb_rpt_geolocaliza_b2c
insert into cob_conta_super..sb_rpt_geolocaliza_b2c(
	FECHA,	     TIPO_DE_TRANSACCION,            BUC,	                 NUMERO_DE_OPERACION,   
	CUENTA,      PRODUCTO,                       SUBPRODUCTO,            APLICATIVO,	                   
	LONGITUD,    LATITUD,                        MONTO,                  HORA,
	ID_SESION,   CLASIFICACION_DE_OPERACIONES,   ESTATUS_DE_OPERACION,   ID_OPERACION
)values(         
	'FECHA',     'TIPO DE TRANSACCIÓN',          'BUC',	                 'NÚMERO DE OPERACIÓN', 
	'CUENTA',    'PRODUCTO',                 	 'SUBPRODUCTO',          'APLICATIVO',	               
	'LONGITUD',  'LATITUD',                      'MONTO',                'HORA',
	'ID SESIÓN', 'CLASIFICACIÓN DE OPERACIONES', 'ESTATUS DE OPERACIÓN', 'ID OPERACIÓN'+ '|'
)
insert into cob_conta_super..sb_rpt_geolocaliza_b2c(
	FECHA,	   TIPO_DE_TRANSACCION,	         BUC,	               NUMERO_DE_OPERACION,	
	CUENTA,	   PRODUCTO,	                 SUBPRODUCTO,	       APLICATIVO,	
	LONGITUD,  LATITUD,                      MONTO,                HORA,
	ID_SESION, CLASIFICACION_DE_OPERACIONES, ESTATUS_DE_OPERACION, ID_OPERACION                                     
)                                                                               
select                                                                          
	fecha,     tipo_trans,                   buc,		           null,     
	cuenta,	   producto,	                 subproducto,          aplicativo,	
	longitud,  latitud,                      monto,                hora,
	null,      null,                         estatus_oper,         id_operacion
from #geolocaliza_b2c 

if @@error != 0
begin
   print 'Error al actualizar informacion en Estructura para generar Reporte'
   select 
   @w_error = 70137,
   @w_mensaje = 'Error al actualizar informacion en Estructura para generar Reporte'
   goto ERROR_PROCESO
end

select @w_sql = 'select FECHA, TIPO_DE_TRANSACCION, BUC, NUMERO_DE_OPERACION, CUENTA, PRODUCTO, SUBPRODUCTO, APLICATIVO, LONGITUD, '
select @w_sql = @w_sql + 'LATITUD, MONTO, HORA, ID_SESION, CLASIFICACION_DE_OPERACIONES, ESTATUS_DE_OPERACION, ID_OPERACION '
select @w_sql = @w_sql + 'from cob_conta_super..sb_rpt_geolocaliza_b2c '

select @w_nombre_arch = ba_arch_resultado,
       @w_ruta_arch   = ba_path_destino
from cobis..ba_batch 
where ba_batch = 36450

select
@w_nombre_log   = @w_nombre_arch + replace(convert(varchar, @w_fecha, @w_formato_fecha), '/', '') + '.err',
@w_nombre_arch  = @w_nombre_arch + replace(convert(varchar, @w_fecha, @w_formato_fecha), '/', '') + '.txt'

select 
@w_ruta_reporte = @w_ruta_arch + @w_nombre_arch,
@w_ruta_errores = @w_ruta_arch + @w_nombre_log


select @w_comando = 'bcp "' + @w_sql + '" queryout "'
select @w_comando = @w_comando + @w_ruta_reporte + '" -b5000 -c -C RAW -T -e ' + @w_s_app + 's_app.ini -T -e"' + @w_ruta_errores + '"' + ' -t"|" '

print 'COMANDO: ' + @w_comando

exec @w_error = xp_cmdshell @w_comando
if @w_error <> 0 begin
  select @w_error = 70146
  return 1
end

return 0

ERROR_PROCESO:

select @w_msg = mensaje
from  cobis..cl_errores with (nolock)
where numero = @w_error
set transaction isolation level read uncommitted

if @w_msg is null select @w_msg = @w_mensaje
else select @w_msg = @w_msg + ' - ' + @w_mensaje

exec @w_return       = cob_conta_super..sp_errorlog
     @i_operacion    = 'I',
     @i_fecha_fin    = @w_fecha,
     @i_origen_error = @w_error,
     @i_fuente       = @w_sp_name,
     @i_descrp_error = @w_msg

return @w_error

go