use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cambio_estado_vigente')
   drop proc sp_cambio_estado_vigente
go

/************************************************************************/
/*   Archivo:              vigopera.sp                                  */
/*   Stored procedure:     sp_cambio_estado_vigente                     */
/*   Base de datos:        cob_cartera                                  */
/*   Producto:             Credito y Cartera                            */
/*   Disenado por:         Raul Altamirano Mendez                       */
/*   Fecha de escritura:   Dic-08-2016                                  */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Realiza el Traslado de los saldos a Vigentes generando transaccion */
/*   respectiva                                                         */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-07-2016    Raul Altamirano  Emision Inicial - Version MX    */
/*      19/01/2022     D Cumbal         Cambio: 170130                  */
/************************************************************************/  
SET ANSI_NULLS ON
GO

create proc sp_cambio_estado_vigente(
   @s_user          login,
   @s_term          varchar(30),
   @i_operacionca   int,
   @o_msg           varchar(100) = null out
)as 

declare
@w_sp_name           varchar(64),
@w_return            int,
@w_secuencial        int,
@w_error             int,   
@w_pago_sostenido    char(1),   
@w_estado            int,
@w_est_cancelado     tinyint,
@w_est_novigente     tinyint,   
@w_est_vigente       tinyint,
@w_est_vencido       tinyint,   
@w_fecha_proceso     datetime,
@w_fecha_ult_proceso datetime,
@w_calificacion      char(1),
@w_moneda            tinyint,   
@w_toperacion        catalogo,
@w_banco             cuenta,
@w_oficina           int,
@w_oficial           int,
@w_commit            char(1),
@w_est_etapa2        int

select 
@w_sp_name 	   = 'sp_cambio_estado_vigente',
@w_secuencial  = 0,       
@w_commit      = 'N'	   

-- VERIFICAR SI TIENE PAGO SOSTENIDO
exec @w_error  = sp_verifica_pago_sostenido_op 
@i_operacion   = @i_operacionca,
@o_psostenido  = @w_pago_sostenido out

if @w_error <> 0
begin
   select @w_error  = 722109,
		  @o_msg    = 'ERROR AL OBTENER INDICADOR DE PAGO SOSTENIDO' 
   goto ERROR_FIN
end

if @w_pago_sostenido = 'N'
begin
   select @w_error  = 0,
		  @o_msg    = 'Cliente NO ha realizado el pago requerido' 
   return @w_error
end

--FECHA DE PROCESO
select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7
 
--OBTIENE DATOS DE LA OPERACION
select 
@w_toperacion        = op_toperacion,
@w_moneda            = op_moneda,
@w_banco             = op_banco,
@w_oficina           = op_oficina,
@w_oficial           = op_oficial,       
@w_estado            = op_estado,
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_calificacion      = op_calificacion
from  ca_operacion
where op_operacion = @i_operacionca

if @@rowcount = 0                
begin
	select @w_error = 701025, 
		   @o_msg = 'NO EXISTE OPERACION' 
	goto ERROR_FIN
end   
	   
--- ESTADOS DE CARTERA 
exec @w_error     = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_etapa2     = @w_est_etapa2    out 

if @w_error <> 0                
begin
	select @w_error = 710217, 
		   @o_msg = 'NO ENCONTRO ESTADO VENCIDO/VIGENTE PARA CARTERA ' 
	goto ERROR_FIN
end

--GENERAR HISTORIAL DE TRN
exec @w_secuencial = sp_gen_sec
@i_operacion       = @i_operacionca 

if @@trancount = 0 
begin
   begin tran
   select @w_commit = 'S'
end
	 
exec @w_error   = sp_historial
@i_operacionca  = @i_operacionca,
@i_secuencial   = @w_secuencial

if @w_error <> 0 
begin
   select @w_error = 710269, 
		  @o_msg = 'ERROR SACANDO HISTORICO' 
   goto ERROR_FIN
end

--TRANSACCION CAMBIO DE ESTADO
insert into ca_transaccion(
tr_secuencial,          tr_fecha_mov,                   tr_toperacion,
tr_moneda,              tr_operacion,                   tr_tran,
tr_en_linea,            tr_banco,                       tr_dias_calc,
tr_ofi_oper,            tr_ofi_usu,                     tr_usuario,
tr_terminal,            tr_fecha_ref,                   tr_secuencial_ref,
tr_estado,              tr_observacion,                 tr_gerente,
tr_gar_admisible,       tr_reestructuracion,            tr_calificacion,
tr_fecha_cont,          tr_comprobante)  
values(
@w_secuencial,          @w_fecha_proceso,               @w_toperacion,
@w_moneda,              @i_operacionca,                 'EST',
'N',                    @w_banco,                       0,
@w_oficina,             @w_oficina,                     @s_user,
@s_term,                @w_fecha_ult_proceso,           0,
'ING',                 	'CAMBIO ESTADO A VIGENTE'		,@w_oficial,
'',                     '',                             isnull(@w_calificacion, 'B'),
@w_fecha_proceso,       0)

if @@error <> 0 
begin
   select @w_error = 708165, 
		  @o_msg = 'ERROR AL REGISTRAR LA TRANSACCION CAMBIO DE ESTADO VENCIDO A VIGENTE ' 
   goto ERROR_FIN
end

