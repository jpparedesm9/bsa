/************************************************************************/
/*  Archivo:                sp_var_limite_intg_cond.sp                  */
/*  Stored procedure:       sp_var_limite_intg_cond                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 12/Sep/2018                                 */
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
/*  Permite determinar si los integrantes de un grupo promo tienen      */
/*  experiencia crediticia o es un emprededor                           */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 12/Sep/2018   P. Ortiz     Emision Inicial                           */
/* 26/Mar/2019   P. Ortiz     Modificaciones solicitadas 100980         */
/* 13/Feb/2020   D. Cumbal    Modificacion 134459 Animate               */
/* 30/Sep/2021   ACH          ERR#168924,se toma el parametro de ingreso*/
/* 06/Sep/2022   S. Rojas     Requerimiento #190876                     */
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_limite_intg_cond')
	drop proc sp_var_limite_intg_cond
GO


CREATE PROC sp_var_limite_intg_cond(
   @s_ssn        int         = null,
   @s_ofi        smallint    = null,
   @s_user       login       = null,
   @s_date       datetime    = null,
   @s_srv        varchar(30) = null,
   @s_term       descripcion = null,
   @s_rol        smallint    = null,
   @s_lsrv       varchar(30) = null,
   @s_sesn       int         = null,
   @s_org        char(1)     = null,
   @s_org_err    int         = null,
   @s_error      int         = null,
   @s_sev        tinyint     = null,
   @s_msg        descripcion = null,
   @t_rty        char(1)     = null,
   @t_trn        int         = null,
   @t_debug      char(1)     = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30)  = null,
   --variables
   @i_id_inst_proc int,    --codigo de instancia del proceso
   @i_id_inst_act  int,    
   @i_id_asig_act  int,
   @i_id_empresa   int, 
   @i_id_variable  smallint 
)
AS
DECLARE 
@w_sp_name              varchar(32),
@w_tramite              int,
@w_return               INT,
@w_valor_ant            varchar(255),
@w_valor_nuevo          varchar(255),
@w_actividad            catalogo,
@w_grupo                int,
@w_ente                 int,
@w_fecha                datetime,
@w_fecha_dif            datetime,
@w_ttramite             varchar(255),
@w_promocion            char(1),
@w_asig_act             int,
@w_numero               int,
@w_proceso              varchar(5),
@w_usuario              varchar(64),
@w_comentario           varchar(1000),
@w_comentario2           varchar(255),
@w_nombre               varchar(64),
@w_exp_credit           varchar(1),
@w_emprendedor          varchar(1),
@w_tramite_ant          int,
@w_cnt_integrantes      varchar(10),
@w_error                int,
@w_maximo_cond          int,
@w_condicionados        int,
@w_variables            varchar(255),
@w_result_values        varchar(255),
@w_parent               int,
@w_diferencia           int,
@w_id                   int,
@w_msg                  varchar(1000),
@w_division             int,
@w_particiones          varchar(250),
@w_id_observacion       smallint,
@w_activa_conformacion  varchar(30),
@w_promo                char(1),
@w_variable_entrada     varchar(20),
@w_oficina              varchar(20), 
@w_porcentaje_cond      float       

select @w_sp_name='sp_var_limite_intg_cond'

select @w_grupo       = convert(int,io_campo_1),
	   @w_tramite     = convert(int,io_campo_3),
	   @w_ttramite    = io_campo_4,
       @w_asig_act = convert(int,@i_id_asig_act),--io_campo_2
	   @w_tramite_ant = convert(int,io_campo_5)
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc
and   io_campo_7 = 'S'

select @w_tramite = isnull(@w_tramite,0)
if @w_tramite = 0 return 0

/* Parametro Conformacion Activado/Desactivado */
select @w_activa_conformacion = pa_char from cobis..cl_parametro where pa_nemonico = 'POCOGR'

select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'
select @w_comentario2 = 'El grupo no permite mas clientes nuevos condicionados.' 
select @w_comentario = '' 
select @w_msg  = ''

select 
@w_promo   =  isnull(tr_promocion,'N'),
@w_oficina =  convert(varchar,isnull(tr_oficina,0))
from cob_credito..cr_tramite 
where tr_tramite = @w_tramite

