/************************************************************************/
/*   Archivo:              venopera.sp                                  */
/*   Stored procedure:     sp_cambio_estado_vencido                     */
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
/*   Realiza el Traslado de los saldos generando transaccion de CASTIGO */
/************************************************************************/
/*                               CAMBIOS                                */
/*      FECHA          AUTOR            CAMBIO                          */
/*      DIC-07-2016    Raul Altamirano  Emision Inicial - Version MX    */
/*   NOV-2021      Andy G.          Req. 170130 Nuevos Estados CCA      */
/*      ENE-27-2022    D. Cumbal        Caso: 177407                    */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_cambio_estado_vencido')
   drop proc sp_cambio_estado_vencido
go

SET ANSI_NULLS ON
GO


create proc sp_cambio_estado_vencido(
   @s_user                login,
   @s_term                varchar(30),
   @i_operacionca         int,
   @i_etapa_fin           int,
   @o_msg                 varchar(100) = null out) 

as 
declare
@w_return               int,
@w_secuencial           int,
@w_error                int,
@w_estado               int,
@w_di_dividendo         smallint,
@w_dividendo_can        smallint,
@w_dividendo_vig        smallint,
@w_est_cancelado        tinyint,
@w_est_novigente        tinyint,
@w_est_castigado        tinyint,
@w_est_vigente          tinyint,
@w_est_vencido          tinyint,
@w_est_suspenso         tinyint,   
@w_fecha_proceso        datetime,
@w_fecha_ult_proceso    datetime,
@w_moneda               tinyint,
@w_tramite              int,
@w_toperacion           catalogo,
@w_banco                cuenta,
@w_oficina              int,
@w_oficial              int,
@w_commit               char(1),
@w_obervacion           varchar(255),
@w_est_etapa1            int,
@w_est_etapa2            int,
@w_est_etapa3            int,
@w_suspenso              char(1),
@w_est_etapa             int,
@w_observacion           varchar(255),
@w_calificacion         char(1),
@w_est_etapa_ant        int,
@w_pago_sostenido      char(1)   
-- CARGAR VARIABLES DE TRABAJO
select
@w_secuencial    = 0,
@w_commit        = 'N'


--- ESTADOS DE CARTERA 
exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out,
@o_est_cancelado  = @w_est_cancelado out,
@o_est_castigado  = @w_est_castigado out,
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_etapa2     = @w_est_etapa2    out,
@o_est_suspenso   = @w_est_suspenso  out

if @@error <> 0  begin
   select @w_error = 710001, @o_msg = 'NO ENCONTRARON ESTADOS PARA CARTERA'
   goto ERROR_FIN
end



select  
@w_obervacion = '',
@w_suspenso   = 'N',
@w_est_etapa  = 0,
@w_calificacion   = '',
@w_est_etapa_ant = 0



---ETAPA 1 0 A 30 DIAS 
--ETAPA 2 31 A 89 DIAS 
--ETAPA 3 VENCIDO 90 DIAS O MAS  

---PASO A ETAPA 1 A 2 



---PASO A ETAPA 2-3 
if @i_etapa_fin = 2 begin 
   select 
   @w_observacion = 'CAMBIO DE ESTADO A ETAPA 2',  --12
   @w_suspenso    = 'N',
   @w_est_etapa   =  @w_est_etapa2,
   @w_calificacion  = 'A' ,
   @w_est_etapa_ant = @w_est_vigente

end 

--ETAPA 3 
if @i_etapa_fin = 3 begin 
   select 
   @w_observacion = 'CAMBIO DE ESTADO ETAPA 3 (VENCIDO)',  --12
   @w_suspenso    = 'N',
   @w_est_etapa   =  @w_est_vencido,
   @w_calificacion  = 'A' ,
   @w_est_etapa_ant = @w_est_etapa2  

end


select @w_fecha_proceso = fc_fecha_cierre
from   cobis..ba_fecha_cierre
where  fc_producto = 7


select 
@w_fecha_ult_proceso = op_fecha_ult_proceso,
@w_toperacion        = op_toperacion,
@w_moneda            = op_moneda,
@w_banco             = op_banco,
@w_oficina           = op_oficina,
@w_oficial           = op_oficial,
@w_tramite           = op_tramite,
@w_estado            = op_estado
from   ca_operacion
where  op_operacion = @i_operacionca

if @@rowcount = 0                
   return 0
