/************************************************************************/
/*  Archivo:                sp_var_marca_interna_renapo.sp              */
/*  Stored procedure:       sp_var_marca_interna_renapo                 */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           P. Ortiz                                    */
/*  Fecha de Documentacion: 20/Feb/2020                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "COBISCORP",representantes exclusivos para el Ecuador de la AT&T    */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de COBISCORP o su representante               */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Determina la cantidad de integrantes que forman parte de un grupo    */
/* promo pero no vienen de una entidad externa                          */
/************************************************************************/
/*                    MODIFICACIONES                                    */
/*  FECHA         AUTOR                     RAZON                       */
/* 20/Feb/2020    P. Ortiz    Emision Inicial                           */
/* 30/Sep/2021    ACH         ERR#168924,se toma el parametro de ingreso*/
/* **********************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_marca_interna_renapo')
	drop proc sp_var_marca_interna_renapo
go

create proc sp_var_marca_interna_renapo(
   @s_ssn            int         = null,
   @s_ofi            smallint    = null,
   @s_user           login       = null,
   @s_date           datetime    = null,
   @s_srv		     varchar(30) = null,
   @s_term	         descripcion = null,
   @s_rol		     smallint    = null,
   @s_lsrv	         varchar(30) = null,
   @s_sesn	         int 	      = null,
   @s_org		     char(1)     = null,
   @s_org_err����    int 	      = null,
   @s_error������    int 	      = null,
   @s_sev            tinyint     = null,
   @s_msg            descripcion = null,
   @t_rty            char(1)     = null,
   @t_trn            int         = null,
   @t_debug          char(1)     = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   --variables
   @i_id_inst_proc   int,    --codigo de instancia del proceso
   @i_id_inst_act    int,    
   @i_id_asig_act    int,
   @i_id_empresa     int, 
   @i_id_variable    smallint 
) 
as 
declare 
@w_sp_name           varchar(32),
@w_tramite           int,
@w_return            int,
@w_valor_ant         varchar(255),
@w_valor_nuevo       varchar(255),
@w_actividad         catalogo,
@w_grupo			      int,
@w_ente              int,
@w_ttramite          varchar(255),
@w_asig_act          int,
@w_numero            int,
@w_proceso		     varchar(5),
@w_usuario		     varchar(64),
@w_comentario	     varchar(1000),
@w_division          int,
@w_particiones       varchar(250),
@w_comentario_aux    varchar(500),
@w_check_renapo      varchar(2),
@w_param_renapo      char(1)

select @w_sp_name='sp_var_marca_interna_renapo'

/* PARAMETROS */
select @w_proceso = pa_int from cobis..cl_parametro where pa_nemonico = 'OAA'
select @w_param_renapo = pa_char from cobis..cl_parametro where pa_nemonico = 'RENAPO'

select
@w_param_renapo = isnull(@w_param_renapo, 'N'),
@w_valor_nuevo  = 'S'

if @w_param_renapo = 'S' begin
   select 
   @w_grupo      = convert(int,io_campo_1),
   @w_tramite    = convert(int,io_campo_3),
   @w_ttramite   = io_campo_4,
   @w_asig_act = convert(int,@i_id_asig_act)--io_campo_2
   from cob_workflow..wf_inst_proceso
   where io_id_inst_proc = @i_id_inst_proc
   
   select @w_tramite = isnull(@w_tramite,0)
   if @w_tramite = 0 return 0
   
   select @w_comentario_aux = ''
   
   print 'INICIA PROCESO sp_var_marca_interna_renapo'
   if @w_ttramite = 'GRUPAL'
   begin
      select @w_comentario = 'Los siguientes integrantes no se encuentran validados en RENAPO:'
      
      select @w_ente = 0
      while 1 = 1
      begin
         
         select top 1 @w_ente = cg_ente 
         from cobis..cl_cliente_grupo, cob_credito..cr_tramite_grupal 
         where cg_grupo = @w_grupo
         and tg_tramite = @w_tramite
         and cg_grupo = tg_grupo
         and tg_cliente = cg_ente
         and tg_participa_ciclo = 'S'
         and cg_estado = 'V'
         and cg_ente > @w_ente
         order by cg_ente asc
         
         if @@rowcount = 0
              break
         
         select @w_check_renapo = ltrim(rtrim(ea_consulto_renapo))
         from cobis..cl_ente_aux 
         where ea_ente = @w_ente
         
         if @w_check_renapo <> 'S' and @w_check_renapo is not null
         begin
            select @w_comentario_aux = @w_comentario_aux + convert(varchar,@w_ente) + ', '
         end
      end --end while
   end
   else
   begin
      select @w_comentario = 'El cliente no se encuentra validado en RENAPO:'
      select @w_ente = @w_grupo
      
      select @w_check_renapo = ea_consulto_renapo 
      from cobis..cl_ente_aux 
      where ea_ente = @w_ente
      
      if @w_check_renapo <> 'S' and @w_check_renapo is not null
      begin
         select @w_comentario_aux = @w_comentario_aux + convert(varchar,@w_ente) + ', '
      end
   end
   print 'El comentario auxiliar es: ' + @w_comentario_aux
   if @w_comentario_aux <> ''
   begin
      select @w_valor_nuevo = 'N'
      
      /* Borrar mensajes anteriores */
      delete cob_workflow..wf_observaciones 
      where ob_id_asig_act = @w_asig_act
      and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and ol_texto like '%' + @w_comentario + '%')
      
      delete cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and ol_observacion in (select ol_observacion from  cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and ol_texto like '%' + @w_comentario + '%')
      
      select @w_comentario = @w_comentario + ' ' + substring(@w_comentario_aux,0,len(@w_comentario_aux)+1) + '. ' 
      
      select top 1 @w_numero = ob_numero from cob_workflow..wf_observaciones 
      where ob_id_asig_act = @w_asig_act
      order by ob_numero desc
      
      if @w_numero is not null
      	select @w_numero = @w_numero + 1 --aumento en uno el maximo
      else
      	select @w_numero = 1
      
      select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user
      
      if len(@w_comentario) > 255
      begin
         insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
         values (@w_asig_act, @w_numero, getdate(), @w_proceso, 4, 'a', @w_usuario)
         
         select @w_division = (len(@w_comentario)/4)
         
         select @w_particiones = substring(@w_comentario,0,@w_division + 1)
         
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 1, @w_particiones)
         
         select @w_particiones = substring(@w_comentario,@w_division + 1,@w_division)
         
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 2, @w_particiones)
         
         select @w_particiones =  substring(@w_comentario,(@w_division *2),@w_division)
         
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 3, @w_particiones)
         
         select @w_particiones =  substring(@w_comentario,(@w_division *3),len(@w_comentario))
         
         insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
         values (@w_asig_act, @w_numero, 4, @w_particiones)
      end
      else
      begin
           insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
           values (@w_asig_act, @w_numero, getdate(), @w_proceso, 1, 'a', @w_usuario)
           
           insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
           values (@w_asig_act, @w_numero, 1, @w_comentario)
      end
   end
   else
   begin
      select @w_valor_nuevo = 'S'
      
      delete cob_workflow..wf_observaciones 
      where ob_id_asig_act = @w_asig_act
      and ob_numero in (select ol_observacion from  cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and ol_texto like '%' + @w_comentario + '%')
      
      delete cob_workflow..wf_ob_lineas 
      where ol_id_asig_act = @w_asig_act 
      and ol_texto like '%' + @w_comentario + '%'
   end
end 

print 'MARCA INTERNA RENAPO: '+ @w_valor_nuevo
--insercion en estrucuturas de variables

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

END

return 0
go

