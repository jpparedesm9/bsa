/************************************************************/
/*   ARCHIVO:         wf_cons_act_usr.sp                    */
/*   NOMBRE LOGICO:   sp_cons_act_usr_wf                    */
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
/*   Consulta las actividades que un usuario posee en su    */
/*   INBOX de tareas, esta consulta es llamda desde la      */
/*   Interfaz de COBIS WorkFlow con otras aplicaciones.     */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA        AUTOR              RAZON                  */
/*   30-Ago-2001  Mario Valarezo A.  Emision Inicial.       */
/*   13-Feb-2002  Mario Valarezo A.  Operacion 'C'.         */
/*   04-Nov-2004  Mario Valarezo A.  Se aumenta columna     */
/*   para saber si actividad est retrasada en el inbox.     */
/*   20-Sep-2013  Sergio Hidalgo V.  Requerimiento CCA-0021 */
/************************************************************/
use cob_workflow
go

if exists (select 1 from sysobjects
            where name = 'sp_cons_act_usr_wf')
begin
  -- print 'ELIMINANDO EL PROCEDIMIENTO sp_cons_act_usr_wf'
  drop procedure sp_cons_act_usr_wf
end
go

create procedure sp_cons_act_usr_wf (
  @s_user                 varchar(30),
  @s_sesn                 int,
  @s_term                 varchar(30),
  @s_date                 datetime,
  @s_srv                  varchar(30),
  @s_lsrv                 varchar(30),
  @s_ofi                  smallint,
  @t_trn                  int,

  @s_rol                  smallint       = null,
  @s_org_err              char(1)        = null,
  @s_error                int            = null,
  @s_sev                  tinyint        = null,
  @s_msg                  descripcion    = null,
  @s_org                  char(1)        = null,
  @t_rty                  char(1)        = null,

  -- Criterios de busqueda.
  @i_id_asig_act          int            = null,
  @i_nombre_act           NOMBRE         = null,
  @i_fecha_asig           varchar(10)    = null,
  @i_formato_fecha        smallint       = 113,  -- YRO 2010-05-18
  @i_nombre               varchar(254)   = null,
  @i_proceso              int 			 = null,
  @i_actividad            int			 = null,
  @i_inst_proceso         int 			 = null,
  @i_fecha_desde          varchar(10)    = null,
  @i_fecha_hasta          varchar(10)    = null,
  @i_identificacion       varchar(30)    = null, 

  -- Parametros generales de entrada.
  @i_criterio             char(1)        = 'I',
  @i_modo                 tinyint        = null,
  @i_id_usuario           int            = null,
  @i_num_filas		     tinyint		 = 8, -- numero de filas que devolvera el sp
  @i_usuario		      varchar(100)   = null,
  @i_cod_alterno          varchar(50)    = null,
  -- Parametro de salida que contiene el numero
  @o_num_registros        int            = null out,
  -- maximo de registros que se traen en el query.
  @o_num_filas            tinyint       = null out
)

As declare
  @w_sp_name              varchar(64),
  @w_table_code  		  int

select @w_sp_name = 'sp_cons_act_usr_wf'

--Recupera el codigo de la tabla wf_estado_proceso
select @w_table_code = codigo from cobis..cl_tabla where tabla='wf_estado_proceso'

-- Si no se tiene id de usuario, se sale del SP y se coloca un mensaje de error.
if @@rowcount = 0
begin -- No existe usuario con ese login.
  exec cobis..sp_cerror
       @i_num  = 3107501,
	   @t_from = @w_sp_name
  return 1
end