--------------------------------------------------------------
-- VERIFICAR SI TIENE PAGO SOSTENIDO
--------------------------------------------------------------
if @w_estado = @w_est_vencido and @w_est_etapa = @w_est_etapa2
begin
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
end

--------------------------------------------------------------

   
--- GENERAR LA TRANSACCION DE CASTIGO 
exec @w_secuencial = sp_gen_sec
@i_operacion       = @i_operacionca

if @@trancount = 0 begin
   begin tran    -- control de atomicidad
   select @w_commit = 'S'
end

exec @w_error   = sp_historial
@i_operacionca  = @i_operacionca,
@i_secuencial   = @w_secuencial

if @w_error <> 0 
begin
   select @w_error = 724510, @o_msg = 'ERROR SACANDO HISTORICO' 
   goto ERROR_FIN
end



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
'ING',                  @w_observacion,                 @w_oficial,
'',                     '',                             'E',
@w_fecha_proceso,       0)

if @@error <> 0 begin
   select @w_error = 708165, @o_msg = 'ERROR AL REGISTRAR LA TRANSACCION DE CAMBIO DE ESTADO A ETAPA: '+convert(varchar, @i_etapa_fin )  
   goto ERROR_FIN
end


--- REGISTRAR VALORES QUE SALEN DE LOS ESTADOS INICIALES 



insert into ca_det_trn
select 
dtr_secuencial   = @w_secuencial,
dtr_operacion    = @i_operacionca,
dtr_dividendo    = am_dividendo,
dtr_concepto     = am_concepto,
dtr_estado       = case 
                        when (am_estado =@w_est_novigente or (am_estado = @w_est_vigente and di_fecha_ven >= @w_fecha_ult_proceso))then @w_estado 
                        when ( am_estado =@w_est_vigente and @i_etapa_fin =2)  then @w_est_vigente
                        when (am_estado =@w_est_vigente and @i_etapa_fin =3)  then @w_estado
                        when ( am_estado =@w_est_vencido and @i_etapa_fin =3)  then @w_est_etapa2
                        else am_estado end,
                        
dtr_periodo      = 0,
dtr_codvalor     = co_codigo * 1000 + case   
                        when ( am_estado = @w_est_novigente or (am_estado = @w_est_vigente and di_fecha_ven >= @w_fecha_ult_proceso))  then @w_estado * 10
                        when ( am_estado = @w_est_vigente and @i_etapa_fin =2)  then @w_est_vigente * 10 + 1
						when ( am_estado = @w_est_vigente and @i_etapa_fin =3)  then @w_estado * 10 + 1
						when ( am_estado = @w_est_vencido and @i_etapa_fin =3)  then @w_est_etapa2 * 10
                  
                        else am_estado*10 end ,
dtr_monto        = sum(am_acumulado - am_pagado) * -1,  
dtr_monto_mn     = 0,
dtr_moneda       = @w_moneda,
dtr_cotizacion   = 1,
dtr_tcotizacion  = 'N',
dtr_afectacion   = 'D',
dtr_cuenta       = '',
dtr_beneficiario = '',
dtr_monto_cont   = 0
from ca_amortizacion, ca_concepto, ca_dividendo
where am_operacion = @i_operacionca
and   am_estado   <> @w_est_cancelado
and   co_concepto  = am_concepto
and   am_operacion = di_operacion 
and   am_dividendo = di_dividendo
--and  ((@i_etapa_fin = 2 and  am_estado <> @w_est_novigente and di_fecha_ven <= @w_fecha_ult_proceso) or @i_etapa_fin <> 2)
group by am_dividendo, di_fecha_ven, am_concepto, case    
                        when (am_estado  =@w_est_novigente or (am_estado = @w_est_vigente and di_fecha_ven >= @w_fecha_ult_proceso)) then @w_estado 
                        when ( am_estado =@w_est_vigente and @i_etapa_fin =2)  then @w_est_vigente
						when (am_estado =@w_est_vigente and @i_etapa_fin =3)  then @w_estado
                        when ( am_estado =@w_est_vencido and @i_etapa_fin =3)  then @w_est_etapa2
                        else am_estado end,
         co_codigo * 1000 + case   
                        when (am_estado =@w_est_novigente or (am_estado = @w_est_vigente and di_fecha_ven >= @w_fecha_ult_proceso)) then @w_estado * 10
                        when (am_estado =@w_est_vigente and @i_etapa_fin =2)  then @w_est_vigente* 10 + 1
                        when (am_estado =@w_est_vigente and @i_etapa_fin =3)  then @w_estado * 10 + 1
                        when ( am_estado =@w_est_vencido and @i_etapa_fin =3)  then @w_est_etapa2*10
                        else am_estado*10 end 
