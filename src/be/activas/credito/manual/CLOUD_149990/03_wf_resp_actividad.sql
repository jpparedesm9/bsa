
use cob_workflow
go
if exists (select 1 from sysobjects
            where name = 'sp_resp_actividad_wf')
begin  
  drop procedure sp_resp_actividad_wf
end
go
/************************************************************/
/*   ARCHIVO:         wf_resp_actividad.sp                  */
/*   NOMBRE LOGICO:   sp_resp_actividad_wf                  */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Respuesta del usuario a una actividad que se le envio.  */
/*  Las posibles respuestas son:                            */
/*         - Respondida.                                    */
/*         - Rechazada.                                     */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA        AUTOR             RAZON                   */
/*   27-Ago-2001  Mario Valarezo A. Emision Inicial.        */
/************************************************************/
create procedure sp_resp_actividad_wf
(
  @s_ssn                int         = null,
  @s_user               varchar(30) = null,
  @s_sesn               int         = null,
  @s_term               varchar(30) = null,
  @s_date               datetime    = null,
  @s_srv                varchar(30) = null,
  @s_lsrv               varchar(30) = null,
  @s_ofi                smallint    = null,
  @t_trn                int         = null,
  @t_debug              char(1)     = 'N',
  @t_file               varchar(14) = null,
  @t_from               varchar(30) = null,
  @s_culture            varchar(10) = null,
  @s_rol                smallint    = null,
  @s_org_err            char(1)     = null,
  @s_error              int         = null,
  @s_sev                tinyint     = null,
  @s_msg                descripcion = null,
  @s_org                char(1)     = null,
  @s_service            int         = null,
  @t_rty                char(1)     = null,

  @i_operacion          char (1),

  @i_id_inst_proc       int,
  @i_id_inst_act        int,
  @i_id_asig_act        int         = 0,
  @i_id_paso            int         = null,
  @i_codigo_res         int         = null,
  @i_ofi_inicio         int         = null,
  @i_ofi_entrega        smallint    = null,
  @i_ofi_asignacion     smallint    = null,

  -- Si este parametro es null, el responder actividad se comporta
  -- de manera normal, pero si tiene el valor = 1 no debe hacer
  -- nada mas que mostrarle al operador los usuarios a los que
  -- puede asignar la actividad.
  @i_asig_manual        tinyint      = 0,
  @i_id_empresa         smallint     = null,
  @i_actualiza_var      char(1)      = 'S',
  @i_canal              int    = null,
  @o_id_excepcion       smallint     = null out,
  @o_id_rol             int          = null out
)
As declare
  @w_sp_name              varchar(64),
  @w_tipo_actividad       varchar(10),
  @w_id_actividad         int,
  @w_id_proceso           int,
  @w_version              int,
  @w_cont_reg  			  int,--AC
  @w_contador  			  int,--AC
  @w_return_code 		  int,--AC
  @w_return_value         varchar(255),--AC
  @w_return_value_desc    varchar(255),--AC
  @w_id_rule 			  int,--AC
  @w_id_rule_version	  int,--AC
  @w_acronym			  varchar(20),

  -- Utilizados controlar las Jerarquias de Participantes.
  @w_id_destinatario      int,
  @w_tipo_destinatario    varchar(10),
  @w_tipo_dist_carga      varchar(10),
  @w_codigo_dist_carga    int,
  @w_tipo_oficina         varchar(10),
  @w_requiere_usr_log     tinyint,
  @w_tiempo_efectivo      int,
  @w_id_rol_ini           int,
  @w_id_rol_fin           int,
  @w_sig_actividad        BOOLEANO,
  @w_verif_requisitos     tinyint,
  @w_inst_exce            char(1),
  @w_excepcion            char(1),
  @w_instruccion          char(1),

  -- Utilizados cuando se trata de un comite.
  @w_usuario_cabecera     int,
  @w_usuario              int,

  @w_retorno              int,
  @w_min_id_inst_act      int,
  @w_destinatario         int,
  @w_rol_dest             int,
  @w_oficina_asig         smallint,
  @w_id_paso              int,
  @w_id_paso_actual       int,
  @w_est_fin_proc         char(10),
  @w_est_proc_actual      varchar(10),
  @w_tramite              int,
  
  -- Notificaciones.
  @w_notificacion         char,
  @w_sms                  char,
  @w_email                char,
  @w_console              char,
  @w_notificado           login,
  @w_texto_notificacion   varchar(255),
  @w_num_sms              varchar(64),
  @w_email_notificado     varchar(200),
  @w_trancount            int,
  @w_error_politicas      char,
  @w_asig_estado          varchar(10),  -- OGU 23/09/2015 Estado 
  @w_evalua_politica      char(1),	    -- AC  11/09/2015 Estado 
  @w_tipo_email           varchar(1),   -- AC  11/09/2015 Notificacion 
  @w_mensaje_email        int,		    -- AC  11/09/2015 Notificacion 
  @w_nombre_programa      varchar(255), -- AC  11/09/2015 Notificacion 
  @w_base_datos		      varchar(255),	
																		
  @w_codigo_alterno 	  varchar(50),
  @w_subject              varchar(255),
  @w_mensaje_error        varchar(255),
  @w_es_accion_retorno    char(1),
  @w_text1                varchar(64),
  @w_text2                varchar(64)
  
--print 'Ejecutando sp_resp_actividad'

select @w_sp_name       = 'sp_resp_actividad_wf',
       @w_sig_actividad = 0
	   
if @s_service is not null
begin
	select @i_canal = @s_service
end


--VALIDACIONES EN ESTE SP.

--OGU 23/09/2015 Verifica si la actividad si la actividad se encuentra reasignada
if exists(select 1 from wf_asig_actividad
		   where aa_id_asig_act = @i_id_asig_act
			 and aa_estado = 'REA')
begin
	exec cobis..sp_cerror
		 @t_from = @w_sp_name,
		 @i_num  = 3107587
	return 1
end
	
-- Verifica si la  instancia de actividad esta suspendida
if exists (select 1 from wf_actividad_proc, wf_inst_actividad
            where ar_codigo_actividad = ia_codigo_act
              and ia_id_inst_act      = @i_id_inst_act
              and (ar_suspendida       = 1 or ia_estado = 'SUS'))
begin
  exec cobis..sp_cerror
       @t_from = @w_sp_name,
       @i_num  = 3107517
  return 1
end

select @w_tramite = null

