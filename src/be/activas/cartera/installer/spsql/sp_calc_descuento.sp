/************************************************************************/
/*  Archivo:                sp_calc_descuento.sp                        */
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
/* Este procedimiento ejecuta la regla para obtener los puntos de 		*/
/* descuento y genera el valor a otorgar como descuento	                */
/*                                                                      */
/*                         MODIFICACIONES                               */
/*  FECHA              AUTOR            RAZON                           */
/* 02/Jul/2019       PRO             	Emision Inicial                 */
/* 11/Feb/2021       ACH             	Caso #153921, estado integrante */
/* 18/Jun/2021       DCU                Caso #161035, no aplica REVOL   */
/* 03/Ago/2021       AGO                RQ #162288, no aplica INDIVIDUAL*/
/************************************************************************/

use cob_cartera
go

if exists(select 1 from sysobjects where name ='sp_calc_descuento')
	drop proc sp_calc_descuento
go

create proc [dbo].[sp_calc_descuento](	
	@i_banco			cuenta 			= null,
	@i_opcion			char(1)			= 'C', --C Calcular, I Calcular e insertar
	@o_valor_descuento	money			= null out
)

as
declare 
@w_sp_name       		varchar(32),
@w_error            	int,
@w_msg              	descripcion,
@w_operacion			int,
@w_banco				varchar(64),
@w_tipo					varchar(10),
@w_val_descuento		money,
@w_val_descuento_aux	money,
@w_sig					int,
@w_puntos				int,
@w_padre				int,
@w_op_padre				cuenta,
@w_iva					money,
@w_est_cancelado		int,
@w_grupo				int,
@w_cliente				int,
@w_cuenta				cuenta,
@w_tramite				int,
@w_oficina				int,
@w_es_grupal			char(1),
@w_es_padre				char(1),
@w_total_int			money,
@w_total_iva			money,
@w_presidente			int,
@w_beneficiario			varchar(30),
@w_decimales 			tinyint,
@w_fecha_proceso		datetime,
@w_moneda_op			tinyint,
@w_oficial				int,
@w_secuencial			int,
@w_estado				int,
@w_lista				int,
@w_insertado			char(1),
@w_oper_sec				int,
@w_es_activa			char(1)

declare @w_t_oper_calc	TABLE(
							operacion 	int ,
							banco 		varchar(64),
							cliente		int
						);

select 	@w_sp_name 			= 	'sp_calc_descuento',
		@o_valor_descuento	= 0
		
exec sp_decimales
@i_moneda = 0,
@o_decimales= @w_decimales out

select @w_insertado = 'N', @w_es_activa = 'N'

select 
@w_operacion 	= op_operacion,
@w_tipo			= op_toperacion,
@w_tramite		= op_tramite,
@w_oficina		= op_oficina,
@w_estado		= op_estado
from cob_cartera..ca_operacion
where op_banco	=	@i_banco	

if @w_tipo = 'REVOLVENTE' or @w_tipo = 'INDIVIDUAL' --no aplica LCR , -- no aplica INDIVIDUAL
   return 0

if exists(select * from ca_det_ciclo where dc_operacion = @w_operacion)
begin
	select @w_es_grupal = 'S'
end
if exists(select * from ca_det_ciclo where dc_referencia_grupal = @i_banco)
begin
	select @w_es_grupal = 'S'
	select @w_es_padre  = 'S' 
end
else
begin
	select @w_es_padre  = 'N'
end

if(@i_opcion ='C')
begin
	if(@w_es_padre ='S')
	begin
		if exists (select * from ca_operacion o, ca_det_ciclo dc	where o.op_operacion = dc.dc_operacion and dc_referencia_grupal = @i_banco and op_banco <> @i_banco and op_estado <>3)
		begin
			select @w_es_activa = 'S'
		end
	end
	else if(@w_es_padre = 'N')
	begin
		if exists (select * from ca_operacion where op_banco= @i_banco and op_estado<>3)
		begin
			select @w_es_activa = 'S'
		end
	end
	
	
	if(@w_es_activa <>'S' OR (@w_es_padre<>'S' and @w_estado= 3))
	begin
		select @o_valor_descuento = dd_monto
		from ca_devolucion_descuento
		where dd_operacion = @w_operacion 
		return 0
	end
	
	
end