having sum(am_acumulado - am_pagado) > 0


if @@error <> 0  begin
   select @w_error = 708165, @o_msg = 'ERROR AL REGISTRAR DETALLES EN ESTADO ACTUAL'
   goto ERROR_FIN
end





insert into ca_det_trn
select 
dtr_secuencial   = @w_secuencial,
dtr_operacion    = @i_operacionca,
dtr_dividendo    = am_dividendo,
dtr_concepto     = am_concepto,
dtr_estado       = @w_est_etapa,
dtr_periodo      = 0,
dtr_codvalor     = co_codigo * 1000 + @w_est_etapa * 10,
dtr_monto        = sum(am_acumulado - am_pagado),  
dtr_monto_mn     = 0,
dtr_moneda       = @w_moneda,
dtr_cotizacion   = 1,
dtr_tcotizacion  = 'N',
dtr_afectacion   = 'D',
dtr_cuenta       = '',
dtr_beneficiario = '',
dtr_monto_cont   = 0
from ca_amortizacion, ca_concepto, ca_dividendo
where am_operacion = @i_operacionca
and   am_estado   <> @w_est_cancelado
and   co_concepto  = am_concepto
and   am_operacion = di_operacion 
and   am_dividendo = di_dividendo
--and  ((@i_etapa_fin = 2 and am_estado <> @w_est_novigente and di_fecha_ven <= @w_fecha_ult_proceso) or @i_etapa_fin <> 2)
group by am_dividendo, am_concepto,
         co_codigo * 1000 +  @w_est_etapa  * 10
having sum(am_acumulado - am_pagado) > 0

if @@error <> 0  begin
   select @w_error = 708165, @o_msg = 'ERROR AL REGISTRAR DETALLES EN NUEVO ESTADO'
   goto ERROR_FIN
end



update ca_operacion set    
op_estado           = @w_est_etapa,
op_suspendio        = @w_suspenso,
op_fecha_suspenso   = @w_fecha_ult_proceso
where  op_operacion = @i_operacionca

if @@error <> 0  begin
   select @w_error = 710003, @o_msg = 'ERROR AL ACTUALIZAR DATOS DE OPERACION'
   goto ERROR_FIN
end