-- Trae el codigo, version del proceso, estado, y campo_3 de la wf_inst_proceso
select @w_id_proceso      = io_codigo_proc,
       @w_version         = io_version_proc,
       @w_est_proc_actual = io_estado,
       @w_tramite         = io_campo_3,
	   @i_ofi_inicio      = isnull(@i_ofi_inicio, io_oficina_inicio),
       @i_canal           = isnull(@i_canal, io_canal)
  from wf_inst_proceso
 where io_id_inst_proc    = @i_id_inst_proc

-- Verifica instancia de proceso esta suspendida, cancelada, o terminada.
if @w_est_proc_actual in ('CAN', 'TER', 'ELI') or
   (@w_est_proc_actual = 'SUS' and @i_operacion <> 'R')  -- PUEDE PROCESAR PARA eliminar el proceso
begin
  exec cobis..sp_cerror
       @t_from = @w_sp_name,
       @i_num  = 3107518
  return 1
end

-- Verifica que la actividad ya ejecutada no vuelva a ser ruteada
if exists (select 1 from wf_inst_actividad, wf_asig_actividad
            where ia_id_inst_act     = aa_id_inst_act
              and ia_id_inst_act     = @i_id_inst_act
              and ia_fecha_fin  is not null
              and ia_estado          = 'COM'
              and aa_codigo_res is not null
              and aa_fecha_fin  is not null
              and aa_estado          = 'COM')
begin
  exec cobis..sp_cerror
       @t_from = @w_sp_name,
       @i_num  = 3107543
  return 1
end

-- Trae el codigo y el tipo de actividad.
select @w_id_actividad     = ac_codigo_actividad,
       @w_tipo_actividad   = ac_tipo_actividad,
       @w_id_paso_actual   = ia_id_paso
  from wf_actividad, wf_inst_actividad
 where ac_codigo_actividad = ia_codigo_act
   and ia_id_inst_act      = @i_id_inst_act
   
   
 -- se realiza actualización debido a duplicidad de transacciones - GVI
 if exists(select 1 from wf_asig_actividad where aa_id_asig_act = @i_id_asig_act and aa_estado <> 'COM')
 begin
	update wf_asig_actividad
       set aa_fecha_fin   = getdate(),
           aa_estado      = 'COM'
     where aa_id_asig_act = @i_id_asig_act --3107543
 end
 else
 begin
	exec cobis..sp_cerror
         @i_num  = 3107543,
         @t_from = @w_sp_name
    return 1
 end

