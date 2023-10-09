/***************************************************************************/
/*   Archivo:                 ca_rep_cob_batch.sp                          */ 
/*   Stored procedure:        sp_reporte_cobranza_batch                    */
/*   Base de Datos:           cob_cartera                                  */
/*   Producto:                Cartera                                      */
/*   Disenado por:            Maria Jose Taco                              */
/*   Fecha de Documentacion:  01/29/2020                                   */
/***************************************************************************/
/*                            IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancario s propiedad de        */
/*   'COBIS'.                                                              */
/*   Su uso no autorizado queda expresamente prohibido asi como            */
/*   cualquier autorizacion o agregado hecho por alguno de sus             */
/*   usuario sin el debido consentimiento por escrito de la                */
/*   Presidencia Ejecutiva de COBIS o su representante                     */
/***************************************************************************/
/*                         PROPOSITO                                       */
/*                     Reporte de Cobranza                                 */
/*	 Extracción de los pagos realizados en base a los dispositivos en los  */
/*   cuales los clientes pagaron                                           */
/***************************************************************************/
/*                     MODIFICACIONES                                      */
/* FECHA                AUTOR                DETALLE                       */
/***************************************************************************/

use cob_cartera 
go 

if exists(select 1 from sysobjects where name = 'sp_reporte_cobranza_batch')
    drop proc sp_reporte_cobranza_batch
go

create proc sp_reporte_cobranza_batch  
(
    @i_param1           datetime   =   null ,
	@i_param2           datetime   =   null 
)as

DECLARE
  @w_sp_name        varchar(20),
  @w_s_app          varchar(50),
  @w_path           varchar(255),  
  @w_msg            varchar(200),  
  @w_return         int,
  @w_dia            varchar(2),
  @w_mes            varchar(2),
  @w_anio           varchar(4),
  @w_fecha_r        varchar(10),
  @w_file_rpt       varchar(40),
  @w_file_rpt_1     varchar(200),
  @w_file_rpt_1_out varchar(140),
  @w_bcp            varchar(2000),
  @w_error          int,
  @w_msg_error      varchar(255),
  @t_show_version   int,
  @w_fecha_desde    datetime,
  @w_fecha_hasta    datetime,
  @w_cmd            varchar(1000),
  @w_destino        varchar(1000),
  @w_comando        varchar(1000),
  @w_errores        varchar(1000),
  @w_ciudad_nacional       int,
  @w_fecha_proceso  datetime
select @w_sp_name = 'sp_reporte_cobranza_batch'

--Versionamiento del Programa
if @t_show_version = 1
begin
  print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.1.0.0'
  return 0
end

truncate table ca_cobranza_batch

-- -------------------------------------------------------------------------------
-- DIRECCION DEL ARCHIVO A GENERAR
-- -------------------------------------------------------------------------------
select @w_s_app = pa_char
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'S_APP'

select @w_ciudad_nacional = pa_int
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'CIUN'
and    pa_producto = 'ADM'


select @w_fecha_proceso = fc_fecha_cierre 
from cobis..ba_fecha_cierre
where fc_producto = 7

if (@i_param1 = @i_param2)
begin
  
   select @w_fecha_desde = dateadd(dd,-1,@i_param1),
          @w_fecha_hasta = @i_param2
          
   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_desde) 
   begin
      select @w_fecha_desde = dateadd(dd,-1,@w_fecha_desde) 
   end       

   select @w_fecha_hasta = @w_fecha_desde
end
else
begin
   select @w_fecha_desde = @i_param1,
          @w_fecha_hasta = @i_param2

   /* DETERMINAR FECHA DE CORTE DEL REPORTE POR EJECUCION EN SARTA 22*/   
   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_hasta) 
      select @w_fecha_hasta= dateadd(dd,-1,@w_fecha_hasta) 

   /* EN CASO QUE LA FECHA DE CORTE SEA UN FERIADO, EL REPORTE DEBE CONSIDERAR ESTAS TRANSACCIONES */
   while exists(select 1 from cobis..cl_dias_feriados where df_ciudad=@w_ciudad_nacional and df_fecha=@w_fecha_desde) 
      select @w_fecha_desde= dateadd(dd,-1,@w_fecha_desde) 
  
  -- print 'desde'+convert(varchar(10),@w_fecha_desde,103)
  -- print 'hasta'+convert(varchar(10),@w_fecha_hasta,103)
