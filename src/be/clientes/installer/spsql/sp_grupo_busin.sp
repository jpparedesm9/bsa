/* ********************************************************************* */
/*      Archivo:                sp_grupo_busin.sp                        */
/*      Stored procedure:       sp_grupo_busin                           */
/*      Base de datos:          cob_pac                                  */
/*      Producto: Clientes                                               */
/*      Disenado por:           Adriana Chiluisa                         */
/*      Fecha de escritura:     22-Mar-2017                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*                              PROPOSITO                                */
/*      Este programa procesa las transacciones del stored procedure     */
/*      Insercion de grupo                                               */
/*      Actualizacion de grupo                                           */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      22/Mar/2017     Adriana Chiluisa     Version Inicial             */
/*      24/Mar/2017     Adriana Chiluisa     Se aniade Operacion U y Q   */
/*      25/Sep/2017     Ma. Jose Taco        Valida solicitud en curso   */
/*      10/Oct/2017     Paul Ortiz Vera      Mensaje de lugar de reunion */
/*      10/Sep/2018     Patricio Mora        Requerimiento 100980        */
/*      29/JUL/2019     PXSG                 Req. 118728 Renovsciones    */
/*      22/Oct/2019     ACHP                 #128805 no Act oficin/Sucurs*/
/*      24/DIC/2019     ACHP                 #132527 toma la ofi del func*/
/* ********************************************************************* */
use cob_pac
go

if exists (select * from sysobjects where name = 'sp_grupo_busin')
   drop proc sp_grupo_busin