-- Si el usuario ha terminado la actividad. Es decir, si la respondio.
if @i_operacion = 'C'
begin
  
  -- Control de campos mandatorios y coherentes
  if @i_id_inst_proc is null or @i_id_inst_act is null or @i_id_asig_act is null or @i_id_paso is null
  begin
    exec cobis..sp_cerror
         @i_num  = 3107558,
         @t_from = @w_sp_name
    return 1
  end

  -- No deja iniciar proceso cuando se esta cambiando de version.
  if exists (select 1 from wf_proceso
              where pr_codigo_proceso = @w_id_proceso
                and pr_version_prd    = @w_version
                and pr_estado         = 'INA')
  begin
    exec cobis..sp_cerror
         @i_num  = 3107536,
         @t_from = @w_sp_name
    return 1
  end

  -- Traigo informacion de destinatario.
  select @w_id_destinatario   = de_id_destinatario,
         @w_tipo_destinatario = de_tipo_destinatario,
         @w_tipo_dist_carga   = de_tipo_distribucion_carga,
         @w_codigo_dist_carga = de_codigo_dist_carga,
         @w_tipo_oficina      = de_tipo_oficina_dist_carga,
         @w_requiere_usr_log  = de_requiere_usr_log
    from wf_destinatario
   where de_codigo_actividad  = @w_id_actividad
     and de_codigo_proceso    = @w_id_proceso
     and de_version_proceso   = @w_version

  -- Traigo informacion adicional de la actividad.
  select @w_tiempo_efectivo  = ar_tiempo_efectivo,
         @w_inst_exce        = ar_inst_exce
    from wf_actividad_proc
   where ar_codigo_actividad = @w_id_actividad
     and ar_codigo_proceso   = @w_id_proceso
     and ar_version_proceso  = @w_version

  -- Traigo el id y el rol del destinatario anterior.
  select @w_usuario     = aa_id_destinatario,
         @w_id_rol_ini  = aa_id_rol
    from wf_asig_actividad
   where aa_id_asig_act = @i_id_asig_act

  -- Si el rol es comite, traigo el id del usuario cabecera del mismo.
  select @w_usuario_cabecera = ro_id_usuario_cabecera
    from wf_rol
   where ro_id_rol           = @w_id_destinatario
     and ro_es_comite        = 1

  -- Si la actividad debe Aprobar las Intruccciones/Excepciones en estado INI
  -- no debe permitir rutear la actividad
  if exists (select 1 from wf_exc_inst_proc
              where ei_id_inst_proc = @i_id_inst_proc
                and ei_estado       = 'INI')
    select @w_excepcion = 'S'

  if exists (select 1 from wf_ins_inst_proc
              where ii_id_inst_proc = @i_id_inst_proc
                and  ii_estado      = 'INI')
    select @w_instruccion = 'S'

  if (@w_instruccion = 'S' or @w_excepcion = 'S') and @w_inst_exce = 'S'
  begin
    exec cobis..sp_cerror
         @i_num  = 3107588,
         @t_from = @w_sp_name
    return 1
  end
  else
  begin
    if (@w_instruccion = 'S' or @w_excepcion = 'S') and @w_inst_exce != 'S'
      print 'Mensaje informativo.- Existen por Aprobar Intrucciones/Excepciones en el proceso'
  end
    
  select @w_text1 = isnull(re_valor, valor)
  from ((cobis..cl_catalogo c 
    inner join cobis..cl_tabla t 
        on c.tabla = t.codigo)
    left outer join cobis..ad_catalogo_i18n 
        on t.tabla = pc_identificador 
        and c.codigo = pc_codigo 
        and re_cultura = upper(replace(@s_culture,'_','-')))
  where t.tabla =  'wf_mensajes_notificacion'
  and c.codigo = 'TEXT1'
  and c.estado = 'V'

  select @w_text2 = isnull(re_valor, valor)
  from ((cobis..cl_catalogo c 
    inner join cobis..cl_tabla t 
        on c.tabla = t.codigo)
    left outer join cobis..ad_catalogo_i18n 
        on t.tabla = pc_identificador 
        and c.codigo = pc_codigo 
        and re_cultura = upper(replace(@s_culture,'_','-')))
  where t.tabla =  'wf_mensajes_notificacion'
  and c.codigo = 'TEXT2'
  
  select @w_text1 = isnull(@w_text1, 'Se ha ingresado el proceso')
  select @w_text2 = isnull(@w_text2, 'a su bandeja de tareas.')

  --print '1'

  --Llamo a sp de observacion para que compie las tablas temporales
  exec @w_retorno 		= sp_observacion_asig_wf
	   @s_ssn           = @s_ssn, 
	   @s_user          = @s_user, 
	   @s_sesn          = @s_sesn, 
	   @s_term          = @s_term, 
	   @s_date          = @s_date, 
	   @s_srv           = @s_srv, 
	   @s_lsrv          = @s_lsrv, 
	   @s_ofi           = @s_ofi, 
	   @t_trn           = @t_trn,
	   @t_debug         = @t_debug, 
	   @t_file          = @t_file, 
	   @t_from          = @t_from, 
	   @s_rol           = @s_rol,
	   @s_org_err       = @s_org_err, 
	   @s_error         = @s_error, 
	   @s_sev           = @s_sev, 
	   @s_msg           = @s_msg, 
	   @s_org           = @s_org, 
	   @t_rty           = @t_rty, 
	   @i_operacion     = 'T',  -- Pasa a las tablas temporales
	   @i_asig_act      = @i_id_asig_act
	   
	  if @w_retorno != 0
	  begin
		exec cobis..sp_cerror
			 @i_num  = @w_retorno,
			 @t_from = @w_sp_name
		return @w_retorno
	  end
	
	--print '2'
	
	 select @w_evalua_politica  = rs_evalua_politica ,
	        @w_es_accion_retorno = rs_es_retorno
     from   wf_resultado
     where  rs_codigo_resultado = @i_codigo_res

	--JRU - validacion en el caso que la accion de retorno no haya sido parametrizada 
	if @w_es_accion_retorno IS NULL
	BEGIN
		SELECT @w_es_accion_retorno = 'N'
	END	
	
	if @w_es_accion_retorno != 'S'
	begin
	  -- Pasa los requisitos de las temporales a las definitivas
	  exec @w_retorno       = sp_requisito_actividad_wf
		   @s_ssn           = @s_ssn,
		   @s_user          = @s_user,
		   @s_sesn          = @s_sesn,
		   @s_term          = @s_term,
		   @s_date          = @s_date,
		   @s_srv           = @s_srv,
		   @s_lsrv          = @s_lsrv,
		   @s_rol           = @s_rol,
		   @s_ofi           = @s_ofi,
		   @s_org_err       = @s_org_err,
		   @s_error         = @s_error,
		   @s_sev           = @s_sev,
		   @s_msg           = @s_msg,
		   @s_org           = @s_org,
		   @t_rty           = @t_rty,
		   @t_trn           = @t_trn,
		   @t_debug         = @t_debug,
		   @t_file          = @t_file,
		   @t_from          = @t_from,
		   @i_operacion     = 'IF',
		   @i_id_paso       = @i_id_paso,
		   @i_id_inst_proc  = @i_id_inst_proc,
		   @i_id_inst_act   = @i_id_inst_act,
		   @i_id_asig_act   = @i_id_asig_act
		   
		 if @w_retorno != 0
		  begin
			exec cobis..sp_cerror
				 @i_num  = @w_retorno,
				 @t_from = @w_sp_name
			return @w_retorno
		  end

	  --print '3'  
	  
	  -- Si aun no cumple con todos los requisitos de
	  -- caracter mandatorio, no deja 'salir' de la actividad.
	  exec @w_retorno       = sp_requisito_actividad_wf
		   @s_ssn           = @s_ssn,
		   @s_user          = @s_user,
		   @s_sesn          = @s_sesn,
		   @s_term          = @s_term,
		   @s_date          = @s_date,
		   @s_srv           = @s_srv,
		   @s_lsrv          = @s_lsrv,
		   @s_rol           = @s_rol,
		   @s_ofi           = @s_ofi,
		   @s_org_err       = @s_org_err,
		   @s_error         = @s_error,
		   @s_sev           = @s_sev,
		   @s_msg           = @s_msg,
		   @s_org           = @s_org,
		   @t_rty           = @t_rty,
		   @t_trn           = @t_trn,
		   @t_debug         = @t_debug,
		   @t_file          = @t_file,
		   @t_from          = @t_from,

		   @i_operacion     = 'V',
		   @i_id_paso       = @i_id_paso,
		   @i_id_inst_proc  = @i_id_inst_proc,
		   @i_id_inst_act   = @i_id_inst_act,
		   @i_id_asig_act   = @i_id_asig_act,
		   @o_verifica      = @w_verif_requisitos out

	  if @w_retorno != 0
	  begin
		exec cobis..sp_cerror
			 @i_num  = @w_retorno,
			 @t_from = @w_sp_name
		return @w_retorno
	  end
	 
      if @w_verif_requisitos = 0
	  begin -- Si aun no cumple un requisito mandatorio
		exec cobis..sp_cerror
			 @i_num  = 3107535,
			 @t_from = @w_sp_name
		return 1
	  end
	end
 
  --print '4'
 
  if @i_actualiza_var = 'S' and @w_tipo_destinatario != 'PRO'
  begin
    -- Transaccionalidad aplicada a los valores
    -- de las variables actualizadas por programa.
    --begin tran

    -- Se guardan cambios de las variables a historicos.
    exec @w_retorno      = sp_actualiza_var_wf
         @s_ssn          = @s_ssn,
         @s_user         = @s_user,
         @s_sesn         = @s_sesn,
         @s_term         = @s_term,
         @s_date         = @s_date,
         @s_srv          = @s_srv,
         @s_lsrv         = @s_lsrv,
         @s_rol          = @s_rol,
         @s_ofi          = @s_ofi,
         @s_org_err      = @s_org_err,
         @s_error        = @s_error,
         @s_sev          = @s_sev,
         @s_msg          = @s_msg,
         @s_org          = @s_org,
         @t_rty          = @t_rty,
         @t_trn          = @t_trn,
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @t_from,

         @i_id_inst_proc = @i_id_inst_proc,
         @i_id_asig_act  = @i_id_asig_act,
         @i_id_proceso   = @w_id_proceso,
         @i_version      = @w_version,
         @i_id_inst_act  = @i_id_inst_act,
         @i_id_empresa   = @i_id_empresa

    if @w_retorno != 0
    begin -- Fallo en ejecucion del sp.
    
    /*while @@trancount > 0 rollback tran
    */
      exec cobis..sp_cerror
           @i_num  = @w_retorno,
           @t_from = @w_sp_name
           
      return @w_retorno
    end
	
    --commit tran
  end

  --print 'Evaluacion de politicas para el paso (AC)'
      select @w_evalua_politica  = rs_evalua_politica 
      from   wf_resultado
      where  rs_codigo_resultado = @i_codigo_res

	  select @w_cont_reg = count(*) 
	  from wf_paso_pol  
	  where pa_id_paso = @i_id_paso
	  
  if @w_evalua_politica = 'S' and @w_cont_reg > 0
	  begin
		
	  select @w_error_politicas = ia_error_politicas from  wf_inst_actividad where ia_id_inst_act = @i_id_inst_act
		  
  	  if @w_error_politicas is null AND @w_es_accion_retorno != 'S'
			begin 
				exec cobis..sp_cerror
				@i_num  = 3107585,
				@t_from = @w_sp_name
				return 1
	  end
	  
	  if @w_error_politicas <> 'N' AND @w_es_accion_retorno != 'S'
	  begin
		exec cobis..sp_cerror
				@i_num  = 3107582,
				@t_from = @w_sp_name
				return 1
	  end 
	  
  end
  --print '5'
  -- Inicio de transaccionalidad.
  begin tran

  -- Se eliminan los resultados de la tabla temporal.
  exec @w_retorno     = sp_eval_atr_res_wf
       @s_ssn         = @s_ssn,
       @s_user        = @s_user,
       @s_sesn        = @s_sesn,
       @s_term        = @s_term,
       @s_date        = @s_date,
       @s_srv         = @s_srv,
       @s_lsrv        = @s_lsrv,
       @s_rol         = @s_rol,
       @s_ofi         = @s_ofi,
       @s_org_err     = @s_org_err,
       @s_error       = @s_error,
       @s_sev         = @s_sev,
       @s_msg         = @s_msg,
       @s_org         = @s_org,
       @t_rty         = @t_rty,
       @t_trn         = @t_trn,
       @t_debug       = @t_debug,
       @t_file        = @t_file,
       @t_from        = @t_from,

       @i_operacion   = 'D',
       @i_id_asig_act = @i_id_asig_act

  if @w_retorno != 0
  begin -- Se dio un error al ejecutar el SP anterior.
    exec cobis..sp_cerror
         @i_num  = @w_retorno,
         @t_from = @w_sp_name
    rollback tran
    return @w_retorno
  end

  
  --print '6'
  -- Estas operaciones se realizan solo si se trata del Responder Actividad habitual y
  -- si se trata de asignacion manual, estas operaciones se las hace al asignar a cada
  -- uno de los usuarios seleccionados.
  if @i_asig_manual = 0
  begin
    -- Proceso de Evaluacion de Politicas.
    select @o_id_excepcion = 0

	if @w_evalua_politica = 'S'
	begin
		exec @w_retorno      = sp_eval_politicas_wf
			 @s_ssn          = @s_ssn,
			 @s_user         = @s_user,
			 @s_sesn         = @s_sesn,
			 @s_term         = @s_term,
			 @s_date         = @s_date,
			 @s_srv          = @s_srv,
			 @s_lsrv         = @s_lsrv,
			 @s_rol          = @s_rol,
			 @s_ofi          = @s_ofi,
			 @s_org_err      = @s_org_err,
			 @s_error        = @s_error,
			 @s_sev          = @s_sev,
			 @s_msg          = @s_msg,
			 @s_org          = @s_org,
			 @t_rty          = @t_rty,
			 @t_trn          = @t_trn,
			 @t_debug        = @t_debug,
			 @t_file         = @t_file,
			 @t_from         = @t_from,

			 @i_id_inst_proc = @i_id_inst_proc,
			 @i_id_asig_act  = @i_id_asig_act,
			 @i_id_proceso   = @w_id_proceso,
			 @i_version      = @w_version,
			 @o_id_excepcion = @o_id_excepcion out

		if @w_retorno != 0 and @w_es_accion_retorno != 'S'
		begin -- Se dio un error al ejecutar el SP anterior.
		  exec cobis..sp_cerror
			   @i_num  = @w_retorno,
			   @t_from = @w_sp_name
		  rollback tran
		  return @w_retorno
		end
	end

	--print '7'
	
    -- Se actualiza el estado de la asignacion a COMpleto.
    update wf_asig_actividad
       set aa_codigo_res    = @i_codigo_res,
           aa_fecha_fin     = getdate(),
           aa_estado        = 'COM',
		   aa_oficina_login = @s_ofi
     where aa_id_asig_act = @i_id_asig_act

    if @@error != 0
    begin -- Error en la actualizacion de wf_asig_actividad.
      exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 3107506
      rollback tran
      return 1
    end

	
	--print '8'
    -- Se actualiza la tabla de Resumenes de Asignacion.
    exec @w_retorno       = sp_m_res_asig_act_wf
         @s_ssn           = @s_ssn,
         @s_user          = @s_user,
         @s_sesn          = @s_sesn,
         @s_term          = @s_term,
         @s_date          = @s_date,
         @s_srv           = @s_srv,
         @s_lsrv          = @s_lsrv,
         @s_rol           = @s_rol,
         @s_ofi           = @s_ofi,
         @s_org_err       = @s_org_err,
         @s_error         = @s_error,
         @s_sev           = @s_sev,
         @s_msg           = @s_msg,
         @s_org           = @s_org,
         @t_rty           = @t_rty,
         @t_trn           = @t_trn,
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @t_from,

         @i_operacion     = 'F',
         @i_id_inst_act   = @i_id_inst_act,
         @i_id_asig_act   = @i_id_asig_act,
         @i_id_proceso    = @w_id_proceso,
         @i_version_proc  = @w_version,
         @i_id_actividad  = @w_id_actividad,
         @i_id_usuario    = @w_usuario,
         @i_id_rol        = @w_id_rol_ini,
		       @i_oficina_inicio   = @i_ofi_inicio,
		       @i_canal            = @i_canal

    if @w_retorno != 0
    begin
      exec cobis..sp_cerror
           @i_num  = @w_retorno,
           @t_from = @w_sp_name
      rollback tran
      return @w_retorno
    end
  end

  
  --print '9'
  -- Si el tipo de destinatario es una Jerarquia lo asigno al siguiente Rol.
  if @w_tipo_destinatario = 'JER'
  begin
    if exists (select 1 from wf_asig_actividad
                where aa_id_inst_act = @i_id_inst_act
                  and aa_estado not in ('COM', 'REA'))
    begin
      select @w_sig_actividad = 1
    end
    else
    begin
      select @w_sig_actividad = 0
	  if @i_codigo_res =  1  
	  begin
		  -- Se ejecuta la asignacion de Jerarquias.
		  exec @w_retorno           = sp_m_asigna_jerarquia_wf
			   @s_ssn               = @s_ssn,
			   @s_user              = @s_user,
			   @s_sesn              = @s_sesn,
			   @s_term              = @s_term,
			   @s_date              = @s_date,
			   @s_srv               = @s_srv,
			   @s_lsrv              = @s_lsrv,
			   @s_rol               = @s_rol,
			   @s_ofi               = @s_ofi,
			   @s_org_err           = @s_org_err,
			   @s_error             = @s_error,
			   @s_sev               = @s_sev,
			   @s_msg               = @s_msg,
			   @s_org               = @s_org,
			   @t_rty               = @t_rty,
			   @t_trn               = @t_trn,
			   @t_debug             = @t_debug,
			   @t_file              = @t_file,
			   @t_from              = @t_from,

			   @i_id_inst_act       = @i_id_inst_act,
			   @i_id_inst_proc      = @i_id_inst_proc,
			   @i_id_jerarquia      = @w_id_destinatario,
			   @i_id_rol_ini        = @w_id_rol_ini,
			   @i_id_proceso        = @w_id_proceso,
			   @i_version           = @w_version,
			   @i_id_actividad      = @w_id_actividad,

			   @i_tipo_dist_car     = @w_tipo_dist_carga,
			   @i_codigo_dist_carga = @w_codigo_dist_carga,
			   @i_tipo_ofi_dist_car = @w_tipo_oficina,
			   @i_requiere_usr_log  = @w_requiere_usr_log,
			   @i_codigo_resultado  = @i_codigo_res,
			   @i_id_paso_ini       = @i_id_paso,
			   @i_tipo_actividad    = @w_tipo_actividad,
			   @i_ofi_asignacion    = @s_ofi, --@i_ofi_asignacion,
			   @i_ofi_entrega       = @s_ofi,  --@i_ofi_entrega,
			   @i_ofi_inicio        = @s_ofi, --@i_ofi_inicio,
			   @i_tiempo_efectivo   = @w_tiempo_efectivo,
			   @i_asig_manual       = @i_asig_manual,
			   @i_id_usuario        = @w_usuario,
			   @i_id_empresa        = @i_id_empresa,
		       @i_canal             = @i_canal,
			   @o_hay_enlaces       = @w_sig_actividad  out,
			   @o_id_rol            = @w_id_rol_fin     out

		  if @w_retorno != 0
		  begin -- Se dio un error al ejecutar el SP anterior.
			exec cobis..sp_cerror
				 @i_num  = @w_retorno,
				 @t_from = @w_sp_name
			rollback tran
			return @w_retorno
		  end

		  if @i_asig_manual = 1
		  begin -- Si se trata de la asignacion manual, debe retornar el identicador del Rol.
			select @o_id_rol = @w_id_rol_fin
			goto FIN
		  end
	  end
    end
  end
  
  --Si el tipo de destinatario es una Jerarquia de Usuario
