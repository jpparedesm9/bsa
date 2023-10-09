/************************************************************************/
/*  Archivo:                sp_var_validacion_animate.sp                */
/*  Stored procedure:       sp_var_validacion_animate                   */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           D. Cumbal                                   */
/*  Fecha de Documentacion: 15/Nov/2019                                 */
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
/* 15/Nov/2019   D. Cumbal    Emision Inicial                           */
/* 19/Nov/2019   ALD		  Calificacion E no permitida	            */
/* 29/Oct/2020   S. Rojas     Mejoras                                   */
/* 30/Sep/2021   ACH          ERR#168924,se toma el parametro de ingreso*/
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_validacion_animate')
	drop proc sp_var_validacion_animate
GO


CREATE PROC sp_var_validacion_animate(
@s_ssn          int         = null,
@s_ofi          smallint    = null,
@s_user         login       = null,
@s_date         datetime    = null,
@s_srv          varchar(30) = null,
@s_term	        descripcion = null,
@s_rol		    smallint    = null,
@s_lsrv	        varchar(30) = null,
@s_sesn 	    int 	    = null,
@s_org		    char(1)     = NULL,
@s_org_err      int 	    = null,
@s_error        int 	    = null,
@s_sev          tinyint     = null,
@s_msg          descripcion = null,
@t_rty          char(1)     = null,
@t_trn          int         = null,
@t_debug        char(1)     = 'N',
@t_file         varchar(14) = null,
@t_from         varchar(30) = null,
--variables
@i_id_inst_proc int,    --codigo de instancia del proceso
@i_id_inst_act  int,    
@i_id_asig_act  int,
@i_id_empresa   int, 
@i_id_variable  smallint 
)
as
declare  
@w_sp_name       	   varchar(32),
@w_return        	   int,
---var variables	   
@w_valor_ant      	   varchar(255),
@w_valor_nuevo    	   varchar(255),
@w_grupo	           int,
@w_ttramite           varchar(255),
@w_tramite            int,
@w_tramite_ant        int,
@w_promocion          char(1),
@w_ciclo_grupal       int,
@w_clientes_ext_cal_c int,
@w_clientes_ext       int,
@w_numero_actual      int,
@w_cliente_consultado int,
@w_comentario         varchar(1000),
@w_integrantes        int,
@w_variables          varchar(255),
@w_result_values      varchar(255),
@w_parent             varchar(255),
@w_resultado          varchar(30),
@w_asig_act           int,
@w_numero             int,
@w_proceso			   varchar(5),
@w_usuario	   	       varchar(64),
@w_nombre		       varchar(50),
@w_num_maximo         int,
@w_calificacion       char(1),
@w_linea               int
         
select @w_sp_name='sp_var_validacion_animate'

select   
@w_grupo       = convert(int,io_campo_1),
@w_tramite     = convert(int,io_campo_3),
@w_tramite_ant = convert(int,io_campo_5),
@w_ttramite    = io_campo_4,	     
@w_asig_act = convert(int,@i_id_asig_act)--io_campo_2
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_grupo = isnull(@w_grupo,0)
if @w_grupo = 0 return 0

select @w_valor_nuevo  = '0'

