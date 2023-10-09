/************************************************************************/
/*   Archivo:             sol_rep_reg.sp                                */
/*   Stored procedure:    sp_solicitud_reportes_reg                     */
/*   Base de datos:       cob_conta		                                */
/*   Producto:            Contabilidad                                  */
/*   Disenado por:        Pedro Montenegro                              */
/*   Fecha de escritura:  Septiembre.2017.                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                              PROPOSITO                               */
/*   Generar el mantenimiento para de la solicitud de generacion de		*/
/*   reportes regulatorios												*/
/************************************************************************/
/*                               MODIFICACIONES                         */
/*  FECHA              AUTOR          CAMBIO                            */
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_solicitud_reportes_reg')
   drop proc sp_solicitud_reportes_reg
go

create proc sp_solicitud_reportes_reg
(
	@s_ssn		   int			= null,
	@s_date		   datetime	= null,
	@s_user		   login		= null,
	@s_term		   descripcion = null,
	@s_corr		   char(1)		= null,
	@s_ssn_corr	   int			= null,
   @s_ofi		   smallint	= null,
	@t_rty		   char(1)		= null,
   @t_trn		   smallint	= null,
	@t_debug	      char(1)		= 'N',
	@t_file		   varchar(14) = null,
	@t_from		   varchar(30) = null,
	@i_operacion	char(1)		= null,
	@i_fecha_proc	datetime	= null,
	@i_reporte		varchar(6)	= null,
	@i_mes			tinyint		= null,
	@i_anio			smallint	= null,
	@o_mes			tinyint		= null out,
	@o_anio			smallint	= null out,
	@o_provision	char(1)		= null out
)
as 
declare	
		@w_error			   int,
		@w_error_tmp		   int,
		@w_rowcount			   int,
		@w_mensaje         varchar(150),
		@w_sp_name			varchar(30),
		@w_param_PMSREP	tinyint,
		@w_param_PGPROV	char(30),
		@w_fecha_aux	datetime,
		@w_fecha_prov	datetime

select @w_sp_name = 'sp_solicitud_reportes_reg'

select @w_param_PMSREP = pa_tinyint
from cobis..cl_parametro
where pa_nemonico in ('PMSREP')
and pa_producto = 'CON'

if @@error != 0 or @@rowcount != 1
begin
	select @w_error = 609327
	goto ERROR_PROCESO
end

select @w_param_PGPROV = pa_char
from cobis..cl_parametro
where pa_nemonico in ('PGPROV')
and pa_producto = 'CON'

if @@error != 0 or @@rowcount != 1
begin
	select @w_error = 609327
	goto ERROR_PROCESO
end

if (@i_operacion = 'C')
begin
	select	lr_reporte as REPORTE,
            lr_descripcion AS DESCRIPCION,
            case when sr_status is null then 0 else 1 end as ESTADO,
            lr_depende_pro as DEPENDE_PROVISION
		from cob_conta..cb_listado_reportes_reg 
		left join cob_conta..cb_solicitud_reportes_reg on sr_reporte = lr_reporte 
			--and sr_fecha = @i_fecha_proc 
			and sr_status	= 'I'
		where lr_estado = 'V'
	
	select @w_error_tmp	= @@error, @w_rowcount = @@rowcount

	if @w_error_tmp != 0
	begin
	   select @w_error = 609312
	   goto ERROR_PROCESO
	end
	else if @w_rowcount = 0
	begin
		select @i_operacion = 'Q'
	end
	else if @w_rowcount > 0
	begin
		select	@o_mes	= sr_mes,
               @o_anio	= sr_anio
			from cob_conta..cb_solicitud_reportes_reg
			where sr_status	= 'I'
			
		if @@error != 0
		begin
		   select @w_error = 609312
		   goto ERROR_PROCESO
		end
	end
end

if (@i_operacion = 'Q')
begin
	select	lr_reporte as REPORTE,
            lr_descripcion AS DESCRIPCION,
            0 as ESTADO,
            lr_depende_pro as DEPENDE_PROVISION
		from cob_conta..cb_listado_reportes_reg 
		where lr_estado = 'V'

	if @@error != 0 or @@rowcount = 0
	begin
	   select @w_error = 609313
	   goto ERROR_PROCESO
	end
end

if (@i_operacion = 'P')
begin   
   select @w_fecha_aux = convert(datetime, (convert(varchar, @i_anio) + '/' + convert(varchar, @i_mes) + '/01'))

   exec @w_error_tmp = cob_conta..sp_calcula_ultima_fecha_habil
      @i_reporte		= 'NINGUN',
      @i_fecha		   = @w_fecha_aux,
      @o_fin_mes_hab	= @w_fecha_prov out

   if @w_error_tmp != 0
   begin
      select @w_error = @w_error_tmp
      goto ERROR_PROCESO
   end

   if (exists(select 1 from cob_conta_super..sb_dato_operacion
            where do_fecha = @w_fecha_prov
            and do_provision is not null
            and do_provision > 0))
   begin
      select @o_provision = 'S'
   end
   else
   begin
      select @o_provision = 'N'
   end
end

if (@i_operacion = 'V')
begin
	

	if (abs(datediff(MM, @i_fecha_proc, convert(datetime, convert(varchar, @i_anio) + '/' + convert(varchar, @i_mes) + '/01'))) > @w_param_PMSREP)
	begin	
	   select @w_error = 609323
	   goto ERROR_PROCESO
	end
   
	insert into ts_solicitud_reportes_reg (secuencial, tipo_transaccion, clase, fecha, usuario, terminal, oficina, fecha_actual, fecha_sol, reporte, mes, anio, estado)
	select @s_ssn, @t_trn, 'A', @s_date, @s_user, @s_term, @s_ofi, getdate(), sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status
		from cob_conta..cb_solicitud_reportes_reg 
		where sr_status = 'I' --sr_fecha = @i_fecha_proc

	if @@error != 0
	begin
	   select @w_error = 609324
	   goto ERROR_PROCESO
	end

	delete from cob_conta..cb_solicitud_reportes_reg 
			where sr_fecha = @i_fecha_proc
         and sr_status = 'I'

	if @@error != 0
	begin
	   select @w_error = 609325
	   goto ERROR_PROCESO
	end
end
	
if (@i_operacion = 'I')
begin
	insert into cob_conta..cb_solicitud_reportes_reg (sr_fecha, sr_reporte, sr_mes, sr_anio)
											values (@i_fecha_proc, @i_reporte, @i_mes, @i_anio)

	if @@error != 0
	begin
	   select @w_error = 609326
	   goto ERROR_PROCESO
	end

	insert into ts_solicitud_reportes_reg (secuencial, tipo_transaccion, clase, fecha, usuario, terminal, oficina, fecha_actual, fecha_sol, reporte, mes, anio, estado)
	select @s_ssn, @t_trn, 'N', @s_date, @s_user, @s_term, @s_ofi, getdate(), sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status
		from cob_conta..cb_solicitud_reportes_reg 
		where sr_fecha	= @i_fecha_proc
		and sr_reporte = @i_reporte

	if @@error != 0
	begin
	   select @w_error = 609324
	   goto ERROR_PROCESO
	end
end

return 0
   
ERROR_PROCESO:
	
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = @w_error
				
	--select @o_msg = ltrim(rtrim(@w_msg))
	return @w_error

go
