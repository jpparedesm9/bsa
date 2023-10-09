use cob_workflow
go

IF OBJECT_ID ('dbo.sp_cons_act_usr_wf') IS NOT NULL
	DROP PROCEDURE dbo.sp_cons_act_usr_wf
GO

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
/*   27-Sep-2016  Erika Ortiz.       Ajustes de nombre     */
/*                                   (en_nomlar)           */
/************************************************************/
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
  @w_table_code  		  int,
  @w_spid                         int,
  @w_user                 int
  
select @w_sp_name = 'sp_cons_act_usr_wf',
       @w_user = null,
       @w_spid = @@SPID

--Recupera el codigo de la tabla wf_estado_proceso
select @w_table_code = codigo 
  from cobis..cl_tabla 
 where tabla='wf_estado_proceso'

-- Si no se tiene id de usuario, se sale del SP y se coloca un mensaje de error.
if @@rowcount = 0
begin -- No existe usuario con ese login.
  exec cobis..sp_cerror
       @i_num  = 3107501,
	   @t_from = @w_sp_name
  return 1
end
 /*create table #id_ente_temp ( id_ente      int     not null,
                              tipo         char(2) not null)
							  
 create table #id_login_temp ( id_login     varchar(25)     not null,
                              tipo         char(2) not null)
*/

 create table #act_usr_temp (io_id_inst_proc      INT NOT NULL,
	                         ia_id_inst_act       INT NOT NULL,
	                         aa_id_asig_act       INT NOT NULL,
	                         io_codigo_proc       INT NOT NULL,
	                         io_version_proc      INT NOT NULL,
	                         ia_codigo_act        SMALLINT NOT NULL,
	                         io_estado            VARCHAR (10) NULL,
	                         io_campo_1           INT NULL,
	                         io_campo_2           VARCHAR (255) NULL,
	                         io_campo_3           INT NULL,
	                         io_campo_4           VARCHAR (255) NULL,
	                         io_campo_5           INT NULL,
							 io_campo_7           VARCHAR (255) NULL,
	                         io_fecha_crea        DATETIME, 
	                         io_codigo_alterno    VARCHAR (50) NULL,
	                         ia_func_asociada     VARCHAR (30) NULL,
	                         ia_id_paso           INT NOT NULL,
	                         ia_nombre_act        VARCHAR (30) NULL, 
	                         aa_fecha_asig        DATETIME NOT NULL, 
	                         aa_fecha_fin         DATETIME NULL,
	                         aa_id_destinatario   INT NOT NULL, 
	                         aa_id_rol            INT NULL, 
	                         aa_oficina_asig      SMALLINT NOT NULL,
	                         aa_estado            VARCHAR (10) NOT NULL,
	                         aa_manual            TINYINT NULL,
	                         aa_claim             CHAR (1) NULL,
	                         aa_act_regreso       CHAR (1) NULL,
	                         aa_id_item_jerarquia INT NULL,
	                         ar_tiempo_efectivo   INT NOT NULL,
	                         ar_tiempo_estandar   INT NOT NULL,
	                         ar_costo_act_proc    money not null
     )

if @i_nombre is not null
begin
	select @i_nombre = UPPER(@i_nombre)
	insert into id_ente_temp 
	select @w_spid, en_ente, 'EN' from cobis..cl_ente  where en_nomlar LIKE '%' + @i_nombre + '%'

	insert into id_login_temp 
	select @w_spid, fu_login, 'LN' from cobis..cl_funcionario where fu_nombre LIKE '%' + @i_nombre + '%'
	
	insert into id_ente_temp 
	select @w_spid, gr_grupo, 'GN' from cobis..cl_grupo where gr_nombre LIKE '%' + @i_nombre + '%'
	
end

if @i_identificacion is not null
begin
	select @i_identificacion = UPPER(@i_identificacion)
	
	insert into id_ente_temp
	select @w_spid, en_ente, 'EI' from cobis..cl_ente  where en_ced_ruc = @i_identificacion
	
	insert into id_login_temp 
	select @w_spid, fu_login, 'LI' from cobis..cl_funcionario where fu_cedruc = @i_identificacion
	
	insert into id_ente_temp 
	select @w_spid, gr_grupo, 'GI' from cobis..cl_grupo where @i_identificacion NOT LIKE '%[^0-9]%'  and gr_grupo = convert(integer,@i_identificacion)
end

if @i_cod_alterno is not null
begin
	select @i_cod_alterno = LTRIM(RTRIM(@i_cod_alterno))
end

select @w_user = us_id_usuario from wf_usuario where us_login = @s_user 

