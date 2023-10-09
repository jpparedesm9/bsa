use cob_workflow
go

if exists (select 1 from sysobjects
            where name = 'sp_cons_act_sup_wf')
begin
  -- print 'ELIMINANDO EL PROCEDIMIENTO sp_cons_act_sup_wf'
  drop procedure sp_cons_act_sup_wf
end
go


/************************************************************/
/*   ARCHIVO:         wf_cons_act_sup.sp                    */
/*   NOMBRE LOGICO:   sp_cons_act_sup_wf                    */
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
/*   Consulta las actividades para la administración de un  */
/*   supervisor  					    */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA        AUTOR               RAZON                 */
/*   10-Jun-2011  Santiago Gavilanes  Emision Inicial.      */
/************************************************************/
CREATE PROCEDURE sp_cons_act_sup_wf
(
  @s_user                 varchar(30)    = null,
  @s_sesn                 int            = null,
  @s_term                 varchar(30)    = null,
  @s_date                 datetime       = null,   
  @s_srv                  varchar(30)    = null,
  @s_lsrv                 varchar(30)    = null,
  @s_ofi                  smallint       = null,
  @t_trn                  int            = null,
  @s_rol                  smallint       = null,
  @s_org_err              char(1)        = null,
  @s_error                int            = null,
  @s_sev                  tinyint        = null,
  @s_msg                  descripcion    = null,
  @s_org                  char(1)        = null,
  @t_rty                  char(1)        = null,
  -- Criterios de busqueda.
  @i_operacion		      varchar(10)	 = null,  
  @i_id_asig_act          int            = 0,  
  @i_formato_fecha        int            = 100, 
  @i_usuario		      varchar(100)   = null,
  @i_proceso		      int            = null,
  @i_estado_proceso	      varchar(100)	 = null,
  @i_num_filas            int            = 255,
  @i_codigo_act           int            = null,
  @i_version_proceso      smallint       = null,
  @i_cod_alterno	      varchar(50)	 = null,
  @i_inst_proceso         int            = null,  -- Instancia Proceso (Nuevo)
  @i_nombre               varchar(254)   = null,  -- Nombre del Cliente (Nuevo)
  @i_ced_ruc              varchar(30)    = null,  -- Identificacion del Cliente (Nuevo)
  @i_fecha_desde          varchar(10)    = null,  -- Fecha Desde (Nuevo)
  @i_fecha_hasta          varchar(10)    = null,  -- Fecha Hasta (Nuevo)
  @i_filtro_por_grupo     varchar(1)     = 'T',
  @o_num_registros        int            = null out,
  @o_num_filas            tinyint        = null out
)
As declare
  @w_sp_name              varchar(64),
  @w_user_id              int,
  @w_retorno              int,
  @w_table_code  		  int,
  @w_bandera		  	  smallint,
  @w_user_id_filter       int,
  @w_spid                 int

select @w_sp_name = 'sp_cons_act_sup_wf'
select @w_spid = @@spid			

--Operación de búsqueda para los registros siguientes de las tareas activas end los flujos

--Recupera el codigo de la tabla wf_estado_proceso
select @w_table_code = codigo from cobis..cl_tabla where tabla='wf_estado_proceso'

							  
/* create table #id_ente_temp ( id_ente      int     not null,
                              tipo         char(2) not null)*/
							  
/*create table #id_login_temp ( id_login     varchar(25)     not null,
                              tipo         char(2) not null)*/
                              
 create table #act_sup_temp (io_id_inst_proc      INT NOT NULL,
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
	                         ia_retrasada         TINYINT null,
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

if @i_ced_ruc is not null
begin
	select @i_ced_ruc = UPPER(@i_ced_ruc)
	
	insert into id_ente_temp
	select @w_spid, en_ente, 'EI' from cobis..cl_ente  where en_ced_ruc = @i_ced_ruc
	
	insert into id_login_temp 
	select @w_spid, fu_login, 'LI' from cobis..cl_funcionario where fu_cedruc = @i_ced_ruc
	
	insert into id_ente_temp 
	select @w_spid, gr_grupo, 'GI' from cobis..cl_grupo where @i_ced_ruc NOT LIKE '%[^0-9]%'  and gr_grupo = convert(integer,@i_ced_ruc)
end


if @i_usuario is not null
begin
	select @w_user_id_filter = us_id_usuario 
      from wf_usuario 
     where us_login = @i_usuario
end


if @w_user_id_filter is null
begin
	select @w_user_id_filter = -1
end

