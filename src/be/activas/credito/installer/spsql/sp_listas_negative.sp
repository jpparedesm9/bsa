/************************************************************************/
/*  Archivo:                sp_listas_negative.sp                       */
/*  Stored procedure:       sp_listas_negative                          */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Agustin Ortiz                               */
/*  Fecha de Documentacion: 06/Nov/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure tipo Variable, Retorna SI si es partner de la solicitud    */
/* de credito individual                                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha        Nombre                 Proposito                      */
/*  06/11/2019    A. Ortiz    Emision Inicial                           */
/*  30/09/2021    ACH         ERR#168924,se toma el parametro de ingreso*/
/* **********************************************************************/
use cob_credito
go

if object_id('dbo.sp_listas_negative') is not null
	drop procedure dbo.sp_listas_negative
go

create proc sp_listas_negative(
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
		@w_lista_negra	    char(1),
		@w_valor_nuevo      varchar(255),
		@w_valor_ant        varchar(255),
		@w_total			int,
		@w_count			int,
		@w_dictamen         varchar(500),
		@w_dictamen_ln		varchar(255),
		@w_dictamen_nf      varchar(255),
		@w_es_ln			char(1),
		@w_es_nf			char(1),
		@w_numero           int,
		@w_asig_act			int,
		@w_proceso			varchar(5),
		@w_usuario			varchar(64)
		
	select @w_sp_name='sp_listas_negative'
	select @w_dictamen =''
	
	select @w_grupo   = convert(int,io_campo_1),
		   @w_operacion = io_campo_4,
		   @w_asig_act = convert(int,@i_id_asig_act)--io_campo_2
	from cob_workflow..wf_inst_proceso
	where io_id_inst_proc = @i_id_inst_proc

	if @w_operacion is null
	begin
		select @w_error = 999999 --No existieron resultados asociados a la operacion indicada   
		exec   @w_error  = cobis..sp_cerror
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

		select	cg_ente,cg_grupo,cg_oficial,cg_estado
		into #clientes
		from cobis..cl_cliente_grupo 
		where cg_estado = 'V' and cg_grupo = @w_grupo 

		select @w_count=count(*) from #clientes

		if @w_ente = 0 return 0
		else
		begin
			while @w_count > 0
			begin
				(select top(1) @w_ente = cg_ente FROM #clientes); 

				exec @w_return = cob_credito..sp_var_lista_negra_int
				 @i_ente   = @w_ente ,
				 @i_valida = 'S',
				 @o_resultado = @o_respuesta output,
				 @o_dictamen_nf = @w_dictamen_nf output,
				 @o_dictamen_ln = @w_dictamen_ln output,
				 @o_es_ln		= @w_es_ln	output,
				 @o_es_nf		= @w_es_nf	output

				 print 'Grupal aparece en Listas: ' + @o_respuesta + ' '+ convert(varchar(20),@w_ente)
				 delete from #clientes where  cg_ente =@w_ente 
	
				 select @w_count=count(*) from #clientes
				 
				 print 'w_dictamen_ln: '+@w_dictamen_ln +' w_dictamen_nf:'+@w_dictamen_nf
				 
				 if @o_respuesta = 'SI'
				 begin
					if(@w_dictamen_ln ='NR' and @w_dictamen_nf='NR')
					begin						
						select @o_respuesta = 'NO'
						select @w_dictamen = @w_dictamen + ' '+convert(varchar(20),@w_ente)+ ' NO BLOQUEANTE'
					end
					else if(@w_dictamen_ln ='SR' or @w_dictamen_nf ='SR')
					begin
						select @w_dictamen = @w_dictamen + ' '+convert(varchar(20),@w_ente)+ ' BLOQUEANTE, Cliente no sujeto de Crédito'
					end
					else if(@w_dictamen_ln = 'EI' or @w_dictamen_nf='EI')
					begin
						select @w_dictamen = @w_dictamen + ' '+convert(varchar(20),@w_ente)+ ' BLOQUEANTE, Cliente no sujeto de Crédito,Favor de comunicarte con tu Analista de Oficina'
					end
					
					if(@o_respuesta = 'SI')
					begin
					    print 'CLIENTE '+convert(varchar(10),@w_ente)+' EN LISTA NEGRA'
						insert into #clientes_mal values(@w_ente)
					end
				 end
			end
			if((select count(*) from #clientes_mal )>0)
			begin
				print 'CLIENTES EN LISTAS NEGRAS'
				select @o_respuesta ='SI'
			end
		end
	end
	else
	if @w_operacion = 'REVOLVENTE' OR @w_operacion = 'INDIVIDUAL'
	begin
		EXEC @w_return = cob_credito..sp_var_lista_negra_int
				 @i_ente   = @w_grupo,
				 @i_valida = 'S',
				 @o_resultado = @o_respuesta output,
				 @o_dictamen_nf = @w_dictamen_nf output,
				 @o_dictamen_ln = @w_dictamen_ln output,
				 @o_es_ln		= @w_es_ln	output,
				 @o_es_nf		= @w_es_nf	output


				 print 'Aparece en Listas: ' + @o_respuesta
				 
				 if @o_respuesta = 'SI'
				 begin
					if(@w_dictamen_ln ='NR' and @w_dictamen_nf='NR')
					begin
						select @o_respuesta = 'NO'
						select @w_dictamen = @w_dictamen + ' '+convert(varchar(20),@w_grupo)+ ' NO BLOQUEANTE'
					end
					else if(@w_dictamen_ln ='SR' or @w_dictamen_nf ='SR')
					begin
						select @w_dictamen = @w_dictamen + ' '+convert(varchar(20),@w_grupo)+ ' BLOQUEANTE, Cliente no sujeto de Crédito'
					end
					else if(@w_dictamen_ln = 'EI' or @w_dictamen_nf='EI')
					begin
						select @w_dictamen = @w_dictamen + ' '+convert(varchar(20),@w_grupo)+ ' BLOQUEANTE, Cliente no sujeto de Crédito,Favor de comunicarte con tu Analista de Oficina'
					end					
					
				 end
	end
	print 'OBSERVACION: '+@w_dictamen
	select @w_valor_nuevo = convert(varchar,@o_respuesta)
	
	select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
	select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
             where ob_id_asig_act = @w_asig_act
             order by ob_numero desc
	
	if (@w_numero is not null)
		 select @w_numero = @w_numero + 1 --aumento en uno el maximo
	 else
		 select @w_numero = 1
		 
	delete cob_workflow..wf_observaciones 
	 where ob_id_asig_act = @w_asig_act
	 and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
	 where ol_id_asig_act = @w_asig_act 
	 and (ol_texto like '%NO BLOQUEANTE%'
	 or   ol_texto like '%BLOQUEANTE, Cliente%'))
	   
	 delete cob_workflow..wf_ob_lineas 
	 where ol_id_asig_act = @w_asig_act 
	 and  (ol_texto like '%NO BLOQUEANTE%'
	 or    ol_texto like '%NO BLOQUEANTE%')
        
	
	if(@o_respuesta = 'SI')
	begin
		if len(@w_dictamen) > 255
		begin
			insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
			 values (@w_asig_act, @w_numero, getdate(), @w_proceso, 2, 'a', @w_usuario)
			 
			 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			 values (@w_asig_act, @w_numero, 1, substring(@w_dictamen,0,254))
			 
			 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			 values (@w_asig_act, @w_numero, 2, substring(@w_dictamen,255,255))
		end
		else
		 begin
			 insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
			 values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
			 
			 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
			 values (@w_asig_act, @w_numero, 1, @w_dictamen)
		 end
	end
	
	-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
	select @w_valor_ant    = isnull(va_valor_actual, '')
	from cob_workflow..wf_variable_actual
	where va_id_inst_proc = @i_id_inst_proc
	and va_codigo_var   = @i_id_variable

	if @@rowcount > 0  --ya existe
	begin
		update cob_workflow..wf_variable_actual
		set va_valor_actual = @w_valor_nuevo 
		where va_id_inst_proc = @i_id_inst_proc
		and va_codigo_var   = @i_id_variable
		
	end
	else
	begin
		insert into cob_workflow..wf_variable_actual
			(va_id_inst_proc, va_codigo_var, va_valor_actual)
		values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )
	
	end
	if object_id('tempdb..#clientes') is not null
		begin
			drop table #clientes
		end
	
	return 0	
	
	go
	