--opcion busca por grupos
IF @i_criterio = 'G'
BEGIN

    SET ROWCOUNT @i_num_filas

	SELECT @o_num_registros = count(1)
	FROM wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad
	WHERE io_id_inst_proc = ia_id_inst_proc
	AND ia_id_inst_act = aa_id_inst_act
	AND io_estado NOT IN ('ELI','TER','SUS','CAN')
	AND aa_estado NOT IN ('COM','REA','REC')
    and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                              --Filtro codigo alterno
    and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                                       --Filtro instancia proceso
    and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                       --Filtro proceso
    and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                                  --Filtro actividad
	and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%' ))                          --Filtro nombre cliente
           or @i_nombre is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%')))
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_ced_ruc = @i_identificacion))                                --Filtro identificacion
           or @i_identificacion is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_cedruc = @i_identificacion)))
     AND (aa_id_rol IN (SELECT ur_id_rol FROM wf_usuario_rol, wf_usuario where ur_id_usuario=us_id_usuario and us_login=@i_usuario))--Filtro usuario
	 and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))           --Filtro fecha desde
     and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))            --Filtro fecha hasta    
	 AND aa_id_asig_act > @i_id_asig_act

	IF @i_id_asig_act = 0
	BEGIN

	SELECT 'ID ASIG ACT'        = aa_id_asig_act,
           'ID INST ACT'        = ia_id_inst_act,
           'ID INST PROC'       = io_id_inst_proc,
           'ESTADO'             = (select valor from cobis..cl_catalogo where tabla = @w_table_code and codigo = c.io_estado),
           'NOMBRE PROCESO'     = (SELECT pr_nombre_proceso	FROM wf_proceso a WHERE pr_codigo_proceso = c.io_codigo_proc),
           'ACTIVIDAD'          = ia_nombre_act,
		   'ID. CLIENTE'        = io_campo_1,
		   'NOMBRE CLIENTE'     = CASE WHEN (SELECT pr_producto	FROM cob_workflow..wf_proceso WHERE pr_codigo_proceso = c.io_codigo_proc) = 'MCH'
                                  THEN 
                                        (SELECT fu_nombre FROM cobis..cl_funcionario	WHERE fu_login = c.io_campo_2)
                                  ELSE 
                                        (SELECT en_nomlar FROM cobis..cl_ente WHERE en_ente = c.io_campo_1)
                                  END,
			'MONTO'             = convert(VARCHAR(32), io_campo_2),
			'NUM TRAMITE'       = io_campo_3,
			'FECHA DE LLEGADA'  = convert(VARCHAR(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(VARCHAR(10), aa_fecha_asig, 108),
			'FUNCIONALIDAD'     = ia_func_asociada,
			'ID. PASO'          = ia_id_paso,
			'ID. PROCESO'       = io_codigo_proc,
			'VER. PROC.'        = io_version_proc,
			'ID. DEST'          = aa_id_destinatario,
			'ID. ROL'           = aa_id_rol,
			'RETRASADA'         = ia_retrasada,
			'ID INST HIJO'      = io_id_inst_proc,
			'VERSION'           = io_version_proc,
			'ID ACTIVIDAD'      = ia_codigo_act,
			'DURACION'          = ar_tiempo_efectivo,
			'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
			'FECHA CREACION'    = convert(VARCHAR(10), io_fecha_crea, @i_formato_fecha) + ' ' + convert(VARCHAR(10), io_fecha_crea, 108),
			'COSTO'             = ar_costo_act_proc,
			'ROL'               = (SELECT ro_nombre_rol FROM wf_rol WHERE ro_id_rol = d.aa_id_rol),
			'NOMBRE DEST'       = (SELECT fu_nombre FROM cobis..cl_funcionario,wf_usuario	WHERE fu_login = us_login AND us_id_usuario = d.aa_id_destinatario),
			'CLAIM'             = aa_claim,
			'URL DETALLE'       = CASE WHEN 
                                      (SELECT co_namespace + co_class --tv_component_detail_id 
                           				FROM cob_pac..bpi_task_view, cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                     					AND tv_task_id = e.ia_codigo_act
                                        AND co_id = tv_component_detail_id
										AND tv_order = 1) IS NULL
                                  THEN 
                                       (SELECT co_namespace + co_class --tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND co_id = tv_component_detail_id
                                        AND tv_task_id = e.ia_codigo_act
										AND tv_order = 1)
                                  ELSE 
                                       (SELECT co_namespace + co_class --select tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND tv_task_id = e.ia_codigo_act
                                        AND co_id = tv_component_detail_id
										AND tv_order = 1)
                                  END,
			'TYPE COMPONENT'    = (SELECT DISTINCT co_ct_id	FROM cob_pac..bpi_task_view,cobis..an_component
                                   WHERE tv_process_id = c.io_codigo_proc
                                   AND tv_version_id = c.io_version_proc
                                   AND tv_task_id = e.ia_codigo_act
                                   AND co_id = tv_component_id
								   AND tv_order = 1),
			'CAMPO_4'           = io_campo_4,
			'REGRESO'           = aa_act_regreso,
			'CODIGO ALTERNO'    = io_codigo_alterno,
			'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act),
			'TIPO DESTINATARIO'	 = (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act)
		FROM wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc
		WHERE io_id_inst_proc = ia_id_inst_proc
			AND ia_id_inst_act = aa_id_inst_act
			AND ar_codigo_actividad = ia_codigo_act
			AND ar_codigo_proceso = io_codigo_proc
			AND ar_version_proceso = io_version_proc
			AND io_estado NOT IN ('ELI','TER','SUS','CAN')
			AND aa_estado NOT IN ('COM','REA','REC')
            and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                              --Filtro codigo alterno
            and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                                       --Filtro instancia proceso
            and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                       --Filtro proceso
            and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                                  --Filtro actividad
        	and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%' ))                          --Filtro nombre cliente
                or @i_nombre is null 
                or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%')))
            and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_ced_ruc = @i_identificacion))                                --Filtro identificacion
                or @i_identificacion is null 
                or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_cedruc = @i_identificacion)))
            AND (aa_id_rol IN (SELECT ur_id_rol FROM wf_usuario_rol, wf_usuario where ur_id_usuario=us_id_usuario and us_login=@i_usuario))--Filtro usuario
            and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))           --Filtro fecha desde
            and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))            --Filtro fecha hasta    
			AND aa_id_asig_act > @i_id_asig_act --para siguiente < para la primera busqueda >
            ORDER BY aa_id_asig_act DESC
	END
	ELSE
	BEGIN

		SELECT 'ID ASIG ACT'        = aa_id_asig_act,
			   'ID INST ACT'        = ia_id_inst_act,
			   'ID INST PROC'       = io_id_inst_proc,
			   'ESTADO'             = (select valor from cobis..cl_catalogo where tabla = @w_table_code and codigo = c.io_estado),
			   'NOMBRE PROCESO'     = (	SELECT pr_nombre_proceso FROM wf_proceso a	WHERE pr_codigo_proceso = c.io_codigo_proc),
               'ACTIVIDAD'          = ia_nombre_act,
			   'ID. CLIENTE'        = io_campo_1,
			   'NOMBRE CLIENTE'     = CASE 	WHEN (SELECT pr_producto FROM cob_workflow..wf_proceso	WHERE pr_codigo_proceso = c.io_codigo_proc) = 'MCH'
                                      THEN 
                                            (SELECT fu_nombre FROM cobis..cl_funcionario	WHERE fu_login = c.io_campo_2)
                                      ELSE 
                                            (SELECT en_nomlar FROM cobis..cl_ente WHERE en_ente = c.io_campo_1						)
                                      END,
			   'MONTO'                = convert(VARCHAR(32), io_campo_2),
			   'NUM TRAMITE'          = io_campo_3,
			   'FECHA DE LLEGADA'     = convert(VARCHAR(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(VARCHAR(10), aa_fecha_asig, 108),
			   'FUNCIONALIDAD'        = ia_func_asociada,
			   'ID. PASO'             = ia_id_paso,
			   'ID. PROCESO'          = io_codigo_proc,
			   'VER. PROC.'           = io_version_proc,
			   'ID. DEST'             = aa_id_destinatario,
			   'ID. ROL'              = aa_id_rol,
			   'RETRASADA'            = ia_retrasada,
			   'ID INST HIJO'         = io_id_inst_proc,
			   'VERSION'              = io_version_proc,
			   'ID ACTIVIDAD'         = ia_codigo_act,
			   'DURACION'             = ar_tiempo_efectivo,
			   'TIEMPO ESTANDAR'      = ar_tiempo_estandar,
			   'FECHA CREACION'       = convert(VARCHAR(10), io_fecha_crea, @i_formato_fecha) + ' ' + convert(VARCHAR(10), io_fecha_crea, 108),
			   'COSTO'                = ar_costo_act_proc,
			   'ROL'                  = (SELECT ro_nombre_rol FROM wf_rol WHERE ro_id_rol = d.aa_id_rol),
			   'NOMBRE DEST'          = (SELECT fu_nombre FROM cobis..cl_funcionario,wf_usuario	WHERE fu_login = us_login AND us_id_usuario = d.aa_id_destinatario),
			   'CLAIM'                = aa_claim,
               'URL DETALLE'          = CASE WHEN 
                                            (SELECT co_namespace + co_class --tv_component_detail_id 
                                            FROM cob_pac..bpi_task_view, cobis..an_component
                                            WHERE tv_process_id = c.io_codigo_proc
                                            AND tv_version_id = c.io_version_proc
                                            AND tv_task_id = e.ia_codigo_act
                                            AND co_id = tv_component_detail_id
											AND tv_order = 1) IS NULL
                                        THEN 
                                            (SELECT co_namespace + co_class --tv_component_detail_id 
                                            FROM cob_pac..bpi_task_view,cobis..an_component
                                            WHERE tv_process_id = c.io_codigo_proc
                                            AND tv_version_id = c.io_version_proc
            								AND co_id = tv_component_detail_id
                        					AND tv_task_id = e.ia_codigo_act
											AND tv_order = 1)
                                        ELSE 
                                            (SELECT co_namespace + co_class --select tv_component_detail_id 
                                            FROM cob_pac..bpi_task_view,cobis..an_component
                                            WHERE tv_process_id = c.io_codigo_proc
                                            AND tv_version_id = c.io_version_proc
                                            AND tv_task_id = e.ia_codigo_act
                                            AND co_id = tv_component_detail_id
											AND tv_order = 1)
                                        END,
			   'TYPE COMPONENT'       = (SELECT DISTINCT co_ct_id FROM cob_pac..bpi_task_view, cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND tv_task_id = e.ia_codigo_act
                                        AND co_id = tv_component_id
										AND tv_order = 1),
               'CAMPO_4'              = io_campo_4,
			   'REGRESO'              = aa_act_regreso,
			   'CODIGO ALTERNO'       = io_codigo_alterno,
			   'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act),
			   'TIPO DESTINATARIO'	 = (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act) 
		FROM wf_inst_proceso c,wf_inst_actividad e,wf_asig_actividad d,wf_actividad_proc
		WHERE io_id_inst_proc = ia_id_inst_proc
		AND ia_id_inst_act = aa_id_inst_act
		AND ar_codigo_actividad = ia_codigo_act
		AND ar_codigo_proceso = io_codigo_proc
		AND ar_version_proceso = io_version_proc
		AND io_estado NOT IN ('ELI','TER','SUS','CAN')
		AND aa_estado NOT IN ('COM','REA','REC')
        and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                              --Filtro codigo alterno
       and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                                       --Filtro instancia proceso
        and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                       --Filtro proceso
        and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                                  --Filtro actividad
        and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%' ))                          --Filtro nombre cliente
              or @i_nombre is null 
              or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%')))
        and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_ced_ruc = @i_identificacion))                                --Filtro identificacion
              or @i_identificacion is null 
              or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_cedruc = @i_identificacion)))
        AND (aa_id_rol IN (SELECT ur_id_rol FROM wf_usuario_rol, wf_usuario where ur_id_usuario=us_id_usuario and us_login=@i_usuario))--Filtro usuario
        and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))           --Filtro fecha desde
        and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))            --Filtro fecha hasta    
		AND aa_id_asig_act < @i_id_asig_act
		ORDER BY aa_id_asig_act DESC
	END
	SET ROWCOUNT 0