if @w_tipo_destinatario = 'JEU'
begin
    if exists (select 1 from wf_asig_actividad
                where aa_id_inst_act = @i_id_inst_act
                  and aa_estado not in ('COM', 'REA'))
    begin
      select @w_sig_actividad = 1
    end
    else
    begin
		select @w_sig_actividad = 0
		if @i_codigo_res = 4
		begin
			
			-- Se ejecuta la asignacion de Jerarquias.
			exec @w_retorno           = sp_m_asig_jer_usr_wf
				 @s_ssn               = @s_ssn,
				 @s_user              = @s_user,
				 @s_sesn              = @s_sesn,
				 @s_term              = @s_term,
				 @s_date              = @s_date,
				 @s_srv               = @s_srv,
				 @s_lsrv              = @s_lsrv,
				 @s_rol               = @s_rol,
				 @s_ofi               = @s_ofi,
				 @s_org_err           = @s_org_err,
				 @s_error             = @s_error,
				 @s_sev               = @s_sev,
				 @s_msg               = @s_msg,
				 @s_org               = @s_org,
				 @t_rty               = @t_rty,
				 @t_trn               = @t_trn,
				 @t_debug             = @t_debug,
				 @t_file              = @t_file,
				 @t_from              = @t_from,

				 @i_id_inst_act       = @i_id_inst_act,
				 @i_id_inst_proc      = @i_id_inst_proc,
				 @i_id_jerarquia      = @w_id_destinatario,
				 @i_id_proceso        = @w_id_proceso,
				 @i_version           = @w_version,
				 @i_id_actividad      = @w_id_actividad,

				 @i_tipo_dist_car     = @w_tipo_dist_carga,
				 @i_codigo_dist_carga = @w_codigo_dist_carga,
				 @i_tipo_ofi_dist_car = @w_tipo_oficina,
				 @i_requiere_usr_log  = @w_requiere_usr_log,
				 @i_id_paso_ini       = @i_id_paso,
				 @i_tipo_actividad    = @w_tipo_actividad,
				 @i_ofi_asignacion    = @s_ofi, --@i_ofi_asignacion,
				 @i_ofi_entrega       = @s_ofi,  --@i_ofi_entrega,
				 @i_ofi_inicio        = @i_ofi_inicio, --@i_ofi_inicio,
				 @i_tiempo_efectivo   = @w_tiempo_efectivo,
				 @i_id_empresa        = @i_id_empresa,
				 @i_codigo_res        = @i_codigo_res,
		          @i_canal            = @i_canal,
				 @o_hay_enlaces       = @w_sig_actividad  out

			if @w_retorno != 0
			begin -- Se dio un error al ejecutar el SP anterior.
				exec cobis..sp_cerror
					 @i_num  = @w_retorno,
					 @t_from = @w_sp_name
				rollback tran
				return @w_retorno
			end
		end
		
		if @i_codigo_res = 1
		begin
			select @w_sig_actividad = 0
		end
		
	end