-- REGISTRAR VALORES QUE SALEN DE LOS ESTADOS INICIALES 
--PRIMER DETALLE
insert into ca_det_trn
select 
dtr_secuencial   = @w_secuencial,
dtr_operacion    = @i_operacionca,
dtr_dividendo    = am_dividendo,
dtr_concepto     = am_concepto,
dtr_estado       = am_estado,
dtr_periodo      = 0,
dtr_codvalor     = co_codigo * 1000 + case when @w_est_etapa2 = @w_estado then @w_est_etapa2 * 10 else am_estado * 10 end,
dtr_monto        = sum(am_acumulado - am_pagado) * -1,
dtr_monto_mn     = 0,
dtr_moneda       = @w_moneda,
dtr_cotizacion   = 1,
dtr_tcotizacion  = 'N',
dtr_afectacion   = 'D',
dtr_cuenta       = '',
dtr_beneficiario = '',
dtr_monto_cont   = 0
from ca_amortizacion, ca_concepto
where am_operacion = @i_operacionca
and   am_estado   <> @w_est_cancelado
and   co_concepto  = am_concepto
group by am_dividendo, am_concepto, 
		 am_estado,
		 co_codigo * 1000 + case when @w_est_etapa2 = @w_estado then @w_est_etapa2 * 10 else am_estado * 10 end
having sum(am_acumulado - am_pagado) > 0

if @@error <> 0  begin
   select @w_error = 708165, 
          @o_msg = 'ERROR AL REGISTRAR DETALLES DE TRANSACCION'
   goto ERROR_FIN
end

--SEGUNDO DETALLE
insert into ca_det_trn
select 
dtr_secuencial   = @w_secuencial,
dtr_operacion    = @i_operacionca,
dtr_dividendo    = am_dividendo,
dtr_concepto     = am_concepto,
dtr_estado       = @w_est_vigente,
dtr_periodo      = 0,
dtr_codvalor     = (co_codigo * 1000 + @w_est_vigente * 10),
dtr_monto        = sum(am_acumulado - am_pagado),
dtr_monto_mn     = 0,
dtr_moneda       = @w_moneda,
dtr_cotizacion   = 1,
dtr_tcotizacion  = 'N',
dtr_afectacion   = 'D',
dtr_cuenta       = '',
dtr_beneficiario = '',
dtr_monto_cont   = 0
from ca_amortizacion, ca_concepto
where am_operacion = @i_operacionca
and   am_estado   <> @w_est_cancelado
and   co_concepto  = am_concepto
group by am_dividendo, am_concepto, (co_codigo * 1000 + @w_est_vigente * 10)
having sum(am_acumulado - am_pagado) > 0

if @@error <> 0  begin
   select @w_error = 708165, 
          @o_msg = 'ERROR AL REGISTRAR DETALLES DE TRANSACCION'
   goto ERROR_FIN
end

--- CAMBIAR DE ESTADO AL RUBRO DE LA OPERACION 
update ca_amortizacion set 
am_estado = case 
              when di_estado = @w_est_novigente then @w_est_novigente
              else @w_est_vigente
            end
from ca_dividendo
where am_operacion = di_operacion
and   am_dividendo = di_dividendo
and   am_operacion = @i_operacionca
and   am_estado   <> @w_est_cancelado

if @@error <> 0  begin
   select @w_error = 705050,
		  @o_msg = 'ERROR AL ACTUALIZAR EL ESTADO DE LOS RUBROS DE LA OPERACION '
   goto ERROR_FIN
end

--- UNIFICAR RUBROS INNECESARIAMENTE SEPARADOS 
select 
operacion = am_operacion,
dividendo = am_dividendo,
concepto  = am_concepto,
secuencia = min(am_secuencia),
cuota     = isnull(sum(am_cuota),     0.00),
gracia    = isnull(sum(am_gracia),    0.00),
acumulado = isnull(sum(am_acumulado), 0.00),
pagado    = isnull(sum(am_pagado),    0.00)
into #para_juntar
from   ca_amortizacion
where  am_operacion = @i_operacionca
and    am_estado   <> @w_est_cancelado
group by am_operacion, am_dividendo, am_concepto, am_estado

if @@error <> 0  begin
   select @w_error = 710001, 
		  @o_msg = 'ERROR AL GENERAR TABLA DE TRABAJO para_juntar '
   goto ERROR_FIN
end
   
update ca_amortizacion set
am_cuota     = cuota,
am_gracia    = gracia,
am_acumulado = acumulado,
am_pagado    = pagado
from   #para_juntar
where  am_operacion = operacion
and    am_dividendo = dividendo
and    am_concepto  = concepto
and    am_secuencia = secuencia

if @@error <> 0  
begin
   select @w_error = 705050, 
          @o_msg   = 'ERROR AL ACTUALIZAR LOS SALDOS DE LOS RUBROS UNIFICADOS' 
   goto ERROR_FIN
end
   
delete ca_amortizacion
from   #para_juntar
where  am_operacion  = operacion
and    am_dividendo  = dividendo
and    am_concepto   = concepto
and    am_secuencia  > secuencia
and    am_estado    <> @w_est_cancelado

if @@error <> 0  begin
   select @w_error = 710003, 
		  @o_msg = 'ERROR AL ELIMINAR REGISTROS UNIFICADOS' 
   goto ERROR_FIN
end

--CAMBIO DE ESTADO DE LA OPERACION A VIGENTE
update ca_operacion set op_estado = @w_est_vigente
where op_operacion = @i_operacionca

if @@error <> 0 
begin
   select @w_error = 705076, 
		  @o_msg = 'ERROR AL ACTUALIZAR ESTADO DE LA OPERACION' 
   goto ERROR_FIN
end

if @w_commit = 'S' begin 
   commit tran
   select @w_commit = 'N'
end
return 0

ERROR_FIN:
if @w_commit = 'S'
   rollback tran
   
return @w_error


GO
