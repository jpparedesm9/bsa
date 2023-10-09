/************************************************************************/
/*   Archivo:                sp_var_listas_cliente.sp                   */
/*   Stored procedure:       sp_var_listas_cliente                      */
/*   Base de Datos:          cob_credito                                */
/*   Producto:               Credito                                    */
/*   Disenado por:           KVI                                        */
/*   Fecha de Documentacion: Marzo 2023                                 */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                          PROPOSITO                                   */
/*   Procedure tipo Variable, Retorna SI si esta en listas negras o     */
/*   negative file                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA         AUTOR                   RAZON                        */
/*   15/03/2023    KVI             Emision Inicial                      */
/* **********************************************************************/
use cob_credito
go

if object_id('dbo.sp_var_listas_cliente') is not null
	drop procedure dbo.sp_var_listas_cliente
go

create proc sp_var_listas_cliente(
	@s_ssn          int          = null,
	@s_ofi          smallint     = null,
	@s_user         login        = null,
    @s_date         datetime     = null,
	@s_srv		    varchar(30)  = null,
	@s_term	        descripcion  = null,
	@s_rol		    smallint     = null,
	@s_lsrv	        varchar(30)  = null,
	@s_sesn	        int 	     = null,
	@s_org		    char(1)      = NULL,
	@s_org_err      int 	     = null,
    @s_error        int 	     = null,
    @s_sev          tinyint      = null,
    @s_msg          descripcion  = null,
    @t_rty          char(1)      = null,
    @t_trn          int          = null,
    @t_debug        char(1)      = 'N',
    @t_file         varchar(14)  = null,
    @t_from         varchar(30)  = null,
	@i_id_inst_proc int,    
	@i_id_inst_act  int,
	@i_id_asig_act  int,
	@i_id_empresa   int,
	@i_id_variable  smallint,
	@o_respuesta    varchar(10)  = null output
	)
as
declare @w_sp_name       	varchar(32),
        @w_return        	int,
		@w_error			int,
        @w_grupo			int,
        @w_ente             int,
		@w_operacion        varchar(64),
		@w_valor_nuevo      varchar(255),
		@w_valor_ant        varchar(255),
		@w_count			int,
		@w_resultado        int
		
		
select @w_sp_name = 'sp_var_listas_cliente'
	
select @w_grupo   = convert(int,io_campo_1),
	   @w_operacion = io_campo_4
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

if @w_operacion is null
begin
	select @w_error = 999999 --No existieron resultados asociados a la operacion indicada   
	exec @w_error  = cobis..sp_cerror
		 @t_debug  = 'N',
		 @t_file   = '',
		 @t_from   = @w_sp_name,
		 @i_num    = @w_error,
		 @i_msg    = ''
    return @w_error
end
	
if @w_operacion = 'GRUPAL'
begin
    create table #clientes_mal
	(
		id_cliente int
	)
	
	select cg_ente, cg_grupo, cg_oficial, cg_estado
	into #clientes
	from cobis..cl_cliente_grupo 
	where cg_estado = 'V' and cg_grupo = @w_grupo 

	select @w_count = count(*) from #clientes

	if @w_ente = 0 return 0
	else
	begin
		while @w_count > 0
		begin
			(select top(1) @w_ente = cg_ente from #clientes); 

            exec @w_return    = cob_credito..sp_busq_listas_cliente
                 @i_ente      = @w_ente,
                 @o_resultado = @w_resultado output 

            if @w_resultado  = 1 
            begin 
            	select @w_valor_nuevo = 'NO';
            end
            else if @w_resultado  = 3
            begin
            	select @w_valor_nuevo = 'SI';
            end

			print 'Grupal aparece en Listas: ' + @w_valor_nuevo + ' ' + convert(varchar(20),@w_ente)
			delete from #clientes where  cg_ente = @w_ente 
	
			select @w_count = count(*) from #clientes
				 
			if @w_valor_nuevo = 'SI'
			begin					
				print 'CLIENTE ' + convert(varchar(10),@w_ente) + ' EN LISTA NEGRA'	
                insert into #clientes_mal values(@w_ente)				
			end
		end
		if((select count(*) from #clientes_mal )>0)
		begin
			print 'CLIENTES EN LISTAS NEGRAS'
			select @w_valor_nuevo = 'SI'
		end
	end
end
else
if @w_operacion = 'REVOLVENTE' or @w_operacion = 'INDIVIDUAL'
begin
    exec @w_return    = cob_credito..sp_busq_listas_cliente
         @i_ente      = @w_grupo,
         @o_resultado = @w_resultado output 

    if @w_resultado  = 1 
    begin 
        select @w_valor_nuevo = 'NO';
    end
    else if @w_resultado  = 3
    begin
    	select @w_valor_nuevo = 'SI';
    end

	print 'Aparece en Listas: ' + @w_valor_nuevo
				 
	if @w_valor_nuevo = 'SI'
	begin
		print 'CLIENTE ' + convert(varchar(10),@w_grupo) + ' EN LISTA NEGRA'
	end
end

--insercion en estrucuturas de variables
if @i_id_asig_act is null
    select @i_id_asig_act = 0
	
-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant = isnull(va_valor_actual, '')
from cob_workflow..wf_variable_actual
where va_id_inst_proc = @i_id_inst_proc
and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
	update cob_workflow..wf_variable_actual
	set   va_valor_actual = @w_valor_nuevo 
	where va_id_inst_proc = @i_id_inst_proc
	and   va_codigo_var   = @i_id_variable	
end
else
begin
	insert into cob_workflow..wf_variable_actual
		   (va_id_inst_proc, va_codigo_var, va_valor_actual)
	values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo)
end

if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
begin
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
			
	if @@error > 0
	begin
        --registro ya existe			
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file = @t_file, 
        @t_from = @t_from,
        @i_num = 2101002
		
        return 1
	end 

end

if object_id('tempdb..#clientes') is not null
begin
	drop table #clientes
end

return 0	

go
	