go
IF OBJECT_ID ('dbo.sp_grupo_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_grupo_busin
GO

create proc sp_grupo_busin (
    @s_ssn                  int             = null,
    @s_user                 login           = null,
    @s_term                 varchar(30)     = null,
    @s_date                 datetime        = null,
    @s_srv                  varchar(30)     = null,
    @s_lsrv                 varchar(30)     = null,
    @s_ofi                  smallint        = null,
    @s_rol                  smallint        = NULL,
    @s_org_err              char(1)         = NULL,
    @s_error                int             = NULL,
    @s_sev                  tinyint         = NULL,
    @s_msg                  descripcion     = NULL,
    @s_org                  char(1)         = NULL,
    @t_show_version         bit             = 0,    -- Mostrar la version del programa
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = null,
    @t_from                 varchar(32)     = null,
    @t_trn                  smallint        = null,
    @i_operacion            char(1),                -- Opcion con que se ejecuta el programa
    @i_modo                 tinyint         = null, -- Modo de busqueda
    @i_tipo                 char(1)         = null, -- Tipo de consulta
    @i_filial               tinyint         = null, -- Codigo de la filial
    @i_oficina              smallint        = null, -- Codigo de la oficina    
    @i_ente                 int             = null, -- Codigo del ente que forma parte del grupo
    @i_grupo                int             = null, -- Codigo del grupo
    @i_nombre               descripcion     = null, -- Nombre del grupo economico
    @i_representante        int             = null, -- Codigo del representante legal
    @i_compania             int             = null, -- Codigo de la compania
    @i_oficial              int             = null, -- Codigo del oficial encargado del grupo econ¢mico
    @i_fecha_registro       datetime        = null, -- Fecha de Registro del grupo
    @i_fecha_modificacion   datetime        = null, -- Fecha de Modificación del grupo 
    @i_ruc                  numero          = null, -- Numero del documento de identificacion
    @i_vinculacion          char(1)         = null, -- Codigo de vinculacion del representante al grupo
    @i_tipo_vinculacion     catalogo        = null, -- Codigo del tipo de vinculacion del representante al grupo
    @i_max_riesgo           money           = null,
    @i_riesgo               money           = null,
    @i_usuario              login           = null,
    @i_reservado            money           = null,
    @i_tipo_grupo           catalogo        = null,
    @i_estado               catalogo        = null, -- Estado del Grupo Economico
    @i_dir_reunion          varchar(125)    = null, -- Direccion de la reunion del grupo
    @i_dia_reunion          catalogo        = null, -- Dia de reunion del grupo
    @i_hora_reunion         datetime        = null, -- Hora de la reunion de del grupo
    @i_comportamiento_pago  varchar(10)     = null, -- 
    @i_num_ciclo            int             = null, --
	@o_grupo                int             = null out,
	@i_gr_tipo              char(1)         = null, -- campo gr_tipo en grupo
    @i_gr_cta_grupal        varchar(30)     = null, --campo  cuenta grupal
    @i_gr_sucursal          int             = null,
    @i_gr_titular1          int             = null, --campo cliente Titular1
    @i_gr_titular2          int             = null, --campo cliente Titular2
    @i_gr_lugar_reunion     char(10)        = null, --campo gr_lugar de Reunion
    @i_gr_tiene_ctagr       char(1)         = null, --campo tiene cuenta grupal
    @i_gr_tiene_ctain       char(1)         = null, --campo tiene cuenta individual
    @i_gr_gar_liquida       char(1)         = null,  --campo tiene garatia liquida
    @o_actualiza_movil      char(1)         = null out
                   
)
as
declare @w_siguiente            int,
        @w_return               int,
        @w_ente                 int,
        @w_num_cl_gr            int,
        @w_contador             int,
        @w_sp_name              varchar(32),
        @w_error                int,    
        @w_grupo                int,
        @w_nombre               descripcion,
        @w_representante        int,
        @w_compania             int,
        @w_oficial              int,
        @w_fecha_registro       datetime,
        @w_fecha_modificacion   datetime,
        @w_ruc                  numero,
        @w_vinculacion          char(1),
        @w_tipo_vinculacion     catalogo,
        @w_max_riesgo           money,
        @w_riesgo               money,
        @w_usuario              login,
        @w_reservado            money,
        @w_tipo_grupo           catalogo,
        @w_estado               catalogo,
        @w_dir_reunion          varchar(125),
        @w_dia_reunion          catalogo,
        @w_hora_reunion         datetime,
        @w_comportamiento_pago  varchar(10),
        @w_num_ciclo            int,
        @w_gr_tipo              char(1),
        @w_gr_cta_grupal        varchar(30),
        @w_gr_sucursal          varchar(30),
        @w_gr_titular1          int,
    	@w_gr_titular2          int,
    	@w_gr_lugar_reunion 	char(10),	   
        @w_gr_tiene_ctagr       char(1),
        @w_gr_tiene_ctain       char(1),
        @w_gr_gar_liquida       char(1),	
        @v_grupo                int,
        @v_nombre               descripcion,
        @v_representante        int,
        @v_compania             int,
        @v_oficial              int,
        @v_fecha_registro       datetime,
        @v_fecha_modificacion   datetime,
        @v_ruc                  numero,
        @v_vinculacion          char(1),
        @v_tipo_vinculacion     catalogo,
        @v_max_riesgo           money,
        @v_riesgo               money,
        @v_usuario              login,
        @v_reservado            money,
        @v_tipo_grupo           catalogo,
        @v_estado               catalogo,
        @v_dir_reunion          varchar(125),
        @v_dia_reunion          catalogo,
        @v_hora_reunion         datetime,
        @v_comportamiento_pago  varchar(10),
        @v_num_ciclo            int,
        @v_gr_tipo              char(1),
        @v_gr_cta_grupal        varchar(30),
        @v_gr_sucursal          int,
        @v_gr_titular1          int,
    	@v_gr_titular2          int,
    	@v_gr_lugar_reunion 	char(10),	   
        @v_gr_tiene_ctagr       char(1),
        @v_gr_tiene_ctain       char(1),
        @v_gr_gar_liquida       char(1),
	    --validaciones numero de integrantes PXSG--
	    @w_integrantes           INT,
	    --validaciones numero de PXSG --
	    @w_num_integrantes       INT ,
        @w_sum_parentesco        INT,
        @w_porcentaje            INT,
        @w_valor_nuevo           INT,
        --validacion de mujeres de PXSG--
        @w_num_sexo_feme         INT,
        --validaciones para conyuge PXSG--
        @w_cliente_gr            INT,
        --validaciones para tesorero y presidente--
        @numIntegrantesGrupo     INT,
        --parametros para validaciones de integrantes--
        @w_param_max_inte        INT,
        @w_param_min_inte        INT,
        @w_param_porc_parentesco FLOAT,
        @w_param_rel_cony		 INT ,
        @w_param_porc_mujeres 	 FLOAT,
        --validacion para emprendedores-- 
        @w_sum_enprender         INT,
        @w_param_porc_emp        FLOAT,
        @w_msg                   varchar (1000),
        @w_actualiza             varchar(1), --MTA
        @w_reunion               varchar(125),
        @w_actualiza_movil       varchar(1) = 'S',
        @w_parm_ofi_movil        smallint,
        @w_parm_etap_ingreso     varchar(30),
        @w_parm_etap_eliminar    varchar(30),
        @w_parm_etap_aprobacion  varchar(30),
        @w_cnt_integrantes       varchar(64),
        @w_variables             varchar(255),
        @w_result_values         varchar(255),
        @w_parent                int,
        @w_condicionados         int,
        @w_maximo_cond           int,
        @w_diferencia            int,
        @w_msg_error             varchar(1000),
        @w_id                    int,
        @w_ofi_movil_def         smallint,
        @w_param_eliminacion     int,
        @w_fecha_proceso         datetime,
        @w_msm_actualiza_movil   varchar(255),
		@w_oficina_funcionario   smallint




-------------------------------- VERSIONAMIENTO DE SP --------------------------------
if @t_show_version = 1
begin
    print 'Stored procedure sp_grupo_busin, Version 1.0.0.0'
    return 0
end
--------------------------------------------------------------------------------------
select @w_sp_name   = 'sp_grupo_busin',
       @w_actualiza = 'S'--MTA
   
if @t_trn != 800
begin
    exec cobis..sp_cerror
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_num        = 151051 -- TRANSACCION NO PERMITIDA
    return 1
end

select @w_parm_ofi_movil        = pa_smallint   from cobis..cl_parametro where pa_nemonico = 'OFIAPP' and pa_producto = 'CRE'
select @w_parm_etap_ingreso     = pa_char       from cobis..cl_parametro where pa_nemonico = 'ETINGR' and pa_producto = 'CRE'
select @w_parm_etap_eliminar    = pa_char       from cobis..cl_parametro where pa_nemonico = 'ETELIM' and pa_producto = 'CRE'
select @w_parm_etap_aprobacion  = pa_char       from cobis..cl_parametro where pa_nemonico = 'ETAPRO' and pa_producto = 'CRE'
select @w_ofi_movil_def         = pa_smallint   from cobis..cl_parametro where pa_nemonico = 'OFIAPP'
--fecha de proceso 
select @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso 
--Parametro para eliminacion de Integrantes
select @w_param_eliminacion = pa_int 
from cobis..cl_parametro
where  pa_nemonico='EICRVI'
and    pa_producto='CRE' 
set @w_msm_actualiza_movil=''



-- Insert --
if @i_operacion = 'I'
begin
    -- Viene el front end como - 31/12/1969 19:00:00 por eso se cambia
    select @i_fecha_modificacion = getdate()
	
    -- Verificar que otro grupo no tenga el mismo nombre --
    if exists (select 1 from cobis..cl_grupo where gr_nombre = @i_nombre)
    begin
        select @w_error = 208901 -- YA EXISTE EL NOMBRE DEL GRUPO
        goto ERROR
    end

    -- Verificar que exista el oficial --
    if not exists (select 1 from cobis..cc_oficial where oc_oficial = @i_oficial) and @i_oficial != null
    begin
        select @w_error = 151091 -- No existe oficial --
        goto ERROR
    end

	select @w_oficina_funcionario = oc_funcionario 
	from   cobis..cc_oficial 
	where  oc_oficial = @i_oficial
	
	-- Se toma del oficial debido a que se esta cambiando la oficina (sucursal)
	select @i_gr_sucursal = fu_oficina 
	from   cobis..cl_funcionario 
	where  fu_funcionario = @w_oficina_funcionario

    -- Obtener un secuencial para el nuevo grupo --
    exec cobis..sp_cseqnos
    @t_debug        = @t_debug,
    @t_file         = @t_file,
    @t_from         = @t_from,
    @i_tabla        = 'cl_grupo',
    @o_siguiente    = @w_siguiente out
    -- Error con el secuencial
    if @w_siguiente = NULL
    begin
        select @w_error = 2101007 -- NO EXISTE TABLA EN TABLA DE SECUENCIALES
        goto ERROR           
    end
   
   -- insertar los datos de grupo --
    insert into cobis..cl_grupo (gr_grupo,       gr_nombre,          gr_representante,     gr_compania,    --1
                                 gr_oficial,     gr_fecha_registro,  gr_fecha_modificacion,gr_ruc,         --2  
                                 gr_vinculacion, gr_tipo_vinculacion,gr_max_riesgo,        gr_riesgo,      --3
                                 gr_usuario,     gr_reservado,       gr_tipo_grupo,        gr_estado,      --4
                                 gr_dir_reunion, gr_dia_reunion,     gr_hora_reunion,      gr_comportamiento_pago,  --5 
                                 gr_num_ciclo,	 gr_tipo,			 gr_cta_grupal,    	   gr_sucursal,
                                 gr_titular1,    gr_titular2,        gr_lugar_reunion,     gr_tiene_ctagr,
                                 gr_tiene_ctain, gr_gar_liquida                                                     --6
                                 )
    values                       (@w_siguiente,   @i_nombre,          NULL,                 @i_compania,    --1
                                  @i_oficial,     @i_fecha_registro,  @i_fecha_modificacion,@i_ruc,         --2
                                  @i_vinculacion, @i_tipo_vinculacion,@i_max_riesgo,        @i_riesgo,      --3      
                                  @i_usuario,     @i_reservado,       @i_tipo_grupo,        @i_estado,      --4
                                  @i_dir_reunion, @i_dia_reunion,     @i_hora_reunion,      @i_comportamiento_pago,  --5 
                                  @i_num_ciclo,   @i_gr_tipo,         @i_gr_cta_grupal,     @i_gr_sucursal,
                                  @i_gr_titular1, @i_gr_titular2,     @i_gr_lugar_reunion,  @i_gr_tiene_ctagr,
                                  @i_gr_tiene_ctain, isnull(@i_gr_gar_liquida,'S')                                                  --6
                                 )                              
    -- si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 103006 -- ERROR EN CREACION DE GRUPO
        goto ERROR 
    end
  --actualizo el lugar de reunion cuando lugar de reunion es igual OT
    IF ( @i_gr_lugar_reunion ='OT')
    BEGIN
    UPDATE cobis..cl_cliente_grupo
     SET cg_lugar_reunion = NULL
    WHERE cg_grupo = @i_grupo
    END

    -- Transaccion servicio - cl_grupo --
    insert into cobis..ts_grupo  (secuencial,    tipo_transaccion,    clase,                 fecha,    --1
                                  terminal,      srv,                 lsrv,                            --2
                                  grupo,         nombre,              representante,         compania, --3
                                  oficial,       fecha_registro,      fecha_modificacion,    ruc,      --4                      
                                  vinculacion,   tipo_vinculacion,    max_riesgo,            riesgo,   --5                      
                                  usuario,       reservado,           tipo_grupo,            estado,   --6                      
                                  dir_reunion,   dia_reunion,         hora_reunion,          comportamiento_pago,--7                      
                                  num_ciclo,     gar_liquida)
    values                       (@s_ssn,       800,                 'N',                   @s_date,   --1
                                  @s_term,       @s_srv,              @s_lsrv,                           --2
                                  @w_siguiente,  @i_nombre,           @i_representante,      @i_compania,--3
                                  @i_oficial,    @i_fecha_registro,   @i_fecha_modificacion, @i_ruc,     --4
                                  @i_vinculacion,@i_tipo_vinculacion, @i_max_riesgo,         @i_riesgo,  --5
                                  @i_usuario,    @i_reservado,        @i_tipo_grupo,         @i_estado,  --6
                                  @i_dir_reunion,@i_dia_reunion,      @i_hora_reunion,       @i_comportamiento_pago,--7
                                  @i_num_ciclo,  isnull(@i_gr_gar_liquida,'S')                                                  --8
                                 )
    -- Si no se puede insertar transaccion de servicio, error --
    if @@error != 0
    begin
        select @w_error = 103005 -- ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR
    end
	
    select @o_grupo = @w_siguiente
	select @o_grupo
			
	--INICIO DE VALIDACIONES--
	--nuevas validaciones maximo 40--
  SELECT @numIntegrantesGrupo=count(cg_ente) FROM cobis..cl_cliente_grupo WHERE cg_grupo=@i_grupo AND cg_estado = 'V'
   IF(@numIntegrantesGrupo<>0)
   BEGIN
    SELECT @w_param_max_inte =pa_int FROM cobis..cl_parametro WHERE pa_nemonico='MAXIGR' AND pa_producto = 'CLI'
    SELECT @w_param_min_inte =pa_int FROM cobis..cl_parametro WHERE pa_nemonico='MINIGR' AND pa_producto = 'CLI'
    select @w_integrantes  = count(cg_ente) from cobis..cl_cliente_grupo
    where cg_grupo = @i_grupo
    and cg_estado = 'V'
 
    if @w_integrantes  > @w_param_max_inte or  @w_integrantes < @w_param_min_inte
     BEGIN
     --PRINT'VALIDAR NÚMERO MÍNIMO Y MÁXIMO DE INTEGRANTES.'
       select @w_error = 208916 -- validación número de integrantes
        goto ERROR
     End 
    
     
     
     --validacion parentesco--
    SELECT @w_param_porc_parentesco=pa_float FROM cobis..cl_parametro WHERE pa_nemonico='PPGRU'  AND pa_producto = 'CRE'
    select distinct @w_num_integrantes = count(cg_ente) 
    from cobis..cl_cliente_grupo 
    where cg_grupo = @i_grupo
    and cg_estado = 'V'
    SELECT @w_sum_parentesco=count(DISTINCT in_ente_i) FROM cobis..cl_instancia
    WHERE  in_relacion IN (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B 
             WHERE A.tabla in ('cl_parentesco_1er','cl_parentesco_2er') AND A.codigo= B.tabla)
    AND in_ente_i IN (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
    AND in_ente_d IN (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
    IF(@w_num_integrantes <>0)
    BEGIN
    select @w_porcentaje = ((@w_sum_parentesco * 100)/@w_num_integrantes)

    select @w_valor_nuevo = @w_porcentaje
    end
    if @w_valor_nuevo > @w_param_porc_parentesco    -- parametro 40 porcentaje de parentesco en grupos
    BEGIN
    --PRINT'VALIDAR PARENTESCO DE INTEGRANTES.'+CONVERT(VARCHAR(30),@w_porcentaje)
      select @w_error = 208917  --Error en Porcentaje de Parentesco
      goto ERROR
    END
    
    SELECT @w_reunion = gr_dir_reunion FROM cobis..cl_grupo WHERE gr_grupo = @i_grupo
    
    if ((@w_reunion IS NULL) or (@w_reunion = ' '))    -- Lugar de reunion
    BEGIN
    --PRINT'VALIDAR Lugar de Reunion.'+CONVERT(VARCHAR(30),@w_porcentaje)
      select @w_error = 208932  --POR FAVOR INGRESE EL LUGAR DE REUNION
      goto ERROR
    END
    
    --validacion de credito--
   if exists (select 1 from cobis..cl_cliente_grupo, cob_cartera..ca_operacion
   where cg_grupo = @i_grupo
   and cg_estado = 'V'
   and cg_ente = op_cliente
   and op_estado NOT IN (0,99,3)
   and datediff(dd, @w_fecha_proceso, op_fecha_fin)>@w_param_eliminacion)
   begin
   --PRINT'VALIDAR CRÉDITOS VIGENTES DE INTEGRANTES.'
      select @w_error = 208918  --validacion de credito
      goto ERROR
   END
   
    --Validación conyuge--
  SELECT @w_param_rel_cony=pa_int FROM cobis..cl_parametro WHERE pa_nemonico='RCONY'  AND pa_producto = 'CRE' 
  
  SELECT @w_cliente_gr= 0
  SELECT top 1   @w_cliente_gr=cg_ente
  from cobis..cl_cliente_grupo
  where cg_grupo =@i_grupo
  and cg_estado = 'V'
  and cg_ente  > @w_cliente_gr 
  order by cg_ente ASC
  WHILE @@rowcount > 0
  begin
  if exists (select 1
  from cobis..cl_instancia
  where in_ente_i = @w_cliente_gr
  and in_relacion =@w_param_rel_cony -- parametro 'RCONY'
  and in_ente_d in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo =@i_grupo and cg_estado = 'V'))
  BEGIN
	  -- PRINT'VALIDAR INTEGRANTES COMO CÓNYUGES ID DEL CLIENTE: '+ convert(VARCHAR(40),@w_cliente_gr)
    select @w_error = 208919  --Validación conyuge--
 
    SELECT  @w_msg= 'VALIDAR INTEGRANTES COMO CÓNYUGES: ID DEL CLIENTE '+convert(VARCHAR(40),@w_cliente_gr)
    
     exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
  END

  SELECT top 1   @w_cliente_gr=cg_ente
  from cobis..cl_cliente_grupo
  where cg_grupo =@i_grupo
  and cg_estado = 'V'
  and cg_ente  > @w_cliente_gr 
  order by cg_ente ASC
  END--Fin While--
    
   --validaciones de mujeres--
   SELECT @w_param_porc_mujeres=pa_float FROM cobis..cl_parametro WHERE pa_nemonico='PMGRU'  AND pa_producto = 'CRE'
   select @w_integrantes = count(cg_ente) 
   from cobis..cl_cliente_grupo 
   where cg_grupo =@i_grupo 
   and cg_estado = 'V'
   select @w_num_sexo_feme = count(1) from cobis..cl_cliente_grupo, cobis..cl_ente
                        where en_ente = cg_ente
                        and p_sexo = 'F'    --genero femenino
                        and cg_grupo =@i_grupo
                        and cg_estado = 'V'                      
   IF(@w_integrantes<>0) 
   BEGIN
   select @w_valor_nuevo = ((@w_num_sexo_feme * 100)/@w_integrantes)
   END

   IF @w_valor_nuevo < @w_param_porc_mujeres -- parametro de porcentaje de mujeres en grupos
   BEGIN
   --PRINT'VALIDAR NÚMERO DE MUJERES.'
     select @w_error = 208920  --Error en Porcentaje de Parentesco
     goto ERROR
   END
  
   --Validacion Emprendedores--
   SELECT @w_param_porc_emp=pa_float FROM cobis..cl_parametro WHERE pa_nemonico='MAXEMP'  AND pa_producto = 'CRE'
 
   select @w_integrantes = count(cg_ente) 
    from cobis..cl_cliente_grupo 
    where cg_grupo =@i_grupo 
    and cg_estado = 'V' 
  
   select @w_sum_enprender = count(nc_emprendedor) FROM cobis..cl_cliente_grupo, cobis..cl_negocio_cliente 
 	where nc_ente = cg_ente 
    and cg_grupo =@i_grupo
    and cg_estado = 'V' 
    and nc_emprendedor ='S'
    and nc_estado_reg='V'
    
   IF(@w_integrantes<>0) 
   BEGIN
    select @w_porcentaje = ((@w_sum_enprender * 100)/@w_integrantes)
   END
   
   IF @w_porcentaje > @w_param_porc_emp -- parametro de emprendedores en grupos
   BEGIN
    select @w_error =208923  --validación emprendedores
    goto ERROR
   END
   
   --Fin Validacion Emprendedores--
  
  --validaciones Presidente--
  SELECT @numIntegrantesGrupo=count(cg_ente) FROM cobis..cl_cliente_grupo WHERE cg_grupo=@i_grupo AND cg_estado = 'V'
  IF(@numIntegrantesGrupo<>0)
  BEGIN
  IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
               WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                               WHERE A.tabla = 'cl_rol_grupo'
                               AND A.codigo = B.tabla
                               AND B.valor = 'PRESIDENTE')
                               AND cg_grupo = @i_grupo AND cg_estado='V')
  BEGIN
  --PRINT'EL GRUPO DEBE TENER UN PRESIDENTE'
  select @w_error =208921  --Validación Tesorero
    goto ERROR
  END                               
  END

  --validaciones SECRETARIO--
  IF(@numIntegrantesGrupo<>0)
  BEGIN
      IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
                   WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                                   WHERE A.tabla = 'cl_rol_grupo'
                                   AND A.codigo = B.tabla
                                   AND B.valor = 'SECRETARIO')
                                   AND cg_grupo = @i_grupo AND cg_estado='V')
      BEGIN
          --PRINT'EL GRUPO DEBE TENER UN SECRETARIO'
          select @w_error = 208926  --Validación SECRETARIO
            goto ERROR
      END                               
  END   