if @w_ttramite = 'GRUPAL'
begin
   /* Comienza validacion de calificacion de clientes externos */
   
   select @w_promocion = tr_promocion
   from cob_credito..cr_tramite
   where tr_tramite = @w_tramite
   
   select @w_ciclo_grupal = isnull(gr_num_ciclo,0) +1
   from   cobis..cl_grupo
   where  gr_grupo = @w_grupo
	   
   if (@w_promocion='S' and @w_tramite >0 and @w_ciclo_grupal=1)
   begin
   	   CREATE TABLE #clientes(
		[idClientes] [int] NOT NULL IDENTITY(1,1),
		[ea_ente]    [int] NOT NULL)
        
        insert into #clientes	
		select   ea_ente 
		from cobis..cl_ente_aux,
		     cob_credito..cr_tramite_grupal
		where ea_nivel_riesgo_cg in('C','E')
		and   ea_ente            = tg_cliente
		and   tg_participa_ciclo = 'S'   
		and   tg_grupo           = @w_grupo
		and   tg_tramite         = @w_tramite
		and   tg_cliente not in  ( select gpi_ente 
		                           from cob_credito..cr_grupo_promo_inicio 
		                           where gpi_grupo = @w_grupo)
		                           
        
        select @w_clientes_ext_cal_c  = isnull(count(1),0) from  #clientes
		
		if @w_clientes_ext_cal_c = 0 
		begin
		    select @w_integrantes = count(distinct(cg_ente)) from cobis..cl_cliente_grupo 
			where cg_grupo = @w_grupo and cg_estado = 'V'
         
			exec  @w_return = cob_pac..sp_rules_param_run
			@s_rol                   = 1,
			@i_rule_mnemonic         = 'MAXEXT',
			@i_modo                  = 'S',
			@i_tipo                  = 'S',
			@i_var_values            = @w_integrantes, 
			@i_var_separator         = '|',
			@o_return_variable       = @w_variables  out,
			@o_return_results        = @w_resultado  out,
			@o_last_condition_parent = @w_parent     out
            
			if @w_return <> 0 begin
				  exec cobis..sp_cerror
			      @t_debug = @t_debug,
			      @t_file  = @t_file,
			      @t_from  = @w_sp_name,
			      @i_num   = 999998,
				  @i_msg   = 'Error al ejecutar regla maximos externos'
            end
             
			select @w_result_values= convert(int,SUBSTRING(@w_resultado,0, CHARINDEX('|',@w_resultado)))
		    
		    truncate table #clientes
		    insert into #clientes	
		    select   ea_ente 
		    from cobis..cl_ente_aux,
		         cob_credito..cr_tramite_grupal
		    where ea_nivel_riesgo_cg in ('A', 'B','D')
		    and   ea_ente            = tg_cliente
		    and   tg_participa_ciclo = 'S'   
		    and   tg_grupo           = @w_grupo
		    and   tg_tramite         = @w_tramite
		    and   tg_cliente not in  ( select gpi_ente 
		                           from cob_credito..cr_grupo_promo_inicio 
		                           where gpi_grupo = @w_grupo)
			
			
			select @w_clientes_ext = isnull(count(1),0) from  #clientes
		end
		print '@w_clientes_ext' + convert(varchar,@w_clientes_ext)
		
		if (@w_clientes_ext > @w_result_values) or @w_clientes_ext_cal_c > 0
		begin
		     print 'ERROR VALIDACION ANIMATE CLIENTE CON CALIFICACION NO PERMITIDA:' + convert(varchar,@w_asig_act)
			 select @w_valor_nuevo  = '1' -- 0 (cumple la politica)
			 
			 if @w_clientes_ext_cal_c > 0
			    select @w_num_maximo = @w_clientes_ext_cal_c
			 else
			    select @w_num_maximo = @w_clientes_ext
			 
		     select @w_numero_actual = 1
		     while (@w_numero_actual<=@w_num_maximo)
		     begin
		      	 select @w_cliente_consultado =ea_ente from #clientes where idClientes=@w_numero_actual 
		         select @w_nombre= en_nomlar from cobis..cl_ente where en_ente=@w_cliente_consultado
		         select @w_calificacion= ea_nivel_riesgo_cg from cobis..cl_ente_aux where ea_ente=@w_cliente_consultado
		         select @w_comentario = @w_comentario + ' '+isnull(@w_calificacion,'C')+':'
		         select @w_comentario = @w_comentario + convert(varchar,@w_cliente_consultado);
		         select @w_comentario = @w_comentario +' '+@w_nombre
			     if( @w_numero_actual<=@w_num_maximo-1)
			             select @w_comentario= @w_comentario+','
			 
		         select @w_numero_actual=@w_numero_actual+1;
	         end
	         
			 delete cob_workflow..wf_observaciones 
             where ob_id_asig_act = @w_asig_act
             and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
             where ol_id_asig_act = @w_asig_act 
             and (ol_texto like 'ERROR: LOS SIGUIENTES INTEGRANTES DEL GRUPO TIENEN CALIFICACION NO PERMITIDA%'
             or   ol_texto like 'ERROR VALIDACION ANIMATE CLIENTES EXTERNOS:%'))
               
             delete cob_workflow..wf_ob_lineas 
             where ol_id_asig_act = @w_asig_act 
             and  (ol_texto like 'ERROR: LOS SIGUIENTES INTEGRANTES DEL GRUPO TIENEN CALIFICACION NO PERMITIDA%'
             or    ol_texto like 'ERROR VALIDACION ANIMATE CLIENTES EXTERNOS:%')
             
             if @w_clientes_ext_cal_c > 0  
                set @w_comentario = 'ERROR: LOS SIGUIENTES INTEGRANTES DEL GRUPO TIENEN CALIFICACION NO PERMITIDA ' +  @w_comentario
             else
                set @w_comentario = 'ERROR VALIDACION ANIMATE CLIENTES EXTERNOS:' +  @w_comentario
                
             set @w_comentario = substring(@w_comentario,0,len(@w_comentario)) + '.'
             
             select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
             where ob_id_asig_act = @w_asig_act
             order by ob_numero desc
            
             if (@w_numero is not null)
                 select @w_numero = @w_numero + 1 --aumento en uno el maximo
             else
                 select @w_numero = 1
               
             select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user 
			 
			 select @w_linea = 0
	         
			 select top 1 @w_linea = ol_linea 
             from cob_workflow..wf_ob_lineas
             where ol_id_asig_act = @w_asig_act
             order by ol_linea desc
   
	         if len(@w_comentario) > 255
             begin
                 insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
                 values (@w_asig_act, @w_numero, getdate(), @w_proceso, 2, 'a', @s_user)
                 
                 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                 values (@w_asig_act, @w_numero, @w_linea + 1, substring(@w_comentario,0,254))
                 
                 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                 values (@w_asig_act, @w_numero, @w_linea + 2, substring(@w_comentario,255,255))
             end
             else
             begin
                 insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
                 values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
                 
                 insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
                 values (@w_asig_act, @w_numero, @w_linea + 1, @w_comentario)
             end
		end	
    end
end


print '@i_id_inst_proc, @i_id_variable, @w_valor_nuevo: ' + convert(varchar,@i_id_inst_proc) + '-' + convert(varchar,@i_id_variable) + ' - ' + @w_valor_nuevo

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
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
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
                    mv_codigo_var= @i_id_variable and
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
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

return 0
go