if @w_ttramite = 'GRUPAL' and @w_activa_conformacion = 'SI' 
begin
	--CONFORMACION GRUPAL
	select @w_cnt_integrantes = convert(varchar,count(tg_cliente))  
	from cob_credito..cr_tramite_grupal 
	where tg_participa_ciclo = 'S'
	and tg_tramite = @w_tramite
	
	select @w_variable_entrada = @w_promo+'|'+ @w_oficina +'|'+ @w_cnt_integrantes
	
	/* Evalua regla de condicionados del grupo */
	exec @w_error           = cob_pac..sp_rules_param_run
	     @s_rol             = @s_rol,
	     @i_rule_mnemonic   = 'LDCC',
	     @i_modo            = 'S',
	     @i_tipo            = 'S',
	     @i_var_values      = @w_variable_entrada, 
	     @i_var_separator   = '|',
	     @o_return_variable = @w_variables  out,
	     @o_return_results  = @w_result_values   OUT,
	     @o_last_condition_parent = @w_parent out 
	if @w_error<>0
	begin
	    exec @w_error = cobis..sp_cerror
	        @t_debug  = 'N',
	        @t_file   = '',
	        @t_from   = 'sp_rules_param_run',
	        @i_num    = @w_error
	end
	
	select @w_porcentaje_cond = convert(float, substring(@w_result_values, 0, len(@w_result_values) - 1))

	select @w_condicionados = count(*) 
	from cobis..cl_ente_aux,
	     cob_credito..cr_tramite_grupal 
	where ea_nivel_riesgo_cg = 'E' --E = Condicionado
	and ea_ente              = tg_cliente 
	and tg_participa_ciclo   =  'S' 
	and tg_tramite           = @w_tramite
	
	/*Redondeo hacia abajo maximo condicionados con calculo de participantes en base al porcentaje*/
	select @w_maximo_cond = floor(@w_cnt_integrantes * (@w_porcentaje_cond/100)) 
	select @w_diferencia = @w_condicionados - @w_maximo_cond
	
	if (@w_condicionados > @w_maximo_cond)
	begin
	   if(@w_tramite_ant is not null)
	   begin
		   if exists (select 1 from cobis..cl_ente_aux, cob_credito..cr_tramite_grupal where ea_ente = tg_cliente
							and tg_participa_ciclo = 'S' and tg_tramite = @w_tramite and ea_nivel_riesgo_cg = 'E' --E = Condicionado
								and ea_ente not in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_participa_ciclo = 'S' and tg_tramite = @w_tramite_ant))
			begin
				select @w_valor_nuevo = 'NO'
			   /* Reasignar mensaje */
				select @w_msg = @w_comentario2
			end
			else
			begin
				select @w_valor_nuevo = 'SI'
			end
		end
	   else
	   begin
	   	set nocount on
			select @w_valor_nuevo = 'NO'
			declare @w_lista table
			   (id     int         identity,
			    ente   int         null,
			    nombre varchar(64))
			
			if @w_tramite_ant is not null
			begin
				insert into  @w_lista 
				select en_ente, (isnull(en_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')) as nombres
				  from cobis..cl_ente_aux, cobis..cl_cliente_grupo, cobis..cl_ente, cob_credito..cr_tramite_grupal
				  where ea_ente            = cg_ente
				   and  ea_ente            = en_ente
				   and  cg_grupo           = @w_grupo
				   and  cg_estado          = 'V'
				   and  ea_nivel_riesgo_cg = 'E'
				   and  tg_tramite         = @w_tramite
				   and  tg_cliente         = ea_ente
				   and  tg_participa_ciclo = 'S'
				   and en_ente     not in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_participa_ciclo = 'S' and tg_tramite = @w_tramite_ant)                    
				order by ea_sum_vencido desc,
						 ea_num_vencido desc
				
				insert into  @w_lista 
				select en_ente, (isnull(en_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')) as nombres
				  from cobis..cl_ente_aux, cobis..cl_cliente_grupo, cobis..cl_ente, cob_credito..cr_tramite_grupal
				  where ea_ente            = cg_ente
				   and  ea_ente            = en_ente
				   and  cg_grupo           = @w_grupo
				   and  cg_estado          = 'V'
				   and  ea_nivel_riesgo_cg = 'E'
				and  tg_tramite         = @w_tramite
				and  tg_cliente         = ea_ente
				and  tg_participa_ciclo = 'S'
				and en_ente          in (select tg_cliente from cob_credito..cr_tramite_grupal where tg_participa_ciclo = 'S' and tg_tramite = @w_tramite_ant)
				order by ea_sum_vencido desc,
				     ea_num_vencido desc
			end
			
			insert into  @w_lista 
			select en_ente, (isnull(en_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')) as nombres
			  from cobis..cl_ente_aux, cobis..cl_cliente_grupo, cobis..cl_ente, cob_credito..cr_tramite_grupal
			  where ea_ente            = cg_ente
			   and  ea_ente            = en_ente
			   and  cg_grupo           = @w_grupo
			   and  cg_estado          = 'V'
			   and  ea_nivel_riesgo_cg = 'E'
			and  tg_tramite         = @w_tramite
			and  tg_cliente         = ea_ente
			and  tg_participa_ciclo = 'S'
			and en_ente        not in (select ente from @w_lista)
			order by ea_sum_vencido desc,
			     ea_num_vencido desc
			
			select @w_id   = 0
			while 1 = 1     
			begin
				select top 1
				    @w_id     = id,
				    @w_nombre = nombre
				from @w_lista
				where id > @w_id      
				order by id
				if @@rowcount = 0
					break
				
				select @w_comentario = @w_comentario + ', '  + @w_nombre 
			end
	   	
	   	select @w_error = 103179, 
			       @w_msg   = replace(replace(mensaje, 'X', convert(varchar, @w_diferencia)), '<lista>', @w_comentario)
			from cobis..cl_errores 
			where numero = 103179
	   end
	   
	   if @w_valor_nuevo = 'NO'
	   begin
			/* Borrar mensajes anteriores */
			select @w_id_observacion = ol_observacion from  cob_workflow..wf_ob_lineas 
			where ol_id_asig_act = @w_asig_act 
			and ol_texto like 'El grupo no permite mas clientes nuevos condicionados%'
			
			if @w_id_observacion is null
				select @w_id_observacion = ol_observacion from  cob_workflow..wf_ob_lineas 
				where ol_id_asig_act = @w_asig_act 
				and ol_texto like 'El grupo excede los CONDICIONADOS, se recomienda eliminar%'
			
			delete cob_workflow..wf_observaciones 
			where ob_id_asig_act = @w_asig_act
			and ob_numero = @w_id_observacion
			
			delete cob_workflow..wf_ob_lineas 
			where ol_id_asig_act = @w_asig_act 
			and ol_observacion = @w_id_observacion
			
			
			select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
			where ob_id_asig_act = @w_asig_act
			order by ob_numero desc
			
			if (@w_numero is not null)
				select @w_numero = @w_numero + 1 --aumento en uno el maximo
			else
				select @w_numero = 1
			
			select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
			
			if(len(@w_msg) < 250)
			begin
				insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
				values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, @s_user, @w_usuario)
				
				insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
				values (@w_asig_act, @w_numero, 1, @w_msg)
			end
			else
			begin
				insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
				values (@w_asig_act, @w_numero, getdate(), @w_proceso, 4, @s_user, @w_usuario)
				
				select @w_division = (len(@w_msg)/4)
				
				select @w_particiones = substring(@w_msg,0,@w_division + 1)
				
				insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
				values (@w_asig_act, @w_numero, 1, @w_particiones)
				
				select @w_particiones = substring(@w_msg,@w_division + 1,@w_division)
				
				insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
				values (@w_asig_act, @w_numero, 2, @w_particiones)
				
				select @w_particiones =  substring(@w_msg,(@w_division *2),@w_division)
				
				insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
				values (@w_asig_act, @w_numero, 3, @w_particiones)
				
				select @w_particiones =  substring(@w_msg,(@w_division *3),len(@w_msg))
				
				insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
				values (@w_asig_act, @w_numero, 4, @w_particiones)
			end
		end
	end
	else
	begin
		select @w_valor_nuevo = 'SI'
	end
end
else if @w_activa_conformacion = 'NO'
begin
   select @w_valor_nuevo = 'SI'
end


-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
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
--print '@i_id_inst_proc %1! @i_id_asig_act %2! @w_valor_ant %3!',@i_id_inst_proc, @i_id_asig_act, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
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

return 0

go