END

--opcion nueva
if @i_criterio = 'S'
begin

set rowcount @i_num_filas

  select @o_num_registros = count(1)
    from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad
   where io_id_inst_proc     = ia_id_inst_proc
     and ia_id_inst_act      = aa_id_inst_act
     and io_estado not in ('ELI', 'TER', 'SUS','CAN')    
     and aa_estado not in ('COM', 'REA', 'REC')
     and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                     --Filtro codigo alterno
     and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                              --Filtro instancia proceso
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                              --Filtro proceso
     and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                         --Filtro actividad
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%' ))                 --Filtro nombre cliente
           or @i_nombre is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%')))
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_ced_ruc = @i_identificacion))                        --Filtro identificacion
           or @i_identificacion is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_cedruc = @i_identificacion)))
     and ((aa_id_destinatario  = (select us_id_usuario from wf_usuario where us_login = @i_usuario)) or @i_usuario is null) --Filtro usuario
	 and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))   --Filtro fecha desde
     and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))    --Filtro fecha hasta    
	 and aa_id_asig_act  > @i_id_asig_act
	 
if @i_id_asig_act = 0
BEGIN
select   'ID ASIG ACT'       = aa_id_asig_act,
         'ID INST ACT'       = ia_id_inst_act,
         'ID INST PROC'      = io_id_inst_proc,
         'ESTADO'            = (select valor from cobis..cl_catalogo where tabla = @w_table_code and codigo = c.io_estado), --aa_estado,
         'NOMBRE PROCESO'    = (select pr_nombre_proceso from wf_proceso a where pr_codigo_proceso = c.io_codigo_proc),
         'ACTIVIDAD'         = ia_nombre_act,
         'ID. CLIENTE'       = io_campo_1,
         'NOMBRE CLIENTE'    = case when (select pr_producto from cob_workflow..wf_proceso where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' 
                               then 
                                    (select fu_nombre from cobis..cl_funcionario where fu_login = c.io_campo_2) 
                               else 
									case 
									when io_campo_7 = 'G' or io_campo_7 = 'S'
									then
										(select gr_nombre from cobis..cl_grupo where gr_grupo = c.io_campo_1)
									else
										(select en_nomlar from cobis..cl_ente where en_ente = c.io_campo_1)
									end
							   end,
         'MONTO'             = convert(varchar(32), io_campo_2),
         'NUM TRAMITE'       = io_campo_3,
         'FECHA DE LLEGADA'  = convert(varchar(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), aa_fecha_asig, 108),
         'FUNCIONALIDAD'     = ia_func_asociada,
         'ID. PASO'          = ia_id_paso,
         'ID. PROCESO'       = io_codigo_proc,
         'VER. PROC.'        = io_version_proc,
         'ID. DEST'          = aa_id_destinatario,
         'ID. ROL'           = aa_id_rol,
         'RETRASADA'         = ia_retrasada,
         'ID INST HIJO'      = io_id_inst_proc,
	     'VERSION'	         = io_version_proc,
         'ID ACTIVIDAD'      = ia_codigo_act,
	     'DURACION'          = ar_tiempo_efectivo,  -- SE REQUIERE ESTE DATO PARA CALCULAR EL ESTADO DE UNA TAREA
	     'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	     'FECHA CREACION'    = convert(varchar(10), io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), io_fecha_crea, 108),
	     'COSTO'	         = ar_costo_act_proc,
	     'ROL'               = (select ro_nombre_rol from wf_rol where ro_id_rol = d.aa_id_rol),
         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                and us_id_usuario = d.aa_id_destinatario),
	     'CLAIM'             = aa_claim,
	     'URL DETALLE'       = case	when 
                                    (select co_namespace + co_class --tv_component_detail_id 
                                    from cob_pac..bpi_task_view, cobis..an_component 
                             		where tv_process_id = c.io_codigo_proc
                      				and tv_version_id = c.io_version_proc
                                    and tv_task_id = e.ia_codigo_act
                                    and co_id = tv_component_id
									and tv_order = 1) is null 
                               then
                       				(select co_namespace + co_class --tv_component_detail_id 
                                    from cob_pac..bpi_task_view, cobis..an_component 
                    		        where tv_process_id = c.io_codigo_proc 
                                    and tv_version_id = c.io_version_proc
                				    and co_id = tv_component_id 
                                    and tv_task_id = e.ia_codigo_act
									and tv_order = 1)
                    		   else 
                                    (select co_namespace + co_class --select tv_component_detail_id 
               				        from cob_pac..bpi_task_view, cobis..an_component 
                                    where tv_process_id = c.io_codigo_proc
                				    and tv_version_id = c.io_version_proc
				                    and tv_task_id = e.ia_codigo_act
				                    and co_id = tv_component_id
									and tv_order = 1)
                               end,
         'TYPE COMPONENT'    = (select distinct co_ct_id from cob_pac..bpi_task_view, cobis..an_component 
                                where tv_process_id = c.io_codigo_proc 
                                and tv_version_id = c.io_version_proc
                                and tv_task_id = e.ia_codigo_act
                                and co_id = tv_component_id
								and tv_order = 1),
         'CAMPO_4'	         = io_campo_4,
	     'REGRESO'           = aa_act_regreso,
	     'CODIGO ALTERNO'    = io_codigo_alterno,
		 'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act),
		 'TIPO DESTINATARIO'	= (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act),
	     'TIPO CLIENTE'      = case when (select pr_producto from cob_workflow..wf_proceso where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' 
                               then
                                    ''
							   else
                                    (select en_subtipo from cobis..cl_ente where en_ente = c.io_campo_1)
							   end
   from wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc
   where io_id_inst_proc     = ia_id_inst_proc
     and ia_id_inst_act      = aa_id_inst_act
     and ar_codigo_actividad = ia_codigo_act
     and ar_codigo_proceso   = io_codigo_proc
     and ar_version_proceso  = io_version_proc
     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')
     and aa_estado      not in ('COM', 'REA', 'REC')
     and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                     --Filtro codigo alterno
     and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                              --Filtro instancia proceso
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                              --Filtro proceso
     and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                         --Filtro actividad
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%' ))                 --Filtro nombre cliente
           or @i_nombre is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%')))
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_ced_ruc = @i_identificacion))                        --Filtro identificacion
           or @i_identificacion is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_cedruc = @i_identificacion)))
     and ((aa_id_destinatario  = (select us_id_usuario from wf_usuario where us_login = @i_usuario)) or @i_usuario is null) --Filtro usuario
	 and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))   --Filtro fecha desde
     and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))    --Filtro fecha hasta 
     order by aa_id_asig_act desc