---Validación Tesorero

  IF(@numIntegrantesGrupo<>0)
  BEGIN
  IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
               WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                               WHERE A.tabla = 'cl_rol_grupo'
                               AND A.codigo = B.tabla
                               AND B.valor = 'TESORERO')
                               AND cg_grupo =@i_grupo AND cg_estado='V')
  BEGIN
  --PRINT'EL GRUPO DEBE TENER UN TESORERO'
    select @w_error = 208922  --Validación Tesorero
    goto ERROR
  END                               
  END
 END
			
end -- Fin Operacion I
if @i_operacion = 'U'
begin
   -- Viene el front end como - 31/12/1969 19:00:00 por eso se cambia
   select @i_fecha_modificacion = getdate()
	
   -- verificar que exista el grupo --
	if not exists (select 1 from cobis..cl_grupo where gr_grupo = @i_grupo)
	begin
        select @w_error = 151029 -- NO EXISTE GRUPO
        goto ERROR
	end
	
	--Verificar que el oficial exista
	if not exists (select 1 from cobis..cc_oficial where oc_oficial = @i_oficial) and @i_oficial != null
	begin
		select @w_error = 151091  -- No existe oficial --
		goto ERROR
	end
	 
    if @i_estado in ('I', 'C')  --estado del grupo INACTIVO, CANCELADO
    begin
      --validacion que todos los miebros no tengas operaciones pendientes
      if exists (select (1) from cob_cartera..ca_operacion, cob_cartera..ca_estado
                            where op_estado = es_codigo
                              and es_procesa = 'S'
                              and op_cliente in (select distinct tg_cliente from cob_credito..cr_tramite_grupal where tg_grupo = @i_grupo))
      begin
         select @w_error = 149053 --TIENE OPERACIONES PENDIENTES
         goto ERROR
      end
    end

    --INICIO CONFORMACION GRUPAL
	/*select @w_cnt_integrantes = convert(varchar,count(cg_ente)) + '|'
	from cobis..cl_cliente_grupo 
	where cg_grupo 	= @i_grupo
	and   cg_estado = 'V'
	
	-- Evalua regla de condicionados del grupo --
	exec @w_error    		= cob_pac..sp_rules_param_run
	     @s_rol             = @s_rol,
	     @i_rule_mnemonic   = 'LDCC',
	     @i_var_values      = @w_cnt_integrantes, 
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
	
	select @w_maximo_cond = convert(int, substring(@w_result_values, 0, len(@w_result_values)))
	
	select @w_condicionados = count(*) 
	from cobis..cl_ente_aux 
	where ea_nivel_riesgo_cg = 'E' --E = Condicionado
	and ea_ente in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
	
	select @w_diferencia = @w_condicionados - @w_maximo_cond 
        
	if(@w_condicionados > @w_maximo_cond)
	begin
		set nocount on
		declare @w_lista table(
			id    int          identity,
			ente   int         null,
			nombre varchar(64)
		)
		
		select @w_grupo = @i_grupo
		
		insert into  @w_lista 
		select en_ente, (isnull(en_nombre,'') + ' ' + isnull(p_p_apellido,'') + ' ' + isnull(p_s_apellido,'')) as nombres
		from cobis..cl_ente_aux, cobis..cl_cliente_grupo, cobis..cl_ente
		where ea_ente            = cg_ente
		and  ea_ente            = en_ente
		and  cg_grupo           = @w_grupo
		and  cg_estado          = 'V'
		and  ea_nivel_riesgo_cg = 'E'
		order by ea_sum_vencido desc,
		     ea_num_vencido desc
		
		select @w_id   = 0,
		    @w_msg  = ''
		
		while 1 = 1     
		begin
			select top 1
				@w_id     = id,
				@w_nombre = nombre
			from @w_lista
			where id > @w_id      
			order by id asc
			if @@rowcount = 0
				break
			
			select @w_msg = @w_msg + ', '  + @w_nombre 
		end
		
		select @w_error = 103180, 
				@w_msg = replace(replace(mensaje, 'X', convert(varchar, @w_diferencia)), '<lista>', @w_msg)
		from cobis..cl_errores where numero = 103180
		
		goto ERROR
	end*/
   --INICIO CONFORMACION GRUPAL
	
    -- Consulta de datos del grupo
    select @w_grupo               = gr_grupo,
           @w_nombre              = gr_nombre,
           @w_representante       = gr_representante,
           @w_compania            = gr_compania,
           @w_oficial             = gr_oficial,
           @w_fecha_registro      = gr_fecha_registro,
           @w_fecha_modificacion  = gr_fecha_modificacion,
           @w_ruc                 = gr_ruc,
           @w_vinculacion         = gr_vinculacion,
           @w_tipo_vinculacion    = gr_tipo_vinculacion,
           @w_max_riesgo          = gr_max_riesgo,
           @w_riesgo              = gr_riesgo,
           @w_usuario             = gr_usuario,
           @w_reservado           = gr_reservado,
           @w_tipo_grupo          = gr_tipo_grupo,
           @w_estado              = gr_estado,
           @w_dir_reunion         = gr_dir_reunion,
           @w_dia_reunion         = gr_dia_reunion,
           @w_hora_reunion        = gr_hora_reunion,
           @w_comportamiento_pago = gr_comportamiento_pago,
           @w_num_ciclo           = gr_num_ciclo,
           @w_gr_tipo 			  = gr_tipo,
           @w_gr_cta_grupal 	  = gr_cta_grupal,
           @w_gr_sucursal		  = gr_sucursal,
           @w_gr_titular1         = gr_titular1,
           @w_gr_titular2		  = gr_titular2,
           @w_gr_lugar_reunion    = gr_lugar_reunion,
           @w_gr_tiene_ctagr      = gr_tiene_ctagr,
           @w_gr_tiene_ctain      = gr_tiene_ctain,
           @w_gr_gar_liquida      = isnull(gr_gar_liquida,'S')
           
    from   cobis..cl_grupo
    where  gr_grupo = @i_grupo
    
    -- INI Guardar los datos anteriores que han cambiado --
    select @v_grupo               = @w_grupo,
           @v_nombre              = @w_nombre,
           @v_representante       = @w_representante,
           @v_compania            = @w_compania,
           @v_oficial             = @w_oficial,
           @v_fecha_registro      = @w_fecha_registro,
           @v_fecha_modificacion  = @w_fecha_modificacion,
           @v_ruc                 = @w_ruc,
           @v_vinculacion         = @w_vinculacion,
           @v_tipo_vinculacion    = @w_tipo_vinculacion,
           @v_max_riesgo          = @w_max_riesgo,
           @v_riesgo              = @w_riesgo,
           @v_usuario             = @w_usuario,
           @v_reservado           = @w_reservado,
           @v_tipo_grupo          = @w_tipo_grupo,
           @v_estado              = @w_estado,
           @v_dir_reunion         = @w_dir_reunion,
           @v_dia_reunion         = @w_dia_reunion,
           @v_hora_reunion        = @w_hora_reunion,
           @v_comportamiento_pago = @w_comportamiento_pago,
           @v_num_ciclo           = @w_num_ciclo,
           @v_gr_tipo          	  = @w_gr_tipo,
           @v_gr_cta_grupal 	  = @w_gr_cta_grupal,
           @v_gr_sucursal		  = @w_gr_sucursal,
           @v_gr_titular1         = @w_gr_titular1,
           @v_gr_titular2		  = @w_gr_titular2,
           @v_gr_lugar_reunion    = @w_gr_lugar_reunion,
           @v_gr_tiene_ctagr      = @w_gr_tiene_ctagr,
           @v_gr_tiene_ctain      = @w_gr_tiene_ctain,
           @v_gr_gar_liquida      = isnull(@w_gr_gar_liquida,'S')
    
    select @i_oficial = @w_oficial -- Se toma el dato guardado debido a que cuando se demora en cargar la pantalla toma el primero de la lista y cambia el oficial del grupo

    if @w_grupo = @i_grupo
        select @w_grupo = null, @v_grupo = null
    else
        select @w_grupo = @i_grupo

    if @w_nombre = @i_nombre
        select @w_nombre = null, @v_nombre = null
    else
        select @w_nombre = @i_nombre

    if @w_representante = @i_representante
        select @w_representante = null, @v_representante = null
    else
        select @w_representante = @i_representante

    if @w_compania = @i_compania
        select @w_compania = null, @v_compania = null
    else
        select @w_compania = @i_compania            
        
    if @w_oficial = @i_oficial
        select @w_oficial = null, @v_oficial = null
    else
        select @w_oficial = @i_oficial
        
    if @w_fecha_registro = @i_fecha_registro
        select @w_fecha_registro = null, @v_fecha_registro = null
    else
        select @w_fecha_registro = @i_fecha_registro        

    if @w_fecha_modificacion = @i_fecha_modificacion
        select @w_fecha_modificacion = null, @v_fecha_modificacion = null
    else
        select @w_fecha_modificacion = @i_fecha_modificacion

    if @w_ruc = @i_ruc
        select @w_ruc = null, @v_ruc = null
    else
        select @w_ruc = @i_ruc        

    if @w_vinculacion = @i_vinculacion
        select @w_vinculacion = null, @v_vinculacion = null
    else
        select @w_vinculacion = @i_vinculacion

    if @w_tipo_vinculacion = @i_tipo_vinculacion
        select @w_tipo_vinculacion = null, @i_tipo_vinculacion = null
    else
        select @w_tipo_vinculacion = @i_tipo_vinculacion
        
    if @w_max_riesgo = @i_max_riesgo
        select @w_max_riesgo = null, @v_max_riesgo = null
    else
        select @w_max_riesgo = @i_max_riesgo

    if @w_usuario = @i_usuario
        select @w_usuario = null, @v_usuario = null
    else
        select @w_usuario = @i_usuario    

    if @w_reservado = @i_reservado
        select @w_reservado = null, @v_reservado = null
    else
        select @w_reservado = @i_reservado

    if @w_tipo_grupo = @i_tipo_grupo
        select @w_tipo_grupo = null, @v_tipo_grupo = null
    else
        select @w_tipo_grupo = @i_tipo_grupo        
        
    if @w_estado = @i_estado
        select @w_estado = null, @v_estado = null
    else
        select @w_estado = @i_estado

    if @w_dir_reunion = @i_dir_reunion
        select @w_dir_reunion = null, @v_dir_reunion = null
    else
        select @w_dir_reunion = @i_dir_reunion
        
    if @w_dia_reunion = @i_dia_reunion
        select @w_dia_reunion = null, @v_dia_reunion = null
    else
        select @w_dia_reunion = @i_dia_reunion    

    if @w_hora_reunion = @i_hora_reunion
        select @w_hora_reunion = null, @v_hora_reunion = null
    else
        select @w_hora_reunion = @i_hora_reunion

    if @w_comportamiento_pago = @i_comportamiento_pago
        select @w_comportamiento_pago = null, @i_comportamiento_pago = null
    else
        select @w_comportamiento_pago = @i_comportamiento_pago    

    if @w_num_ciclo = @i_num_ciclo
        select @w_num_ciclo = null, @i_num_ciclo = null
    else
        select @w_num_ciclo = @i_num_ciclo  
    
	if(@s_ofi= (select pa_int from cobis..cl_parametro where pa_nemonico = 'MOBOFF'))
	begin
		
		select @i_dir_reunion = (select gr_dir_reunion from cobis..cl_grupo WHERE gr_grupo = @i_grupo)
		
	end
    
    if @w_gr_gar_liquida = @i_gr_gar_liquida
        select @w_gr_gar_liquida = null, @v_gr_gar_liquida = null
    else
        select @w_gr_gar_liquida = @i_gr_gar_liquida  

    -- FIN Guardar los datos anteriores que han cambiado --
    
    -- INI Transaccion servicio - cl_grupo --
    insert into cobis..ts_grupo  (secuencial,    tipo_transaccion,    clase,                 fecha,    --1
                                  terminal,      srv,                 lsrv,                            --2
                                  grupo,         nombre,              representante,         compania, --3
                                  oficial,       fecha_registro,      fecha_modificacion,    ruc,      --4                      
                                  vinculacion,   tipo_vinculacion,    max_riesgo,            riesgo,   --5                      
                                  usuario,       reservado,           tipo_grupo,            estado,   --6                      
                                  dir_reunion,   dia_reunion,         hora_reunion,          comportamiento_pago,--7                      
                                  num_ciclo,     gar_liquida)
    values                       (@s_ssn,        800,                 'P',                   @s_date,   --1
                                  @s_term,       @s_srv,              @s_lsrv,                           --2
                                  @i_grupo,      @v_nombre,           @v_representante,      @v_compania,--3
                                  @v_oficial,    @v_fecha_registro,   @v_fecha_modificacion, @v_ruc,     --4
                                  @v_vinculacion,@v_tipo_vinculacion, @v_max_riesgo,         @v_riesgo,  --5
                                  @v_usuario,    @v_reservado,        @v_tipo_grupo,         @v_estado,  --6
                                  @v_dir_reunion,@v_dia_reunion,      @v_hora_reunion,       @v_comportamiento_pago,--7
                                  @v_num_ciclo  ,isnull(@v_gr_gar_liquida,'S')                                                         --8
                                 )
                                 
    -- si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 103005  --ERROR EN CREACION DE TRANSACCION DE SERVICIO
        goto ERROR        
    end

    -- Modificar los datos anteriores -- 
    update cobis..cl_grupo
    set    gr_oficial            = @i_oficial,
           gr_fecha_modificacion = @i_fecha_modificacion,
           gr_estado             = @i_estado,
           gr_dir_reunion        = @i_dir_reunion,
           gr_dia_reunion        = @i_dia_reunion,
           gr_hora_reunion       = @i_hora_reunion,
           gr_tipo				 = @i_gr_tipo,
           gr_cta_grupal		 = @i_gr_cta_grupal,
           --gr_sucursal	     = @i_gr_sucursal, --desde la pantalla de mantenimiento este campo esta dehabilitado para editar
           gr_titular1			 = @i_gr_titular1,
           gr_titular2			 = @i_gr_titular2,
           gr_lugar_reunion      = @i_gr_lugar_reunion,
           gr_tiene_ctagr        = @i_gr_tiene_ctagr,
           gr_tiene_ctain        = @i_gr_tiene_ctain,
           gr_gar_liquida        = isnull(@i_gr_gar_liquida,'S')
           
           --gr_comportamiento_pago= @i_comportamiento_pago
           --gr_num_ciclo          = @i_num_ciclo
    where  gr_grupo = @i_grupo

    -- Si no se puede modificar, error --
    if @@rowcount = 0
    begin
        select @w_error = 105007  --ERROR EN ACTUALIZACION DE GRUPO
        goto ERROR             
    end
    --actualizo el lugar de reunion cuando lugar de reunion es igual OT
    IF ( @i_gr_lugar_reunion ='OT')
    BEGIN
    UPDATE cobis..cl_cliente_grupo
     SET cg_lugar_reunion = NULL
    WHERE cg_grupo = @i_grupo
    END
    
    -- Insert en ts_grupo
    insert into cobis..ts_grupo  (secuencial,    tipo_transaccion,    clase,                 fecha,    --1
                                  terminal,      srv,                 lsrv,                            --2
                                  grupo,         nombre,              representante,         compania, --3
                                  oficial,       fecha_registro,      fecha_modificacion,    ruc,      --4                      
                                  vinculacion,   tipo_vinculacion,    max_riesgo,            riesgo,   --5                      
                                  usuario,       reservado,           tipo_grupo,            estado,   --6                      
                                  dir_reunion,   dia_reunion,         hora_reunion,          comportamiento_pago,--7                      
                                  num_ciclo,     gar_liquida)
    values                       (@s_ssn,        800,                 'A',                   @s_date,   --1
                                  @s_term,       @s_srv,              @s_lsrv,                           --2
                                  @i_grupo,      @w_nombre,           @w_representante,      @w_compania,--3
                                  @w_oficial,    @w_fecha_registro,   @w_fecha_modificacion, @w_ruc,     --4
                                  @w_vinculacion,@w_tipo_vinculacion, @w_max_riesgo,         @w_riesgo,  --5
                                  @w_usuario,    @w_reservado,        @w_tipo_grupo,         @w_estado,  --6
                                  @w_dir_reunion,@w_dia_reunion,      @w_hora_reunion,       @w_comportamiento_pago,--7
                                  @w_num_ciclo  ,isnull(@w_gr_gar_liquida,'S')                                                  --8
                                 )
    
    -- Si no se puede insertar, error --
    if @@error != 0
    begin
        select @w_error = 103005  --ERROR EN CREACION DE TRANSACCION DE SERVICIO 
        goto ERROR
    end
    
    --INICIO DE VALIDACIONES--
	--nuevas validaciones maximo 40--
  SELECT @numIntegrantesGrupo=count(cg_ente) FROM cobis..cl_cliente_grupo WHERE cg_grupo=@i_grupo AND cg_estado = 'V'
   IF(@numIntegrantesGrupo<>0)
   BEGIN
    SELECT @w_param_max_inte =pa_int FROM cobis..cl_parametro WHERE pa_nemonico='MAXIGR' AND pa_producto = 'CLI'
    SELECT @w_param_min_inte =pa_int FROM cobis..cl_parametro WHERE pa_nemonico='MINIGR' AND pa_producto = 'CLI'
    select @w_integrantes  = count(cg_ente) from cobis..cl_cliente_grupo
    where cg_grupo = @i_grupo
    and cg_estado = 'V'
 
    if @w_integrantes  >@w_param_max_inte or  @w_integrantes<@w_param_min_inte
     BEGIN
    -- PRINT'VALIDAR NÚMERO MÍNIMO Y MÁXIMO DE INTEGRANTES.'
       select @w_error = 208916 -- validación número de integrantes
        goto ERROR
     End 
    
     
     
     --validacion parentesco--
     SELECT @w_param_porc_parentesco=pa_float FROM cobis..cl_parametro WHERE pa_nemonico='PPGRU'  AND pa_producto = 'CRE'
    select distinct @w_num_integrantes = count(cg_ente) 
    from cobis..cl_cliente_grupo 
    where cg_grupo = @i_grupo
    and cg_estado = 'V'
    SELECT @w_sum_parentesco=count(DISTINCT in_ente_i) FROM cobis..cl_instancia
    WHERE  in_relacion IN (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B 
             WHERE A.tabla in ('cl_parentesco_1er','cl_parentesco_2er') AND A.codigo= B.tabla)
    AND in_ente_i IN (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
    AND in_ente_d IN (select cg_ente from cobis..cl_cliente_grupo where cg_grupo = @i_grupo and cg_estado = 'V')
    IF(@w_num_integrantes <>0)
    BEGIN
    select @w_porcentaje = ((@w_sum_parentesco * 100)/@w_num_integrantes)

    select @w_valor_nuevo = @w_porcentaje
    end
    if @w_valor_nuevo > @w_param_porc_parentesco    -- parametro 40 porcentaje de parentesco en grupos
    BEGIN
    --PRINT'VALIDAR PARENTESCO DE INTEGRANTES.'+CONVERT(VARCHAR(30),@w_porcentaje)
      select @w_error = 208917  --Error en Porcentaje de Parentesco
      goto ERROR
    END
    
    SELECT @w_reunion = gr_dir_reunion FROM cobis..cl_grupo WHERE gr_grupo = @i_grupo
    
    if ((@w_reunion IS NULL) or (@w_reunion = ' '))    -- Lugar de reunion
    BEGIN
    --PRINT'VALIDAR Lugar de Reunion.'+CONVERT(VARCHAR(30),@w_porcentaje)
      select @w_error = 208932  --POR FAVOR INGRESE EL LUGAR DE REUNION
      goto ERROR
    END
    
    --validacion de credito--
   if exists (select 1 from cobis..cl_cliente_grupo, cob_cartera..ca_operacion
   where cg_grupo = @i_grupo
   and cg_estado = 'V'
   and cg_ente = op_cliente
   and op_estado NOT IN (0,99,3, 6)
   and datediff(dd, @w_fecha_proceso, op_fecha_fin)>@w_param_eliminacion)
   begin
   --PRINT'VALIDAR CRÉDITOS VIGENTES DE INTEGRANTES.'
      select @w_error = 208918  --validacion de credito
      goto ERROR
   END
   
    --Validación conyuge--
  SELECT @w_param_rel_cony=pa_int FROM cobis..cl_parametro WHERE pa_nemonico='RCONY'  AND pa_producto = 'CRE' 
  
  SELECT @w_cliente_gr= 0
  SELECT top 1   @w_cliente_gr=cg_ente
  from cobis..cl_cliente_grupo
  where cg_grupo =@i_grupo
  and cg_estado = 'V'
  and cg_ente  > @w_cliente_gr 
  order by cg_ente ASC
  WHILE @@rowcount > 0
  begin
  if exists (select 1
  from cobis..cl_instancia
  where in_ente_i = @w_cliente_gr
  and in_relacion =@w_param_rel_cony -- parametro 'RCONY'
  and in_ente_d in (select cg_ente from cobis..cl_cliente_grupo where cg_grupo =@i_grupo and cg_estado = 'V'))
  BEGIN
  --PRINT'VALIDAR INTEGRANTES COMO CÓNYUGES ID DEL CLIENTE: '+ convert(VARCHAR(40),@w_cliente_gr)
    select @w_error = 208919  --Validación conyuge--
    SELECT  @w_msg= 'VALIDAR INTEGRANTES COMO CÓNYUGES: ID DEL CLIENTE  '+convert(VARCHAR(40),@w_cliente_gr)
     exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = @w_error,
             @i_msg   = @w_msg
  END

  SELECT top 1   @w_cliente_gr=cg_ente
  from cobis..cl_cliente_grupo
  where cg_grupo =@i_grupo
  and cg_estado = 'V'
  and cg_ente  > @w_cliente_gr 
  order by cg_ente ASC
  END--Fin While--
    
   --validaciones de mujeres--
   SELECT @w_param_porc_mujeres=pa_float FROM cobis..cl_parametro WHERE pa_nemonico='PMGRU'  AND pa_producto = 'CRE'
   select @w_integrantes = count(cg_ente) 
   from cobis..cl_cliente_grupo 
   where cg_grupo =@i_grupo 
   and cg_estado = 'V'
   select @w_num_sexo_feme = count(1) from cobis..cl_cliente_grupo, cobis..cl_ente
                        where en_ente = cg_ente
                        and p_sexo = 'F'    --genero femenino
                        and cg_grupo =@i_grupo
                        and cg_estado = 'V'                      
   IF(@w_integrantes<>0) 
   BEGIN
   select @w_valor_nuevo = ((@w_num_sexo_feme * 100)/@w_integrantes)
   END

   IF @w_valor_nuevo < @w_param_porc_mujeres -- parametro de porcentaje de mujeres en grupos
   BEGIN
   --PRINT'VALIDAR NÚMERO DE MUJERES.'
     select @w_error = 208920  --Error en Porcentaje de Parentesco
     goto ERROR
   END
  
    --Validación de emprendedores--
   SELECT @w_param_porc_emp=pa_float FROM cobis..cl_parametro WHERE pa_nemonico='MAXEMP'  AND pa_producto = 'CRE'
 
   select @w_integrantes = count(cg_ente) 
    from cobis..cl_cliente_grupo 
    where cg_grupo =@i_grupo 
    and cg_estado = 'V' 
   select @w_sum_enprender = count(nc_emprendedor) FROM cobis..cl_cliente_grupo, cobis..cl_negocio_cliente 
 	where nc_ente = cg_ente 
    and cg_grupo =@i_grupo
    and cg_estado = 'V' 
    and nc_emprendedor ='S'
    AND nc_estado_reg='V'
    
  IF(@w_integrantes<>0) 
   BEGIN
    select @w_porcentaje = ((@w_sum_enprender * 100)/@w_integrantes)
   END
   
   IF @w_porcentaje > @w_param_porc_emp -- parametro emprededores en grupos
   BEGIN
    select @w_error =208923  --Validación emprendedor
    goto ERROR
   END
   
   --Fin Validación Emprendedores--
  
  --validaciones Presidente--
  SELECT @numIntegrantesGrupo=count(cg_ente) FROM cobis..cl_cliente_grupo WHERE cg_grupo=@i_grupo AND cg_estado = 'V'
  IF(@numIntegrantesGrupo<>0)
  BEGIN
  IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
               WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                               WHERE A.tabla = 'cl_rol_grupo'
                               AND A.codigo = B.tabla
                               AND B.valor = 'PRESIDENTE')
                               AND cg_grupo = @i_grupo AND cg_estado='V')
  BEGIN
  --PRINT'EL GRUPO DEBE TENER UN PRESIDENTE'
  select @w_error =208921  --Validación Presidente
    goto ERROR
  END                               
  END
  
  --validaciones SECRETARIO--
  IF(@numIntegrantesGrupo<>0)
  BEGIN
      IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
                   WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                                   WHERE A.tabla = 'cl_rol_grupo'
                                   AND A.codigo = B.tabla
                                   AND B.valor = 'SECRETARIO')
                                   AND cg_grupo = @i_grupo AND cg_estado='V')
      BEGIN
          --PRINT'EL GRUPO DEBE TENER UN SECRETARIO'
          select @w_error = 208926  --Validación SECRETARIO
            goto ERROR
      END                               
  END  