if(@w_es_padre ='S' and @i_opcion<>'I')
begin
		select @w_op_padre = @i_banco
		
		select @w_padre = op_operacion
		from ca_operacion 
		where op_banco = @w_op_padre

		select @w_lista=count (op_operacion) from 
		ca_operacion o,
		ca_det_ciclo dc
		where 
		o.op_operacion = dc.dc_operacion 
		and dc_referencia_grupal =	@w_op_padre
		and op_banco <> @w_op_padre
		--and op_estado = 1

		if(@w_lista = 0)
		begin
			return 0
		end
end

if(@i_opcion = 'I')
begin
	print 'Calculo Descuento, valida Cancelados'
	exec @w_error = cob_cartera..sp_estados_cca
		@o_est_cancelado  = @w_est_cancelado out	

	if(@w_es_grupal = 'S')
	begin
		select @w_op_padre = dc_referencia_grupal
		from ca_det_ciclo
		where dc_operacion = @w_operacion
		
		select @w_padre = op_operacion
		from ca_operacion 
		where op_banco = @w_op_padre

		select op_operacion, op_estado from 
		ca_operacion o,
		ca_det_ciclo dc
		where 
		o.op_operacion = dc.dc_operacion 
		and dc_referencia_grupal =	@w_op_padre
		and op_banco <> @w_op_padre
		and op_estado <>@w_est_cancelado

		if(@@rowcount > 1)
		begin
			return 0
		end
	end
	else
	begin
		if exists(select * from cob_cartera..ca_operacion 
					where op_banco = @i_banco 
					and op_estado <> @w_est_cancelado)
		begin
			return 0
		end
	end
end

if (@w_es_padre = 'S' or (@w_es_grupal='S' and @i_opcion='I'))
begin

	if(@i_opcion = 'I' and @w_es_padre <>'S')
	begin
		select @i_banco = @w_op_padre
	end	
	
	select 	@w_padre 	= op_operacion,
			@w_grupo	= op_cliente
	from cob_cartera..ca_operacion
	where op_banco	=	@i_banco

	insert into @w_t_oper_calc
	select 	op_operacion, 
			op_banco, 
			op_cliente
	from ca_det_ciclo,
		ca_operacion
	where dc_referencia_grupal = @i_banco
	and op_operacion = dc_operacion
	and op_banco <> @i_banco
	
	select top 1 @w_banco	=	banco 
	from @w_t_oper_calc

	exec @w_error = sp_calc_descuento_operacion
			@i_banco 			= @w_banco,			
			@o_puntos			= @w_puntos out

	if(@w_error <> 0)
	begin
		goto ERROR
	end
end
else
begin
	insert into @w_t_oper_calc
	select op_operacion, op_banco, op_cliente	
	from ca_operacion 
	where op_banco = @i_banco

	exec @w_error = sp_calc_descuento_operacion
			@i_banco 			= @i_banco,			
			@o_puntos			= @w_puntos out

	if(@w_error <> 0)
	begin
		goto ERROR
	end	
end

select @w_iva	= ro_porcentaje/100
from  cob_cartera..ca_rubro_op 
where ro_operacion = @w_operacion
and ro_concepto ='IVA_INT'