END
ELSE
BEGIN
select   'ID ASIG ACT'       = aa_id_asig_act,
         'ID INST ACT'       = ia_id_inst_act,
         'ID INST PROC'      = io_id_inst_proc,
         'ESTADO'            = (select valor from cobis..cl_catalogo where tabla = @w_table_code and codigo = c.io_estado),--aa_estado,
         'NOMBRE PROCESO'    = (select pr_nombre_proceso from wf_proceso a where pr_codigo_proceso = c.io_codigo_proc),
         'ACTIVIDAD'         = ia_nombre_act,
         'ID. CLIENTE'       = io_campo_1,
         'NOMBRE CLIENTE'    = case  when (select pr_producto from cob_workflow..wf_proceso where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' 
                               then
							 	 (select fu_nombre from cobis..cl_funcionario where fu_login = c.io_campo_2)
							   else
                                 case 
									when io_campo_7 = 'G' or io_campo_7 = 'S'
									then
										(select gr_nombre from cobis..cl_grupo where gr_grupo = c.io_campo_1)
									else
										(select en_nomlar from cobis..cl_ente where en_ente = c.io_campo_1)
									end
							   end,
         'MONTO'             = convert(varchar(32), io_campo_2),
         'NUM TRAMITE'       = io_campo_3,
         'FECHA DE LLEGADA'  = convert(varchar(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), aa_fecha_asig, 108),
         'FUNCIONALIDAD'     = ia_func_asociada,
         'ID. PASO'          = ia_id_paso,
         'ID. PROCESO'       = io_codigo_proc,
         'VER. PROC.'        = io_version_proc,
         'ID. DEST'          = aa_id_destinatario,
         'ID. ROL'           = aa_id_rol,
         'RETRASADA'         = ia_retrasada,
         'ID INST HIJO'      = io_id_inst_proc,
	     'VERSION'	         = io_version_proc,
         'ID ACTIVIDAD'      = ia_codigo_act,
	     'DURACION'          = ar_tiempo_efectivo,  -- SE REQUIERE ESTE DATO PARA CALCULAR EL ESTADO DE UNA TAREA
	     'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	     'FECHA CREACION'    = convert(varchar(10), io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), io_fecha_crea, 108),
	     'COSTO'	         = ar_costo_act_proc,
	     'ROL'               = (select ro_nombre_rol from wf_rol  where ro_id_rol = d.aa_id_rol),
         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario where fu_login = us_login and us_id_usuario = d.aa_id_destinatario),
	     'CLAIM'             = aa_claim,
	     'URL DETALLE'       = case when
                                    (select co_namespace + co_class --tv_component_detail_id 
                 				    from cob_pac..bpi_task_view, cobis..an_component 
                     			    where tv_process_id = c.io_codigo_proc
				                    and tv_version_id = c.io_version_proc
				                    and tv_task_id = e.ia_codigo_act
				                    and co_id = tv_component_detail_id 
									and tv_order = 1) is null 
                               then
				                    (select co_namespace + co_class --tv_component_detail_id 
				                    from cob_pac..bpi_task_view, cobis..an_component 
				                    where tv_process_id = c.io_codigo_proc 
                                    and tv_version_id = c.io_version_proc
                         		    and co_id = tv_component_detail_id 
                                    and tv_task_id = e.ia_codigo_act
									and tv_order = 1)
                               else 
                                    (select co_namespace + co_class --select tv_component_detail_id 
                                    from cob_pac..bpi_task_view, cobis..an_component 
                                    where tv_process_id = c.io_codigo_proc
                                    and tv_version_id = c.io_version_proc
                				    and tv_task_id = e.ia_codigo_act
            				        and co_id = tv_component_detail_id
									and tv_order = 1)
                               end,   
         'TYPE COMPONENT'    = (select distinct co_ct_id from cob_pac..bpi_task_view, cobis..an_component 
                			    where tv_process_id = c.io_codigo_proc
           				        and tv_version_id = c.io_version_proc
				                and tv_task_id = e.ia_codigo_act
				                and co_id = tv_component_id
								and tv_order = 1),
         'CAMPO_4'	        =  io_campo_4,
	     'REGRESO'          = aa_act_regreso,
	     'CODIGO ALTERNO'   = io_codigo_alterno,
		 'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act),
		 'TIPO DESTINATARIO'= (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act) 
   from wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc
   where io_id_inst_proc     = ia_id_inst_proc
     and ia_id_inst_act      = aa_id_inst_act
     and ar_codigo_actividad = ia_codigo_act
     and ar_codigo_proceso   = io_codigo_proc
     and ar_version_proceso  = io_version_proc
     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')
     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU
     and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                     --Filtro codigo alterno
     and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                              --Filtro instancia proceso
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                              --Filtro proceso
     and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                         --Filtro actividad
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%' ))                 --Filtro nombre cliente
           or @i_nombre is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%')))
	 and ((io_campo_1 IN (select en_ente from cobis..cl_ente  where en_ced_ruc = @i_identificacion))                        --Filtro identificacion
           or @i_identificacion is null 
           or (io_campo_2 IN (select fu_login from cobis..cl_funcionario where fu_cedruc = @i_identificacion)))
     and ((aa_id_destinatario  = (select us_id_usuario from wf_usuario where us_login = @i_usuario)) or @i_usuario is null) --Filtro usuario
	 and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))   --Filtro fecha desde
     and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))    --Filtro fecha hasta 
     order by aa_id_asig_act desc