if @w_est_etapa <> @w_est_etapa2 
begin
   -- BUSCAR EL MENOR DIVIDENDO NO CANCELADO
   select @w_di_dividendo = isnull(min(di_dividendo),-999)
   from   ca_dividendo
   where  di_operacion  = @i_operacionca
   and    di_estado    in (@w_est_vencido, @w_est_vigente)
   
   select @w_dividendo_can = isnull(max(di_dividendo),0)
   from   ca_dividendo
   where  di_operacion = @i_operacionca
   and    di_estado    = @w_est_cancelado   
   
   select @w_dividendo_vig = isnull(max(di_dividendo),-1)
   from   ca_dividendo
   where  di_operacion = @i_operacionca
   and    di_estado    = @w_est_vigente
   
   select am.* into #moras
   from ca_amortizacion am, 
     ca_rubro_op
   where am_operacion = @i_operacionca
   and   am_dividendo > @w_dividendo_can
   and   ro_operacion = @i_operacionca
   and   ro_provisiona  = 'S'
   and   ro_tipo_rubro  = 'M'
   and   ro_concepto    = am_concepto

   select am.* into #intereses
   from ca_amortizacion am, 
     ca_rubro_op
   where am_operacion = @i_operacionca
   and   am_dividendo = @w_dividendo_vig
   and   ro_operacion = @i_operacionca
   and   ro_provisiona  = 'S'
   and   ro_tipo_rubro  = 'I'
   and   ro_concepto    = am_concepto
   
   update #moras set
   am_secuencia = am_secuencia + 1,
   am_cuota     = 0,
   am_acumulado = 0,
   am_estado    =  @w_est_suspenso 
   
   if @@error <> 0  begin
   select @w_error = 710002, @o_msg = 'ERROR AL ACTUALIZAR DATOS DE MORAS EN TEMPORAL'
   goto ERROR_FIN
   end
   
   update #intereses set
   am_secuencia = am_secuencia + 1,
   am_cuota     = am_cuota - am_acumulado,
   am_acumulado = 0,
   am_pagado    = case when am_pagado > am_acumulado then am_pagado - am_acumulado else 0 end,
   am_gracia    = case when am_gracia > am_acumulado then am_gracia - am_acumulado else 0 end,
   am_estado    =  @w_est_suspenso
   
   if @@error <> 0  begin
   select @w_error = 710002, @o_msg = 'ERROR AL ACTUALIZAR DATOS DE INTERESES EN TEMPORAL'
   goto ERROR_FIN
   end
   
   delete #intereses 
   where am_cuota <= 0
   
   if @@error <> 0  begin
   select @w_error = 710003, @o_msg = 'ERROR AL ELIMINAR DATOS DE INTERESES EN TEMPORAL'
   goto ERROR_FIN
   end
   
   update ca_amortizacion set
   am_estado = case 
               when ro_provisiona = 'N' then @w_est_vencido
               when ro_provisiona = 'S'  and am_estado = @w_est_vigente then @w_est_vencido
               else am_estado
            end
   from  ca_rubro_op
   where am_operacion = @i_operacionca
   and   am_dividendo > @w_dividendo_can
   and   (am_acumulado - am_pagado) > 0
   and   ro_operacion = @i_operacionca
   and   ro_concepto  = am_concepto   
   
   if @@error <> 0  begin
   select @w_error = 710002, @o_msg = 'ERROR AL ACTUALIZAR DATOS DE RUBROS EN TEMPORAL'
   goto ERROR_FIN
   end
   
   update ca_amortizacion set
   am_cuota  = am_acumulado,
   am_pagado = case when am_pagado > am_acumulado then am_acumulado else am_pagado end,
   am_gracia = case when am_gracia > am_acumulado then am_acumulado else am_gracia end
   from  ca_rubro_op
   where am_operacion = @i_operacionca
   and   am_dividendo = @w_dividendo_vig
   and   ro_operacion = @i_operacionca
   and   ro_provisiona  = 'S'
   and   ro_tipo_rubro  = 'I'
   and   ro_concepto    = am_concepto
   
   if @@error <> 0  begin
   select @w_error = 710002, @o_msg = 'ERROR AL ACTUALIZAR DATOS DE INTERESES EN TEMPORAL'
   goto ERROR_FIN
   end

   update ca_amortizacion set
   am_cuota  = am_acumulado
   from  ca_rubro_op
   where am_operacion = @i_operacionca
   and   am_dividendo > @w_dividendo_can
   and   ro_operacion = @i_operacionca
   and   ro_provisiona  = 'S'
   and   ro_tipo_rubro  = 'M'
   and   ro_concepto    = am_concepto
   
   if @@error <> 0  begin
   select @w_error = 710002, @o_msg = 'ERROR AL ACTUALIZAR DATOS DE MORAS EN TEMPORAL'
   goto ERROR_FIN
   end   
   
   insert into ca_amortizacion(
   am_operacion,   am_dividendo,   am_concepto,
   am_estado,      am_periodo,     am_cuota,
   am_gracia,      am_pagado,      am_acumulado,
   am_secuencia)
   select 
   am_operacion,   am_dividendo,   am_concepto,
   am_estado,      am_periodo,     am_cuota,
   am_gracia,      am_pagado,      am_acumulado,
   am_secuencia
   from #moras
   
   if @@error <> 0  begin
   select @w_error = 710001, @o_msg = 'ERROR AL INGRESAR DATOS DE MORAS DESDE TEMPORAL A DEFINITIVA'
   goto ERROR_FIN
   end
   
   insert into ca_amortizacion(
   am_operacion,   am_dividendo,   am_concepto,
   am_estado,      am_periodo,     am_cuota,
   am_gracia,      am_pagado,      am_acumulado,
   am_secuencia)
   select 
   am_operacion,   am_dividendo,   am_concepto,
   am_estado,      am_periodo,     am_cuota,
   am_gracia,      am_pagado,      am_acumulado,
   am_secuencia
   from #intereses
   
   if @@error <> 0  begin
   select @w_error = 710001, @o_msg = 'ERROR AL INGRESAR DATOS DE INTERESES DESDE TEMPORAL A DEFINITIVA'
   goto ERROR_FIN
   end
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