if(@w_puntos is not null AND @w_puntos > 0)
begin
	select @w_fecha_proceso = fp_fecha
	from cobis..ba_fecha_proceso

	select 	
	am_operacion, 																	di_dividendo,	sum(am_cuota) as saldo,
	round(convert(money,((sum(am_cuota) *@w_puntos/100)/365)*(case when di_fecha_ini <= @w_fecha_proceso then case when di_fecha_ven<@w_fecha_proceso then DATEDIFF(day, di_fecha_ini,di_fecha_ven) else DATEDIFF(day,di_fecha_ini, @w_fecha_proceso) end else 0 end)),@w_decimales)    	as calculo,	@w_padre as padre,		
	round(convert(money,((sum(am_cuota) *@w_puntos/100)/365)*(case when di_fecha_ini <= @w_fecha_proceso then case when di_fecha_ven<@w_fecha_proceso then DATEDIFF(day, di_fecha_ini,di_fecha_ven) else DATEDIFF(day,di_fecha_ini, @w_fecha_proceso) end else 0 end)*@w_iva),@w_decimales) 	as iva,
	(case when di_fecha_ini <= @w_fecha_proceso then case when di_fecha_ven<@w_fecha_proceso then DATEDIFF(day, di_fecha_ini,di_fecha_ven) else DATEDIFF(day,di_fecha_ini, @w_fecha_proceso) end else 0 end) dias
	into 	#calculo_operaciones
	from 	ca_amortizacion, 
			ca_dividendo 
	where am_operacion in (select operacion from @w_t_oper_calc)
	and am_operacion 	= di_operacion
	and am_dividendo 	>= di_dividendo
	and am_concepto 	= 'CAP'
	and di_estado		in (1,2,3)
	group by di_dividendo, di_dias_cuota,am_operacion,di_fecha_ini, di_estado, di_fecha_can, di_fecha_ven
	
	
	select 	@w_val_descuento 	= sum(calculo) + sum(iva),
			@w_total_int		= sum(calculo),
			@w_total_iva		= sum(iva)
	from #calculo_operaciones	
	
	if exists(select * from ca_devolucion_descuento where dd_operacion_padre= @w_padre)
	begin
		select @w_insertado = 'S'
	end
	
	if(@i_opcion = 'I' and @w_insertado <> 'S')
	begin	
		
		select 	@w_beneficiario = en_nombre+' '+p_p_apellido, 
				@w_cuenta		= ea_cta_banco,
				@w_presidente	= en_ente
		from cobis..cl_cliente_grupo, cobis..cl_ente_aux, cobis..cl_ente
		where cg_grupo=@w_grupo 
		and cg_ente = ea_ente
		and cg_ente	= en_ente
		and ea_ente = en_ente
		and cg_estado = 'V'-- Cs#153921
		and cg_rol= 'P'
		
		begin tran
		
		--SE INSERTA DETALLE DE DESCUENTO A DEVOLVER
		insert into cob_cartera..ca_devolucion_descuento (			
		dd_operacion,			dd_operacion_padre,			dd_oficina,
		dd_tramite,				dd_monto,					dd_monto_int,
		dd_monto_iva,			dd_cuenta,					dd_fecha_registro,
		dd_estado_pago,			dd_ente,					dd_beneficiario,		
		dd_grupo,				dd_estado_notifica,			dd_tasa_descuento,
		dd_fecha_pago,			dd_tipo
		)
		select 	
		am_operacion,			@w_padre,					@w_oficina,
		null,					sum(calculo + iva),			sum(calculo),
		sum(iva),				@w_cuenta,					getDate(),
		'I',					cliente,					en_nombre + ' '+ p_p_apellido,
		@w_grupo,				'I',						@w_puntos,
		null,					'H'
		from #calculo_operaciones, 
			@w_t_oper_calc,
			cobis..cl_ente
		where am_operacion = operacion
		and en_ente = cliente
		group by am_operacion, cliente, en_nombre, p_p_apellido
		
		--SE INSERTA TOTAL A DEVOLVER POR OPERACION AGRUPADORA
		insert into cob_cartera..ca_devolucion_descuento (			
		dd_operacion,			dd_operacion_padre,			dd_oficina,
		dd_tramite,				dd_monto,					dd_monto_int,
		dd_monto_iva,			dd_cuenta,					dd_fecha_registro,
		dd_estado_pago,			dd_ente,					dd_beneficiario,		
		dd_grupo,				dd_estado_notifica,			dd_tasa_descuento,	
		dd_fecha_pago,			dd_tipo
		)values(
		@w_padre,				null,						@w_oficina,
		@w_tramite,				@w_val_descuento,			@w_total_int,
		@w_total_iva,			@w_cuenta,					getDate(),
		'I',					@w_presidente,				@w_beneficiario,
		@w_grupo,				'I',						@w_puntos,
		null,					'P')
		
		--INSERTA TRANSACCION
		select 	@w_tipo 		= op_toperacion,
				@w_moneda_op	= op_moneda,
				@w_oficial		= op_oficial		
		from ca_operacion 
		where op_operacion = @w_padre
		
		select top 1 @w_oper_sec =	operacion
		from @w_t_oper_calc
		
		exec @w_secuencial = sp_gen_sec
        @i_operacion          = @w_oper_sec
		
		insert into ca_transaccion  with (rowlock)(
		tr_fecha_mov,         	tr_toperacion,     	tr_moneda,
		tr_operacion,         	tr_tran,           	tr_secuencial,
		tr_en_linea,          	tr_banco,          	tr_dias_calc,
		tr_ofi_oper,          	tr_ofi_usu,        	tr_usuario,
		tr_terminal,          	tr_fecha_ref,      	tr_secuencial_ref,
		tr_estado,            	tr_gerente,        	tr_gar_admisible,
		tr_reestructuracion,  	tr_calificacion,   	tr_observacion,
		tr_fecha_cont,        	tr_comprobante)
		values(
		@w_fecha_proceso,  	 	@w_tipo,			@w_moneda_op,
		@w_padre,      			'DSC',		       	@w_secuencial,
		'A',		         	@i_banco,          	0,
		@w_oficina,		       	@w_oficina,		   	'usrbatch',
		'consola',	           	@w_fecha_proceso,  	0,
		'ING',               	@w_oficial,        	'',
		'N', 					'',				   	'PAGO POR DESCUENTO DE TASA',
		@w_fecha_proceso,      	0)

		if @@error <> 0 
		begin
			rollback tran
			return 708165 
		end
		
		--SE INSERTA DETALLE DE INT
		insert into ca_det_trn  with (rowlock)(
		dtr_secuencial,    dtr_operacion,  dtr_dividendo,
		dtr_concepto,      dtr_estado,     dtr_periodo,
		dtr_codvalor,      dtr_monto,      dtr_monto_mn,
		dtr_moneda,        dtr_cotizacion, dtr_tcotizacion,
		dtr_afectacion,    dtr_cuenta,     dtr_beneficiario,
		dtr_monto_cont)
		select 
		@w_secuencial, 	   @w_padre,   0,
		'INT',      	   0,     		   0,
		(co_codigo * 1000) + (1*10) + (0), dd_monto_int,      dd_monto_int,
		0,        			1,             'N',
		'C',               dd_ente,     dd_beneficiario,
		0
		from  ca_devolucion_descuento, ca_concepto
		where dd_operacion_padre = @w_padre
		and co_concepto	= 'INT'
			
		if @@error <> 0 
		begin
			rollback tran
			return 708154 
		end
		
		--SE INSERTA DETALLE DE IVA
		insert into ca_det_trn  with (rowlock)(
		dtr_secuencial,    dtr_operacion,  dtr_dividendo,
		dtr_concepto,      dtr_estado,     dtr_periodo,
		dtr_codvalor,      dtr_monto,      dtr_monto_mn,
		dtr_moneda,        dtr_cotizacion, dtr_tcotizacion,
		dtr_afectacion,    dtr_cuenta,     dtr_beneficiario,
		dtr_monto_cont)
		select 
		@w_secuencial, 	   @w_padre,   0,
		'IVA_INT',     	   0,     		   0,
		(co_codigo * 1000) + (1*10) + (0), dd_monto_iva,      dd_monto_iva,
		0,        			1,             'N',
		'C',               dd_ente,		   dd_beneficiario,
		0
		from  ca_devolucion_descuento, ca_concepto
		where dd_operacion_padre = @w_padre
		and co_concepto	= 'IVA_INT'
		
		if @@error <> 0 
		begin
			rollback tran
			return 708154 
		end
		
		--SE INSERTA DETALLE PARA TOTAL
		insert into ca_det_trn  with (rowlock)(
		dtr_secuencial,    dtr_operacion,  dtr_dividendo,
		dtr_concepto,      dtr_estado,     dtr_periodo,
		dtr_codvalor,      dtr_monto,      dtr_monto_mn,
		dtr_moneda,        dtr_cotizacion, dtr_tcotizacion,
		dtr_afectacion,    dtr_cuenta,     dtr_beneficiario,
		dtr_monto_cont)
		select 
		@w_secuencial, 	   @w_padre,   0,
		'SANTANDER',   	   0,     		   0,
		131, 			   dd_monto,      dd_monto,
		0,        			1,             'N',
		'D',               dd_ente,		   dd_beneficiario,
		0
		from  ca_devolucion_descuento
		where dd_operacion = @w_padre
		
		if @@error <> 0 
		begin
			rollback tran
			return 708154 
		end
		
		commit tran
		
	end	

	select @o_valor_descuento = @w_val_descuento
end

return 0

ERROR:
exec cobis..sp_cerror 
	  @t_from = @w_sp_name, 
	  @i_num = @w_error, 
	  @i_msg = @w_msg

return @w_error
go
			