end

  --print '10'
  
  
  -- Si el tipo de destinatario es un Comite, controlo
  -- que solo el cabecera del mismo pueda responder.
  if @w_tipo_destinatario = 'COM'
  begin
    -- Si se trata del Cabecera del comite, podra responder, caso contrario no.
    if @w_usuario = @w_usuario_cabecera
    begin
      select @w_sig_actividad = 0
    end
    else
    begin
      select @w_sig_actividad = 1
    end
  end

  -- Para el caso de jerarquias, si no hay enlaces de salida, se pasa a la siguiente actividad.
  -- Para el caso de Comites, solo si es el usuario cabecera, se pasa a la siguiente actividad.
  if @w_sig_actividad = 0
  begin	
    --print 'inicia sp_sig_actividad_wf'
    -- Se llama a la siguiente actividad.
    exec @w_retorno           = sp_sig_actividad_wf
         @s_ssn               = @s_ssn,
         @s_user              = @s_user,
         @s_sesn              = @s_sesn,
         @s_term              = @s_term,
         @s_date              = @s_date,
         @s_srv               = @s_srv,
         @s_lsrv              = @s_lsrv,
         @s_rol               = @s_rol,
         @s_ofi               = @s_ofi,
         @s_org_err           = @s_org_err,
         @s_error             = @s_error,
         @s_sev               = @s_sev,
         @s_msg               = @s_msg,
         @s_org               = @s_org,
         @t_rty               = @t_rty,
         @t_trn               = @t_trn,
         @t_debug             = @t_debug,
         @t_file              = @t_file,
         @t_from              = @t_from,

         @i_id_inst_proceso   = @i_id_inst_proc,
         @i_id_proceso        = @w_id_proceso,
         @i_version_proc      = @w_version,
         @i_id_inst_actividad = @i_id_inst_act,
         @i_id_paso_ini       = @i_id_paso,
         @i_codigo_resultado  = @i_codigo_res,
         @i_tipo_actividad    = @w_tipo_actividad,
         @i_ofi_inicio        = @i_ofi_inicio, --@i_ofi_inicio, 
         @i_ofi_entrega       = @s_ofi, --@i_ofi_entrega,
         @i_ofi_asignacion    = @s_ofi, --@i_ofi_asignacion,
         @i_id_empresa        = @i_id_empresa,
		 @i_canal          = @i_canal
	
	--print 'FINALIZA sp_sig_actividad_wf'
	select @w_retorno

    if @w_retorno != 0
    begin -- Se dio un error al ejecutar el SP anterior.
      exec cobis..sp_cerror
           @i_num  = @w_retorno,
           @t_from = @w_sp_name
      rollback tran
      return @w_retorno
    end
	
	-- if @@error != 0
    -- begin -- Error en la actualizacion de wf_inst_actividad.
      -- exec cobis..sp_cerror
           -- @t_from  = @w_sp_name,
           -- @i_num   = @w_retorno
      -- rollback tran
      -- return @w_retorno
    -- end

    -- Se actualiza el estado de la instancia a COMpleto.
    update wf_inst_actividad
       set ia_fecha_fin   = getdate(),
           ia_estado      = 'COM'
     where ia_id_inst_act = @i_id_inst_act

    if @@error != 0
    begin -- Error en la actualizacion de wf_inst_actividad.
      exec cobis..sp_cerror
           @t_from  = @w_sp_name,
           @i_num   = 3107506
      rollback tran
      return @w_retorno
    end

    -- Se actualiza la tabla de resumen de actividades.
    exec @w_retorno       = sp_m_res_act_proc_wf
         @s_ssn           = @s_ssn,
         @s_user          = @s_user,
         @s_sesn          = @s_sesn,
         @s_term          = @s_term,
         @s_date          = @s_date,
         @s_srv           = @s_srv,
         @s_lsrv          = @s_lsrv,
         @s_rol           = @s_rol,
         @s_ofi           = @s_ofi,
         @s_org_err       = @s_org_err,
         @s_error         = @s_error,
         @s_sev           = @s_sev,
         @s_msg           = @s_msg,
         @s_org           = @s_org,
         @t_rty           = @t_rty,
         @t_trn           = @t_trn,
         @t_debug         = @t_debug,
         @t_file          = @t_file,
         @t_from          = @t_from,

         @i_tipo          = 'F',
         @i_id_inst_act   = @i_id_inst_act,
         @i_id_proceso    = @w_id_proceso,
         @i_version       = @w_version,
         @i_id_actividad  = @w_id_actividad,
		 @i_oficina_inicio = @i_ofi_inicio,
		 @i_canal          = @i_canal

    if @w_retorno != 0
    begin
      exec cobis..sp_cerror
           @i_num  = @w_retorno,
           @t_from = @w_sp_name
      rollback tran
      return @w_retorno
    end
  end
  
  --print '12'

  -- Para notificacion
  select @w_notificacion = pr_notificacion, @w_sms = pr_sms, @w_email = pr_email, @w_console = pr_console, @w_tipo_email = pr_tipo_email , @w_mensaje_email = pr_mensaje_email, @w_codigo_alterno = io_codigo_alterno
  from wf_proceso, wf_inst_proceso 
  where pr_codigo_proceso = io_codigo_proc and io_id_inst_proc = @i_id_inst_proc
  
  --print '%1! %2!', @w_notificacion, @i_id_inst_proc
  
  if @w_notificacion = 'S'
  begin

    select @w_texto_notificacion = @w_text1 + ' ' + convert(varchar,@i_id_inst_proc)  + ' ' + @w_text2
    
    select @w_notificado = us_login
    from wf_asig_actividad,wf_inst_actividad, wf_usuario 
    where aa_id_inst_act = ia_id_inst_act and 
    ia_id_inst_proc = @i_id_inst_proc AND 
    aa_id_destinatario = us_id_usuario AND 
    aa_estado = 'PEN'      

    --print '%1! %2! ', @w_notificado, @w_console 
  
    if @w_sms = 'S'
    begin
        select @w_num_sms = mf_descripcion
        from cobis..cl_funcionario, cobis..cl_medios_funcio 
        where fu_funcionario = mf_funcionario and mf_tipo = '1' AND fu_login = @w_notificado

        if @w_num_sms is not null
        begin
            exec cobis..sp_despacho_ins
            @t_trn = 1,
            @i_cliente            = 1, 
            @i_servicio           = 1,  
            @i_estado             = 'P', 
            @i_tipo               = 'SMS',
            @i_tipo_mensaje       = '',
            @i_prioridad          = 1,
            --@i_num_dir            = '',
            @i_var1               = null, 
            @i_var2               = null, 
            @i_var3               = null, 
            @i_var4               = null, 
            @i_var5               = null, 
            @i_var6               = null,
            @i_var7               = null,
            --@i_from               = '087174494',
            @i_to                 = @w_num_sms,
            @i_cc                 = null, 
            @i_bcc                = null,
            @i_subject            = @w_texto_notificacion,
            @i_body               = @w_texto_notificacion,
            @i_content_manager    = 'TEXT',
            @i_retry              = 'N',
            @i_fecha_envio        = null,
            @i_hora_ini           = null,
            @i_hora_fin           = null,
            @i_tries              = 0,
            @i_max_tries          = 0,
			@i_template           = 0 
			--print 'No existe cobis..sp_despacho_ins'
        end
    end
        
    if @w_email = 'S'
    begin
		select @w_subject = @w_text1 + ' ' + @w_codigo_alterno  + ' ' + @w_text2
		if @w_tipo_email = 'T'  and @w_mensaje_email is not null and @w_mensaje_email != 0
		begin
			-- Consulta del Nombre del Programa.
			select @w_nombre_programa = ip_nombre_programa,
				   @w_base_datos      = ip_nombre_bdd                   
			  from wf_info_programa
			 where ip_id_programa     = @w_mensaje_email
			 
			if (@w_base_datos is not null)
		    begin
				if object_id(@w_base_datos + '..' + @w_nombre_programa) is null
				begin
					select @w_mensaje_error = 'EL PROGRAMA: ' + @w_nombre_programa + ' NO EXISTE EN LA BASE DE DATOS: ' +  @w_base_datos
		
					exec cobis..sp_cerror
					@t_from = @w_sp_name,
					@i_msg  = @w_mensaje_error,
					@i_num  = 3107586
					return 3107586
				end
				else
				begin
					select @w_nombre_programa = @w_base_datos + '..' + @w_nombre_programa
				end 
			end
			else
			begin
				if object_id('cob_workflow' + '..' + @w_nombre_programa) is null
				begin     
					select @w_mensaje_error = 'EL PROGRAMA: ' + @w_nombre_programa + ' NO EXISTE EN LA BASE DE DATOS: ' +  'cob_workflow'
		
					exec cobis..sp_cerror
					@t_from = @w_sp_name,
					@i_msg  = @w_mensaje_error,
					@i_num  = 3107586
					return 3107586
				end
				else
				begin
					select @w_nombre_programa = 'cob_workflow' + '..' + @w_nombre_programa
				end
			end
			
			exec @w_retorno    = @w_nombre_programa
			 @i_id_inst_proc   = @i_id_inst_proc,
			 @i_id_inst_act    = @i_id_inst_act,
			 @i_id_asig_act    = @i_id_asig_act,
			 @i_id_empresa     = @i_id_empresa,
			 @i_codigo_alterno = @w_codigo_alterno,
			 @o_texto_notificacion	 = @w_texto_notificacion out
		
			-- Error en la ejecucion del Programa.
			if @w_retorno <> 0
			begin
			  --print 'retorna: %1!', @w_retorno
			  return @w_retorno
			end
			
		end
		else
		begin
			--Se debe implemetar la funcionalidad para cuando es plantilla
			select @w_texto_notificacion = @w_subject
		end
	
	
        select @w_email_notificado = mf_descripcion
        from cobis..cl_funcionario, cobis..cl_medios_funcio 
        where fu_funcionario = mf_funcionario and mf_tipo = '0' AND fu_login = @w_notificado
        
        if @w_email_notificado is not null
        begin
            exec cobis..sp_despacho_ins
            @t_trn = 1,
            @i_cliente            = 1, 
            @i_servicio           = 1,  
            @i_estado             = 'P', 
            @i_tipo               = 'MAIL',
            @i_tipo_mensaje       = '',
            @i_prioridad          = 1,
            --@i_num_dir            = '',
            @i_var1               = null, 
            @i_var2               = null, 
            @i_var3               = null, 
            @i_var4               = null, 
            @i_var5               = null, 
            @i_var6               = null,
            @i_var7               = null,
            --@i_from               = 'andres.villenas@cobiscorp.com',
            @i_to                 = @w_email_notificado,
            --@i_cc                 = 'andres.villenas@cobiscorp.com', 
            @i_bcc                = null,
            @i_subject            = @w_subject,
            @i_body               = @w_texto_notificacion,
            @i_content_manager    = 'TEXT',
            @i_retry              = 'N',
            @i_fecha_envio        = null,
            @i_hora_ini           = null,
            @i_hora_fin           = null,
            @i_tries              = 0,
            @i_max_tries          = 0,
			@i_template           = 0
			--print 'No existe cobis..sp_despacho_ins'
        end
    end
	
	--print '13'
    
    /*if @w_console = 'S'
    begin    
        exec cobis..sp_begin_secure_sendmsg @i_touser = @w_notificado, @i_toserver=@s_srv        
            select  
              w_com  	= '',
              w_desc 	= @w_texto_notificacion,
              w_timeout = 30,
              w_queue   = 'Y',
              w_par1    = '',
              w_par2    = '',
              w_par3    = ''
        exec cobis..sp_end_secure_sendmsg
            @i_wait = 'N'
    end*/
  end
  
  --print '14'

  FIN:
  -- Finalizacion de transaccionalidad.
  commit tran
