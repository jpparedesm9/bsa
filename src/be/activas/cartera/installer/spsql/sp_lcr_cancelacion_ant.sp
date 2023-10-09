/************************************************************************/
/*   Archivo:                 sp_lcr_cancelacion_ant.sp					*/
/*   Stored procedure:        sp_lcr_cancelacion_ant					*/
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Agosto 27 de 2017                         */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'COBISCorp'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Permitir la cancelación anticipada de una Línea de Crédito.		*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   27/08/2019 Ariana Larios   Emision Inicial                         */
/*   25/11/2019 ACHP            #129695-Se cambia de sp para los errores*/
/************************************************************************/

use cob_cartera 
go

if not object_id('sp_lcr_cancelacion_ant') is null
   drop proc sp_lcr_cancelacion_ant
go

create proc sp_lcr_cancelacion_ant
@s_user					login       = null,
@s_term					varchar(32) = null,
@s_date					datetime    = null,
@i_banco				varchar(30) = null
as
declare 
@w_error				int,
@w_fecha				datetime,
@w_sp_name				varchar(32),
@w_operacion			varchar(10),
@w_saldo				money ,
@w_pagos				money ,
@w_desembolsos			money ,
@w_moneda				int,
@w_fecha_fin_anterior	datetime,
@w_fecha_ult_proceso	datetime,
@w_referencia			varchar(20),
@w_secuencial			int,
@w_oficina_op			int,
@w_periodo_int			int,
@w_oficial           	int,
@i_num					int


select @w_sp_name='sp_lcr_cancelacion_ant'
select @w_fecha=@s_date

--Recuperamos valores anteriores y comprobamos que sea LCR
select 
	@w_operacion			=	op_operacion,
	@w_fecha_fin_anterior	=	op_fecha_fin, 
	@w_fecha_ult_proceso	=	op_fecha_ult_proceso,
	@w_moneda 				=	op_moneda, 
	@w_oficina_op 			=	op_oficina,
	@w_oficial 				=	op_oficial 
	from cob_cartera..ca_operacion 
	where op_toperacion='REVOLVENTE'
	and op_banco=@i_banco 

	if @w_operacion is null
	begin
	   select @i_num = 70068
	   goto ERROR_FIN
	end
	
	--Verificamos vigencia
	if exists (select  1 from cob_cartera..ca_operacion
	where op_toperacion='REVOLVENTE' 
	and op_fecha_fin<=@w_fecha 
	and op_banco=@i_banco )
	begin
		select @i_num = 70069
		goto ERROR_FIN
	end 

	--Validamos que no exista saldo pendiente de cobro
	select @w_desembolsos = sum(dtr_monto)
	from ca_transaccion, ca_det_trn 
	where tr_operacion  = dtr_operacion  
	and   tr_secuencial = dtr_secuencial
	and   tr_fecha_ref  <= @w_fecha  
	and   tr_tran='DES'
	and   dtr_concepto = 'CAP'
	and   tr_estado <> 'RV'  
	and   tr_secuencial >0   
	and  tr_toperacion='REVOLVENTE'   
	and   tr_operacion = @w_operacion

	--Validamos que no exista saldo pendiente de cobro
	select @w_pagos = sum(dtr_monto)
	from ca_transaccion, ca_det_trn 
	where tr_operacion  = dtr_operacion  
	and   tr_secuencial = dtr_secuencial
	and   tr_fecha_ref  <= @w_fecha  
	and   tr_tran='PAG'
	and   dtr_concepto = 'CAP'
	and   tr_estado <> 'RV'  
	and   tr_secuencial >0   
	and	  tr_toperacion='REVOLVENTE' 
	and tr_operacion = @w_operacion


	if(@w_desembolsos-@w_pagos>0)
	begin 
		select @i_num = 70070
		goto ERROR_FIN
	end
	 
	---------------------------------------------
	
	--Consultamos si existen transacciones pendientes de aplicacion
	if exists(select * from ca_transaccion 
    --where tr_fecha_mov > @w_fecha_ult_proceso  
    where tr_fecha_ref > @w_fecha_ult_proceso  
	and   tr_tran in ('PAG','DES')
	and   tr_estado <> 'RV'  
	and   tr_secuencial >0   
	and	  tr_toperacion='REVOLVENTE' 
	and tr_operacion = @w_operacion)
	begin
		select @i_num = 70071
		goto ERROR_FIN
	end
	
	----------------------------------------------
	
	--NUEVA TRANSACCION DE CUUOTAMIN CLC 
	exec @w_secuencial  = sp_gen_sec
	@i_operacion        = @w_operacion

	-- OBTENER RESPALDO ANTES DE LA CANCELACION ANTICIPADA DE LCR
	exec @w_error  = sp_historial
	@i_operacionca  = @w_operacion,
	@i_secuencial   = @w_secuencial

    --Actualizamos la fecha de vencimiento con la fecha de hoy
	update ca_operacion
	set  op_fecha_fin =@w_fecha
	where op_toperacion='REVOLVENTE' 
	and op_operacion=@w_operacion
	IF @@ERROR <> 0
	BEGIN
		select @i_num = 70073
		goto ERROR_FIN
	END
	
    -- INSERCION DE CABECERA CONTABLE DE CARTERA  (REVISAR FV)
   insert into ca_transaccion(
   tr_fecha_mov,         tr_toperacion,     tr_moneda,
   tr_operacion,         tr_tran,           tr_secuencial,
   tr_en_linea,          tr_banco,          tr_dias_calc,
   tr_ofi_oper,          tr_ofi_usu,        tr_usuario,
   tr_terminal,          tr_fecha_ref,      tr_secuencial_ref,
   tr_estado,            tr_gerente,        tr_gar_admisible,
   tr_reestructuracion,  tr_calificacion,   tr_observacion,
   tr_fecha_cont,        tr_comprobante)
   values(
   @w_fecha,			'REVOLVENTE',        @w_moneda,
   @w_operacion,		'CLC',                @w_secuencial,
   'N',                 @i_banco,             0,
   @w_oficina_op,       @w_oficina_op,        @s_user,
   @s_term,             @w_fecha_ult_proceso, 0, 
   'ING',               @w_oficial,           '',
   'N',                 '',                   'CANCELACION ANTICIPADA DE LCR',
   @s_date,             0)
   
   if @@error <> 0 begin
      select 
      @i_num = 70072
      goto ERROR_FIN
   end
   

return 0
--Si existen errores termina en ERROR_FIN
ERROR_FIN:
begin
    exec sp_errorlog 
    @i_fecha   = @s_date,
    @i_error   = @i_num,--@w_error, 
    @i_usuario = @s_user, 
    @i_tran    = 7999,
    @i_tran_name=@w_sp_name,
    @i_cuenta= @i_banco,--@w_banco,
    @i_rollback = 'S'
	
	return @i_num
end

