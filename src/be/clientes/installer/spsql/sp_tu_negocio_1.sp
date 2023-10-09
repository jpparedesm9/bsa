/****************************************************************/
/*   ARCHIVO:         	sp_tu_negocio_1.sp		        */
/*   NOMBRE LOGICO:   	sp_tu_negocio_1       		    */
/*   PRODUCTO:          CLIENTES                                */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*  Validar los datos segun las validaciones para Tu Negocio v1 */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   19-12-2019    A. Ortiz        Emision Inicial.     	    */
/****************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_tu_negocio_1')
   drop proc sp_tu_negocio_1
go

create procedure sp_tu_negocio_1(
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int			= null,
	@s_term             varchar(30) = null,
	@s_date             datetime	= null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint	= null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = null,
	@t_rty				char(1)     = null,
	@t_trn				int         = null,	
	@i_inst_proc	   	int			= null,    --codigo de instancia del proceso
	@i_ente				int			= null,
	@i_id_formulario	int			= null
)
as
declare	@w_sp_name 				varchar(64),
		@w_limite_inferior      money,
		@w_limite_superior      money,
		@w_ingreso_semanal      money,
		@w_gasto_semanal        money,
		@w_diferencia_ingresos  money,
		@w_valor		        money,
		@w_multiplo             int,
		@w_msg                  varchar(250),
		@w_id_fila				int,
		@w_tipo_ingreso			varchar(254),
		@w_id_documento			int,
		@w_desc_tipo_doc		varchar(254),
		@w_fila					int,
		@w_pregunta_multi       int,
		@w_validacion		    money

select @w_sp_name 	= 'sp_tu_negocio_1'

select @w_limite_inferior = pa_money 
from cobis..cl_parametro 
where pa_nemonico = 'LIMINF'

select @w_limite_superior = pa_money
from cobis..cl_parametro 
where pa_nemonico = 'LIMSUP'

select @w_multiplo = pa_int
from cobis..cl_parametro 
where pa_nemonico = 'MCIEN'

--Suma de TODOS los Ingresos Semanales debe estar entre 1000 y 300,000 pesos
select @w_ingreso_semanal = sum(convert(money,rt_respuesta)) from cl_frm_ente_resp_tabla_tmp 
where rt_pregunta_form = 19 and rt_id_columna > 1
and rt_ente = @i_ente

if @w_ingreso_semanal between @w_limite_inferior and @w_limite_superior
begin
	select @w_ingreso_semanal = @w_ingreso_semanal
end
else 
begin -- Error en la insercion
	select @w_msg = 'La suma de los ingresos semanales del cliente no esta en el rango permitido (<'+convert(varchar,@w_limite_inferior)+'> a <'+convert(varchar,@w_limite_superior)+'>)'
	exec sp_cerror
	@t_from  = @w_sp_name,
	@i_num   = 70335,
	@i_msg   = @w_msg
	return 1
end

--Suma de TODOS los Gastos Semanales debe estar entre 1000 y 300,000 pesos
select @w_gasto_semanal = sum(convert(money,rt_respuesta)) from cl_frm_ente_resp_tabla_tmp 
where rt_pregunta_form = 20 and rt_id_columna > 1
and rt_ente = @i_ente

if @w_gasto_semanal between @w_limite_inferior and @w_limite_superior
begin
	print @w_gasto_semanal
	select @w_gasto_semanal = @w_gasto_semanal
end
else
begin 
	select @w_msg = 'La suma de los gastos semanales del cliente no esta en el rango permitido (<'+convert(varchar,@w_limite_inferior)+'> a <'+convert(varchar,@w_limite_superior)+'>)'
	exec sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 70336,
		@i_msg   = @w_msg
	return 1
end

--Diferencia entre la totalidad de ingresos y gastos sea un valor superior a los 1000 pesos
select @w_diferencia_ingresos = @w_ingreso_semanal - @w_gasto_semanal

if @w_diferencia_ingresos < @w_limite_inferior
begin
	select @w_msg = 'Las diferencia entre ingresos y gastos, es muy pequeña, no llegan a los <'+convert(varchar,@w_limite_inferior)+'> pesos.'
	exec sp_cerror
		@t_from  = @w_sp_name,
		@i_num   = 70337,
		@i_msg   = @w_msg
	return 1
end 


--Validar si hay documentos de soporte para ingresos
if(@w_ingreso_semanal is not null AND @w_ingreso_semanal > 0)
begin
	select rt_fila,rt_respuesta
	into #ingresos
	from cl_frm_ente_resp_tabla_tmp 
	where rt_ente= @i_ente 
	and rt_pregunta_form=19 
	and rt_id_columna=1		

	select @w_id_fila=1
	select @w_desc_tipo_doc = ''
	
	while(1=1)
	begin
		select @w_tipo_ingreso = rt_respuesta
		from #ingresos
		where rt_fila = @w_id_fila
		
		if @@rowcount = 0
			break
		
		if(@w_tipo_ingreso = 'LI')
		begin
			select @w_fila= rt_fila 
			from cl_frm_ente_resp_tabla_tmp 
			where rt_ente			=	@i_ente
			and rt_pregunta_form	=	19 
			and rt_respuesta		=	@w_tipo_ingreso
			and rt_fila				= 	@w_id_fila
			
			select @w_valor=sum(convert(money,rt_respuesta))
			from cl_frm_ente_resp_tabla_tmp 
			where rt_ente=@i_ente
			and rt_pregunta_form=19 
			and rt_fila=@w_fila 
			and rt_id_columna>1
			
			if(@w_valor > 0)
			begin						
				select @w_id_documento = td_codigo_tipo_doc from cob_workflow..wf_tipo_documento where td_nombre_tipo_doc='COMPROBANTE LIBRO DE INGRESOS'
				
				if not exists(select * from cob_workflow..wf_req_inst where ri_id_inst_proc=@i_inst_proc and ri_codigo_tipo_doc=@w_id_documento)
				begin
					select @w_desc_tipo_doc= @w_desc_tipo_doc + ' COMPROBANTE LIBRO DE INGRESOS,'
				end
			end
		end
		if(@w_tipo_ingreso = 'FA')
		begin
			select @w_fila= rt_fila 
			from cl_frm_ente_resp_tabla_tmp 
			where rt_ente			=	@i_ente
			and rt_pregunta_form	=	19 
			and rt_respuesta		=	@w_tipo_ingreso
			and rt_fila				= 	@w_id_fila
			
			select @w_valor=sum(convert(money,rt_respuesta))
			from cl_frm_ente_resp_tabla_tmp 
			where rt_ente=@i_ente
			and rt_pregunta_form=19 
			and rt_fila=@w_fila 
			and rt_id_columna>1
			
			if(@w_valor > 0)
			begin
				select @w_id_documento = td_codigo_tipo_doc from cob_workflow..wf_tipo_documento where td_nombre_tipo_doc='COMPROBANTE FACTURAS'
				
				if not exists(select * from cob_workflow..wf_req_inst where ri_id_inst_proc=@i_inst_proc and ri_codigo_tipo_doc=@w_id_documento)
				begin
					select @w_desc_tipo_doc= @w_desc_tipo_doc + ' COMPROBANTE FACTURAS,'
				end
			end
		end
		if(@w_tipo_ingreso = 'NR')
		begin
			select @w_fila= rt_fila 
			from cl_frm_ente_resp_tabla_tmp 
			where rt_ente			=	@i_ente
			and rt_pregunta_form	=	19 
			and rt_respuesta		=	@w_tipo_ingreso
			and rt_fila				= 	@w_id_fila
			
			select @w_valor=sum(convert(money,rt_respuesta))
			from cl_frm_ente_resp_tabla_tmp 
			where rt_ente=@i_ente
			and rt_pregunta_form=19 
			and rt_fila=@w_fila 
			and rt_id_columna>1
			
			if(@w_valor > 0)
			begin
				select @w_id_documento = td_codigo_tipo_doc from cob_workflow..wf_tipo_documento where td_nombre_tipo_doc='COMPROBANTE NOTAS DE REMISION'
				
				if not exists(select * from cob_workflow..wf_req_inst where ri_id_inst_proc=@i_inst_proc and ri_codigo_tipo_doc=@w_id_documento)
				begin
					select @w_desc_tipo_doc= @w_desc_tipo_doc + ' COMPROBANTE NOTAS DE REMISION,'
				end
			end
		end
		
		delete from #ingresos where rt_fila = @w_id_fila
		select @w_id_fila= @w_id_fila+1
	end	

	if(@w_desc_tipo_doc is not null AND @w_desc_tipo_doc <> '')
	begin
		select @w_msg = 'Falta capturar Comprobante de ingreso tipo: '+SUBSTRING(@w_desc_tipo_doc,0,LEN(@w_desc_tipo_doc))
		exec sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 70337,
			@i_msg   = @w_msg
		return 1
	end
end

--El valor a solicitar (pregunta 16) debe ser múltiplo de 100 Pesos.
select @w_valor = en_respuesta, @w_pregunta_multi = en_pregunta_form from cl_frm_ente_respuesta_tmp 
where en_ente 		= @i_ente
and en_formulario	= @i_id_formulario
and en_pregunta_form = 16

if @w_pregunta_multi = 16
begin
	if @w_valor = 0
	begin
		exec sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 70339,
			@i_msg   = 'Se debe solicitar un monto mayor a 0'
		return 1
	end
	
	select @w_validacion = @w_valor % @w_multiplo
	 
	if @w_validacion != 0
	begin
		exec sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 70339,
			@i_msg   = 'El valor a solicitar debe ser múltiplo de 100 pesos.'
		return 1
	end 
end