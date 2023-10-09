/*************************************************************************/
/*   Archivo:            sp_alerta_cliente.sp                            */
/*   Stored procedure:   sp_alerta_cliente                               */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       Paúl Ortiz Vera                                 */
/*   Fecha de escritura: 01/06/2018                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa da mantenimiento a la tabla cl_negocio_cliente        */
/*************************************************************************/
/*                               OPERACIONES                             */
/*   OPER. OPCION                     DESCRIPCION                        */
/*     I            Creación de una alerta                               */
/*     D            Eliminación (estado E) una operacion inusual (OI)    */
/*     S            Listado todas las OI ingresadas en el día            */
/*     S            Listado las alertas de riesgo ingresadas del día     */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 01/06/2018   Paúl Ortiz Vera               Versión Inicial            */
/*************************************************************************/
use cobis
go
if object_id ('sp_alerta_cliente') is not null
	drop procedure sp_alerta_cliente
go
create proc sp_alerta_cliente (
   @s_ssn             int         = null,
   @s_user            login       = null,
   @s_term            varchar(32) = null,
   @s_date            datetime    = null,
   @s_sesn            int         = null,
   @s_culture         varchar(10) = null,
   @s_srv             varchar(30) = null,
   @s_lsrv            varchar(30) = null,
   @s_ofi             smallint    = null,
   @s_rol             smallint    = null,
   @s_org_err         char(1)     = null,
   @s_error           int         = null,
   @s_sev             tinyint     = null,
   @s_msg             descripcion = null,
   @s_org             char(1)     = null,
   @t_debug           char(1)     = 'N',
   @t_file            varchar(10) = null,
   @t_from            varchar(32) = null,
   @t_trn             int         = null,
   @t_show_version    bit         = 0,
   @i_operacion       char(1),
   @i_codigo          int         = null,
   @i_tipo            varchar(10) = null,
   @i_fecha_alta      datetime    = null,
   @i_fecha_report    datetime    = null,
   @i_nombre          varchar(25) = null,
   @i_s_nombre        varchar(25) = null,
   @i_apellido        varchar(25) = null,
   @i_s_apellido      varchar(25) = null,
   @i_comentario      varchar(500)= null,
   @i_observacion     varchar(255)= null,
   @i_estado          varchar(100)= null,
   @i_generate_report varchar(2)  = NULL,
   @o_codigo          int         = null  output,
   @i_modo            tinyint     = null,
   @i_start_date      datetime    = null,
   @i_finish_date     datetime    = null,
   @i_tipo_operacion  varchar(50) = null
   
)as
declare 
   @w_ts_name         varchar(32),
   @w_num_error       int,
   @w_sp_name         varchar(32),
   @w_codigo          int,
   @w_tipo            varchar(10),
   @w_fecha_alta      datetime,
   @w_fecha_report    datetime,
   @w_nombre          varchar(60),
   @w_s_nombre        varchar(25),
   @w_apellido        varchar(25),
   @w_s_apellido      varchar(25),
   @w_nombre_completo varchar(100),
   @w_comentario      varchar(500),
   @w_observacion     varchar(255),
   @w_estado          varchar(100),
   @w_estatus_ei      varchar(2),
   @w_generate_report varchar(2),
   @w_fecha_proceso   DATETIME,
   @w_tipo_operacion  varchar(10),
   @w_id_alerta       INT,
   @w_rfc_user       VARCHAR(30)
   
select @w_sp_name = 'sp_alerta_cliente'

   -- Validar codigo de transacciones --
if ((@t_trn <> 1713 and @i_operacion = 'I') or
    (@t_trn <> 1714 and @i_operacion = 'D') or
    (@t_trn <> 1715 and @i_operacion = 'S') or
    (@t_trn <> 1716 and @i_operacion = 'A') or
    (@t_trn <> 1717 and @i_operacion = 'U'))
begin
   select @w_num_error = 151051 --Transaccion no permitida
   goto errores
end

