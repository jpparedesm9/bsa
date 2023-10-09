/************************************************************************/
/*  Archivo:                sp_valida_pagos_inc.sp                        */
/*  Stored procedure:       sp_valida_pagos_inc                            */
/*  Base de Datos:          cob_cartera                                 */
/*  Producto:               Cartera                                     */
/*  Disenado por:           PRO                                         */
/*  Fecha de Documentacion: 10/Nov/2020                                 */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*          				PROPOSITO                                   */
/* Valida los pagos para permitir el incremento	   					    */
/*                                                                      */
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 10/11/2020       PRO             	Emision Inicial                 */ 
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_valida_pagos_inc')
	drop proc sp_valida_pagos_inc
go

create proc [dbo].[sp_valida_pagos_inc](		
    @i_operacion		int				,
	@i_con_error		char(1)			='N',
	@o_respuesta		char(1)   		= null out
)

as
declare 
@w_sp_name       		varchar(32),
@w_error            	int,
@w_msg              	descripcion,
@w_operacion			int,
@w_iva					money,
@w_val_descuento 		money,
@w_val_descuento_aux 	money,
@w_operacion_desc   	int,
@w_toperacion			varchar(10),
@w_promocion			char(1),
@w_ciclos				int,
@w_dias_atraso			int,
@w_cliente				int,
@w_est_cancelado		int,
@w_separador			char(1),
@w_valores				varchar(30),
@w_variables			varchar(20),
@w_resultado			varchar(20),
@w_parent				varchar(20),
@w_factor				float,
@w_puntos				float,
@w_oper_padre			cuenta,
@w_oper_padre_int		int,
@w_fecha_proceso		datetime,
@w_pago_minimo			money,
@w_param_umbral 		money,
@w_num_pagos			int,
@w_saldo_capital		money


select 	@w_sp_name 		= 	'sp_valida_pagos_inc',
		@w_separador	=	'|',
		@o_respuesta	=	'S'

select 	@w_operacion 	= 	op_operacion,		
		@w_cliente		= 	op_cliente
from ca_operacion
where op_operacion	= @i_operacion

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_param_umbral = pa_money
   from   cobis..cl_parametro with (nolock)
   where  pa_nemonico = 'LCRUMB'
   and    pa_producto = 'CCA'

select @w_pago_minimo = isnull(sum(am_cuota - am_pagado), 0)
from ca_amortizacion, ca_dividendo
where am_operacion = @w_operacion
and am_operacion   = di_operacion
and am_dividendo   = di_dividendo
and (di_estado     = 2 or (di_estado = 1 and di_fecha_ven = @w_fecha_proceso ))

if @w_pago_minimo = 0 
begin  
-- VALOR A PROYECTAR  EN CASO DE NO EXIGIBLES
 -- PAGO MINIMO 
	 select @w_saldo_capital = sum(am_cuota - am_pagado) 
	 from ca_amortizacion
	 where am_operacion 	= @w_operacion
	 and am_concepto 	= 'CAP'
	 
	 if  @w_saldo_capital < @w_param_umbral select @w_pago_minimo  = @w_saldo_capital 
	 else begin 
		
		EXEC cob_cartera..sp_obtener_factor_pgmin
		@i_operacion =@w_operacion,
		@o_factor = @w_factor OUT
		
		select @w_pago_minimo =  round(@w_saldo_capital*(@w_factor/100), 0) 
		if @w_pago_minimo < @w_param_umbral select @w_pago_minimo = @w_param_umbral		
	 end 
end

SELECT tr_secuencial, tr_operacion, dtr_monto
INTO #pagos
FROM ca_transaccion, ca_det_trn 
WHERE tr_secuencial> (
SELECT max(tr_secuencial) FROM ca_transaccion WHERE tr_operacion=@w_operacion AND tr_secuencial>0 AND tr_tran='DES')
AND dtr_operacion = tr_operacion
AND tr_secuencial = dtr_secuencial
AND dtr_concepto = 'VAC0'
AND tr_tran='PAG'
AND tr_operacion=@w_operacion
AND tr_secuencial >0

SELECT @w_num_pagos = count(*) FROM #pagos
print 'TOTAL PAGOS: '+convert(varchar(10),isnull(@w_num_pagos,0))
print 'PAGO MINIMO: '+convert(varchar(10),isnull(@w_pago_minimo,0))
SELECT @w_num_pagos = count(*) FROM #pagos WHERE dtr_monto >= @w_pago_minimo
print 'TOTAL PAGOS MINIMO: '+convert(varchar(10),isnull(@w_num_pagos,0))
if(@w_num_pagos < 3)
begin
	select @o_respuesta = 'N'
	if(@i_con_error ='N')	return 0
	else
	begin
		select @w_error = 724686
		goto ERROR
	end	
end
return 0

ERROR:
exec cobis..sp_cerror 
	  @t_from = @w_sp_name, 
	  @i_num = @w_error, 
	  @i_msg = @w_msg
     
return @w_error

go
