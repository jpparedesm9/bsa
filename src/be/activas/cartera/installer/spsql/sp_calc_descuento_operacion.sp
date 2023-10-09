/************************************************************************/
/*  Archivo:                sp_calc_descuento_operacion.sp              */
/*  Stored procedure:       sp_var_tprestamo                            */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           PRO                                         */
/*  Fecha de Documentacion: 02/Jul/2019                                 */
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
/* Este procedimiento calcula el valor de decuento de tasa dada 		*/
/*	la operacion             											*/
/*                                                                      */
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 02/Jul/2019       PRO             	Emision Inicial                 */ 
/* 04/Mar/2020       DCU                #154690                         */
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_calc_descuento_operacion')
	drop proc sp_calc_descuento_operacion
go

create proc [dbo].[sp_calc_descuento_operacion](		
    @i_banco			varchar(64)		= null,
	@o_puntos			int				= null out
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
@w_puntos_descuento		int,
@w_puntos				float,
@w_oper_padre			cuenta,
@w_oper_padre_int		int,
@w_fecha_proceso		datetime,
@w_num_pagos_elavon		int = 0,
@w_tasa_actual			float,
@w_tasa_res				float,
@w_oficina				int,
@w_fecha_desem			datetime

select 	@w_sp_name 		= 	'sp_calc_descuento_operacion',
		@w_separador	=	'|'	
		

exec @w_error = cob_cartera..sp_estados_cca
@o_est_cancelado  = @w_est_cancelado out

select 	@w_operacion 	= 	op_operacion,
		@w_toperacion	= 	op_toperacion,
		@w_promocion	=	op_promocion,
		@w_cliente		= 	op_cliente,
		@w_oficina		= 	op_oficina,
		@w_fecha_desem	=	op_fecha_ini
from ca_operacion
where op_banco	= @i_banco

if @w_toperacion = 'GRUPAL'
begin
   if exists (select 1 from cob_credito..cr_tramite_grupal where tg_referencia_grupal = @i_banco)
   begin
      select @w_promocion = tr_promocion
      from cob_cartera..ca_operacion,
      cob_credito..cr_tramite
      where op_banco   = @i_banco
      and   tr_tramite = op_tramite
   end
   else
   begin
      select @w_promocion = tr_promocion
      from cob_credito..cr_tramite_grupal,
      cob_credito..cr_tramite
      where tg_prestamo  = @i_banco
      and   tr_tramite   = tg_tramite 
   end
end



select @w_promocion = isnull(@w_promocion,'N')

if not exists(SELECT * FROM cobis..cl_catalogo WHERE tabla =(SELECT codigo FROM cobis..cl_tabla WHERE tabla ='ca_descuento_oficina') AND codigo = @w_oficina AND convert(DATETIME,valor)<=@w_fecha_desem)
begin
	print 'OFICINA Y FECHA NO PARAMETRIZADOS TERMINA PROCESO DE CALCULO: Oficina '+convert(varchar(8),@w_oficina)+ ' Fecha: '+convert(varchar(12),@w_fecha_desem,103)
	select @o_puntos = 0
	return 0
end

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

if(@w_toperacion = 'GRUPAL')
begin
	--SE VALIDA SI LA OPERACION ENVIADA ES LA PADRE SINO DE OBTIENE
	if exists(select ci_ciclo from ca_ciclo where ci_operacion =  @w_operacion)
	begin 
		select @w_ciclos = ci_ciclo
		from ca_ciclo
		where ci_operacion =  @w_operacion
		
		select @w_dias_atraso  = max(datediff(dd, di_fecha_ven, case when di_estado = @w_est_cancelado then di_fecha_can else @w_fecha_proceso end))
		from  ca_dividendo
		where di_operacion in (select dc_operacion from ca_det_ciclo where dc_referencia_grupal =@i_banco)
		and   di_fecha_ven < @w_fecha_proceso
		
		EXEC sp_cal_pagos_elavon 
		@i_operacion = @w_operacion,
		@o_num_pagos = @w_num_pagos_elavon OUT
		
		select @w_tasa_actual = ro_porcentaje
		from ca_rubro_op
		where ro_operacion = @w_operacion
		and ro_concepto = 'INT'
	end 
	else
	begin		
		select @w_oper_padre = dc_referencia_grupal from ca_det_ciclo where dc_operacion = @w_operacion
		
		select @w_dias_atraso  = max(datediff(dd, di_fecha_ven, case when di_estado = @w_est_cancelado then di_fecha_can else @w_fecha_proceso end))
		from  ca_dividendo
		where di_operacion in (select dc_operacion from ca_det_ciclo where dc_referencia_grupal =@w_oper_padre)
		and   di_fecha_ven < @w_fecha_proceso		
			
		select @w_oper_padre_int = op_operacion from ca_operacion where op_banco = @w_oper_padre
		select @w_ciclos = ci_ciclo
		from ca_ciclo
		where ci_operacion =  @w_oper_padre_int
		
		EXEC sp_cal_pagos_elavon 
		@i_operacion = @w_oper_padre_int,
		@o_num_pagos = @w_num_pagos_elavon OUT
		
		select @w_tasa_actual = ro_porcentaje
		from ca_rubro_op
		where ro_operacion = @w_oper_padre_int
		and ro_concepto = 'INT'
	end	
end
else if(@w_toperacion = 'INDIVIDUAL')
begin
	select @w_ciclos = count(op_operacion)
	from ca_operacion
	where op_cliente = @w_cliente
	and op_estado	= @w_est_cancelado
end

if(@w_dias_atraso < 0) select  @w_dias_atraso= 0

select @w_valores = @w_toperacion + @w_separador + isnull(@w_promocion,'N') + @w_separador + convert(varchar(4),isnull(@w_dias_atraso,0))+ @w_separador + convert(varchar(3),isnull(@w_num_pagos_elavon,0))+@w_separador+convert(varchar(10),@w_tasa_actual)

print @w_valores

exec  @w_error = cob_pac..sp_rules_param_run
@s_rol                   = 1,
@i_rule_mnemonic         = 'PLREC',
@i_modo                  = 'S',
@i_tipo                  = 'S',
@i_var_values            = @w_valores, 
@i_var_separator         = @w_separador,
@o_return_variable       = @w_variables  out,
@o_return_results        = @w_resultado 	out,
@o_last_condition_parent = @w_parent  	out 

if(@w_error <> 0)
begin
	goto ERROR
end

if(@w_resultado is not null)
begin
	print 'RESULTADO: '+@w_resultado
	select @w_puntos_descuento = convert(int,SUBSTRING(@w_resultado,CHARINDEX(@w_separador,@w_resultado)+1, 1))
	select @w_tasa_res = convert(float,SUBSTRING(@w_resultado,0, CHARINDEX(@w_separador,@w_resultado)))
	
	if(@w_puntos_descuento is null or @w_puntos_descuento <0)
		select @w_puntos_descuento = 0
	
	if(@w_tasa_res is not null and @w_tasa_res <> 0)
		select @w_puntos_descuento = @w_tasa_actual - @w_tasa_res
		
   	print 'Valor de descuento :' + convert(varchar(2),@w_puntos_descuento)

	select @o_puntos = @w_puntos_descuento
end

return 0

ERROR:
exec cobis..sp_cerror 
	  @t_from = @w_sp_name, 
	  @i_num = @w_error, 
	  @i_msg = @w_msg
     
return @w_error

go
