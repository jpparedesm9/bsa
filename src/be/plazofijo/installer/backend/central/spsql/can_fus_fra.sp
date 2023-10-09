/************************************************************************/
/*      Archivo:                canfufra.sp                             */
/*      Stored procedure:       sp_can_fus_fra                          */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Ximena cartagena U                      */
/*      Fecha de documentacion: 12/May/2000                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Realizar la Cancelacion de todas y cada una de las operaciones  */
/*      que fueron Fusionadas o Fraccionadas                            */
/*      En la tabla PF_CANCELACION se insertan las operaciones que      */
/*      deben ser canceladas.                                           */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*   FECHA         AUTOR                 RAZON                          */
/*   12/May/00  Ximena Caratagena U      Emision Inicial                */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_can_fus_fra')
   drop proc sp_can_fus_fra
go

create proc sp_can_fus_fra (
@s_ssn              integer        = NULL,
@s_user             login          = NULL,
@s_sesn             integer        = NULL,
@s_term             varchar(30)    = NULL,
@s_date             datetime       = NULL,
@s_srv              varchar(30)    = NULL,
@s_lsrv             varchar(30)    = NULL,
@s_ofi              integer        = NULL,
@s_rol              integer        = NULL,
@t_debug            char(1)        = 'N',
@t_file             varchar(10)    = NULL,
@t_from             varchar(32)    = NULL,
@t_trn              smallint       = NULL,
@i_operacion        char(1)        = NULL,
@i_observacion	    descripcion    = null,
@i_operacion_can    int            = 0 )
with encryption
as
declare
@w_sp_name           varchar(32),
@w_return                int,
@w_numdeci               int,
@w_usadeci               char(1),
@w_toperacion            catalogo,
@w_num_banco             cuenta,
@w_operacion             int,
@w_moneda                tinyint,
@w_pignorado             char(1),
@w_monto_blq             money,
@w_cancela               char(1),
@w_ente                  int,
@w_fpago                 catalogo,
@w_fecha_ven             datetime,
@w_fecha_pg_int          datetime,
@w_fecha_ult_pg_int      datetime,
@w_accion_sgte           varchar(4),
@w_estado_op             catalogo,
@w_causa_mod             varchar(10),
@w_comentario            varchar(60),
@w_valor                 money,
@w_monto_pg_int          money,
@w_int_ganado            money,
@w_int_pagados           money,
@w_int_vencido           money,
@w_total_int_pagados     money,
@w_fecha_mod             datetime,
@w_oficina               int,
@w_oficina_ant           int,
@w_historia              int,
@w_secuencial            int,   
@w_cuota                 tinyint

select   @w_sp_name =  'sp_can_fus_fra'


/* Verificar Control del Numero de Transaccion enviado por el FrontEnd */
if @t_trn <> 14954
begin
	exec cobis..sp_cerror
		@t_debug     = @t_debug,
		@t_file      = @t_file,
		@t_from      = @w_sp_name,
		@i_num       = 141112
	return 1
end      
    
/* Control de error para la Operacion */
if @i_operacion <> 'I'
begin
	/* Operacion no existe */
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 141004
	return 1
end 

begin tran	--**************************************************************************************************

/* INSERCION de los CDTs cancelados en PF_CANCELACION */
select 	@w_operacion = 0,
	@w_secuencial = 1,
	@w_historia= 0  

select  @w_operacion  = cn_operacion
from  pf_cancelacion_tmp
where  cn_usuario = @s_user
	and  cn_sesion = @s_sesn
	and  cn_operacion = @i_operacion_can
order by  cn_tsecuencial

if @@rowcount = 0 
begin
	exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
			@t_from  = @w_sp_name, @i_num   = 141051
	return 1
end 

select 	@w_num_banco = op_num_banco,
	@w_oficina = op_oficina,
	@w_moneda = op_moneda,
	@w_ente = op_ente,
	@w_valor = op_monto,
	@w_fpago = op_fpago,
	@w_fecha_ven = op_fecha_ven,
	@w_toperacion = op_toperacion,
	@w_fecha_pg_int = op_fecha_pg_int,
	@w_estado_op = op_estado,
	@w_oficina_ant = op_oficina,
	@w_monto_pg_int = op_monto_pg_int,
	@w_fecha_ult_pg_int = op_fecha_ult_pg_int,
	@w_int_ganado = op_int_ganado,
	@w_int_pagados = op_int_pagados,
	@w_total_int_pagados = op_total_int_pagados,
	@w_fecha_mod = op_fecha_mod,
	@w_pignorado = op_pignorado,
	@w_monto_blq = op_monto_blq,
	@w_accion_sgte = op_accion_sgte
from pf_operacion
where op_operacion = @w_operacion

if @@rowcount = 0 
begin
	exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
				@t_from  = @w_sp_name, @i_num   = 141051
	return 1
end


select  @w_usadeci  = mo_decimales
from cobis..cl_moneda
where mo_moneda = @w_moneda

if @w_usadeci = 'S'
begin 
	select @w_numdeci = isnull (pa_tinyint,0)
	from cobis..cl_parametro
	where pa_nemonico = 'DCI'
		and pa_producto = 'PFI'
end
else
	select @w_numdeci = 0   

select @w_cancela = 'S'

if (@w_pignorado = 'S') or (@w_monto_blq > 0) or (@w_estado_op <> 'ACT') 
begin
	select @w_cancela = 'N'
	print 'Pignorado: ' + cast( @w_pignorado as varchar)+', Bloq: '+ cast( @w_monto_blq as varchar)+', Estado: '+ cast( @w_estado_op as varchar) 
	exec cobis..sp_cerror @t_debug = @t_debug,
	                  @t_file  = @t_file,
	                  @t_from  = @w_sp_name,
	                  @i_num   = 141031
	return 1