set @w_estatus_ei='EI'

SELECT @w_fecha_proceso=fp_fecha from cobis..ba_fecha_proceso

if @i_operacion = 'I'
begin
    begin tran
    exec @w_num_error = cobis..sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_operaciones_inusuales',
        @o_siguiente = @w_codigo out
        
    select @o_codigo = @w_codigo
        
        if @w_num_error <> 0
        begin
            select @w_num_error = 2101007 --NO EXISTE TABLA EN TABLA DE SECUENCIALES
            goto errores
        end
    
	
    if exists (select 1 
	             from cobis..cl_operaciones_inusuales 
    			where oin_codigo = @w_codigo)
    begin
    	select @w_num_error = 208938 --YA EXISTE UNA OPERACION INUSUAL PARA EL CLIENTE 
         goto errores
    end
    
    select @w_estado = 'EI'/*En Investi*/
    select @w_nombre_completo = isnull(@i_nombre, '') +' '+ isnull(@i_s_nombre, '') +' '+ isnull(@i_apellido, '') +' '+ isnull(@i_s_apellido, '')
    
    insert into cobis..cl_operaciones_inusuales(
    		oin_codigo,             oin_tipo_op,               oin_fecha_alta,            oin_fecha_reporte,
    		oin_nombre_rep,         oin_s_nombre_rep,          oin_apellido_rep,          oin_s_apellido_rep,
			oin_estado,             oin_comentario)
    values(
            @w_codigo               ,@i_tipo                   ,@i_fecha_alta             ,@i_fecha_report,
            isnull(@i_nombre, '')   ,@i_s_nombre   ,isnull(@i_apellido, '')   ,@i_s_apellido,
            @w_estado               ,@i_comentario)

     if @@error <> 0
      begin 
         select @w_num_error = 208939 --ERROR AL INSERTAR LA OPERACION INUSUAL DEL CLIENTE 
         goto errores
      end

    --SRO. Inserción en línea batch
    SELECT 
            @w_tipo_operacion = clc.valor 
      FROM  cobis..cl_tabla clt, 
            cobis..cl_catalogo  clc 
     WHERE  clt.codigo = clc.tabla 
       AND  clt. tabla ='cl_operaciones_inusuales' 
       AND  clc.codigo = @i_tipo 
                                                        
    --Insersion del rfc y curp del funcionario que se esta logueando
    select   @w_rfc_user=fu_cedruc
  from  cobis..cc_oficial,
      cobis..cl_funcionario
  where  fu_login         = @s_user
  and  fu_funcionario   = oc_funcionario
    
    
                                                        
    insert into cobis..cl_alertas_riesgo(
            ar_sucursal          ,ar_grupo             ,ar_ente,
            ar_nombre_grupo      ,ar_nombre            ,ar_rfc              ,ar_contrato,
            ar_tipo_producto     ,ar_tipo_lista        ,ar_fecha_consulta   ,ar_fecha_alerta,
            ar_fecha_operacion   ,ar_fecha_dictamina   ,ar_fecha_reporte    ,ar_observaciones,
            ar_nivel_riesgo      ,ar_etiqueta          ,ar_escenario        ,ar_tipo_alerta,
            ar_tipo_operacion    ,ar_monto             ,ar_status           ,ar_genera_reporte, ar_codigo)
    values(
            ' '                 ,' '                      , ' ',
            ' '                 , @w_nombre_completo      , @w_rfc_user                 , ' ',
            ' '                 , @i_tipo                 , @w_fecha_proceso    , @w_fecha_proceso,
            @i_fecha_alta       , null                    , @i_fecha_report     , ' ',
            ' '                 ,' '                      , ' '                 , ' ',
            @w_tipo_operacion   , 0                        , @w_estado          , ' ',@w_codigo)  
            
	
   if @@error <> 0
      begin 
         select @w_num_error = 208939 --ERROR AL INSERTAR LA OPERACION INUSUAL DEL CLIENTE 
         goto errores
      end
    
    commit tran
    goto fin
