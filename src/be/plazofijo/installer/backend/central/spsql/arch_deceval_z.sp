/*****************************************************************************/
/*  ARCHIVO:         arch_deceval_z.sp                                       */
/*  NOMBRE LOGICO:   sp_arch_deceval_z                                       */
/*  PRODUCTO:        Depositos a Plazo Fijo                                  */
/*****************************************************************************/
/*                            IMPORTANTE                                     */
/* Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCorp */
/* Su uso no autorizado queda  expresamente  prohibido asi como cualquier    */
/* alteracion o agregado hecho  por alguno de sus usuarios sin el debido     */
/* consentimiento por escrito de COBISCorp. Este programa esta protegido por */
/* la ley de derechos de autor y por las convenciones internacionales de     */
/* propiedad intelectual.  Su uso  no  autorizado dara derecho a COBISCORP   */
/* para obtener ordenes  de secuestro o  retencion  y  para  perseguir       */
/* penalmente a  los autores de cualquier infraccion.                        */
/*****************************************************************************/
/*                               PROPOSITO                                   */
/* Enviar la informacion para DECEVAL.                                       */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists ( select 1 from sysobjects where type = 'P' and name = 'sp_arch_deceval_z')
   drop proc sp_arch_deceval_z
go

create proc sp_arch_deceval_z(
@w_debug	         char(1) = null)
with encryption
as
declare
@w_error             int,
@w_msg               descripcion,
@w_descripcion       descripcion,
@w_fecha_proc        datetime,
@w_archivo           descripcion,
@w_archivo_aux       descripcion,
@w_archivo_bcp       descripcion,
@w_archivo_in        descripcion,
@w_errores           descripcion,
@w_estado            char(1),
@w_path_s_app        varchar(30),
@w_path              varchar(250),
@w_s_app             varchar(250),
@w_cmd               varchar(250),
@w_bd                varchar(250),
@w_tabla             varchar(250),
@w_comando           varchar(250),
@w_operacion         varchar(104),
@w_observacion       varchar(114),
@w_dcv_anna	     char(1),
@w_tot_reg		int,
@w_ed_tot_op		int,
@w_operacion_en_z	int,
@w_tot_reg_z		int,
@w_ag_deceval        varchar(4)


select @w_ag_deceval = isnull(pa_char,'000')
from   cobis..cl_parametro
where  pa_nemonico = 'AGDCVL'
and    pa_producto = 'PFI'

if @w_ag_deceval is null begin
   select @w_msg = 'NO ESTA DEFINIDO EL PARAMETRO AGENCIA DECEVAL'
   goto ERROR
end


select @w_path_s_app = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'S_APP'

if @w_path_s_app is null begin
   select @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
   goto ERROR
end

select @w_dcv_anna = isnull(pa_char,'N')
from   cobis..cl_parametro
where  pa_nemonico = 'DCVANN'
and    pa_producto = 'PFI'


/* OBTENGO LA FECHA DE PROCESO */
select
@w_fecha_proc = fp_fecha
from cobis..ba_fecha_proceso

select
@w_path = ba_path_destino
from  cobis..ba_batch
where ba_batch = 14091

select @w_debug = 'S' 

select @w_comando = ' dir  /B ' + @w_path + 'Z*.* > ' + @w_path + 'salida'
if @w_debug = 'S' print '@w_comando ' +  @w_comando
exec @w_error = xp_cmdshell @w_comando

truncate table pf_aux

/* REALIZO BCP archivos */
select 	@w_s_app 	= @w_path_s_app + 's_app'
select	@w_archivo_bcp 	= @w_path  + 'salida',
   	@w_errores     	= @w_path  + 'salida.error',
   	@w_cmd         	= @w_s_app + ' bcp -auto -login cob_pfijo..pf_aux in '
select  @w_comando 	= @w_cmd + @w_archivo_bcp + ' -b5000 -c -e'+@w_errores  +  ' -config '+ @w_s_app + '.ini'
if @w_debug = 'S'  print '@w_comando ' +  @w_comando
exec @w_error = xp_cmdshell @w_comando


if exists( select 1 from pf_aux)
begin

	select @w_cmd = @w_s_app + ' bcp -auto -login cob_pfijo..pf_archivo_dcv_z in '
	
	
	/* RECORRO LA TABLA CON LOS ARCHIVOS QUE HAN SIDO GENERADOS Y NO PROCESADOS */
	declare cur_envios cursor for
	select 	substring(pa_varchar, 1,datalength(pa_varchar) ),
		'P' + @w_ag_deceval + substring(pa_varchar, 5, 4)
	from   	pf_aux
	order by pa_varchar
	
	open cur_envios
	
	fetch cur_envios into 
	@w_archivo_in,
	@w_archivo_aux
	
	
	while @@fetch_status = 0
	begin
	
	   	truncate table pf_archivo_dcv_z