END
set rowcount 0
end

-- Si el criterio de busqueda es el identificador de asignacion.

if @i_criterio = 'I'

begin

  set rowcount @i_num_filas

  select @o_num_filas = @i_num_filas



/*  select @o_num_registros    = count(1)

    from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and io_estado      not in ('ELI', 'TER', 'SUS')

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and io_id_inst_proc    > @i_id_asig_act

*/



  select @o_num_registros = count(1)

    from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and aa_id_asig_act  > @i_id_asig_act


  select 'ID ASIG ACT'       = aa_id_asig_act,

         'ID INST ACT'       = ia_id_inst_act,

         'ID INST PROC'      = io_id_inst_proc,

         'ESTADO'            = (select valor from cobis..cl_catalogo where tabla = @w_table_code and codigo = c.io_estado),--aa_estado,

         'NOMBRE PROCESO'    = (select pr_nombre_proceso from wf_proceso a

                                 where pr_codigo_proceso = c.io_codigo_proc),

         'ACTIVIDAD'         = ia_nombre_act,

         'ID. CLIENTE'       = io_campo_1,

         'NOMBRE CLIENTE'    = 
		                     
							 case
                              
				             when 
							 	
							     (select pr_producto 
							 	 
							 	 from cob_workflow..wf_proceso
							 	 
							 	 where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' then
								 
							 	 (select fu_nombre from cobis..cl_funcionario 
								 
								 where fu_login = c.io_campo_2)                                 -- Requerimiento CCA-0021
								 
							 else
							 
		                         (select en_nomlar from cobis..cl_ente
                                  
                                 where en_ente = c.io_campo_1)
								 
							 end,

         'MONTO'             = convert(varchar(32), io_campo_2),

         'NUM TRAMITE'       = io_campo_3,

         'FECHA DE LLEGADA'  = convert(varchar(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), aa_fecha_asig, 108),

         'FUNCIONALIDAD'     = ia_func_asociada,

         'ID. PASO'          = ia_id_paso,

         'ID. PROCESO'       = io_codigo_proc,

         'VER. PROC.'        = io_version_proc,

         'ID. DEST'          = aa_id_destinatario,
		 
         'ID. ROL'           = aa_id_rol,

         'RETRASADA'         = ia_retrasada,

         'ID INST HIJO'      = io_id_inst_proc,

	     'VERSION'	         = io_version_proc,

         'ID ACTIVIDAD'      = ia_codigo_act,

	     'DURACION'          = ar_tiempo_efectivo,  -- SE REQUIERE ESTE DATO PARA CALCULAR EL ESTADO DE UNA TAREA
		 
	     'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
		 
	     'FECHA CREACION'    = convert(varchar(10), io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), io_fecha_crea, 108),
		 
	     'COSTO'	         = ar_costo_act_proc,
		 
	     'ROL'               = (select ro_nombre_rol from wf_rol
                                where ro_id_rol = d.aa_id_rol),

         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                and us_id_usuario = d.aa_id_destinatario),
							
	     'CLAIM'             = aa_claim,

	     'URL DETALLE'   = 

				case

				when 

				     (select co_namespace + co_class --tv_component_detail_id 

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc

				     and tv_version_id = c.io_version_proc

				     and tv_task_id = e.ia_codigo_act

				     and co_id = tv_component_id 
					 and tv_order = 1) is null then

				     (select co_namespace + co_class --tv_component_detail_id 

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc 

				     and tv_version_id = c.io_version_proc

				     and co_id = tv_component_id 
                                     and tv_task_id = e.ia_codigo_act 
									 and tv_order = 1)

				else (select co_namespace + co_class --select tv_component_detail_id 

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc

				     and tv_version_id = c.io_version_proc

				     and tv_task_id = e.ia_codigo_act

				     and co_id = tv_component_id 
					 and tv_order = 1)

				end,

	'TYPE COMPONENT'     = (select distinct co_ct_id

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc

				     and tv_version_id = c.io_version_proc

				     and tv_task_id = e.ia_codigo_act

				     and co_id = tv_component_id
					 and tv_order = 1),


	'CAMPO_4'	= io_campo_4,
	
	'REGRESO'   = aa_act_regreso,
	
	'CODIGO ALTERNO'   = io_codigo_alterno,
	
	'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act),

	'TIPO DESTINATARIO'	 = (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = e.ia_codigo_act)
	
    from wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and ar_codigo_actividad = ia_codigo_act

     and ar_codigo_proceso   = io_codigo_proc

     and ar_version_proceso  = io_version_proc

     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and ((aa_id_asig_act  > @i_id_asig_act and @i_modo = 1))