---Validación Tesorero

  IF(@numIntegrantesGrupo<>0)
  BEGIN
  IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
               WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                               WHERE A.tabla = 'cl_rol_grupo'
                               AND A.codigo = B.tabla
                               AND B.valor = 'TESORERO')
                               AND cg_grupo =@i_grupo AND cg_estado='V')
  BEGIN
 -- PRINT'EL GRUPO DEBE TENER UN TESORERO'
    select @w_error = 208922  --Validación Tesorero
    goto ERROR
  END                               
  END
 END


end -- Fin Operacion U

if @i_operacion = 'Q'
begin

declare 
@w_cod_act_ing_web int , 
@w_cod_act_eli_web int, 
@w_cod_act_apro_web int, 
@w_cod_act_actual_web int,
@w_id_proceso_web int, 
@w_tramite_web int
    --Valida que no exista una solicitud en curso
    if exists (SELECT 1 FROM cob_workflow..wf_inst_proceso
                WHERE io_campo_1 = @i_grupo
                  AND io_estado not in ('TER', 'CAN', 'SUS', 'ELI')
				  and io_campo_7='S')
    begin
    
 select @w_cod_act_ing_web = ac_codigo_actividad from cob_workflow..wf_actividad where ac_nombre_actividad = 'INGRESAR SOLICITUD'
    
    select @w_id_proceso_web = io_id_inst_proc,
	        @w_tramite_web    = io_campo_3
    from   cob_workflow..wf_inst_proceso
    where  io_campo_1 = @i_grupo
    and    io_estado in ('EJE')
	 and    io_campo_7 = 'S'
	 if @@rowcount > 0
	begin
     if (@w_id_proceso_web is not null or @w_id_proceso_web > 0)
        begin
	        print '@w_id_proceso_web:' + convert(varchar(64),isnull(@w_id_proceso_web,0))
	        print '@w_tramite_web:' + convert(varchar(64),isnull(@w_tramite_web,0))	
            
            select top 1 @w_cod_act_actual_web = ia_codigo_act 
			   FROM cob_workflow..wf_inst_actividad
            where  ia_id_inst_proc = @w_id_proceso_web
            order by ia_id_inst_act desc
            
            print 'Codigo Actividad Actual_web:' + convert(varchar,@w_cod_act_actual_web)
        
            if(@w_cod_act_actual_web != @w_cod_act_ing_web )
            begin 
                print 'Ingreso a actividades diferentes'
                set @w_actualiza = 'N' -- Si es N desde el movil indica No se puede cambiar este grupo mientras tenga un tramite
            end	
        end
	end

    
	   -- select @w_actualiza = 'N'
        print 'sp_gb 1 Parametro ofi movil:' + convert(varchar(30),isnull(@w_parm_ofi_movil,0)) + '-oficina sesion:'+ convert(varchar(30),isnull(@s_ofi,0))
		if ( @s_ofi = @w_parm_ofi_movil)
		begin
            exec sp_grupo_busin
            @i_operacion       = 'M',
            @i_grupo           = @i_grupo,
            @t_trn             = 800,			
            @o_actualiza_movil = @w_actualiza_movil OUTPUT
		end
	end
	
	if(@w_actualiza_movil='N')
	begin
	 select @w_msm_actualiza_movil=mensaje from cobis..cl_errores
	where numero =103197
	end
 
    /*Motivo: en reimpresion esta saliendo ciclo 2 cuando el cliente tiene ciclo 1*/
	declare @w_num int
    select @w_num = 0
	if exists (select 1 FROM cob_cartera..ca_operacion--, cob_credito..cr_tramite_grupal
               where op_cliente  = @i_grupo
               and op_toperacion = 'GRUPAL'
               and op_estado IN (0,99))
    begin
        select @w_num = 1	
	end	
	
    -- Consulta de datos del grupo
    select 'Id_Gupo'             = gr_grupo,
           'Nombre'              = gr_nombre,
           'Oficial'             = gr_oficial,
           'Fecha_Registro'      = gr_fecha_registro,
           'Fecha_Modificacion'  = gr_fecha_modificacion,
           'Estado'              = gr_estado,
           'Dir_Reunion'         = gr_dir_reunion,
           'Dia_Reunion'         = gr_dia_reunion,
           'Hora_Reunion'        = gr_hora_reunion,
           'Comportamiento_Pago' = gr_comportamiento_pago,
           'Num_Ciclo'           = isnull(gr_num_ciclo,0) + @w_num,
           'Cuenta_grupal'       = gr_cta_grupal,
           'Sucursal'            = gr_sucursal,--12
           'Tipo'                = gr_tipo,
           'Titular1_Codigo'     = gr_titular1,--14
           'Titular1_Nombre'     = (SELECT en_nomlar FROM cobis..cl_ente WHERE en_ente=gr.gr_titular1), 
           'Titular2_Codigo'     = gr_titular2,          
           'Titular2_Nombre'     = (SELECT en_nomlar FROM cobis..cl_ente WHERE en_ente=gr.gr_titular2),
           'Lugar_reunion'       = gr_lugar_reunion,
           'Tiene_Cta_Grupal'    = gr_tiene_ctagr,
           'Tiene_Cta_Individual'= gr_tiene_ctain,
		   'Actualiza'           = @w_actualiza, --Valida si el grupo tiene una solicitud en curso para pantalla de Mant. de grupos,
		   'Gar_liquida'         = isnull(gr_gar_liquida,'S'),
		   'ActualizaMov'        = @w_actualiza_movil,  --Valida si el grupo tiene una solicitud en curso para el movil,
		   'Msm_ActualizaMov'     = @w_msm_actualiza_movil   --Valida si el grupo tiene una solicitud y envia mensaje a la apk,
		   
    from   cobis..cl_grupo gr
    where  gr_grupo = @i_grupo
	
	IF @@ROWCOUNT = 0
	begin
        select @w_error = 103141 -- NO EXISTE EL GRUPO
        goto ERROR
    end
	
	
	