end
       
--DETERMINAR UNIVERSO DE REGISTROS A REPORTAR 
select 
secuencial_id      = co_secuencial,
cod_interno        = co_codigo_interno,
fecha_val          = co_fecha_valor, 
fecha_real         = co_fecha_real,
fecha_proceso      = co_fecha_proceso,
monto_grupal       = co_monto,
reverso            = case co_accion when 'R' then 'SI' else 'NO' end,
canal_id           = co_trn_id_corresp,
origen_pago        = co_corresponsal,
referencia         = co_referencia,
pag_estado         = (case co_estado 
                          when 'A' then 'Anulado'
						  when 'I' then 'Pendiente'
						  when 'R' then 'Reversado'
						  when 'E' then 'Error'
						  when 'P' then 'Aplicado'
                          else  '' end )
into #pagos
from ca_corresponsal_trn
where co_fecha_proceso BETWEEN @w_fecha_desde and @w_fecha_hasta
and   co_tipo     <> 'GL'

if @@error != 0 begin
   select 
   @w_error = 105506,
   @w_msg_error = 'No Existen Registros'
   goto ERROR_PROCESO
END

--CREAR TABLA DE DETALLE DE PAGOS
select 
operacion      = cd_operacion,
banco          = cd_banco,
secuencial_ing = cd_sec_ing ,
monto_op       = convert(money,0),
grupo          = convert(int,0),
secuencial     = secuencial_id
into #detalle_pagos
from #pagos,ca_corresponsal_det
where secuencial_id =cd_secuencial
and reverso = 'NO'
and pag_estado not in ( 'Anulado', 'Pendiente', 'Error')

if @@error != 0 
begin
   select 
   @w_error = 145003,
   @w_msg_error = 'Error en actualización de reporte'
   goto ERROR_PROCESO
end

update #detalle_pagos 
set monto_op = abd_monto_mn 
from ca_abono,
     ca_abono_det     
where ab_secuencial_ing =  abd_secuencial_ing     
and ab_operacion =abd_operacion
and ab_secuencial_ing = secuencial_ing
and ab_operacion = operacion

update #detalle_pagos  
set grupo = tg_grupo
from cob_credito..cr_tramite_grupal
where tg_operacion = operacion 


select 
cb_secuencial  = tr_secuencial, 
cb_contrato    = tr_banco,
cod_interno    = tr_operacion, 
cb_grupo_id    = 0,
cb_fecha_pago  = tr_fecha_ref,
cb_hora_pago   = tr_fecha_real,
cb_origen_pago = 'PAGO FINANCIANDO',  --'BANCO SANTANDER'
cb_monto       = 0 
into  #ca_cobranzas_batch
from  ca_transaccion 
where tr_tran = 'PAG'
and   tr_estado <> 'RV'
and   tr_secuencial >0 
and   tr_observacion = 'RENOVACION'
and   tr_fecha_mov BETWEEN @w_fecha_desde and @w_fecha_hasta

select 
dt_secuencial = dtr_secuencial, 
dt_operacion  = dtr_operacion ,
dt_monto      = sum(dtr_monto) 
into  #ca_cob_det 
from  ca_det_trn ,  #ca_cobranzas_batch 
where dtr_secuencial = cb_secuencial
and   dtr_operacion  = cod_interno
and   dtr_concepto not in( 'VAC0')
group by dtr_secuencial, dtr_operacion


update #ca_cobranzas_batch  
set    cb_monto= dt_monto
from   #ca_cob_det
where  dt_secuencial = cb_secuencial
and    cod_interno    =  dt_operacion


update #ca_cobranzas_batch 
set    cb_grupo_id = tg_grupo
from   cob_credito..cr_tramite_grupal
where  tg_operacion = cod_interno


insert into ca_cobranza_batch(
cb_contrato      ,cb_grupo_id             ,cb_fecha_pago,
cb_hora_pago     ,cb_origen_pago          ,cb_monto )
select 
'CONTRATO'       ,'ID GRUPO'              ,'FECHA PAGO' ,
'HORA PAGO'      ,'ORIGEN DE PAGO'        ,'MONTO'                       