--     and ((io_id_inst_proc  >= @i_id_asig_act and @i_modo = 0)

--      or  (io_id_inst_proc   > @i_id_asig_act and @i_modo = 1))

--   order by io_id_inst_proc

     order by aa_id_asig_act desc

end



-- Si el criterio de busqueda es el Nombre de la Actividad.

if @i_criterio = 'A'

begin

  set rowcount @i_num_filas

  select @o_num_filas = @i_num_filas



  if @i_id_asig_act is null

  begin

    select @i_id_asig_act = 0

  end



  select @o_num_registros    = count(1)

    from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and ia_nombre_act    like @i_nombre_act + '%'

     and io_id_inst_proc    >= @i_id_asig_act



  select 'ID ASIG ACT'       = aa_id_asig_act,

         'ID INST ACT'       = ia_id_inst_act,

         'ID INST PROC'      = io_id_inst_proc,

         'ESTADO'            = aa_estado,

         'NOMBRE PROCESO'    = (select pr_nombre_proceso from wf_proceso a

                                 where pr_codigo_proceso = c.io_codigo_proc),

         'ACTIVIDAD'         = ia_nombre_act,

         'ID. CLIENTE'       = io_campo_1,

         'NOMBRE CLIENTE'    = (select en_nomlar from cobis..cl_ente

                                 where en_ente = c.io_campo_1),

         'MONTO'             = convert(varchar(32), io_campo_2),

         'NUM TRAMITE'       = io_campo_3,

         'FECHA DE LLEGADA'  = convert(varchar(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), aa_fecha_asig, 108),

         'FUNCIONALIDAD'     = ia_func_asociada,

         'ID. PASO'          = ia_id_paso,

         'ID. PROCESO'       = io_codigo_proc,

         'VER. PROC.'        = io_version_proc,

         'ID. DEST'          = aa_id_destinatario,

         'ID. ROL'           = aa_id_rol,

         'RETRASADA'         = ia_retrasada,

         'ID INST HIJO'      = io_id_inst_proc,

	 'VERSION'	     = io_version_proc,

	 'DURACION'          = ar_tiempo_efectivo,
	 'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	 'FECHA CREACION'    = io_fecha_crea,
	 'COSTO'	     = ar_costo_act_proc,
	 'ROL'               = (select ro_nombre_rol from wf_rol
                                  where ro_id_rol = d.aa_id_rol),

         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                  and us_id_usuario = d.aa_id_destinatario),
	 'CLAIM'             = aa_claim,


	 'URL DETALLE'       = 

				case

				when 

				     (select co_namespace + co_class --tv_component_detail_id 

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc

				     and tv_version_id = c.io_version_proc

				     and tv_task_id = e.ia_codigo_act

				     and co_id = tv_component_detail_id 
					 and tv_order = 1) is null then

				     (select co_namespace + co_class --tv_component_detail_id 

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc 

				     and tv_version_id = c.io_version_proc

				     and co_id = tv_component_detail_id 
                                     and tv_task_id = e.ia_codigo_act 
									 and tv_order = 1)

				else (select co_namespace + co_class --select tv_component_detail_id 

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc

				     and tv_version_id = c.io_version_proc

				     and tv_task_id = e.ia_codigo_act

				     and co_id = tv_component_detail_id 
					 and tv_order = 1)

				end,


	'TYPE COMPONENT'     = (select co_ct_id
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = e.ia_codigo_act
				     and co_id = tv_component_id
					 and tv_order = 1),
					 
	'CODIGO ALTERNO'   = io_codigo_alterno
	
    from wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and ar_codigo_actividad = ia_codigo_act

     and ar_codigo_proceso   = io_codigo_proc

     and ar_version_proceso  = io_version_proc

     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and ia_nombre_act    like @i_nombre_act + '%'

     and ((io_id_inst_proc  >= @i_id_asig_act and @i_modo = 0)

      or  (io_id_inst_proc  > @i_id_asig_act and @i_modo = 1))

   order by io_id_inst_proc desc