end -- Fin Operacion Q

if @i_operacion = 'V' -- Validacion de miembros
begin 
--print 'Ingreso a Operacion V - Validacion'
    	
        --validaciones Presidente--
        SELECT @numIntegrantesGrupo=count(cg_ente) FROM cobis..cl_cliente_grupo WHERE cg_grupo=@i_grupo AND cg_estado = 'V'
        IF(@numIntegrantesGrupo<>0)
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
                         WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                                         WHERE A.tabla = 'cl_rol_grupo'
                                         AND A.codigo = B.tabla
                                         AND B.valor = 'PRESIDENTE')
                                         AND cg_grupo = @i_grupo AND cg_estado='V')
            BEGIN
            --PRINT'EL GRUPO DEBE TENER UN PRESIDENTE'
            select @w_error =208921  --Validación Presidente
              goto ERROR
            END                               
        END
        
        --validaciones SECRETARIO--
        IF(@numIntegrantesGrupo<>0)
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
                         WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                                         WHERE A.tabla = 'cl_rol_grupo'
                                         AND A.codigo = B.tabla
                                         AND B.valor = 'SECRETARIO')
                                         AND cg_grupo = @i_grupo AND cg_estado='V')
            BEGIN
                --PRINT'EL GRUPO DEBE TENER UN SECRETARIO'
                select @w_error = 208926  --Validación SECRETARIO
                  goto ERROR
            END                               
        END  
        
        --Validación Tesorero        
        IF(@numIntegrantesGrupo<>0)
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM cobis..cl_cliente_grupo 
                         WHERE cg_rol = (SELECT B.codigo FROM cobis..cl_tabla A, cobis..cl_catalogo B
                                         WHERE A.tabla = 'cl_rol_grupo'
                                         AND A.codigo = B.tabla
                                         AND B.valor = 'TESORERO')
                                         AND cg_grupo =@i_grupo AND cg_estado='V')
            BEGIN
            -- PRINT'EL GRUPO DEBE TENER UN TESORERO'
              select @w_error = 208922  --Validación Tesorero
              goto ERROR
            END                               
        END
	