if @i_operacion = 'QS'
begin
    if @i_usuario is not null
    begin
        select @w_user_id = us_id_usuario 
        from wf_usuario 
        where us_login = @i_usuario
    end
    else
    begin
        select @w_user_id = us_id_usuario 
        from wf_usuario 
        where us_login = @s_user
    end
 
--ejecuta sp para jerarquia de usuarios
	
	--se verifica si usuario logueado es supervisor del usuario de filtro
	if @i_usuario = @s_user or @i_usuario is null
	begin
		select @w_bandera = 1
	end
	else
	begin
		select @w_bandera = count(us_id_usuario) 
		from wf_usuario_jerarquia_tpl uj, wf_item_jerarquia_tpl ij 
		where uj.ij_id_item_jerarquia = ij.ij_id_item_jerarquia 
		and ij.ij_id_item_padre IN (select ij_id_item_jerarquia
									from wf_usuario_jerarquia_tpl  
									where us_id_usuario = (select us_id_usuario 
															from wf_usuario 
															where us_login = @s_user))
		and us_id_usuario = (select us_id_usuario 
							from wf_usuario 
							where us_login = @i_usuario)
	end
	
	if @w_bandera >= 1
	begin
		EXEC @w_retorno = sp_cons_usu_jer_wf  
			 @i_usuario = @w_user_id,
			 @ssn       = @s_sesn

		if @w_retorno <> 0
		begin
			return @w_retorno
		end
	end

    insert into #act_sup_temp 
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
           ia_retrasada,
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
       AND io_estado NOT IN ('ELI','TER','CAN')
       AND aa_estado NOT IN ('COM','REA','REC')
       AND (aa_id_destinatario  in   (select jer_user_temp from wf_jer_user_TEMP where ssn = @s_sesn and jer_user_temp <> @w_user_id)) 

    