if (@i_usuario is not null and @s_user <> @i_usuario)
begin
   if exists (select 1 from wf_usuario where us_login = @i_usuario)
   begin 
	select @w_user = us_id_usuario from wf_usuario where us_login = @i_usuario
   end
   else
   begin 
      select @w_user = null
   end
end




--print 'usuario:  %1!', @w_user

/*create table #id_rol_temp ( id_rol int  not null)*/
insert into id_rol_temp 
select @w_spid, ur_id_rol from wf_usuario_rol, wf_usuario where ur_id_usuario=us_id_usuario and us_login=@s_user

insert into #act_usr_temp 
Select io_id_inst_proc,
       ia_id_inst_act,
       aa_id_asig_act,
       io_codigo_proc,
       io_version_proc,
       ia_codigo_act,
       io_estado,
       io_campo_1,
       io_campo_2,
	   io_campo_3,
       io_campo_4,
       io_campo_5,
	   io_campo_7,
       io_fecha_crea, 
       io_codigo_alterno,
	   ia_func_asociada,
	   ia_id_paso,
	   ia_nombre_act,
       aa_fecha_asig, 
       aa_fecha_fin,
	   aa_id_destinatario, 
       aa_id_rol, 
       aa_oficina_asig,
       aa_estado,
       aa_manual,
	   aa_claim,
	   aa_act_regreso,
	   aa_id_item_jerarquia,
       ar_tiempo_efectivo,
       ar_tiempo_estandar,
       ar_costo_act_proc
  FROM wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc
 WHERE io_id_inst_proc = ia_id_inst_proc
   AND ia_id_inst_act = aa_id_inst_act
   AND ar_codigo_actividad = ia_codigo_act
   AND ar_codigo_proceso = io_codigo_proc
   AND ar_version_proceso = io_version_proc
   AND io_estado NOT IN ('ELI','TER','SUS','CAN')
   AND aa_estado NOT IN ('COM','REA','REC')
   AND (aa_id_destinatario  = @w_user ) --Filtro usuario

insert into #act_usr_temp 
Select io_id_inst_proc,
       ia_id_inst_act,
       aa_id_asig_act,
       io_codigo_proc,
       io_version_proc,
       ia_codigo_act,
       io_estado,
       io_campo_1,
       io_campo_2,
	   io_campo_3,
       io_campo_4,
       io_campo_5,
	   io_campo_7,
       io_fecha_crea, 
       io_codigo_alterno,
	   ia_func_asociada,
	   ia_id_paso,
	   ia_nombre_act,
       aa_fecha_asig, 
       aa_fecha_fin,
	   aa_id_destinatario, 
       aa_id_rol, 
       aa_oficina_asig,
       aa_estado,
       aa_manual,
	   aa_claim,
	   aa_act_regreso,
	   aa_id_item_jerarquia,
       ar_tiempo_efectivo,
       ar_tiempo_estandar,
       ar_costo_act_proc
  FROM wf_inst_proceso c, wf_inst_actividad e, wf_asig_actividad d, wf_actividad_proc
 WHERE io_id_inst_proc = ia_id_inst_proc
   AND ia_id_inst_act = aa_id_inst_act
   AND ar_codigo_actividad = ia_codigo_act
   AND ar_codigo_proceso = io_codigo_proc
   AND ar_version_proceso = io_version_proc
   AND io_estado NOT IN ('ELI','TER','SUS','CAN')
   AND aa_estado NOT IN ('COM','REA','REC')
   AND (aa_id_rol IN (SELECT id_rol FROM id_rol_temp))	  --Filtro para cargar todas las tareas de los roles donde esta el usuario
   AND aa_id_destinatario not in (@w_user) 

