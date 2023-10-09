/************************************************************************/
/*  Archivo:                sp_var_validacion_edad.sp                   */
/*  Stored procedure:       sp_var_validacion_edad                      */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Agustin Ortiz                               */
/*  Fecha de Documentacion: 20/Nov/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBOSCORP",representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de COBISCORP o su representante               */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Permite determinar si los integrantes de un grupo promo cumple      */
/*  las condiciones de animate                                          */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 20/Nov/2019   Agustin Ortiz            Emision Inicial               */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_validacion_edad')
	drop proc sp_var_validacion_edad
GO


CREATE PROC sp_var_validacion_edad(
	@i_id_inst_proc int,    --codigo de instancia del proceso
	@i_ente         int,
	@i_tproducto    varchar(60),
	@o_resultado    char(2) = null output
)
as
declare @w_sp_name       	   varchar(32),
        @w_return        	   int,
        ---var variables	   
        @w_asig_actividad 	   int,
        @w_valor_ant      	   varchar(255),
        @w_valor_nuevo    	   varchar(255),
        @w_grupo	           int,
		@w_tramite             int,
        @w_promocion           char(1),
        @w_ciclo               int,
        @w_variables           varchar(255),
        @w_result_values       varchar(255),
        @w_resultado           varchar(30),
		@w_cadena              varchar(255),
		@w_fecha               datetime,
		@w_parent              varchar(255),
		@w_edad_cliente        int,
		@w_edad_minima         int,
		@w_edad_maxima         int
         
		select @w_sp_name='sp_var_validacion_edad'
		
		select  @w_grupo		= io_campo_1,
				@w_tramite 		= io_campo_3
		from cob_workflow..wf_inst_proceso
		where io_id_inst_proc 	= @i_id_inst_proc
		  and io_campo_7 		= 'S'
		  
		select @w_tramite = isnull(@w_tramite,0)
		
		if @w_tramite = 0
		begin
			select @w_promocion='N'
		end
	    else
		begin	
			select @w_promocion = isnull(tr_promocion, 'N')
			from cob_credito..cr_tramite
			where tr_tramite = @w_tramite			
		end
		
		select @w_promocion = isnull(tr_promocion, 'N')
		from cob_credito..cr_tramite
		where tr_tramite = @w_tramite
		print @w_tramite

		select @w_ciclo = isnull(gr_num_ciclo,0) + 1
	    from cobis..cl_grupo
	    where gr_grupo 	= @w_grupo

	
		if @i_tproducto = 'GRUPAL'
		begin
			print @i_tproducto
			select @w_fecha = p_fecha_nac from cobis..cl_ente where en_ente = @i_ente 

			select @w_edad_cliente = convert(varchar,DATEDIFF(yyyy, @w_fecha, GETDATE()))
			
			select @w_cadena = @i_tproducto +'|'+@w_promocion+'|'+convert(varchar(5),@w_ciclo)
			print 'Cadena: ' +@w_cadena
				exec  	@w_return = cob_pac..sp_rules_param_run
						@s_rol                   = 1,
						@i_rule_mnemonic         = 'EGRUPO',
						@i_modo                  = 'S',
						@i_tipo                  = 'S',
						@i_var_values            = @w_cadena, 	
						@i_var_separator         = '|',
						@o_return_variable       = @w_variables  out,
						@o_return_results        = @w_resultado      out,
						@o_last_condition_parent = @w_parent         out
			print 'RETURN '+convert(varchar,@w_return)
						
				if @w_return <> 0 
				begin
				  exec cobis..sp_cerror
			      @t_debug = '',
			      @t_file  = '',
			      @t_from  = @w_sp_name,
			      @i_num   = 999998,
				  @i_msg   = 'Error al ejecutar regla edad minima'

				end
			print 'Resultado: '+@w_resultado

			select @w_edad_minima= convert(int,SUBSTRING(@w_resultado,0, CHARINDEX('|',@w_resultado)))
			print 'edad minima: ' + convert(varchar,@w_edad_minima)
            select @w_edad_maxima= convert(int,SUBSTRING(@w_resultado,CHARINDEX('|',@w_resultado)+1,2))
			print 'edad maxima: ' + convert(varchar,@w_edad_maxima)

			if ( @w_edad_cliente >= @w_edad_minima and @w_edad_cliente < @w_edad_maxima)
			begin
				select @o_resultado ='SI'
				print @o_resultado
			end
			else
				select @o_resultado ='NO'
				print @o_resultado
		end
		
		if @i_tproducto = 'REVOLVENTE'
		begin
			select  @w_grupo		= io_campo_1,
				    @w_tramite 		= io_campo_3
			from cob_workflow..wf_inst_proceso
			where io_id_inst_proc 	= @i_id_inst_proc

			select @w_promocion = isnull(tr_promocion, 'N')
			from cob_credito..cr_tramite
			where tr_tramite = @w_tramite
			
			select @w_fecha = p_fecha_nac from cobis..cl_ente where en_ente = @i_ente 
	
			select @w_edad_cliente = convert(varchar,DATEDIFF(yyyy, @w_fecha, GETDATE()))

			select @w_ciclo = count(op_operacion) + 1  from cob_cartera..ca_operacion where op_toperacion='REVOLVENTE' and op_cliente = @i_ente

			select @w_cadena = @i_tproducto +'|'+@w_promocion+'|'+convert(varchar(5),@w_ciclo)
			print 'Cadena: '+@w_cadena
				exec  	@w_return = cob_pac..sp_rules_param_run
						@s_rol                   = 1,
						@i_rule_mnemonic         = 'EGRUPO',
						@i_modo                  = 'S',
						@i_tipo                  = 'S',
						@i_var_values            = @w_cadena, 	
						@i_var_separator         = '|',
						@o_return_variable       = @w_variables  out,
						@o_return_results        = @w_resultado  out,
						@o_last_condition_parent = @w_parent     out
				
				print @w_resultado
				print @w_parent

				if @w_return <> 0 
				begin
				  exec cobis..sp_cerror
			      @t_debug = '',
			      @t_file  = '',
			      @t_from  = @w_sp_name,
			      @i_num   = 999998,
				  @i_msg   = 'Error al ejecutar regla edad minima'

				end

			select @w_edad_minima= convert(int,SUBSTRING(@w_resultado,0, CHARINDEX('|',@w_resultado)))
			print 'edad minima: ' + convert(varchar,@w_edad_minima)
            select @w_edad_maxima= convert(int,SUBSTRING(@w_resultado,CHARINDEX('|',@w_resultado)+1,2))
			print 'edad maxima: ' + convert(varchar,@w_edad_maxima)
			
			if ( @w_edad_cliente >= @w_edad_minima and @w_edad_cliente < @w_edad_maxima)
			begin
				select @o_resultado ='SI'
			end
			else
				select @o_resultado ='NO'
		end

		if @i_tproducto = 'INDIVIDUAL'
		begin
			print @i_tproducto
			select @w_ciclo = isnull(en_nro_ciclo,0) + 1
			from cobis..cl_ente, cobis..cl_ente_aux
			where en_ente = @i_ente 
			and   ea_ente = @i_ente

			select  @w_grupo		= io_campo_1,
				    @w_tramite 		= io_campo_3
			from cob_workflow..wf_inst_proceso
			where io_id_inst_proc 	= @i_id_inst_proc

			select @w_promocion = isnull(tr_promocion, 'N')
			from cob_credito..cr_tramite
			where tr_tramite = @w_tramite
			
			select @w_fecha = p_fecha_nac from cobis..cl_ente where en_ente = @i_ente 
	
			select @w_edad_cliente = convert(varchar,DATEDIFF(yyyy, @w_fecha, GETDATE()))

			select @w_cadena = @i_tproducto +'|'+@w_promocion+'|'+convert(varchar(5),@w_ciclo)
			print 'Cadena: '+@w_cadena
				exec  	@w_return = cob_pac..sp_rules_param_run
						@s_rol                   = 1,
						@i_rule_mnemonic         = 'EGRUPO',
						@i_modo                  = 'S',
						@i_tipo                  = 'S',
						@i_var_values            = @w_cadena, 	
						@i_var_separator         = '|',
						@o_return_variable       = @w_variables  out,
						@o_return_results        = @w_resultado  out,
						@o_last_condition_parent = @w_parent     out
				
				print @w_resultado
				print @w_parent

				if @w_return <> 0 
				begin
				  exec cobis..sp_cerror
			      @t_debug = '',
			      @t_file  = '',
			      @t_from  = @w_sp_name,
			      @i_num   = 999998,
				  @i_msg   = 'Error al ejecutar regla edad minima'

				end

			select @w_edad_minima= convert(int,SUBSTRING(@w_resultado,0, CHARINDEX('|',@w_resultado)))
			print 'edad minima: ' + convert(varchar,@w_edad_minima)
            select @w_edad_maxima= convert(int,SUBSTRING(@w_resultado,CHARINDEX('|',@w_resultado)+1,2))
			print 'edad maxima: ' + convert(varchar,@w_edad_maxima)
			
			if ( @w_edad_cliente >= @w_edad_minima and @w_edad_cliente <= @w_edad_maxima)
			begin
				select @o_resultado ='SI'
			end
			else
				select @o_resultado ='NO'

		end
	return 0
go