set rowcount @i_num_filas

  /*Numero de registros*/
	select @o_num_registros = count(1)  
    from #act_sup_temp
	where (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno = null)                                                          --Filtro codigo alterno
    and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso = null or @i_inst_proceso = 0)                                   --Filtro instancia proceso
    and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                --Filtro proceso
    and (ia_codigo_act = @i_codigo_act or @i_codigo_act is null)                                                                --Filtro actividad
	and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN') and spid = @w_spid) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' AND spid = @w_spid))))--Filtro nombre cliente
	and (@i_ced_ruc is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI') and spid = @w_spid)) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' AND spid = @w_spid)))--Filtro identificacion cliente
	and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))        --Filtro fecha desde
    and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))         --Filtro fecha hasta   
	and (io_estado =  @i_estado_proceso or @i_estado_proceso is null)                                                        --Filtro estado 'SUS' ,'EJE','CAN'
    and aa_id_asig_act > @i_id_asig_act
	 
	/*Consulta de informacion*/
	select   'ID ASIG ACT'       = aa_id_asig_act,
		'ID INST ACT'       = ia_id_inst_act,
		'ID INST PROC'      = io_id_inst_proc,
		'ESTADO'            = (select valor from cobis..cl_catalogo where tabla = @w_table_code and codigo = c.io_estado),--aa_estado,
		'NOMBRE PROCESO'    = (select pr_nombre_proceso from wf_proceso a where pr_codigo_proceso = c.io_codigo_proc),
		'ACTIVIDAD'         = ia_nombre_act,		 
		'ID. CLIENTE'       = io_campo_1,
		'NOMBRE CLIENTE'    = case when (select pr_producto from cob_workflow..wf_proceso where pr_codigo_proceso = c.io_codigo_proc) = 'MCH' 
							  then						 	 
								 ''
							  else
								 (select en_nomlar from cobis..cl_ente where en_ente = c.io_campo_1)
							  end,
		'MONTO'             = convert(varchar(32), c.io_campo_2),
		'NUM TRAMITE'       = io_campo_3,
		'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),
		'FUNCIONALIDAD'     = ia_func_asociada,
		'ID. PASO'          = ia_id_paso,
		'ID. PROCESO'       = io_codigo_proc,
		'VER. PROC.'        = io_version_proc,
		'USUARIO DEST'      = (select us_login  from wf_usuario where us_id_usuario = c.aa_id_destinatario),
		'ID. DEST'          = aa_id_destinatario,   
		'ID. ROL'           = aa_id_rol,
		'RETRASADA'         = ia_retrasada,
		'ID INST HIJO'      = io_id_inst_proc,
		'VERSION'	        = io_version_proc,
		'ID ACTIVIDAD'      = ia_codigo_act,
		'OWNER_IDENTIFIER'  = aa_id_destinatario,
		'DURACION'          = ar_tiempo_efectivo,
		'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
		'FECHA CREACION'    = convert(varchar(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), c.io_fecha_crea, 108),
		'COSTO'	            = ar_costo_act_proc,
		'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
							   where fu_login = us_login
							   and us_id_usuario = c.aa_id_destinatario),
		'ROL'               = (select ro_nombre_rol from wf_rol where ro_id_rol = c.aa_id_rol),
		'CODIGO ALTERNO'    = io_codigo_alterno,
		'ID TIPO DESTINATARIO' = (	select max(de_id_destinatario) from wf_destinatario 
									where de_codigo_proceso = c.io_codigo_proc 
									and de_version_proceso = c.io_version_proc 
									and de_codigo_actividad = c.ia_codigo_act),
		'TIPO DESTINATARIO' = (	select max(de_tipo_destinatario) 
								from wf_destinatario where de_codigo_proceso = c.io_codigo_proc 
								and de_version_proceso = c.io_version_proc and de_codigo_actividad = c.ia_codigo_act)
	from #act_sup_temp c
	where (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno = null)                       --Filtro codigo alterno
	and (io_id_inst_proc =  @i_inst_proceso or @i_inst_proceso = null or @i_inst_proceso = 0)--Filtro instancia proceso
	and (c.io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)                                                --Filtro proceso
	and (ia_codigo_act = @i_codigo_act or @i_codigo_act is null)                                                                --Filtro actividad
	and (@i_nombre is null or	(io_campo_1 IN (select id_ente from id_ente_temp where tipo in ('EN','GN')) or (io_campo_2 IN (select id_login from id_login_temp where tipo = 'LN' and spid = @w_spid))))--Filtro nombre cliente
	and (@i_ced_ruc is null or (io_campo_1 IN (select id_ente from id_ente_temp  where tipo in ('EI','GI'))) or (io_campo_2 IN (select id_login from id_login_temp  where tipo = 'LI' and spid = @w_spid)))--Filtro identificacion cliente
	and ((convert(datetime, aa_fecha_asig, 103) >= convert(datetime, @i_fecha_desde, 103)) OR (@i_fecha_desde IS NULL ))        --Filtro fecha desde
	and ((convert(datetime, aa_fecha_asig, 103) <= convert(datetime, @i_fecha_hasta, 103)) OR (@i_fecha_hasta IS NULL))         --Filtro fecha hasta   
	and (io_estado =  @i_estado_proceso or @i_estado_proceso is null) --Filtro estado 'SUS' ,'EJE' , 'CAN'			 
	order by aa_id_asig_act
	
	delete wf_jer_user_TEMP
	where ssn = @s_sesn
	 
  set rowcount 0
end