--opcion busca por grupos
IF @i_criterio = 'G'
BEGIN

	IF @i_usuario IS NOT NULL
	BEGIN	
		IF(@s_user <> @i_usuario)
		BEGIN
			select @w_user = us_id_usuario from wf_usuario where us_login = @i_usuario
		END
		ELSE 
		BEGIN
			select @w_user = null
		END		
	END
	ELSE
	BEGIN
		select @w_user = null
	END
	

		

    SET ROWCOUNT @i_num_filas

	SELECT @o_num_registros = count(1)
	FROM #act_usr_temp c
	WHERE (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                              --Filtro codigo alterno
    and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                                       --Filtro instancia proceso
    and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                       --Filtro proceso
    and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                                  --Filtro actividad
	and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))                          --Filtro nombre cliente
	and (@i_identificacion is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))                    --Filtro identificacion cliente
        --AND (aa_id_rol IN (SELECT id_rol FROM id_rol_temp where spid = @w_spid))														--Filtro para cargar todas las tareas de los roles donde esta el usuario
	--and (aa_id_destinatario  = @w_user or @w_user is null) --Filtro usuario
        and aa_id_destinatario not in (select us_id_usuario from wf_usuario where us_login = @s_user)
	and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_desde, 103)) <= 0 OR (@i_fecha_desde IS NULL ))           --Filtro fecha desde
	and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_hasta, 103)) >= 0 OR (@i_fecha_hasta IS NULL))            --Filtro fecha hasta 
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
			'FECHA DE LLEGADA'  = convert(VARCHAR(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(VARCHAR(10), c.aa_fecha_asig, 108),
			'FUNCIONALIDAD'     = ia_func_asociada,
			'ID. PASO'          = ia_id_paso,
			'ID. PROCESO'       = io_codigo_proc,
			'VER. PROC.'        = io_version_proc,
			'ID. DEST'          = aa_id_destinatario,
			'ID. ROL'           = aa_id_rol,
			 'RETRASADA'         = case when 
			(
			
					(
							select datediff(minute,  c.aa_fecha_asig , getdate() )
					) --minutos entre fecha inicio y fin
					-
					(
					   (
						   SELECT COUNT(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)		 
						) --feriados
						+
						(
						   SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (
						case when exists 
							(
							SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7) 
							)
						   OR
                            (							  
							   DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7)
							 )
						then( 
						   select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig) 
						)
						else 
						   0
						end
						
						)

						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
						
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end 
			,
			'ID INST HIJO'      = io_id_inst_proc,
			'VERSION'           = io_version_proc,
			'ID ACTIVIDAD'      = ia_codigo_act,
             --se suma feriados y fines de semana
			'DURACION'          = ar_tiempo_efectivo,
			'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
			'FECHA CREACION'    = convert(VARCHAR(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(VARCHAR(10), c.io_fecha_crea, 108),
			'COSTO'             = ar_costo_act_proc,
			'ROL'               = (SELECT ro_nombre_rol FROM wf_rol WHERE ro_id_rol = c.aa_id_rol),
			'NOMBRE DEST'       = (SELECT fu_nombre FROM cobis..cl_funcionario,wf_usuario	WHERE fu_login = us_login AND us_id_usuario = c.aa_id_destinatario),
			'CLAIM'             = aa_claim,
			'URL DETALLE'       =  CASE WHEN 
                                      (SELECT co_namespace + co_class --tv_component_detail_id 
                           				FROM cob_pac..bpi_task_view, cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND co_id = tv_component_id                     			
                                        AND tv_task_id = c.ia_codigo_act
					AND tv_order = 1) IS NULL
                                  THEN 
                                       (SELECT co_namespace + co_class --tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND co_id = tv_component_detail_id
                                        AND tv_task_id = c.ia_codigo_act
					AND tv_order = 1)
                                  ELSE 
                                       (SELECT co_namespace + co_class --select tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND co_id = tv_component_id
                                        AND tv_task_id = c.ia_codigo_act
					AND tv_order = 1)
                                  END,
			'TYPE COMPONENT'    = (SELECT DISTINCT co_ct_id	FROM cob_pac..bpi_task_view,cobis..an_component
                                   WHERE tv_process_id = c.io_codigo_proc
                                   AND tv_version_id = c.io_version_proc
                                   AND tv_task_id = c.ia_codigo_act
                                   AND co_id = tv_component_id
								   AND tv_order = 1
								    ),
			'CAMPO_4'           = io_campo_4,
			'REGRESO'           = aa_act_regreso,
			'CODIGO ALTERNO'    = io_codigo_alterno,
			'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),
			'TIPO DESTINATARIO'	 = (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),
			'TIPO CLIENTE'       =  case when (select pr_producto from cob_workflow..wf_proceso where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' 
									then
										''
									else
										(select en_subtipo from cobis..cl_ente where en_ente = c.io_campo_1)
									end
		FROM #act_usr_temp c
		WHERE (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                              --Filtro codigo alterno
            and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                                       --Filtro instancia proceso
            and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                       --Filtro proceso
            and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                                  --Filtro actividad
			and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))--Filtro nombre cliente
			and (@i_identificacion is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))--Filtro identificacion cliente
                        --AND (aa_id_rol IN (SELECT id_rol FROM id_rol_temp where spid = @w_spid))--Filtro para cargar todas las tareas de los roles donde esta el usuario
			and (aa_id_destinatario  = @w_user or @w_user is null) --Filtro usuario
                        and aa_id_destinatario not in (select us_id_usuario from wf_usuario where us_login = @s_user) 
                        and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_desde, 103)) <= 0 OR @i_fecha_desde IS NULL )           --Filtro fecha desde
			and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_hasta, 103)) >= 0 OR @i_fecha_hasta IS NULL)            --Filtro fecha hasta     
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
			   'MONTO'                = convert(VARCHAR(32), c.io_campo_2),
			   'NUM TRAMITE'          = io_campo_3,
			   'FECHA DE LLEGADA'     = convert(VARCHAR(10), aa_fecha_asig, @i_formato_fecha) + ' ' + convert(VARCHAR(10), c.aa_fecha_asig, 108),
			   'FUNCIONALIDAD'        = ia_func_asociada,
			   'ID. PASO'             = ia_id_paso,
			   'ID. PROCESO'          = io_codigo_proc,
			   'VER. PROC.'           = io_version_proc,
			   'ID. DEST'             = aa_id_destinatario,
			   'ID. ROL'              = aa_id_rol,
			    'RETRASADA'         = case when 
			(
			
					(
							select datediff(minute,  c.aa_fecha_asig , getdate() )
					) --minutos entre fecha inicio y fin
					-
					(
					   (
						   SELECT COUNT(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)		 
						) --feriados
						+
						(
						   SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (
						case when exists 
							(
							SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7) 
							)
						   OR
                            (							  
							   DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7)
							 )
						then( 
						   select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig) 
						)
						else 
						   0
						end
						
						)

						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
						
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end 
			,
			   'ID INST HIJO'         = io_id_inst_proc,
			   'VERSION'              = io_version_proc,
			   'ID ACTIVIDAD'         = ia_codigo_act,
			   'DURACION'             = ar_tiempo_efectivo,
			   'TIEMPO ESTANDAR'      = ar_tiempo_estandar,
			   'FECHA CREACION'       = convert(VARCHAR(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(VARCHAR(10), c.io_fecha_crea, 108),
			   'COSTO'                = ar_costo_act_proc,
			   'ROL'                  = (SELECT ro_nombre_rol FROM wf_rol WHERE ro_id_rol = c.aa_id_rol),
			   'NOMBRE DEST'          = (SELECT fu_nombre FROM cobis..cl_funcionario,wf_usuario	WHERE fu_login = us_login AND us_id_usuario = c.aa_id_destinatario),
			   'CLAIM'                = aa_claim,
               'URL DETALLE'          = CASE WHEN 
                                            (SELECT co_namespace + co_class --tv_component_detail_id 
                                            FROM cob_pac..bpi_task_view, cobis..an_component
                                            WHERE tv_process_id = c.io_codigo_proc
                                            AND tv_version_id = c.io_version_proc
                                            AND tv_task_id = c.ia_codigo_act
                                            AND co_id = tv_component_id) IS NULL
                                        THEN 
                                            (SELECT co_namespace + co_class --tv_component_detail_id 
                                            FROM cob_pac..bpi_task_view,cobis..an_component
                                            WHERE tv_process_id = c.io_codigo_proc
                                            AND tv_version_id = c.io_version_proc
            								AND co_id = tv_component_detail_id
                        					AND tv_task_id = c.ia_codigo_act
											 )
                                        ELSE 
                                            (SELECT co_namespace + co_class --select tv_component_detail_id 
                                            FROM cob_pac..bpi_task_view,cobis..an_component
                                            WHERE tv_process_id = c.io_codigo_proc
                                            AND tv_version_id = c.io_version_proc
                                            AND tv_task_id = c.ia_codigo_act
                                            AND co_id = tv_component_id
											 )
                                        END,
			   'TYPE COMPONENT'       = (SELECT DISTINCT co_ct_id FROM cob_pac..bpi_task_view, cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND tv_task_id = c.ia_codigo_act
                                        AND co_id = tv_component_id
										 ),
               'CAMPO_4'              = io_campo_4,
			   'REGRESO'              = aa_act_regreso,
			   'CODIGO ALTERNO'       = io_codigo_alterno,
			   'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),
			   'TIPO DESTINATARIO'	 = (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act) 
		FROM #act_usr_temp c
		WHERE (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                              --Filtro codigo alterno
        and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                                       --Filtro instancia proceso
        and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                       --Filtro proceso
        and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                                  --Filtro actividad
        and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))--Filtro nombre cliente
		and (@i_identificacion is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))--Filtro identificacion cliente
        --AND (aa_id_rol IN (SELECT id_rol FROM id_rol_temp where spid = @w_spid))--Filtro para cargar todas las tareas de los roles donde esta el usuario
        and (aa_id_destinatario  = @w_user or @w_user is null) --Filtro usuario
        and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_desde, 103)) >= 0 OR @i_fecha_desde IS NULL )           --Filtro fecha desde
		and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_hasta, 103)) <= 0 OR @i_fecha_hasta IS NULL)            --Filtro fecha hasta     
		AND aa_id_asig_act < @i_id_asig_act
		ORDER BY aa_id_asig_act DESC
	END
	SET ROWCOUNT 0