end


if @i_operacion = 'U'
begin
    select (1) from cobis..cl_alertas_riesgo where ar_id_alerta = @i_codigo
    if @@rowcount = 0
    begin
		select @w_num_error =  208940 --NO EXISTE REGISTRO CON EL ID DE ALERTA
		goto errores
    end 
      begin tran
      select
        @w_codigo            = ar_id_alerta,
        @w_fecha_alta        = ar_fecha_dictamina,
        @w_observacion       = ar_observaciones,
        @w_estado            = ar_status,
        @w_generate_report   = ar_genera_reporte
    from cobis..cl_alertas_riesgo
    where ar_id_alerta = @i_codigo
    if @@rowcount = 0
      begin
         select @w_num_error =  208941 --ERROR AL BUSCAR DATOS DE LA ALERTA
         goto errores
      end 
    
    
    update cobis..cl_alertas_riesgo
    set ar_observaciones    = @i_observacion,
        ar_status           = @i_estado,
        ar_genera_reporte   = rtrim(@i_generate_report)
    where ar_id_alerta  = @i_codigo
  
    if @@error <> 0
    begin
     select @w_num_error = 208942 --ERROR AL ACTUALIZAR DATOS DE LA ALERTA
     goto errores
    end
    
    if(rtrim(@i_estado) ='NR' OR rtrim(@i_estado)='SR')
    begin
    update cobis..cl_alertas_riesgo
    set   ar_fecha_dictamina  = @i_fecha_alta,
          ar_fecha_alerta     = @w_fecha_proceso
    where ar_id_alerta  = @i_codigo 
    end
    
    if(rtrim(@i_generate_report)='S')
    begin
    update cobis..cl_alertas_riesgo
    set   ar_fecha_reporte   = @w_fecha_proceso
    where ar_id_alerta  = @i_codigo
	/*
	exec cob_conta_super..sp_rep_operacion_inurel
	@i_param1   =   null, -- FECHA DE PROCESO FE null
    @i_param2   =   null, -- ALERTA FE null
    @i_param3   =   @i_codigo  -- codigo de alerta  
	*/
    end
    
    
    commit tran
goto fin
end


if @i_operacion = 'D'
begin
    select (1) from cobis..cl_operaciones_inusuales where oin_codigo = @i_codigo
    if @@rowcount = 0
    begin
        select @w_num_error =  208943 --ERROR AL BUSCAR DATOS DE LA ALERTA
        goto errores
    end 
    
    begin tran

    update cobis..cl_operaciones_inusuales
       set oin_estado = 'E'     --estado eliminado
     where oin_codigo = @i_codigo
  
    if @@error <> 0
    begin
     select @w_num_error = 208944 --ERROR AL ELIMINAR DATOS DE LA ALERTA
     goto errores
    end
	
	select @w_nombre_completo = isnull(@i_nombre, '') +' '+ isnull(@i_s_nombre, '') +' '+ isnull(@i_apellido, '') +' '+ isnull(@i_s_apellido, '')
    
    select 1
	  from cobis..cl_alertas_riesgo	       
     where ar_codigo = @i_codigo
    
    if @@rowcount = 0
    begin
       select @w_num_error =  208943 --ERROR AL BUSCAR DATOS DE LA ALERTA
       goto errores
    end 
    
    update cobis..cl_alertas_riesgo
       set ar_status    = 'E' ,            --estado eliminado
       ar_fecha_alerta  = @w_fecha_proceso --se actualiza la fecha de alerta
     where ar_codigo = @i_codigo
	 
	 if @@error <> 0
    begin
     select @w_num_error = 208944 --ERROR AL ELIMINAR DATOS DE LA ALERTA
     goto errores
    end

    commit tran
goto fin
end