--Operación de búsqueda para los registros anteriores de las tareas activas end los flujos
if @i_operacion = 'QA'
begin
   
   insert into #act_sup_temp 
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
           io_fecha_crea, 
           io_codigo_alterno,
           ia_func_asociada,
           ia_id_paso,
           ia_nombre_act,
           ia_retrasada,
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
       AND io_estado NOT IN ('ELI','TER')
       AND aa_estado NOT IN ('COM','REA','REC')
       AND ((aa_id_destinatario  = @w_user_id_filter) or @i_usuario is null)

   set rowcount @i_num_filas
  
  /*Numero de registros*/
  select @o_num_registros = count(1)  
    from #act_sup_temp
   where (io_estado =  @i_estado_proceso or @i_estado_proceso is null) --'SUS' ,'EJE' , 'CAN'
     and (io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)
     and (ia_codigo_act = @i_codigo_act or @i_codigo_act is null)
     and aa_id_asig_act < @i_id_asig_act     
   
   /*Consulta de informacion*/
   select   'ID ASIG ACT'       = aa_id_asig_act,
            'ID INST ACT'       = ia_id_inst_act,
            'ID INST PROC'      = io_id_inst_proc,
            'ESTADO'            = io_estado,--aa_estado,
            'NOMBRE PROCESO'    = (select pr_nombre_proceso 
                                     from wf_proceso a
                                    where pr_codigo_proceso = c.io_codigo_proc),
            'ACTIVIDAD'         = ia_nombre_act,		 
            'ID. CLIENTE'       = io_campo_1,
            'NOMBRE CLIENTE'    = (select en_nomlar from cobis..cl_ente where en_ente = c.io_campo_1),
            'MONTO'             = convert(varchar(32), io_campo_2),
            'NUM TRAMITE'       = io_campo_3,
            'FECHA DE LLEGADA'  = convert(varchar(10), c.aa_fecha_asig, @i_formato_fecha) + ' ' + convert(varchar(10), c.aa_fecha_asig, 108),
            'FUNCIONALIDAD'     = ia_func_asociada,
            'ID. PASO'          = ia_id_paso,
            'ID. PROCESO'       = io_codigo_proc,
            'VER. PROC.'        = io_version_proc,
   		    'USUARIO DEST'      = (select us_login  from wf_usuario where us_id_usuario = c.aa_id_destinatario),
            'ID. DEST'          = aa_id_destinatario,
            'ID. ROL'           = aa_id_rol,
            'RETRASADA'         = ia_retrasada,
            'ID INST HIJO'      = io_id_inst_proc,
            'VERSION'	     = io_version_proc,
            'ID ACTIVIDAD'      = ia_codigo_act,
            'OWNER_IDENTIFIER'  = aa_id_destinatario,
  	    'DURACION'          = ar_tiempo_efectivo,
	    'TIEMPO ESTANDAR'   = ar_tiempo_estandar,
	    'FECHA CREACION'    = convert(varchar(10), c.io_fecha_crea, @i_formato_fecha) + ' ' + convert(varchar(10), c.io_fecha_crea, 108) ,
	    'COSTO'	        = ar_costo_act_proc,
    'NOMBRE DEST'       = (select fu_nombre from cobis..cl_funcionario, wf_usuario 
                                where fu_login = us_login
                                  and us_id_usuario = c.aa_id_destinatario),
	    'ROL'               = (select ro_nombre_rol from wf_rol
                                  where ro_id_rol = c.aa_id_rol),
        'CODIGO ALTERNO'   = io_codigo_alterno
    from #act_sup_temp c
   where (io_estado =  @i_estado_proceso or @i_estado_proceso is null) --'SUS' ,'EJE' , 'CAN'
     and (c.io_codigo_proc =  @i_proceso or @i_proceso is null or @i_proceso = 0)
     and (ia_codigo_act = @i_codigo_act or @i_codigo_act is null or @i_codigo_act = 0)
     and aa_id_asig_act < @i_id_asig_act
	 and (io_codigo_alterno =  @i_cod_alterno or @i_cod_alterno is null)
     order by aa_id_asig_act	 
  set rowcount 0
end
--Operaci+Ýn de búsqueda para procesos con tareas activas en el sistema
if @i_operacion = 'QP'
begin
  select 'COD_PROC'        = pr_codigo_proceso,
           'NOM_PROC'        = pr_nombre_proceso
    from wf_proceso,wf_version_proceso
	where pr_codigo_proceso = vp_codigo_proceso
    and pr_version_prd    = vp_version_proceso
    and vp_estado         = 'PRD'
    and pr_estado = 'ACT'
    order by pr_nombre_proceso asc
end

--Operación de búsqueda de los estados de un proceso
if @i_operacion = 'QSA'
begin
  select 'PRO_STATUS_CODE' =  CPST.codigo,
         'PRO_STATUS_NAME' =  CPST.valor
                              from cobis..cl_catalogo CPST,cobis..cl_tabla TPST
                             where TPST.tabla  = 'wf_estado_proceso'
                               and TPST.codigo = CPST.tabla
   and  CPST.codigo in ('EJE','SUS') 
end
--Operación de búsqueda de los estados de un proceso
if @i_operacion = 'QAC'
begin
	select 'ACT_ACTIVITY_CODE' = ac_codigo_actividad,
	   'ACT_ACTIVITY_NAME' = ac_nombre_actividad
	from wf_proceso, wf_actividad,wf_actividad_proc,wf_version_proceso
	where pr_codigo_proceso = ar_codigo_proceso
	and ar_codigo_actividad = ac_codigo_actividad
	and ar_version_proceso = vp_version_proceso
	and pr_codigo_proceso = vp_codigo_proceso
	and pr_version_prd    = vp_version_proceso
	and vp_estado         = 'PRD'
	and pr_codigo_proceso = @i_proceso 
	order by ac_nombre_actividad asc
end