end--Fin operacion V


if @i_operacion = 'M' -- Validacion de miembros
begin
    set  @o_actualiza_movil = 'S'
    declare @w_cod_act_ing int , @w_cod_act_eli int, @w_cod_act_apro int, @w_cod_act_actual int, @w_id_proceso int, @w_tramite int
    
    select @w_cod_act_ing = ac_codigo_actividad from cob_workflow..wf_actividad where ac_nombre_actividad = @w_parm_etap_ingreso
    select @w_cod_act_eli = ac_codigo_actividad from cob_workflow..wf_actividad where ac_nombre_actividad = @w_parm_etap_eliminar
	select @w_cod_act_apro = ac_codigo_actividad from cob_workflow..wf_actividad where ac_nombre_actividad = @w_parm_etap_aprobacion
    
    print 'sp_gb-CodigoGrupo:' + convert(varchar(64),@i_grupo)        
    print 'sp_gb-CodigoActividadIngreso:' + convert(varchar(64),@w_cod_act_ing)
    print 'sp_gb-CodigoActividadEliminar:' + convert(varchar(64),@w_cod_act_eli)
	print 'sp_gb-CodigoActividadAprobar:' + convert(varchar(64),@w_cod_act_apro)
    
    select @w_id_proceso = io_id_inst_proc,
	       @w_tramite    = io_campo_3
    from   cob_workflow..wf_inst_proceso
    where  io_campo_1 = @i_grupo
    and    io_estado in ('EJE')
	and io_campo_7 = 'S'
    
	if @@rowcount > 0
	begin
        if (@w_id_proceso is not null or @w_id_proceso > 0)
        begin
	        print 'sp_gb-@w_id_proceso:' + convert(varchar(64),isnull(@w_id_proceso,0))
	        print 'sp_gb-@w_tramite:' + convert(varchar(64),isnull(@w_tramite,0))	
            
            select top 1 @w_cod_act_actual = ia_codigo_act 
			FROM cob_workflow..wf_inst_actividad
            where  ia_id_inst_proc = @w_id_proceso
            order by ia_id_inst_act desc
            
            print 'sp_gb-Codigo Actividad Actual:' + convert(varchar,@w_cod_act_actual)
        
            if(@w_cod_act_actual != @w_cod_act_ing )
            begin 
                print 'Ingreso a actividades diferentes'
                set @o_actualiza_movil = 'N' -- Si es N desde el movil indica No se puede cambiar este grupo mientras tenga un tramite
            end	
        end
	end
	print 'sp_gb-@w_actualiza_movil:' + convert(varchar,@o_actualiza_movil)
end
	
return 0
ERROR:
    begin --Devolver mensaje de Error
    	if @w_msg is null
    	begin
    		exec cobis..sp_cerror
	             @t_debug = @t_debug,
	             @t_file  = @t_file,
	             @t_from  = @w_sp_name,
	             @i_num   = @w_error
	        return @w_error
    	end
    	else if @w_msg is not null
    	begin
    		exec cobis..sp_cerror
	             @t_debug = @t_debug,
	             @t_file  = @t_file,
	             @t_from  = @w_sp_name,
	             @i_num   = @w_error,
	             @i_msg   = @w_msg
	        return @w_error
    	end
    end
go