if @w_debug = 'S' print '@w_archivo_in  ' + cast(@w_archivo_in  as varchar(200))
if @w_debug = 'S' print '@w_archivo_aux  ' + cast(@w_archivo_aux  as varchar(200))

	   
	   	-- ARMAR Comando para eejcutar BCP
	   	select 	@w_archivo_bcp = @w_path + @w_archivo_in  + ' -f' + @w_path + 'bcp.fmt ',
	   		@w_errores     = @w_path + 'E'+substring(@w_archivo_in, 2, datalength(@w_archivo_in))
	   	select  @w_comando = 'bcp cob_pfijo..pf_archivo_dcv_z in ' + @w_archivo_bcp + ' -b5000  -e' + @w_errores  + ' -T ' 

if @w_debug = 'S' print '@w_comando  ' + cast(@w_comando  as varchar(200))
	   
	   	-- EJECUTAR Comando para ejecutar BCP para cargar en tabla pf_archivo_dcv_z los datos enviados por deceval
	   	exec @w_error = xp_cmdshell @w_comando
	   	if @w_error <> 0 begin
	      		select @w_msg = 'ERROR AL CARGA ARCHIVO '+@w_archivo_in+ ' '+ convert(varchar, @w_error)
	      		goto ERROR_CUR
	   	end

		-- Consulto la primera operacion del archivo 'Z' con esta identifico el nombre del archivo padre 'P'
		-- Y Valido que halla minimo un registro para procesar
		select 	@w_operacion_en_z = 0
		
		select  @w_operacion_en_z =  isnull(convert(int,substring(dz_operacion,1,9)),0)
		from 	cob_pfijo..pf_archivo_dcv_z 
		order by convert(int,substring(dz_operacion,1,9))

if @w_debug = 'S' print '@w_operacion_en_z ' +  cast(@w_operacion_en_z as varchar)

		if @w_operacion_en_z <= 0 or @w_operacion_en_z = null
	      	begin
	      		select @w_msg = 'SIN INFORMACION EN pf_archivo_dcv_z segun: ' + convert(varchar,@w_archivo_in)
	      		goto ERROR_CUR
		end
		-- Valido existencia de archivo origial 'P' con respecto a operacion recibida en archivo 'Z'
		select @w_archivo = 'X' 
		
		select 	@w_archivo = ltrim(rtrim(isnull(de_archivo,'X')))
		from	pf_det_envios_dcv
		where	de_operacion = @w_operacion_en_z
		
	   	if @@rowcount <= 0  or @w_archivo = 'X' begin
	      		select @w_msg = 'NO SE HALLO ARCHIVO ORIGIAL P para op: ' + convert(varchar,@w_operacion_en_z)
	      		goto ERROR_CUR
	   	end

if @w_debug = 'S' print '@w_archivo ' +  @w_archivo
if @w_debug = 'S' print '@w_archivo_aux ' +  @w_archivo_aux
		
		if substring(@w_archivo,1,8) <> rtrim(ltrim(@w_archivo_aux)) begin
	      		select @w_msg = 'ARCHIVO ORIGIAL P ' + @w_archivo_aux + ' DIFERENTE A: ' + @w_archivo
	      		goto ERROR_CUR
		end
		
		-- Valido que exista archivo origial tipo 'P' sin procesar y el numero total de registros dell 'P' con relacion al archio enviado tipo 'Z'
		select  @w_ed_tot_op = 0 
		select 	@w_ed_tot_op = isnull(ed_tot_op,0)
		from   	pf_envios_dcv   
		where  	ed_archivo_out 	is null
		and	ed_estado 	<> 'P'
		and	ed_archivo 	= @w_archivo

	
		if @w_ed_tot_op = 0 begin
			select @w_msg = 'ERROR AL CARGA ARCHIVO ' + @w_archivo_in + ' segun: ' + @w_archivo
	      		goto ERROR_CUR
	   	end

		select 	@w_tot_reg_z = count(*)
		from	pf_archivo_dcv_z