--Operación de búsqueda de las actividades de un proceso
if @i_operacion = 'QAA'
begin
	select 'ACT_ACTIVITY_CODE' = ac_codigo_actividad,
	   'ACT_ACTIVITY_NAME' = ac_nombre_actividad
	from wf_proceso, wf_actividad,wf_actividad_proc,wf_version_proceso
	where pr_codigo_proceso = ar_codigo_proceso
	and ar_codigo_actividad = ac_codigo_actividad
	and ar_version_proceso = vp_version_proceso
	and pr_codigo_proceso = vp_codigo_proceso
	and pr_version_prd    = vp_version_proceso
	and pr_codigo_proceso = @i_proceso 
	order by ac_nombre_actividad asc
end


--Consulta procesos del un usuario especifico

if @i_operacion = 'QPU'

begin

	create table #id_proceso_temp (io_codigo_proc       INT NOT NULL)	
		
	if @i_filtro_por_grupo = 'G'
	begin
		
		/*create table id_rol_temp ( id_rol      int  not null)*/
		insert into id_rol_temp 
		select @w_spid, ur_id_rol from wf_usuario_rol, wf_usuario where ur_id_usuario=us_id_usuario and us_login=@s_user
	
		insert into #id_proceso_temp
		select io_codigo_proc 
		from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad a
		where io_id_inst_proc = ia_id_inst_proc
		and ia_id_inst_act  = aa_id_inst_act		
		and io_estado  in ('EJE', 'SUS')
		and aa_estado  = 'PEN'
		and aa_id_rol  in (SELECT id_rol FROM id_rol_temp)	        
        union						 
		select io_codigo_proc 
		from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad a
		where io_id_inst_proc = ia_id_inst_proc
		and ia_id_inst_act  = aa_id_inst_act		
		and io_estado  in ('EJE', 'SUS')
		and aa_estado  = 'PEN'
		and aa_id_item_jerarquia in (select ujt.ij_id_item_jerarquia from cob_workflow..wf_usuario_jerarquia_tpl ujt
						 where ujt.us_id_usuario = @w_user_id_filter) 	
	
		select 'COD_PROC'        = pr_codigo_proceso,
			   'NOM_PROC'        = pr_nombre_proceso
		from wf_proceso, wf_version_proceso
		where pr_codigo_proceso = vp_codigo_proceso
		and pr_version_prd    = vp_version_proceso
		and vp_estado         = 'PRD'
		and pr_estado = 'ACT'
		and pr_codigo_proceso in (select io_codigo_proc from #id_proceso_temp) 
	end
	else
	begin
	
		insert into #id_proceso_temp
		select io_codigo_proc 
		from wf_inst_proceso c, wf_inst_actividad, wf_asig_actividad a
		where io_id_inst_proc = ia_id_inst_proc
		and ia_id_inst_act  = aa_id_inst_act		
		and io_estado  in ('EJE', 'SUS')
		and aa_estado  = 'PEN'
		and aa_id_destinatario  = @w_user_id_filter
		
		select 'COD_PROC'        = pr_codigo_proceso,
           'NOM_PROC'        = pr_nombre_proceso
		from wf_proceso, wf_version_proceso
	where pr_codigo_proceso = vp_codigo_proceso
    and pr_version_prd    = vp_version_proceso
    and vp_estado         = 'PRD'
    and pr_estado = 'ACT'
		and pr_codigo_proceso in (select io_codigo_proc from #id_proceso_temp)
    order by pr_nombre_proceso asc
		
	end
	
end


--Operación de búsqueda de las actividades por tipo de destino y versión
if @i_operacion = 'QAT'
begin
select 'ACT_ACTIVITY_CODE' = ac_codigo_actividad,
	   'ACT_ACTIVITY_NAME' = ac_nombre_actividad,
       'PASO' = pa_id_paso  
	from wf_proceso,wf_version_proceso, wf_actividad_proc, wf_actividad, wf_destinatario, wf_paso
    where pr_codigo_proceso = vp_codigo_proceso
    and vp_version_proceso = @i_version_proceso
    and vp_codigo_proceso = @i_proceso
    and pr_codigo_proceso = ar_codigo_proceso
    and vp_version_proceso = ar_version_proceso
    and ac_codigo_actividad = ar_codigo_actividad
    and pr_codigo_proceso = de_codigo_proceso
    and vp_version_proceso = de_version_proceso
    and ac_codigo_actividad = de_codigo_actividad
    and de_tipo_destinatario not in ('PRO', 'SUB', 'POL')
    and pr_codigo_proceso = pa_codigo_proceso
    and vp_version_proceso = pa_version_proceso
    and ac_codigo_actividad = pa_codigo_actividad
end

delete id_ente_temp where spid = @w_spid
delete id_login_temp where spid = @w_spid
delete id_rol_temp where spid = @w_spid



return 0

GO