end

-- Si el usuario RECHAZA la asignacion.
if @i_operacion = 'R'
begin
  -- Inicio de la operacion transaccional.
  begin tran

  /*if exists (select 1 from cob_credito..cr_tramite
              where tr_id_inst_proceso =  @i_id_inst_proc
                and tr_estado          = 'E'
                and tr_tipo            = 'O')
  begin -- Error en la actualizacion de wf_asig_actividad.
    exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 3107506 ,
         @i_msg   = 'NO ES POSIBLE RECHAZAR EL TRAMITE ESTA EJECUTADO YA EN CARTERA'
         rollback tran
     return 1
  end*/

  -- Se cambia el estado de la asignacion a RECHAZADA
  update wf_asig_actividad
     set aa_fecha_fin   = getdate(),
         aa_estado      = 'REC'
   where aa_id_asig_act = @i_id_asig_act

  if @@error != 0
  begin -- Error en la actualizacion de wf_asig_actividad.
    exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 3107506
    rollback tran
    return 1
  end

  select @w_destinatario     = aa_id_destinatario,
         @w_rol_dest         = aa_id_rol,
         @w_min_id_inst_act  = aa_id_inst_act,
         @w_oficina_asig     = aa_oficina_asig,
         @w_id_paso          = ia_id_paso,
         @w_tipo_actividad   = ac_tipo_actividad
    from wf_actividad, wf_inst_actividad, wf_asig_actividad
   where ac_codigo_actividad = ia_codigo_act
     and ia_id_inst_act      = aa_id_inst_act
     and aa_id_asig_act      = (select min(aa_id_asig_act) from wf_inst_actividad, wf_asig_actividad
                                 where ia_id_inst_act  = aa_id_inst_act
                                   and ia_id_inst_proc = @i_id_inst_proc)

  if @w_id_paso_actual <> @w_id_paso
  begin
    -- Se Actualiza el estado de la Actividad a INACTIVO.
    exec @w_retorno      = sp_m_inst_act_wf
         @s_ssn          = @s_ssn,
         @s_user         = @s_user,
         @s_sesn         = @s_sesn,
         @s_term         = @s_term,
         @s_date         = @s_date,
         @s_srv          = @s_srv,
         @s_lsrv         = @s_lsrv,
         @s_rol          = @s_rol,
         @s_ofi          = @s_ofi,
         @s_org_err      = @s_org_err,
         @s_error        = @s_error,
         @s_sev          = @s_sev,
         @s_msg          = @s_msg,
         @s_org          = @s_org,
         @t_rty          = @t_rty,
         @t_trn          = @t_trn,
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @t_from,

         @i_operacion    = 'E',
         @i_estado_act   = 'INA',
         @i_id_inst_act  = @i_id_inst_act,
		 @i_oficina_inicio = @i_ofi_inicio,
		 @i_canal          = @i_canal

    if @w_retorno != 0
    begin
      exec cobis..sp_cerror
           @i_num  = @w_retorno,
           @t_from = @w_sp_name
      rollback tran
      return 1
    end

    -- Asigna al destinatario de la primera actividada
    exec @w_retorno            = sp_rechaza_actividad_wf
         @s_ssn                = @s_ssn,
         @s_user               = @s_user,
         @s_sesn               = @s_sesn,
         @s_term               = @s_term,
         @s_date               = @s_date,
         @s_srv                = @s_srv,
         @s_lsrv               = @s_lsrv,
         @s_rol                = @s_rol,
         @s_ofi                = @s_ofi,
         @s_org_err            = @s_org_err,
         @s_error              = @s_error,
         @s_sev                = @s_sev,
         @s_msg                = @s_msg,
         @s_org                = @s_org,
         @t_rty                = @t_rty,
         @t_trn                = @t_trn,
         @t_debug              = @t_debug,
         @t_file               = @t_file,
         @t_from               = @t_from,

         @i_operacion          = 'D',
         @i_id_inst_proceso    = @i_id_inst_proc,
         @i_id_inst_act        = @w_min_id_inst_act,
         @i_id_asig_act        = @i_id_asig_act,
         @i_id_empresa         = @i_id_empresa,
         @i_id_paso_ini        = @w_id_paso,
         @i_tipo_act           = @w_tipo_actividad,
         @i_id_destinatario    = @w_destinatario,
         @i_id_rol_dest        = @w_rol_dest,

         @i_ofi_inicio         = @s_ofi, --@w_oficina_asig,
         @i_ofi_entrega        = @s_ofi, --@w_oficina_asig,
         @i_ofi_asignacion     = @s_ofi --@w_oficina_asig

    if @w_retorno != 0
    begin
      exec cobis..sp_cerror
           @i_num  = @w_retorno,
           @t_from = @w_sp_name
      rollback tran
      return 1
    end
  end

  -- Se cambia el estado del proceso a SUSPENDIDO o ELIMINADO
  if @w_id_paso_actual = @w_id_paso
  begin
    select @w_est_fin_proc = 'ELI'

    /*if @w_tramite is not null
    begin
      -- SI EXISTE TRAMITE ELIMINARLO
      exec @w_retorno = cob_credito..sp_de_tramite
           @s_ssn     = @s_ssn,
           @s_user    = @s_user,
           @s_sesn    = @s_sesn,
           @s_term    = @s_term,
           @s_date    = @s_date,
           @s_srv     = @s_srv,
           @s_lsrv    = @s_lsrv,
           @s_rol     = @s_rol,
           @s_ofi     = @s_ofi,
           @s_org_err = @s_org_err,
           @s_error   = @s_error,
           @s_sev     = @s_sev,
           @s_msg     = @s_msg,
           @s_org     = @s_org,
           @t_rty     = @t_rty,
           @t_debug   = @t_debug,
           @t_file    = @t_file,
           @t_from    = @t_from,
           @t_trn     = @t_trn,
           @i_tramite = @w_tramite

      if @w_retorno != 0
      begin
        rollback tran
        return 1
     end
   end*/

   -- Se comenta porque no existe la tabla cr_observacion_clf, esa tabla
   -- es una personalizacion de INVERLAT. MVA 2010-05-10
   --else
   --begin
     -- EES: SE ELIMINA INFOMACION DE UNA DE CALIFICACION POR ORIGINACION
     --delete from cob_credito..cr_observacion_clf
     -- where ob_cliente   = (select cc_cliente from cob_credito..cr_calificacion_cl
     --                        where cc_inst_proceso = @i_id_inst_proc
     --                          and cc_tipo_clf     = 'O')
     --   and ob_tipo_clf  = 'O'

     --delete from cob_credito.. cr_calificacion_cl
     -- where cc_inst_proceso = @i_id_inst_proc
     --   and cc_tipo_clf     = 'O'
   --end
 end
 else
   select @w_est_fin_proc = 'SUS'

 update wf_inst_proceso
    set io_fecha_fin    = getdate(),
        io_estado       = @w_est_fin_proc
  where io_id_inst_proc = @i_id_inst_proc

  if @@error != 0
  begin -- Error en la actualizacion de wf_asig_actividad.
    exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 3107506
    rollback tran
    return 1
  end
  

  
  
  -- Finalizacion de la operacion transaccional.
  commit tran
end

return 0
go