if @w_debug = 'S' print '@w_ed_tot_op ' +  cast(@w_ed_tot_op as varchar) + ' w_tot_reg_z ' + cast(@w_tot_reg_z as varchar)

		if @w_tot_reg_z <> @w_ed_tot_op begin
			select @w_msg = '# TOAL REG arch Z: ' + @w_tot_reg_z + ' diferente a P: ' + @w_ed_tot_op
	      		goto ERROR_CUR
		end

	
	   	/* RECORRO LAS OPERACIONES RECHAZADAS PARA LLENAR EL ERRORLOG */
	   	declare cur_rechazo cursor for
	   	select	convert(varchar(114), dz_operacion)
	   	from  	pf_archivo_dcv_z
	   	where 	dz_estado = 'R'
	   
	   	open cur_rechazo
	   
	   	fetch cur_rechazo into 
	   	@w_operacion
	   
	   	while @@fetch_status = 0
	   	begin
	         	select 	@w_observacion = substring(@w_operacion,10,100)
	         	select	@w_operacion = substring(@w_operacion,1,9)
	         
	      		exec sp_errorlog
				@s_date        = @w_fecha_proc,
				@i_fecha       = @w_fecha_proc,
				@i_error       = 1,
				@i_usuario     = 'operador',
				@i_tran        = 14091,
				@i_cuenta      = @w_operacion,
				@i_descripcion = @w_observacion,
				@i_cta_pagrec  = ''
	   
	      		fetch cur_rechazo into 
	      		@w_operacion
	   	end 
	   	close cur_rechazo
	   	deallocate cur_rechazo
	   
		-- Actualizo operaciones en detalle de envio segun estado enviado por deceval
	
	   	begin tran
	   
	   	update 	pf_det_envios_dcv 
	   	set	de_op_deceval  	= dz_op_deceval,
	   		de_observacion 	= substring(dz_operacion,11,63),
	   		de_fungible    	= dz_fungible ,
	   		de_isin    	= dz_isin ,
	   		de_estado      	= dz_estado ,
	   		de_fecha        = @w_fecha_proc
	   	from  	pf_archivo_dcv_z
	   	where 	de_operacion = isnull(convert(int,substring(dz_operacion,1,9)),0)
	
	   	if @@error <> 0 begin
	      		rollback tran
	      		select @w_descripcion = 'ERROR AL ACTUALIZAR EN DETALLE DATOS DE '+@w_archivo
	      		goto ERROR_CUR
	   	end
	
		-- Actualizo fungible en maestro de pfijo segun estado enviado por deceval
	
	   	update 	pf_operacion 
	   	set	op_isin		= dz_isin 
	   	from  	pf_archivo_dcv_z
	   	where 	op_operacion = isnull(convert(int,substring(dz_operacion,1,9)),0)
	   	and   	dz_estado    = 'A'
	   
	   	if @@error <> 0 begin
	      		rollback tran
	      		select @w_descripcion = 'ERROR AL ACTUALIZAR EN MAESTRO DATOS DE '+@w_archivo
	      		goto ERROR_CUR
	   	end
	      
		-- Actualizo Archivo original tipo 'P' a estado Procesado 
	   	update pf_envios_dcv set
	   	ed_estado = 'P',
	   	ed_archivo_out = @w_archivo_in,
		ed_tot_apr = (select count(1) from  cob_pfijo..pf_det_envios_dcv where de_archivo = E.ed_archivo and de_estado = 'A'),
		ed_tot_rec = (select count(1) from  cob_pfijo..pf_det_envios_dcv where de_archivo = E.ed_archivo and de_estado = 'R')   	
	   	from 	pf_envios_dcv E
	   	where 	ed_archivo 	= @w_archivo
		and	ed_estado 	<> 'P'
	
	   	if @@error <> 0 begin
	      		rollback tran
	      		select @w_descripcion = 'ERROR AL ACTUALIZAR ESTADO DE ARCHIVO ORIGINAL P'
	      		goto ERROR_CUR
	   	end
	
	   	commit tran

		select @w_comando = ' rm ' + @w_path + @w_archivo_in
		if @w_debug = 'S' print '@w_comando ' +  @w_comando
		exec @w_error = xp_cmdshell @w_comando
	
	    
	   	goto SIGUIENTE
	   	
	   	ERROR_CUR:
	   
			exec sp_errorlog
				@s_date      = @w_fecha_proc,
				@i_fecha     = @w_fecha_proc,
				@i_error     = 1,
				@i_usuario   = 'operador',
				@i_tran      = 14091,
				@i_cuenta    = @w_descripcion,
				@i_descripcion = @w_msg,
				@i_cta_pagrec  = ''
	  
	
	   	SIGUIENTE:
	   	fetch cur_envios into 
	   	@w_archivo_in,
	   	@w_archivo_aux
	
	
	end --cursor
	
	
	close cur_envios
	deallocate cur_envios

end

return 0
ERROR:
select @w_descripcion = 'CARGA DECEVAL '

exec sp_errorlog
@s_date      = @w_fecha_proc,
@i_fecha     = @w_fecha_proc,
@i_error     = 1,
@i_usuario   = 'operador',
@i_tran      = 14091,
@i_cuenta    = @w_descripcion,
@i_descripcion = @w_msg,
@i_cta_pagrec  = ''

return 1

go