if @@error != 0 begin
   select 
   @w_error = 141080,
   @w_msg_error = 'No se pudo insertar cabecera'
   goto ERROR_PROCESO
end

insert into ca_cobranza_batch(
cb_contrato       ,cb_grupo_id       ,cb_fecha_pago,
cb_hora_pago      ,cb_origen_pago    ,cb_monto)													   
select
convert(varchar,a.banco),
convert(varchar,a.grupo),
convert(varchar,b.fecha_proceso, 101),
convert(varchar,substring(convert(varchar,b.fecha_real), 12,8)),
convert(varchar,b.origen_pago),
convert(varchar,a.monto_op)
from #detalle_pagos a,
     #pagos b
WHERE a.secuencial = b.secuencial_id     

if @@error != 0 begin
   select 
   @w_error = 17048,
   @w_msg_error = 'ERROR AL INSERTAR REGISTRO EN TABLA CA_COBRANZA_BATCH'
   goto ERROR_PROCESO
end


--#SE INSERTAN LOS PAGOS PRODUCTOS DE UNA RENOVACION (LA QUE CANCELA EL PRESTAMO ANTERIOR 

insert into ca_cobranza_batch(
cb_contrato       ,cb_grupo_id       ,cb_fecha_pago,
cb_hora_pago      ,cb_origen_pago    ,cb_monto)													   
select  
rtrim(convert(varchar,cb_contrato)),
convert(varchar,cb_grupo_id),
convert(varchar,cb_fecha_pago,101),
convert(varchar,substring(convert(varchar,cb_hora_pago), 12,8)),
convert(varchar,cb_origen_pago),
convert(varchar,cb_monto)
from #ca_cobranzas_batch      

if @@error != 0 begin
   select 
   @w_error = 17048,
   @w_msg_error = 'ERROR AL INSERTAR REGISTRO EN TABLA CA_COBRANZA_BATCH'
   goto ERROR_PROCESO
end

--GENERACION DEL REPORTE 
--FORMATO DE HORAS 
select 
@w_mes   = substring(convert(varchar,@w_fecha_desde, 101),1,2),
@w_dia   = substring(convert(varchar,@w_fecha_desde, 101),4,2),
@w_anio  = substring(convert(varchar,@w_fecha_desde, 101),9,2)


--DATOS DEL ARCHIVO
select 
@w_file_rpt =  ba_arch_resultado,
@w_path     =  ba_path_destino,
@w_fecha_r  =  @w_dia + @w_mes + @w_anio 
from cobis..ba_batch 
where ba_batch = 7592

--ARMADA DEL NOMBRE DEL REPORTE 
select 
@w_file_rpt       = isnull(@w_file_rpt, 'COBRANZA_'),
@w_file_rpt_1     = @w_path + @w_file_rpt + @w_fecha_r + '_' +'.txt',
@w_file_rpt_1_out = @w_path + @w_file_rpt + @w_fecha_r + '_' +'.err'

select @w_cmd     = @w_s_app + 's_app bcp -auto -login cob_cartera..ca_cobranza_batch out '

select @w_comando = @w_cmd  +  @w_file_rpt_1  + ' -b5000 -c -T -e ' + @w_file_rpt_1_out+ ' -t"\t" ' + '-config ' + @w_s_app + 's_app.ini'


exec @w_error = xp_cmdshell @w_comando

if @w_error <> 0 begin
  select 
  @w_return = 70146,
  @w_msg    = 'ERROR: GENERAR LISTADO'
  goto ERROR_PROCESO
end


--ERROR GENERAL DEL PROCESO 
return 0

ERROR_PROCESO:
     select @w_msg = isnull(@w_msg, 'ERROR GENERAL DEL PROCESO')
	 
     exec cob_cartera..sp_errorlog
	 @i_error         = @w_error,
	 @i_usuario       = 'usrbatch',
	 @i_tran          = 26004,
	 @i_tran_name     = null,
	 @i_rollback      = 'S'

     return @w_error

GO