end           
   
if @w_accion_sgte is null  or @w_accion_sgte = 'NULL'
	select @w_accion_sgte = 'NULL'
else
begin
	select @w_cancela = 'N'
	exec cobis..sp_cerror @t_debug  = @t_debug,
	                  @t_file   =  @t_file,
	                  @t_from   =  @w_sp_name,
	                  @i_num    =  141031
	return 1
end

select @w_int_vencido = 0
        
/* INSERCION Definitiva en PF_CANCELACION */
if @w_cancela = 'S' 
begin 
	insert into pf_cancelacion (ca_operacion, ca_secuencial, ca_secpin,
		ca_funcionario, ca_oficina, ca_pen_monto, ca_pen_porce,
		ca_solicitante, ca_tipo, ca_estado, ca_fpago, ca_fecha_ven, 
		ca_fecha_pg_int, ca_accion_sgte, ca_estado_op, ca_autorizado, 
		ca_comentario, ca_valor, ca_fecha_crea, ca_monto_pg_int, 
		ca_int_ganado, ca_int_pagados, ca_int_vencido, 
		ca_total_int_pagados, ca_fecha_ult_pg_int, ca_fecha_mod,
		ca_oficina_ant)
	values (@w_operacion, @w_secuencial, null, @s_user, @s_ofi, null,
		null,  @w_ente, 'F', 'I', @w_fpago, @w_fecha_ven, 
		@w_fecha_pg_int, @w_accion_sgte, @w_estado_op, null, null, 
		@w_valor, @s_date, @w_monto_pg_int, @w_int_ganado, 
		@w_int_pagados,  @w_int_vencido, @w_total_int_pagados, 
		@w_fecha_ult_pg_int, @w_fecha_mod, @w_oficina_ant)            
	/* Si no se puede insertar, error */
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 143039
		return 1
	end
        

        /*Actualiza estado de producto en cl_det_producto*/

        update cobis..cl_det_producto 
          set dp_estado_ser = 'C'
         from pf_operacion, cobis..cl_det_producto
        where op_num_banco = dp_cuenta 
	 and op_num_banco = @w_num_banco            
	 and dp_producto = 14
        
        if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 143064
		return 1
	end

       
	/* INSERCION De La Transaccion de Servicio */
	insert into ts_cancelacion (secuencial, tipo_transaccion, clase, 
		fecha, usuario, terminal, srv, lsrv, operacion, funcionario, 
		oficina, pen_monto, pen_porce, secuencia, solicitante, 
		tipo, estado, comentario, fecha_crea, fpago, fecha_ven, 
		fecha_pg_int, accion_sgte, estado_op, autorizado, fecha_mod, valor)
	values(@s_ssn, @t_trn, 'N', @s_date, @s_user, @s_term, 
		@s_srv, @s_lsrv, @w_operacion, @s_user, @s_ofi, null, 
		null, null, @w_ente, 'F', 'I', null, @s_date, @w_fpago, @w_fecha_ven,
		@w_fecha_pg_int, @w_accion_sgte, @w_estado_op, null, @s_date, 
		@w_valor)
	/* Si no se puede insertar, error */
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 143005
		return 1
	end

	/* CONSULTA del Numero de la Historia si existe */
	select @w_historia  = max(hi_secuencial)
	from pf_historia
	where hi_operacion = @w_operacion
            
	/* Asignacion De Valores */
	select 	@w_historia = @w_historia + 1,
		@w_estado_op = 'CAN',
		@w_causa_mod = 'CAN'            
           
	/* ACTUALIZACION De PF_OPERACION */                 
	update pf_operacion
	set 	op_accion_sgte = @w_accion_sgte,
		op_mon_sgte = op_mon_sgte + 1,
		op_fecha_mod = @s_date,
		op_historia = op_historia + 1,
		op_estado = @w_estado_op, 
		op_fecha_cancela = @s_date,
		--op_fecha_pg_int = @s_date,
		op_causa_mod = @w_causa_mod
	where op_operacion = @w_operacion
	/* Si no se puede modificar, error */
	if @@rowcount <> 1
	begin
		exec cobis..sp_cerror
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 145001
		return 1
	end         

	/* Insercion Transaccion de Servicio */            
	insert into ts_operacion (secuencial, tipo_transaccion, clase, fecha, 
		usuario, terminal, srv, lsrv, accion_sgte, fecha_mod)
	values (@s_ssn, @t_trn, 'N', @s_date, @s_user, @s_term, 
		@s_srv, @s_lsrv, @w_accion_sgte, @w_fecha_mod)
	if @@error <> 0
	begin
		exec cobis..sp_cerror 	@t_debug=@t_debug,@t_file=@t_file,
					@t_from=@w_sp_name,   @i_num = 143005
		return 1
	end

	/* Insercion De la Historia en PF_HISTORIA */                
	insert into pf_historia (hi_operacion, hi_secuencial, hi_fecha, 
		hi_trn_code, hi_valor, hi_funcionario, hi_oficina, hi_fecha_crea, 
		hi_fecha_mod, hi_observacion)
	values (@w_operacion, @w_historia, @s_date, 14953, @w_monto_pg_int, 
		@s_user, @s_ofi, @s_date, @s_date, @i_observacion)
	if @@error <> 0
	begin
		exec cobis..sp_cerror 	@t_debug=@t_debug,@t_file=@t_file,
					@t_from=@w_sp_name,   @i_num = 143006
		return 1
	end

	--Actualizacion de cuotas  a F = FRACCIONADO
	update pf_cuotas
	set cu_estado = 'F'
	where cu_operacion = @w_operacion
	and cu_estado = 'V'

end --fin de @w_cancela = 'S'

commit tran	--*************************************************************************************************
return 0
go