if @i_operacion = 'S'
begin
    set rowcount 0
    select 
        'codigo'            = oin_codigo,
        'tipoOperacion'     = oin_tipo_op,
        'fechaAlta'         = convert(char(10), oin_fecha_alta, 103),
        'fechaReporte'      = convert(char(10), oin_fecha_reporte, 103),
        'nombre'            = isnull(oin_nombre_rep, '') +' '+ isnull(oin_s_nombre_rep, '') 
                              +' '+ isnull(oin_apellido_rep, '') +' '+ isnull(oin_s_apellido_rep, ''),
        'comentario'        = oin_comentario
    from cobis..cl_operaciones_inusuales
    WHERE oin_estado <> 'E'
    ORDER BY oin_fecha_alta ASC 

goto fin
end
if @i_operacion = 'A'
begin
    if  @i_modo=0
	begin
        set rowcount 0
        select 
        'dAlerta'               = ar_id_alerta,
        'sucursal'              = ar_sucursal,
        'grupo'                 = ar_grupo,
        'ente'                  = ar_ente,
        'nombre'                = ar_nombre,
        'contrato'              = ar_contrato,
        'tipoProducto'          = ar_tipo_producto,
        'tipoLista'             = ar_tipo_lista,
        'fechaAlerta'           = convert(char(10), ar_fecha_alerta, 103),
        'fechaOperacion'        = convert(char(10), ar_fecha_operacion, 103),
        'fechaDictamina'        = convert(char(10), ar_fecha_dictamina, 103),
        'fechaReporte'          = convert(char(10), ar_fecha_reporte, 103),
        'observaciones'         = ar_observaciones,
        'nivelRiesgo'           = ar_nivel_riesgo,
        'etiqueta'              = ar_etiqueta,
        'escenario'             = ar_escenario,
        'tipoAlerta'            = ar_tipo_alerta,
        'tipooperacion'         = ar_tipo_operacion,
        'monto'                 = ar_monto,
        'status'                = ar_status,
        'generaReporte'         = ar_genera_reporte,
        'nombreGrupo'           = ar_nombre_grupo,
        'rfc'                   = ar_rfc,
		'fechaConsulta'         = convert(char(10), ar_fecha_consulta, 103)
        from cobis..cl_alertas_riesgo
        where (ar_status  is null or ar_status = @w_estatus_ei)
        and ar_fecha_alerta BETWEEN @i_start_date AND @i_finish_date
        order by dAlerta asc  
	end
	
	if  @i_modo=1
	begin
	select 
        'dAlerta'               = ar_id_alerta,
        'sucursal'              = ar_sucursal,
        'grupo'                 = ar_grupo,
        'ente'                  = ar_ente,
        'nombre'                = ar_nombre,
        'contrato'              = ar_contrato,
        'tipoProducto'          = ar_tipo_producto,
        'tipoLista'             = ar_tipo_lista,
        'fechaAlerta'           = convert(char(10), ar_fecha_alerta, 103),
        'fechaOperacion'        = convert(char(10), ar_fecha_operacion, 103),
        'fechaDictamina'        = convert(char(10), ar_fecha_dictamina, 103),
        'fechaReporte'          = convert(char(10), ar_fecha_reporte, 103),
        'observaciones'         = ar_observaciones,
        'nivelRiesgo'           = ar_nivel_riesgo,
        'etiqueta'              = ar_etiqueta,
        'escenario'             = ar_escenario,
        'tipoAlerta'            = ar_tipo_alerta,
        'tipooperacion'         = ar_tipo_operacion,
        'monto'                 = ar_monto,
        'status'                = ar_status,
        'generaReporte'         = ar_genera_reporte,
        'nombreGrupo'           = ar_nombre_grupo,
        'rfc'                   = ar_rfc,
		'fechaConsulta'         = convert(char(10), ar_fecha_consulta, 103)
        from cobis..cl_alertas_riesgo
        where (ar_status  is null or ar_status =@w_estatus_ei)
        AND ar_tipo_lista=@i_tipo_operacion 
        order by dAlerta asc 
	end

goto fin
end


--Control errores
errores:
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_num_error
   return @w_num_error
fin:
   return 0


go