end



-- Si el criterio de busqueda es la Fecha de asignacion.

if @i_criterio = 'F'

begin

  set rowcount @i_num_filas

  select @o_num_filas = @i_num_filas



  if @i_id_asig_act is null

  begin

    select @i_id_asig_act = 0

  end



  select @o_num_registros    = count(1)

    from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and convert(varchar(10), aa_fecha_asig, 103)        = @i_fecha_asig

     and io_id_inst_proc    >= @i_id_asig_act



  select 'ID ASIG ACT'       = aa_id_asig_act,

         'ID INST ACT'       = ia_id_inst_act,

         'ID INST PROC'      = io_id_inst_proc,

         'ESTADO'            = aa_estado,

         'NOMBRE PROCESO'    = (select pr_nombre_proceso from wf_proceso a

                                 where pr_codigo_proceso = c.io_codigo_proc),

         'ACTIVIDAD'         = ia_nombre_act,

         'ID. CLIENTE'       = io_campo_1,

         'NOMBRE CLIENTE'    = (select en_nomlar from cobis..cl_ente

                                 where en_ente = c.io_campo_1),

         'MONTO'             = convert(varchar(32), io_campo_2),

         'NUM TRAMITE'       = io_campo_3,

         'FECHA DE LLEGADA'  = convert(varchar(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), aa_fecha_asig, 108),

         'FUNCIONALIDAD'     = ia_func_asociada,

         'ID. PASO'          = ia_id_paso,

         'ID. PROCESO'       = io_codigo_proc,

         'VER. PROC.'        = io_version_proc,

         'ID. DEST'          = aa_id_destinatario,

         'ID. ROL'           = aa_id_rol,

         'RETRASADA'         = ia_retrasada,

         'ID INST HIJO'      = io_id_inst_proc,

	 'VERSION'	     = io_version_proc,

	 'DURACION'          = ar_tiempo_efectivo,
	 'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	 'FECHA CREACION'    = io_fecha_crea,
	 'COSTO'	     = ar_costo_act_proc,
	 'ROL'               = (select ro_nombre_rol from wf_rol
                                  where ro_id_rol = d.aa_id_rol),

         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                  and us_id_usuario = d.aa_id_destinatario),
	 'CLAIM'             = aa_claim,

	 'URL DETALLE'       = 
				case
				when 
				     (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = e.ia_codigo_act
				     and co_id = tv_component_detail_id
					 and tv_order = 1) is null then 
				    (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc 
				     and tv_version_id = c.io_version_proc
				     and co_id = tv_component_detail_id
					 and tv_order = 1)
				else (select co_namespace + co_class --select tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = e.ia_codigo_act
				     and co_id = tv_component_detail_id
					 and tv_order = 1)
				end,
	'TYPE COMPONENT'     = (select co_ct_id
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = e.ia_codigo_act
				     and co_id = tv_component_id
					 and tv_order = 1),
					 
	'CODIGO ALTERNO'   = io_codigo_alterno

    from wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc

   where io_id_inst_proc     = ia_id_inst_proc

     and ia_id_inst_act      = aa_id_inst_act

     and io_estado      not in ('ELI', 'TER', 'SUS','CAN')

     and ar_codigo_actividad = ia_codigo_act

     and ar_codigo_proceso   = io_codigo_proc

     and ar_version_proceso  = io_version_proc

     and aa_id_destinatario  = @i_id_usuario

     and aa_estado      not in ('COM', 'REA', 'REC')      -- CMU

     and convert(varchar(10), aa_fecha_asig, 103)        = @i_fecha_asig

     and ((io_id_inst_proc  >= @i_id_asig_act and @i_modo = 0)

      or  (io_id_inst_proc   > @i_id_asig_act and @i_modo = 1))

   order by io_id_inst_proc desc

end

return 0
go