END

--opcion nueva
if @i_criterio = 'S'
begin
	if (@i_usuario is null)
	BEGIN
		select @w_user = null
	END
set rowcount @i_num_filas

  select @o_num_registros = count(1)
    from #act_usr_temp
   where (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                     --Filtro codigo alterno
     and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                              --Filtro instancia proceso
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                              --Filtro proceso
     and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                         --Filtro actividad
	 and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))--Filtro nombre cliente
	 and (@i_identificacion is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))--Filtro identificacion cliente
	 and (aa_id_destinatario  = @w_user or @w_user is null) --Filtro usuario
	 and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_desde, 103)) <= 0 OR @i_fecha_desde IS NULL )           --Filtro fecha desde
	 and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_hasta, 103)) >= 0 OR @i_fecha_hasta IS NULL)            --Filtro fecha hasta     
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
									when c.io_campo_7 = 'G' or c.io_campo_7 = 'S'
									then
										(select gr_nombre from cobis..cl_grupo where gr_grupo = c.io_campo_1)
									else
										(select en_nomlar from cobis..cl_ente where en_ente = c.io_campo_1)
									end
							   end,
         'MONTO'             = convert(varchar(32), c.io_campo_2),
         'NUM TRAMITE'       = io_campo_3,
         'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),
         'FUNCIONALIDAD'     = ia_func_asociada,
         'ID. PASO'          = ia_id_paso,
         'ID. PROCESO'       = io_codigo_proc,
         'VER. PROC.'        = io_version_proc,
         'ID. DEST'          = aa_id_destinatario,
         'ID. ROL'           = aa_id_rol,
        'RETRASADA'         = case when 
			(
			
					(
							select datediff(minute,  c.aa_fecha_asig , getdate() )
					) --minutos entre fecha inicio y fin
					-
					(
					   (
						   SELECT COUNT(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)		 
						) --feriados
						+
						(
						   SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (
						case when exists 
							(
							SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7) 
							)
						   OR
                            (							  
							   DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7)
							 )
						then( 
						   select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig) 
						)
						else 
						   0
						end
						
						)

						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
						
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end 
			,
         'ID INST HIJO'      = io_id_inst_proc,
	     'VERSION'	         = io_version_proc,
         'ID ACTIVIDAD'      = ia_codigo_act,
	     'DURACION'          = ar_tiempo_efectivo,
	     'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	     'FECHA CREACION'    = convert(varchar(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), io_fecha_crea, 108),
	     'COSTO'	         = ar_costo_act_proc,
	     'ROL'               = (select ro_nombre_rol from wf_rol where ro_id_rol = c.aa_id_rol),
         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                and us_id_usuario = c.aa_id_destinatario),
	     'CLAIM'             = aa_claim,
	     'URL DETALLE'       = CASE WHEN 
                                      (SELECT co_namespace + co_class --tv_component_detail_id 
                           				FROM cob_pac..bpi_task_view, cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                  			AND tv_task_id = c.ia_codigo_act
                                        AND co_id = tv_component_id
					AND tv_order = 1) IS NULL
                                  THEN 
                                       (SELECT co_namespace + co_class --tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND co_id = tv_component_detail_id
                                        AND tv_task_id = c.ia_codigo_act
					AND tv_order = 1)
                                  ELSE 
                                       (SELECT co_namespace + co_class --select tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND tv_task_id = c.ia_codigo_act
                                        AND co_id = tv_component_id
					AND tv_order = 1)
                                  END,                              
         'TYPE COMPONENT'    = (select distinct co_ct_id from cob_pac..bpi_task_view, cobis..an_component 
                                where tv_process_id = c.io_codigo_proc 
                                and tv_version_id = c.io_version_proc
                                and tv_task_id = c.ia_codigo_act
                                and co_id = tv_component_id
								 AND tv_order = 1),
         'CAMPO_4'	         = io_campo_4,
	     'REGRESO'           = aa_act_regreso,
	     'CODIGO ALTERNO'    = io_codigo_alterno,
		 'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),
		 'TIPO DESTINATARIO'	= (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),
	     'TIPO CLIENTE'      = case when (select pr_producto from cob_workflow..wf_proceso where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' 
                               then
                                    ''
							   else
                                    (select en_subtipo from cobis..cl_ente where en_ente = c.io_campo_1)
							   END
   from #act_usr_temp c
   where io_estado      not in ('ELI', 'TER', 'SUS','CAN')
     and aa_estado      not in ('COM', 'REA', 'REC')
	 and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                     --Filtro codigo alterno
     and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                              --Filtro instancia proceso
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                              --Filtro proceso
     and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                         --Filtro actividad
	 and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))--Filtro nombre cliente
	 and (@i_identificacion is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))--Filtro identificacion cliente
	 and (aa_id_destinatario  = @w_user or @w_user is null) --Filtro usuario
	 and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_desde, 103)) <= 0 OR @i_fecha_desde IS NULL )           --Filtro fecha desde
	 and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_hasta, 103)) >= 0 OR @i_fecha_hasta IS NULL)            --Filtro fecha hasta     
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
									when c.io_campo_7 = 'G' or c.io_campo_7 = 'S'
									then
										(select gr_nombre from cobis..cl_grupo where gr_grupo = c.io_campo_1)
									else
										(select en_nomlar from cobis..cl_ente where en_ente = c.io_campo_1)
									end
                                 
							   end,
         'MONTO'             = convert(varchar(32), io_campo_2),
         'NUM TRAMITE'       = io_campo_3,
         'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),
         'FUNCIONALIDAD'     = ia_func_asociada,
         'ID. PASO'          = ia_id_paso,
         'ID. PROCESO'       = io_codigo_proc,
         'VER. PROC.'        = io_version_proc,
         'ID. DEST'          = aa_id_destinatario,
         'ID. ROL'           = aa_id_rol,
          'RETRASADA'         = case when 
			(
			
					(
							select datediff(minute,  c.aa_fecha_asig , getdate() )
					) --minutos entre fecha inicio y fin
					-
					(
					   (
						   SELECT COUNT(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)		 
						) --feriados
						+
						(
						   SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (
						case when exists 
							(
							SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7) 
							)
						   OR
                  (							  
							   DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7)
							 )
						then( 
						   select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig) 
						)
						else 
						   0
						end
						
						)

						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
						
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end 
			,
         'ID INST HIJO'      = io_id_inst_proc,
	     'VERSION'	         = io_version_proc,
         'ID ACTIVIDAD'      = ia_codigo_act,
	     'DURACION'          = ar_tiempo_efectivo, 
	     'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	     'FECHA CREACION'    = convert(varchar(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), c.io_fecha_crea, 108),
	     'COSTO'	         = ar_costo_act_proc,
	     'ROL'               = (select ro_nombre_rol from wf_rol  where ro_id_rol = c.aa_id_rol),
         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario where fu_login = us_login and us_id_usuario = c.aa_id_destinatario),
	     'CLAIM'             = aa_claim,
	     'URL DETALLE'       = CASE WHEN 
                                      (SELECT co_namespace + co_class --tv_component_detail_id 
                           				FROM cob_pac..bpi_task_view, cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                     			AND tv_task_id = c.ia_codigo_act
                                        AND co_id = tv_component_id
 					AND tv_order = 1) IS NULL
                                  THEN 
                                       (SELECT co_namespace + co_class --tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND co_id = tv_component_detail_id
                                        AND tv_task_id = c.ia_codigo_act
					AND tv_order = 1)
                                  ELSE 
                                       (SELECT co_namespace + co_class --select tv_component_detail_id 
                                        FROM cob_pac..bpi_task_view,cobis..an_component
                                        WHERE tv_process_id = c.io_codigo_proc
                                        AND tv_version_id = c.io_version_proc
                                        AND tv_task_id = c.ia_codigo_act
                                        AND co_id = tv_component_id
					AND tv_order = 1)
                                  END,           
         'TYPE COMPONENT'    = (select distinct co_ct_id from cob_pac..bpi_task_view, cobis..an_component 
                			    where tv_process_id = c.io_codigo_proc
           				        and tv_version_id = c.io_version_proc
				                and tv_task_id = c.ia_codigo_act
				                and co_id = tv_component_id
								AND tv_order = 1
								 ),
         'CAMPO_4'	        =  io_campo_4,
	     'REGRESO'          = aa_act_regreso,
	     'CODIGO ALTERNO'   = io_codigo_alterno,
		 'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),
		 'TIPO DESTINATARIO'= (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act) 
   from #act_usr_temp c
   where (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)                                                     --Filtro codigo alterno
     and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso is null or @i_inst_proceso = 0)                              --Filtro instancia proceso
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                              --Filtro proceso
     and (ia_codigo_act =  @i_actividad or @i_actividad is null or @i_actividad = 0)                                         --Filtro actividad
	 and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))--Filtro nombre cliente
	 and (@i_identificacion is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))--Filtro identificacion cliente
     and (aa_id_destinatario  = @w_user or @w_user is null) --Filtro usuario
	 and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_desde, 103)) <= 0 OR @i_fecha_desde IS NULL )           --Filtro fecha desde
	 and (datediff(dd,aa_fecha_asig,convert(datetime, @i_fecha_hasta, 103)) >= 0 OR @i_fecha_hasta IS NULL)            --Filtro fecha hasta     
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
    from #act_usr_temp c
   where aa_id_destinatario  = @i_id_usuario
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

         'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),

         'FUNCIONALIDAD'     = ia_func_asociada,

         'ID. PASO'          = ia_id_paso,

         'ID. PROCESO'       = io_codigo_proc,

         'VER. PROC.'        = io_version_proc,

         'ID. DEST'          = aa_id_destinatario,
		 
         'ID. ROL'           = aa_id_rol,

          'RETRASADA'         = case when 
			(
			
					(
							select datediff(minute,  c.aa_fecha_asig , getdate() )
					) --minutos entre fecha inicio y fin
					-
					(
					   (
						   SELECT COUNT(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)		 
						) --feriados
						+
						(
						   SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (
						case when exists 
							(
							SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7) 
							)
						   OR
                            (							  
							   DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7)
							 )
						then( 
						   select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig) 
						)
						else 
						   0
						end
						
						)

						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
						
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end 
			,

         'ID INST HIJO'      = io_id_inst_proc,

	     'VERSION'	         = io_version_proc,

         'ID ACTIVIDAD'      = ia_codigo_act,

	     'DURACION'          = ar_tiempo_efectivo , 
		 
	     'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
		 
	     'FECHA CREACION'    = convert(varchar(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), c.io_fecha_crea, 108),
		 
	     'COSTO'	         = ar_costo_act_proc,
		 
	     'ROL'               = (select ro_nombre_rol from wf_rol
                                where ro_id_rol = c.aa_id_rol),

         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                and us_id_usuario = c.aa_id_destinatario),
							
	     'CLAIM'             = aa_claim,

	     'URL DETALLE'   = case when 
				     (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id 
  				     AND tv_order = 1) is null 
                               then
				     (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc 
				     and tv_version_id = c.io_version_proc
				     and co_id = tv_component_detail_id 
                                     and tv_task_id = c.ia_codigo_act 
  				     AND tv_order = 1)
				else (select co_namespace + co_class --select tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id 
					 AND tv_order = 1)

				end,

	'TYPE COMPONENT'     = (select distinct co_ct_id

				     from cob_pac..bpi_task_view, cobis..an_component 

				     where tv_process_id = c.io_codigo_proc

				     and tv_version_id = c.io_version_proc

				     and tv_task_id = c.ia_codigo_act

				     and co_id = tv_component_id
					 AND tv_order = 1
					  ),


	'CAMPO_4'	= io_campo_4,
	
	'REGRESO'   = aa_act_regreso,
	
	'CODIGO ALTERNO'   = io_codigo_alterno,
	
	'ID TIPO DESTINATARIO' = (select max(de_id_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act),

	'TIPO DESTINATARIO'	 = (select max(de_tipo_destinatario) from wf_destinatario where de_codigo_proceso = c.io_codigo_proc and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act)
	
    from #act_usr_temp c
   where aa_id_destinatario  = @i_id_usuario
     and ((aa_id_asig_act  > @i_id_asig_act and @i_modo = 1))
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
    from #act_usr_temp c
   where aa_id_destinatario  = @i_id_usuario
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

         'MONTO'             = convert(varchar(32), c.io_campo_2),

         'NUM TRAMITE'       = io_campo_3,

         'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),

         'FUNCIONALIDAD'     = ia_func_asociada,

         'ID. PASO'          = ia_id_paso,

         'ID. PROCESO'       = io_codigo_proc,

         'VER. PROC.'        = io_version_proc,

         'ID. DEST'          = aa_id_destinatario,

         'ID. ROL'           = aa_id_rol,

          'RETRASADA'         = case when 
			(
			
					(
							select datediff(minute,  c.aa_fecha_asig , getdate() )
					) --minutos entre fecha inicio y fin
					-
					(
					   (
						   SELECT COUNT(1)*1440 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)		 
						) --feriados
						+
						(
						   SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (
						case when exists 
							(
							SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7) 
							)
						   OR
                            (							  
							   DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7)
							 )
						then( 
						   select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig) 
						)
						else 
						   0
						end
						
						)

						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
						
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end 
			,

         'ID INST HIJO'      = io_id_inst_proc,

	 'VERSION'	     = io_version_proc,

	 'DURACION'          = ar_tiempo_efectivo,
	 'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	 'FECHA CREACION'    = io_fecha_crea,
	 'COSTO'	     = ar_costo_act_proc,
	 'ROL'               = (select ro_nombre_rol from wf_rol
                                  where ro_id_rol = c.aa_id_rol),

         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                  and us_id_usuario = c.aa_id_destinatario),
	 'CLAIM'             = aa_claim,


	 'URL DETALLE'       = case when 
				     (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id 
				     AND tv_order = 1) is null 
                               then
				     (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc 
				     and tv_version_id = c.io_version_proc
				     and co_id = tv_component_detail_id 
                                     and tv_task_id = c.ia_codigo_act 
				     AND tv_order = 1)
				else (select co_namespace + co_class --select tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id 
				     AND tv_order = 1)
				end,


	'TYPE COMPONENT'     = (select co_ct_id
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id
					 AND tv_order = 1
					  ),
					 
	'CODIGO ALTERNO'   = io_codigo_alterno
	
    from #act_usr_temp c
   where aa_id_destinatario  = @i_id_usuario
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
    from #act_usr_temp c
   where aa_id_destinatario  = @i_id_usuario
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
         'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),
         'FUNCIONALIDAD'     = ia_func_asociada,
         'ID. PASO'          = ia_id_paso,
         'ID. PROCESO'       = io_codigo_proc,
         'VER. PROC.'        = io_version_proc,
         'ID. DEST'          = aa_id_destinatario,
         'ID. ROL'           = aa_id_rol,
          'RETRASADA'         = case when ((select datediff(minute,  c.aa_fecha_asig , getdate() )) --minutos entre fecha inicio y fin
					-
					((SELECT COUNT(1)*1440 
                                            from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
						   where df_fecha >= CONVERT( varchar(10), c.aa_fecha_asig , 101)  and df_fecha<= CONVERT( varchar(10), getdate() , 101) 
						   and ofi.of_oficina = c.aa_oficina_asig and DATEPART(dw, df_fecha) not in (1,7)) --feriados
						+
						(SELECT 1440 * case when (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END)) < 0 then 0 else (
							(DATEDIFF(wk,  c.aa_fecha_asig, getdate()) * 2) -(CASE WHEN DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7) THEN 1 ELSE 0 END) ) end	
						) --fines de semana
					
						- (case when exists (SELECT 1 from cobis..cl_dias_feriados df inner join cobis..cl_oficina ofi on df.df_ciudad = ofi.of_ciudad 
							   where df_fecha = CONVERT( varchar(10), c.aa_fecha_asig , 101) and ofi.of_oficina = c.aa_oficina_asig 
							   and DATEPART(dw, df_fecha) not in (1,7))
						   OR (DATEPART(dw,  c.aa_fecha_asig) in ( 1, 7))
						then(select 1440 - datepart(hour, c.aa_fecha_asig) * 60 - datepart(minute, c.aa_fecha_asig))
						else 
						   0
						end)
						--minutos restantes del primer día hasta llegar a la media noche (fin de día)
					) --minutos de feriados + fines de semana + minutos del dia corriente - horas del primer día
			) > ar_tiempo_efectivo then 1 else 0 end,

         'ID INST HIJO'      = io_id_inst_proc,
	 'VERSION'	     = io_version_proc,
	 'DURACION'          = ar_tiempo_efectivo,
	 'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	 'FECHA CREACION'    = io_fecha_crea,
	 'COSTO'	     = ar_costo_act_proc,
	 'ROL'               = (select ro_nombre_rol from wf_rol
                                  where ro_id_rol = c.aa_id_rol),
         'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                  and us_id_usuario = c.aa_id_destinatario),
	 'CLAIM'             = aa_claim,

	 'URL DETALLE'       = 
				case when 
				     (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id
				     AND tv_order = 1) is null 
                                then 
				    (select co_namespace + co_class --tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc 
				     and tv_version_id = c.io_version_proc
				     and co_id = tv_component_detail_id
				     AND tv_order = 1)
				else (select co_namespace + co_class --select tv_component_detail_id 
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id
				     AND tv_order = 1)
				end,
	'TYPE COMPONENT'     = (select co_ct_id
				     from cob_pac..bpi_task_view, cobis..an_component 
				     where tv_process_id = c.io_codigo_proc
				     and tv_version_id = c.io_version_proc
				     and tv_task_id = c.ia_codigo_act
				     and co_id = tv_component_id
					 AND tv_order = 1),
					 
	'CODIGO ALTERNO'   = io_codigo_alterno
    from #act_usr_temp c
   where aa_id_destinatario  = @i_id_usuario
     and convert(varchar(10), aa_fecha_asig, 103)        = @i_fecha_asig
     and ((io_id_inst_proc  >= @i_id_asig_act and @i_modo = 0)
      or  (io_id_inst_proc   > @i_id_asig_act and @i_modo = 1))
   order by io_id_inst_proc desc

end
delete id_ente_temp where spid = @w_spid
delete id_login_temp where spid = @w_spid
delete id_rol_temp where spid = @w_spid

return 0
go
