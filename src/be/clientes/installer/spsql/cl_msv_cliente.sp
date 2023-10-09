/***********************************************************************/
/*   Archivo:                    cl_msv_cliente.sp                     */
/*   Stored procedure:           sp_msv_clientes                       */
/*   Base de Datos:              cobis                                 */
/*   Producto:                   cobis                                 */
/*   Disenado por:               Jorge Tellez Caceres                  */
/*   Fecha de Documentacion:     01/Mar/2013                           */
/***********************************************************************/
/*                        IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                        PROPOSITO                                    */
/*   Este procedimiento realiza el ingreso del cliente con su          */
/*   respectiva direccion, telefono, origen de fondos y mercado        */
/*   objetivo.                                                         */
/*   Se creo para el ingreso masivo de alianzas comerciales.           */
/***********************************************************************/
/*                     MODIFICACIONES                                  */
/*      FECHA            AUTOR                RAZON                    */
/*  01/Mar/20013   Jorge Tellez C.  JTC. 535. Emision Inicial.         */
/*                                  Alianzas comerciales.              */
/*  02/May/2016    DFu              Migracion CEN                      */
/***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_msv_clientes')
  drop proc sp_msv_clientes
go

create proc sp_msv_clientes
(
  @t_show_version bit = 0,
  @i_id_carga     int,
  @i_id_alianza   int,
  @i_tipo_ced     varchar(2),
  @i_ced_ruc      numero,
  @i_hijo         char(2) = null,
  @o_error_ext    int = null out,
  @o_retorno_ext  varchar(250) = null out
)
as
  declare
    @w_sp_name           char(30),
    @w_ssn               int,
    @w_fecha             datetime,
    @w_cliente           int,
    @w_operacion         char(1),
    ---- Informacion del archivo plano   
    --@w_cod_alianza       numero,  
    @w_oficina           smallint,
    @w_nombre            varchar(32),
    @w_p_apellido        varchar(16),
    @w_s_apellido        varchar(16),
    @w_sexo              char(1),
    @w_fecha_nac         datetime,
    @w_ciudad_nac        int,
    @w_lugar_doc         int,
    @w_estado_civil      catalogo,
    @w_actividad         catalogo,
    -- Referencia tabla cl_asociacion_actividad, segun el tipo de persona  
    @w_fecha_emision     datetime,
    @w_sector            catalogo,
    @w_depa_nac          int,
    @w_depa_emi          int,
    @w_tipo_productor    catalogo,
    @w_regimen_fiscal    catalogo,
    @w_antiguedad        smallint,
    @w_estrato           varchar(10),
    @w_recurso_pub       char(1),
    @w_influencia        char(1),
    @w_persona_pub       char(1),
    @w_victima           char(1),
    --Dir   
    @w_descripcion       varchar(254),
    @w_tipo_dir          catalogo,
    -- 002-RESIDENCIA 003-EMPRESA  011-NEGOCIO               
    @w_provincia         smallint,-- 11-DISTRITO CAPITAL               
    @w_principal         char(1),
    @w_principal_dir     char(1),
    @w_ciudad_dir        int,
    @w_rural_urb         char(1),-- Urbana    Rural               
    --Tel  
    @w_valor_tel         varchar(16),
    @w_tipo_telefono     char(1),-- C-celular  D-directo               
    --Orig. Fondos  
    @w_origen_fondos     mensaje,
    --Merc. Objetivo  
    @w_mercado_objetivo  catalogo,-- Urbana Rural               
    @w_subtipo_mo        catalogo,
    -- 002-Servicios Catalogo: cl_subtipo_mercado, relacionado con tabla cl_asociacion_actividad  
    @w_actividad_mer_obj catalogo,
    @w_banca             catalogo,-- Microempresa               
    @w_segmento          catalogo,-- Formacion               
    @w_subsegmento       catalogo,-- Por definir               
    -- Variables default y calculadas  
    @w_user              login,
    @w_term              varchar(30),
    @w_srv               varchar(30),
    @w_lsrv              varchar(30),
    @w_rol               int,
    @w_digito            char(1),-- Solo empresas  
    @w_pais              smallint,
    @w_filial            tinyint,
    @w_tipo              catalogo,
    @w_retencion         char(1),-- Sujeto a retenci¾n                       
    @w_exc_sipla         char(1),-- Exento FOE                       
    @w_exc_por2          char(1),
    -- Exento GMF (Exento 4x1000)                       
    @w_tipo_vinculacion  catalogo,
    @w_mala_referencia   char(1),
    @w_situacion_cliente catalogo,
    @w_pais_emi          smallint,
    @w_pensionado        char(1),
    @w_impuesto_vtas     char(1),
    @w_accion            varchar(10),
    @w_procedencia       varchar(10),
    -- Procedencia de la vinculaci¾n. catalogo cl_procedencia.  
    @w_num_hijos         smallint,
    -- dir  
    @w_parroquia         smallint,
    @w_barrio            char(40),-- 835-ACACIAS               
    @w_observacion       char(80),
    -- telefono         
    @w_prefijo           catalogo,
    -- Prefijo: 314 concel, 315 movistar,etc               
    -- origen_fondos        --   
    @w_producto          mensaje,
    @w_prov              varchar(64),-- Provincia  
    @w_cod_dir           int,-- Secuencial de direccion  
    @w_cod_tel           int,-- Secuencial de direccion  
    @w_trn               int,
    @w_operacion_aux     char(1),
    @w_return            int,
    @w_referencia        varchar(64),
    @w_tdn               char(30),
    @w_direccion         tinyint,
    @w_count             int,
    @w_bandera_seg       varchar(64),
    @w_profesion         catalogo,-- Profesión 000 sin profesión -> p_profesion
    @w_nivel_estudio     catalogo,
    -- Nivel estudios 001 Ninguno  -> p_nivel_estudio
    @w_ocupacion         catalogo
  -- Ocupación 004 Independiente -> en_concordato

  select
    @w_sp_name = 'sp_msv_clientes'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_cliente = null
  select
    @w_cliente = en_ente
  from   cobis..cl_ente with (nolock)
  where  en_ced_ruc  = @i_ced_ruc
     and en_tipo_ced = @i_tipo_ced
  select
    @w_bandera_seg = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'SEGMSV'
     and pa_producto = 'MIS'

  if @w_bandera_seg = 'S'
    select
      'ENTRO A SP sp_msv_clientes' + @i_ced_ruc

  if @w_cliente is null
  begin
    select
      @w_operacion = 'I'
  end
  else
  begin
    select
      @w_operacion = 'U'
    goto CLIENTE_EXISTE
  end

  ------------------------------------------------------------------------------------------------------------  
  ------------------------ INFORMACION QUE VIENE DEL ARCHIVO PLANO   -----------------------------------------  
  if @w_bandera_seg = 'S'
    select
      '0.1 sp_param_alianza_cli operacion: ' + @w_operacion + ' ced:' +
      @i_ced_ruc

  exec @w_return = sp_param_alianza_cli -- sp_helpcode sp_param_alianza_cli  
    @i_operacion         = 'A',
    -- Variables del archivo plano   
    @i_id_carga          = @i_id_carga,
    @i_id_alianza        = @i_id_alianza,
    @i_ced_ruc           = @i_ced_ruc,
    @i_tipo_ced          = @i_tipo_ced,
    @i_hijo              = @i_hijo,
    @o_oficina           = @w_oficina out,-- 4030  
    @o_nombre            = @w_nombre out,-- 'Pedro'      
    @o_p_apellido        = @w_p_apellido out,-- 'Jaramillo'      
    @o_s_apellido        = @w_s_apellido out,--  'Perez'     
    @o_sexo              = @w_sexo out,-- 'M'  
    @o_fecha_nac         = @w_fecha_nac out,-- '01/01/1975'  
    @o_ciudad_nac        = @w_ciudad_nac out,-- 11001   
    @o_lugar_doc         = @w_lugar_doc out,
    -- 11010                 -- Ciudad de donde es el documento de identidad  
    @o_estado_civil      = @w_estado_civil out,-- 'SO'   
    @o_actividad         = @w_actividad out,-- '001000'  
    @o_fecha_emision     = @w_fecha_emision out,-- '01/01/1998'  
    @o_sector            = @w_sector out,-- '000000'         
    @o_tipo_productor    = @w_tipo_productor out,-- '000'           
    @o_regimen_fiscal    = @w_regimen_fiscal out,-- '0003'         
    @o_antiguedad        = @w_antiguedad out,-- 180            
    @o_estrato           = @w_estrato out,-- '03'             
    @o_recurso_pub       = @w_recurso_pub out,-- null             
    @o_influencia        = @w_influencia out,-- null             
    @o_persona_pub       = @w_persona_pub out,-- null             
    @o_victima           = @w_victima out,-- null              
    --Dir   
    @o_descripcion       = @w_descripcion out,
    -- 'AV 99 O 999 99 IN 99878'               
    @o_tipo_dir          = @w_tipo_dir out,
    -- '011'                   -- 002-RESIDENCIA 003-EMPRESA  011-NEGOCIO               
    @o_principal         = @w_principal out,-- 'S'  
    @o_ciudad_dir        = @w_ciudad_dir out,-- 11001               
    @o_rural_urb         = @w_rural_urb out,
    -- 'U'                     -- Urbana    Rural               
    --Tel  
    @o_valor_tel         = @w_valor_tel out,-- '3695699'               
    @o_tipo_telefono     = @w_tipo_telefono out,
    -- 'C'                     -- C-celular  D-directo               
    --Orig. Fondos  
    @o_origen_fondos     = @w_origen_fondos out,-- 'TRABAJADOR'               
    --Merc. Objetivo  
    @o_mercado_objetivo  = @w_mercado_objetivo out,
    -- 'U'            -- Urbana Rural               
    @o_subtipo_mo        = @w_subtipo_mo out,
    -- '002'          -- 002-Servicios Catalogo: cl_subtipo_mercado, relacionado con tabla cl_asociacion_act ividad  
    @o_actividad_mer_obj = @w_actividad_mer_obj out,
    -- '001000'       -- Referencia tabla cl_asociacion_actividad, segun el tipo de persona  
    @o_banca             = @w_banca out,
    -- '1'            -- Microempresa                
    @o_segmento          = @w_segmento out,
    -- '01'           -- Formacion               
    @o_subsegmento       = @w_subsegmento out,
    -- '001'          -- Por definir               
    @o_error_ext         = @o_error_ext out,
    @o_retorno_ext       = @o_retorno_ext out

  if @@error <> 0
      or @w_return <> 0
  begin
    -- Manejo de error no controlado
    if isnull(@w_return,
              0) = 0
    begin
      select
        @o_retorno_ext = 'Error no controlado - sp_param_alianza_cli. OP=A '
      select
        @o_error_ext = 1
      goto ERROR
    end

    --Si no se trae informacion del archivo a cargar, retorna sin generar error  
    if @w_nombre is null
       and @w_p_apellido is null
       and @w_s_apellido is null
       and @w_sexo is null
       and @w_fecha_nac is null
       and @w_ciudad_nac is null
       and @w_lugar_doc is null
       and @w_actividad is null
       and @w_sector is null
       and @w_estrato is null
    begin
      select
        @w_descripcion =
      'MASIVO CLIENTES.: No trajo inf. de archivo a cargar. Retorna sin error.'
      select
        @w_descripcion = @w_descripcion + ' cedula: ' + isnull(@i_ced_ruc, '') +
                         ' tipo_id: '
        + isnull(
                         @i_tipo_ced
        , '')
      if @w_cliente is not null
        select
          @w_descripcion = @w_descripcion + ' ente: ' + convert( varchar(20),
                           @w_cliente
                           )

      insert into cobis..cl_error_log
                  (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                   er_descripcion)
      values      ( getdate(),null,'msv',null,null,
                    @w_descripcion )

      select
        @o_error_ext = 0
      select
        @o_retorno_ext = null
      return 0
    end

    select
      @o_error_ext = @w_return
    if @o_retorno_ext is null
    begin
      select
        @o_retorno_ext =
'Error al traer las variables que viene en archivo plano - sp_param_alianza_cli.'
end
  goto ERROR
end
  if @w_bandera_seg = 'S'
    select
      '0.2 sp_param_alianza_cli ced:' + @i_ced_ruc

  ------------------------------------------------------------------------------------------------------------  
  ------------------------ VARIABLES DEFAULT Y VARIABLES CALCULADAS ------------------------------------------  
  if @w_bandera_seg = 'S'
    select
      '0.3 sp_param_alianza_cli ced:' + @i_ced_ruc
  exec @w_return = sp_param_alianza_cli
    @i_operacion     = 'V',
    -- Parametros de salida para variables default   
    @o_user          = @w_user out,
    @o_term          = @w_term out,
    @o_srv           = @w_srv out,
    @o_lsrv          = @w_lsrv out,
    @o_rol           = @w_rol out,
    --@o_digito               = @w_digito               out,  
    @o_pais          = @w_pais out,
    @o_filial        = @w_filial out,
    @o_tipo          = @w_tipo out,
    @o_retencion     = @w_retencion out,
    -- Sujeto a retenci¾n                       
    @o_exc_sipla     = @w_exc_sipla out,-- Exento FOE                       
    @o_exc_por2      = @w_exc_por2 out,
    -- Exento GMF (Exento 4x1000)                       
    @o_tipo_vincul   = @w_tipo_vinculacion out,
    @o_mala_referen  = @w_mala_referencia out,
    @o_situacion_cli = @w_situacion_cliente out,
    @o_pais_emi      = @w_pais_emi out,
    @o_pensionado    = @w_pensionado out,
    @o_impuesto_vtas = @w_impuesto_vtas out,
    @o_accion        = @w_accion out,
    @o_procedencia   = @w_procedencia out,
    -- Procedencia de la vinculaci¾n. catalogo cl_procedencia.  
    @o_num_hijos     = @w_num_hijos out,
    -- dir  
    @o_parroquia     = @w_parroquia out,
    @o_barrio        = @w_barrio out,
    @o_observacion   = @w_observacion out,
    -- telefono         
    @o_prefijo       = @w_prefijo out,
    -- Prefijo: 314 concel, 315 movistar,etc               
    -- origen_fondos    
    @o_producto      = @w_producto out,
    @o_profesion     = @w_profesion out,
    -- Profesión 000 sin profesión -> p_profesion
    @o_nivel_estudio = @w_nivel_estudio out,
    -- Nivel estudios 001 Ninguno  -> p_nivel_estudio
    @o_ocupacion     = @w_ocupacion out,
    -- Ocupación 004 Independiente -> en_concordato
    @o_error_ext     = @o_error_ext out,
    @o_retorno_ext   = @o_retorno_ext out

  if @@error <> 0
      or @w_return <> 0
  begin
    -- Manejo de error no controlado
    if isnull(@w_return,
              0) = 0
    begin
      select
        @o_retorno_ext = 'Error no controlado - sp_param_alianza_cli. OP=V '
      select
        @o_error_ext = 1
      goto ERROR
    end

    select
      @o_error_ext = @w_return
    if isnull(@o_retorno_ext,
              '') <> ''
      select
        @o_retorno_ext = @o_retorno_ext
    else
      select
        @o_retorno_ext =
        'Error al traer las variables por default - sp_param_alianza_cli.'
    goto ERROR
  end
  if @w_bandera_seg = 'S'
    select
      '0.4 sp_param_alianza_cli ced:' + @i_ced_ruc

  ----------------------------------------------------------------------------------------------------------------  
  -- Si es un telefono CELULAR y si los 3 primeros caracteres existen en catalogo, se parte el numero ------------  
  if @w_tipo_telefono = 'C'
  begin
    if len(@w_valor_tel) > 3
    begin
      if exists (select
                   '1'
                 from   cobis..cl_tabla t with (nolock),
                        cobis..cl_catalogo c with (nolock)
                 where  t.tabla  = 'cl_prefijo_telefono'
                    and t.codigo = c.tabla
                    and c.codigo = substring (@w_valor_tel,
                                              1,
                                              3))
      begin
        select
          @w_prefijo = substring (@w_valor_tel,
                                  1,
                                  3)
        select
          @w_valor_tel = substring (@w_valor_tel,
                                    4,
                                    len(@w_valor_tel))
      end
    end
  end

  ----------------------------------------------------------------------------------------------------------------  
  -- Si es un telefono DIRECTO y segun provincia ingresamos un valor ---------------------------------------------  
  if @w_tipo_telefono = 'D'
  begin
    select
      @w_prov = pv_descripcion
    from   cobis..cl_ciudad with (nolock),
           cobis..cl_provincia with (nolock)
    where  pv_provincia = ci_provincia
       and ci_ciudad    = @w_ciudad_dir

    select
      @w_prefijo = c.codigo
    from   cobis..cl_tabla t with (nolock),
           cobis..cl_catalogo c with (nolock)
    where  t.tabla                    = 'cl_indicativo_telefono'
       and t.codigo                   = c.tabla
       and charindex(@w_prov,
                     c.valor) > 0

  end

  select
    @w_fecha = getdate()
  select
    @w_depa_nac = ci_provincia
  from   cobis..cl_ciudad with (nolock)
  where  ci_ciudad = @w_ciudad_nac
  select
    @w_depa_emi = ci_provincia
  from   cobis..cl_ciudad with (nolock)
  where  ci_ciudad = @w_lugar_doc
  select
    @w_provincia = ci_provincia
  from   cobis..cl_ciudad with (nolock)
  where  ci_ciudad = @w_ciudad_dir
  -- @w_ciudad Se debe calcular segun ciudad -- 11-DISTRITO CAPITAL               
  select
    @w_digito = null -- Solo empresas  

  --------------------------------------------------------------------------------------------------  
  --------------------------- CREACION DE CLIENTE --------------------------------------------------  
  begin tran

  if @w_operacion = 'I'
  begin
    -- exec @w_ssn = ADMIN...rp_ssn 
    select
      @w_ssn = siguiente + 1
    from   cobis..cl_seqnos
    where  bdatos = 'cobis'
       and tabla  = 'cl_masivo'
    update cobis..cl_seqnos
    set    siguiente = @w_ssn
    where  bdatos = 'cobis'
       and tabla  = 'cl_masivo'

    if @w_bandera_seg = 'S'
      select
        '1sp_persona_ins :ofi:' + convert( varchar(20), @w_oficina ) + ' ced:' +
        @i_ced_ruc
    exec @w_return = sp_persona_ins -- sp_helpcode sp_persona_ins  
      @s_ssn                = @w_ssn,
      @s_user               = @w_user,
      @s_term               = @w_term,
      @s_date               = @w_fecha,
      @s_srv                = @w_srv,
      @s_lsrv               = @w_lsrv,
      @s_ofi                = @w_oficina,
      @s_rol                = @w_rol,
      @s_org_err            = null,
      @s_error              = null,
      @s_sev                = null,
      @s_msg                = null,
      @s_org                = null,
      @t_debug              = 'N',
      @t_file               = null,
      @t_from               = null,
      @t_trn                = 103,
      @i_operacion          = @w_operacion,
      @i_persona            = null,
      @i_nombre             = @w_nombre,
      @i_p_apellido         = @w_p_apellido,
      @i_s_apellido         = @w_s_apellido,
      @i_sexo               = @w_sexo,
      @i_fecha_nac          = @w_fecha_nac,
      @i_tipo_ced           = @i_tipo_ced,
      @i_cedula             = @i_ced_ruc,
      @i_digito             = @w_digito,-- Solo empresas  
      @i_pasaporte          = null,
      @i_pais               = @w_pais,
      @i_ciudad_nac         = @w_ciudad_nac,
      @i_lugar_doc          = @w_lugar_doc,
      @i_nivel_estudio      = @w_nivel_estudio,
      -- Nivel estudios 001 Ninguno  -> p_nivel_estudio       
      @i_tipo_vivienda      = null,
      @i_calif_cliente      = null,
      @i_profesion          = @w_profesion,
      --   Profesión 000 sin profesión -> p_profesion  
      @i_estado_civil       = @w_estado_civil,
      @i_num_cargas         = null,
      @i_nivel_ing          = null,
      @i_nivel_egr          = null,
      @i_filial             = @w_filial,
      @i_oficina            = @w_oficina,
      @i_tipo               = @w_tipo,
      @i_grupo              = null,
      @i_oficial            = null,
      @i_retencion          = @w_retencion,
      -- Sujeto a retenci¾n                       
      @i_exc_sipla          = @w_exc_sipla,-- Exento FOE                       
      @i_exc_por2           = @w_exc_por2,
      -- Exento GMF (Exento 4x1000)                       
      @i_asosciada          = null,
      @i_tipo_vinculacion   = @w_tipo_vinculacion,
      @i_actividad          = @w_actividad,
      @i_comentario         = null,
      @i_fecha_emision      = @w_fecha_emision,
      @i_fecha_expira       = null,
      @i_sector             = @w_sector,
      @i_referido           = null,
      @i_nit                = null,
      @i_mala_referencia    = @w_mala_referencia,
      @i_gran_contribuyente = null,
      @i_situacion_cliente  = @w_situacion_cliente,
      @i_patrim_tec         = null,
      @i_fecha_patrim_bruto = null,
      @i_total_activos      = null,
      @i_rep_superban       = null,
      @i_preferen           = null,
      @i_depa_nac           = @w_depa_nac,
      @i_pais_emi           = @w_pais_emi,
      @i_depa_emi           = @w_depa_emi,
      @i_categoria          = null,
      @i_pensionado         = @w_pensionado,
      @i_tipo_productor     = @w_tipo_productor,
      @i_regimen_fiscal     = @w_regimen_fiscal,
      @i_numempleados       = null,
      @i_rioe               = null,
      @i_impuesto_vtas      = @w_impuesto_vtas,
      @i_pas_finan          = null,
      @i_fpas_finan         = null,
      @i_opInter            = null,
      @i_otringr            = null,
      @i_doctos_carpeta     = null,
      @i_exento_cobro       = null,
      @i_tipo_empleo        = @w_ocupacion,
      -- Ocupación 004 Independiente -> en_concordato             
      @i_cod_central        = null,
      @i_doc_validado       = null,
      @o_dif_oficial        = null,
      @i_ofiprod            = null,
      @i_accion             = @w_accion,
      @i_procedencia        = @w_procedencia,
      -- Procedencia de la vinculaci¾n. catalogo cl_procedencia.  
      @i_antiguedad         = @w_antiguedad,
      @i_estrato            = @w_estrato,
      @i_num_hijos          = @w_num_hijos,
      @i_recurso_pub        = @w_recurso_pub,
      @i_influencia         = @w_influencia,
      @i_persona_pub        = @w_persona_pub,
      @i_victima            = @w_victima,
      @i_crea_ext           = 'S',
      @o_msg_msv            = @o_retorno_ext output

    if @@error <> 0
    begin
      -- Manejo de error no controlado
      select
        @o_retorno_ext = 'Error no controlado - sp_persona_ins. OP=I '
      select
        @o_error_ext = 1
      goto ERROR
    end

    select
      @w_cliente = null
    select
      @w_cliente = en_ente
    from   cobis..cl_ente with (nolock)
    where  en_ced_ruc  = @i_ced_ruc
       and en_tipo_ced = @i_tipo_ced

    if @w_return <> 0
        or @w_cliente is null
    begin
      select
        @o_error_ext = @w_return
      if isnull(@o_retorno_ext,
                '') <> ''
        select
          @o_retorno_ext = @o_retorno_ext
      else
        select
          @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_persona_ins.'
        from   cobis..cl_errores
        where  numero = @o_error_ext
      goto ERROR
    end
    if @w_bandera_seg = 'S'
      select
        '2sp_persona_ins ' + ' ced:' + @i_ced_ruc

  end

  --------------------------------------------------------------------------------------------------  
  --------------------------- ACTUALIZACION DE CLIENTE --------------------------------------------------  
  if @w_operacion = 'U'
  begin
    -- exec @w_ssn = ADMIN...rp_ssn 
    select
      @w_ssn = siguiente + 1
    from   cobis..cl_seqnos
    where  bdatos = 'cobis'
       and tabla  = 'cl_masivo'
    update cobis..cl_seqnos
    set    siguiente = @w_ssn
    where  bdatos = 'cobis'
       and tabla  = 'cl_masivo'

    if @w_bandera_seg = 'S'
      select
        '1sp_persona_upd' + ' ced:' + @i_ced_ruc

    exec @w_return = sp_persona_upd -- sp_helpcode sp_persona_upd  
      @s_ssn                = @w_ssn,
      @s_user               = @w_user,
      @s_term               = @w_term,
      @s_date               = @w_fecha,
      @s_srv                = @w_srv,
      @s_lsrv               = @w_lsrv,
      @s_ofi                = @w_oficina,
      @s_rol                = @w_rol,
      @s_org_err            = null,
      @s_error              = null,
      @s_sev                = null,
      @s_msg                = null,
      @s_org                = null,
      @t_debug              = 'N',
      @t_file               = null,
      @t_from               = null,
      @t_trn                = 104,
      @i_operacion          = @w_operacion,
      @i_persona            = @w_cliente,
      @i_nombre             = @w_nombre,
      @i_p_apellido         = @w_p_apellido,
      @i_s_apellido         = @w_s_apellido,
      @i_sexo               = @w_sexo,
      @i_fecha_nac          = @w_fecha_nac,
      @i_tipo_ced           = @i_tipo_ced,
      @i_cedula             = @i_ced_ruc,
      @i_digito             = @w_digito,-- Solo empresas  
      @i_pasaporte          = null,
      @i_pais               = @w_pais,
      @i_ciudad_nac         = @w_ciudad_nac,
      @i_lugar_doc          = @w_lugar_doc,
      @i_nivel_estudio      = @w_nivel_estudio,
      -- Nivel estudios 001 Ninguno  -> p_nivel_estudio
      @i_tipo_vivienda      = null,
      @i_calif_cliente      = null,
      @i_profesion          = @w_profesion,
      -- Profesión 000 sin profesión -> p_profesion
      @i_estado_civil       = @w_estado_civil,
      @i_num_cargas         = null,
      @i_nivel_ing          = null,
      @i_nivel_egr          = null,
      @i_filial             = @w_filial,
      @i_oficina            = @w_oficina,
      @i_tipo               = @w_tipo,
      @i_grupo              = null,
      @i_oficial            = null,
      @i_retencion          = @w_retencion,
      -- Sujeto a retenci¾n                       
      @i_exc_sipla          = @w_exc_sipla,-- Exento FOE                       
      @i_exc_por2           = @w_exc_por2,
      -- Exento GMF (Exento 4x1000)                       
      @i_asosciada          = null,
      @i_tipo_vinculacion   = @w_tipo_vinculacion,
      @i_actividad          = @w_actividad,
      @i_comentario         = null,
      @i_fecha_emision      = @w_fecha_emision,
      @i_fecha_expira       = null,
      @i_sector             = @w_sector,
      @i_referido           = null,
      @i_nit                = null,
      --   @i_mala_referencia      = @w_mala_referencia,              
      @i_gran_contribuyente = null,
      @i_situacion_cliente  = @w_situacion_cliente,
      @i_patrim_tec         = null,
      @i_fecha_patrim_bruto = null,
      @i_total_activos      = null,
      @i_rep_superban       = null,
      @i_preferen           = null,
      @i_depa_nac           = @w_depa_nac,
      @i_pais_emi           = @w_pais_emi,
      @i_depa_emi           = @w_depa_emi,
      @i_categoria          = null,
      @i_pensionado         = @w_pensionado,
      @i_tipo_productor     = @w_tipo_productor,
      @i_regimen_fiscal     = @w_regimen_fiscal,
      @i_numempleados       = null,
      @i_rioe               = null,
      @i_impuesto_vtas      = @w_impuesto_vtas,
      @i_pas_finan          = null,
      @i_fpas_finan         = null,
      @i_opInter            = null,
      @i_otringr            = null,
      @i_doctos_carpeta     = null,
      @i_exento_cobro       = null,
      @i_tipo_empleo        = @w_ocupacion,
      -- Ocupación 004 Independiente -> en_concordato             
      --   @i_cod_central          = null,             
      @i_doc_validado       = null,
      @o_dif_oficial        = null,
      @i_ofiprod            = null,
      @i_accion             = @w_accion,
      @i_procedencia        = @w_procedencia,
      -- Procedencia de la vinculaci¾n. catalogo cl_procedencia.  
      @i_antiguedad         = @w_antiguedad,
      @i_estrato            = @w_estrato,
      @i_num_hijos          = @w_num_hijos,
      @i_recurso_pub        = @w_recurso_pub,
      @i_influencia         = @w_influencia,
      @i_persona_pub        = @w_persona_pub,
      @i_victima            = @w_victima,
      @i_crea_ext           = 'S',
      @o_msg_msv            = @o_retorno_ext out

    if @@error <> 0
    begin
      -- Manejo de error no controlado
      select
        @o_retorno_ext = 'Error no controlado - sp_persona_upd. '
      select
        @o_error_ext = 1
      goto ERROR
    end

    if @w_bandera_seg = 'S'
      select
        '2sp_persona_upd' + ' ced:' + @i_ced_ruc
    if @w_return <> 0
    begin
      select
        @o_error_ext = @w_return
      if isnull(@o_retorno_ext,
                '') <> ''
        select
          @o_retorno_ext = @o_retorno_ext
      else
        select
          @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_persona_upd.'
        from   cobis..cl_errores
        where  numero = @o_error_ext
      goto ERROR
    end
    if @w_bandera_seg = 'S'
      select
        '3sp_persona_upd - Update' + ' ced:' + @i_ced_ruc

  end

  select
    @w_cliente = en_ente
  from   cobis..cl_ente with (nolock)
  where  en_ced_ruc  = @i_ced_ruc
     and en_tipo_ced = @i_tipo_ced

  ---------------------------------------------------------------------------------------------------------------  
  ------------------------------- INGRESO DE DIRECCION NUEVA ----------------------------------------------------         
  -- TIPO DIRECCION NEGOCIO --> 011  
  select
    @w_tdn = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TDN'

  update cobis..cl_ente
  set    en_oficina_prod = @w_oficina,
         en_oficina = @w_oficina
  where  en_ente = @w_cliente

/* VERIFICA SI LA DIRECCION QUE SE ENVIA YA EXISTE     */
  /* SI NO EXISTE CREA UNA NUEVA, PERO NO COMO PRINCIPAL */
  if not exists (select
                   '1'
                 from   cl_direccion with (nolock)
                 where  di_ente                      = @w_cliente
                    and ltrim(rtrim(di_descripcion)) =
                        ltrim(rtrim(@w_descripcion))
                    and ltrim(rtrim(di_tipo))        = @w_tipo_dir)
  begin
    select
      @w_operacion_aux = 'I'

    -- SI ENVIA Y EXISTE EL TIPO DE DIRECCION NEGOCIO (011).  
    select
      @w_direccion = null
    select
      @w_direccion = di_direccion,
      @w_principal_dir = di_principal
    from   cobis..cl_direccion
    where  di_ente               = @w_cliente
       and ltrim(rtrim(di_tipo)) = @w_tipo_dir
       and di_tipo               = @w_tdn -- 011  

    if @@rowcount > 0
    begin
      select
        @w_operacion_aux = 'U'
    end

    -- SI SE ENVIA DIR PRINCIPAL:
    -- EL RESTO DE DIR. SE COLOCAN COMO NO PRINCIPALES Y LA QUE VIENE DEL ARCHIVO PLANO SE COLOCA COMO PRINCIPAL.
    if @w_principal = 'S'
    begin
      update cobis..cl_direccion
      set    di_principal = 'N'
      where  di_ente = @w_cliente
    end

    if @w_operacion_aux = 'I'
    begin
      select
        @w_trn = 109
    end
    else
    begin
      select
        @w_trn = 110

      -- SI SE ENVIA DIR PRINCIPAL COMO NO:
      -- SE VERIFICA SI EL TRAMITE TIENE DIR PRINCIPAL. 
      -- SI NO TIENE SE COLOCA LA QUE VIENEN COMO DIRECCION PRINCIPAL.
      if isnull(@w_principal,
                'N') = 'N'
      begin
        -- SI LA DIR A ACTUALIZAR ES LA DIR PRINCIPAL.
        -- SIGUE COMO PRINCIPAL PUES EL CLIENTE NO PUEDE QUEDARSE SIN DIR PRINCIPAL,ASI VENGA EN EL ARCHIVO QUE NO ES UNA DIR PRINCIPAL.
        if isnull(@w_principal_dir,
                  'S') = 'S'
        begin
          select
            @w_principal = @w_principal_dir
        end
        else
        begin
          -- 
          select
            @w_count = count(di_principal)
          from   cobis..cl_direccion
          where  di_ente      = @w_cliente
             and di_principal = 'S'

          if @w_count = 0
            select
              @w_principal = 'S'
        end
      end
    end

    -- exec @w_ssn = ADMIN...rp_ssn 
    select
      @w_ssn = siguiente + 1
    from   cobis..cl_seqnos
    where  bdatos = 'cobis'
       and tabla  = 'cl_masivo'
    update cobis..cl_seqnos
    set    siguiente = @w_ssn
    where  bdatos = 'cobis'
       and tabla  = 'cl_masivo'

    if @w_bandera_seg = 'S'
      select
        '1sp_direccion_dml - Update' + ' ced:' + @i_ced_ruc
    exec @w_return = sp_direccion_dml -- sp_helpcode sp_direccion_dml         
      @s_ssn         = @w_ssn,
      @s_user        = @w_user,
      @s_ofi         = @w_oficina,
      @s_rol         = 13,
      @s_date        = @w_fecha,
      @i_operacion   = @w_operacion_aux,
      --@w_operacion, se ingresa I, para que ingrese la nueva direccion   
      @t_trn         = @w_trn,--  esta trx es para update = 110,               
      @i_ente        = @w_cliente,--1490219,               
      @i_direccion   = @w_direccion,
      @i_descripcion = @w_descripcion,
      @i_tipo        = @w_tipo_dir,
      -- 002-RESIDENCIA 003-EMPRESA  011-NEGOCIO               
      @i_provincia   = @w_provincia,-- 11-DISTRITO CAPITAL               
      @i_principal   = @w_principal,
      -- @w_principal, Cuando actualiza y ya tiene dir, no coloca la dir como principal.  
      @i_oficina     = @w_oficina,
      @i_verificado  = 'N',
      -- En el ingreso se envia siempre N, y cuando actualiza toma variable de entrada  
      @i_ciudad      = @w_ciudad_dir,
      @i_zona        = @w_oficina,-- La misma oficina               
      @i_tienetel    = 'S',
      @i_rural_urb   = @w_rural_urb,-- Urbana    Rural               
      @i_parroquia   = @w_parroquia,
      @i_barrio      = @w_barrio,-- 835-ACACIAS               
      @i_observacion = @w_observacion,
      @i_crea_ext    = 'S',
      @o_msg_msv     = @o_retorno_ext output

    if @@error <> 0
        or @w_return <> 0
    begin
      -- Manejo de error no controlado
      if isnull(@w_return,
                0) = 0
      begin
        select
          @o_retorno_ext = 'Error no controlado - sp_direccion_dml. '
        select
          @o_error_ext = 1
        goto ERROR
      end

      select
        @o_error_ext = @w_return
      if isnull(@o_retorno_ext,
                '') <> ''
        select
          @o_retorno_ext = @o_retorno_ext
      else
        select
          @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_direccion_dml.'
        from   cobis..cl_errores
        where  numero = @o_error_ext
      goto ERROR
    end
    if @w_bandera_seg = 'S'
      select
        '2sp_direccion_dml - Update' + ' ced:' + @i_ced_ruc
  end

  ---------------------------------------------------------------------------------------------------------------  
  ------------------------------- INGRESO DE TELEFONO  ----------------------------------------------------------         
  -- exec @w_ssn = ADMIN...rp_ssn 
  select
    @w_ssn = siguiente + 1
  from   cobis..cl_seqnos
  where  bdatos = 'cobis'
     and tabla  = 'cl_masivo'
  update cobis..cl_seqnos
  set    siguiente = @w_ssn
  where  bdatos = 'cobis'
     and tabla  = 'cl_masivo'

  -- Secuencial de direccion  
  select
    @w_cod_dir = max(di_direccion)
  from   cl_direccion with (nolock)
  where  di_ente = @w_cliente
     and di_tipo = @w_tipo_dir
  -- Secuencial de telefono  
  select
    @w_cod_tel = max(te_secuencial)
  from   cl_telefono with (nolock)
  where  te_ente      = @w_cliente
     and te_direccion = @w_cod_dir

  -- Si no se tiene direccion no se ingresa el telefono  
  if @w_cod_dir is not null
  begin
    -- Si codigo de telefono no existe lo crea  
    select
      @w_operacion_aux = 'I'
    if @w_cod_tel is null
    begin
      select
        @w_cod_tel = 1
    end
    else
    begin
      -- Si envian existe tipo de telefono negocio y el clinete ya tiene uno lo actualiza.   
      -- Si envian un tipo de telefono diferente a negocio, crea el telefono  
      if @w_tipo_dir = @w_tdn
      begin -- TIPO DIRECCION NEGOCIO --> 011  
        select
          @w_operacion_aux = 'U'
      end
      else
      begin
        select
          @w_cod_tel = @w_cod_tel + 1
      end
    end

    -- Si el telefono existe, teniendo en cuenta el tipo de dir, no se hace nada. No tiene en cuenta el nemonico.  
    if exists (select
                 '1'
               from   cobis..cl_telefono with (nolock)
               where  te_ente                = @w_cliente
                  and ltrim(rtrim(te_valor)) = @w_valor_tel
                  and te_direccion           = @w_cod_dir)
      select
        @w_cod_tel = -1

    -- Si el telefono CELULAR existe no se hace nada.   
    if exists (select
                 '1'
               from   cobis..cl_telefono with (nolock)
               where  te_ente                  = @w_cliente
                  and ltrim(rtrim(te_valor))   = @w_valor_tel
                  and ltrim(rtrim(te_prefijo)) = @w_prefijo
                  and te_direccion             = @w_cod_dir)
      select
        @w_cod_tel = -1

    -- Cuando no existe el telefono se ingresa como nuevo no se actualiza  
    if @w_cod_tel >= 1
       and not exists (select
                         te_valor
                       from   cl_telefono
                       where  te_valor         = @w_valor_tel
                          and te_ente          = @w_cliente
                          and te_tipo_telefono = @w_tipo_telefono)
    begin
      if @w_operacion_aux = 'I'
        select
          @w_trn = 111
      else
        select
          @w_trn = 112

      if @w_bandera_seg = 'S'
        select
          '1sp_telefono - Update' + ' ced:' + @i_ced_ruc
      exec @w_return = sp_telefono -- sp_helpcode sp_telefono         
        @s_ssn           = @w_ssn,
        @s_user          = @w_user,
        @t_trn           = @w_trn,
        @i_operacion     = @w_operacion_aux,--   
        @i_ente          = @w_cliente,-- 1490219,               
        @i_direccion     = @w_cod_dir,-- Secuencial de direccion               
        @i_secuencial    = @w_cod_tel,
        @i_valor         = @w_valor_tel,
        @i_tipo_telefono = @w_tipo_telefono,
        -- C-celular  D-directo               
        @i_prefijo       = @w_prefijo,
        -- Prefijo: 314 concel, 315 movistar,etc               
        @i_crea_ext      = 'S',
        @o_msg_msv       = @o_retorno_ext output

      if @@error <> 0
          or @w_return <> 0
      begin
        -- Manejo de error no controlado
        if isnull(@w_return,
                  0) = 0
        begin
          select
            @o_retorno_ext = 'Error no controlado - sp_telefono. '
          select
            @o_error_ext = 1
          goto ERROR
        end

        select
          @o_error_ext = @w_return
        if isnull(@o_retorno_ext,
                  '') <> ''
          select
            @o_retorno_ext = @o_retorno_ext
        else
          select
            @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_telefono.'
          from   cobis..cl_errores
          where  numero = @o_error_ext
        goto ERROR
      end

      if @w_bandera_seg = 'S'
        select
          '2sp_telefono - Update' + ' ced:' + @i_ced_ruc
    end
  end

  ---------------------------------------------------------------------------------------------------------------  
  ------------------------------- ORIGEN DE FONDOS --------------------------------------------------------------         
  -- exec @w_ssn = ADMIN...rp_ssn 
  select
    @w_ssn = siguiente + 1
  from   cobis..cl_seqnos
  where  bdatos = 'cobis'
     and tabla  = 'cl_masivo'
  update cobis..cl_seqnos
  set    siguiente = @w_ssn
  where  bdatos = 'cobis'
     and tabla  = 'cl_masivo'

  if exists (select
               '1'
             from   cl_origen_fondos
             where  of_ente = @w_cliente)
    select
      @w_operacion = 'U'

  if @w_operacion = 'U'
    select
      @w_trn = 157
  else
    select
      @w_trn = 156

  if @w_bandera_seg = 'S'
    select
      '1sp_origen_fondos - Update' + ' ced:' + @i_ced_ruc
  exec @w_return = sp_origen_fondos --  sp_helpcode sp_origen_fondos         
    @s_ssn           = @w_ssn,
    @s_user          = @w_user,
    @i_operacion     = @w_operacion,
    @t_trn           = @w_trn,
    @i_ente          = @w_cliente,
    @i_origen_fondos = @w_origen_fondos,
    @i_producto      = @w_producto,
    @i_crea_ext      = 'S',
    @o_msg_msv       = @o_retorno_ext output

  if @@error <> 0
      or @w_return <> 0
  begin
    -- Manejo de error no controlado
    if isnull(@w_return,
              0) = 0
    begin
      select
        @o_retorno_ext = 'Error no controlado - sp_origen_fondos.  '
      select
        @o_error_ext = 1
      goto ERROR
    end

    select
      @o_error_ext = @w_return
    if isnull(@o_retorno_ext,
              '') <> ''
      select
        @o_retorno_ext = @o_retorno_ext
    else
      select
        @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_origen_fondos.'
      from   cobis..cl_errores
      where  numero = @o_error_ext
    goto ERROR
  end

  if @w_bandera_seg = 'S'
    select
      '2sp_origen_fondos - Update' + ' ced:' + @i_ced_ruc
  ---------------------------------------------------------------------------------------------------------------         
  ------------------------------- MERCADO OBJETIVO --------------------------------------------------------------         
  if @w_operacion = 'U'
    select
      @w_trn = 1496
  else
    select
      @w_trn = 1495

  -- exec @w_ssn = ADMIN...rp_ssn 
  select
    @w_ssn = siguiente + 1
  from   cobis..cl_seqnos
  where  bdatos = 'cobis'
     and tabla  = 'cl_masivo'
  update cobis..cl_seqnos
  set    siguiente = @w_ssn
  where  bdatos = 'cobis'
     and tabla  = 'cl_masivo'

  if @w_bandera_seg = 'S'
    select
      '1sp_banmer - Update' + ' ced:' + @i_ced_ruc
  exec @w_return = sp_banmer -- sp_helpcode sp_banmer  
    @s_ssn              = @w_ssn,
    @s_user             = @w_user,
    @i_operacion        = @w_operacion,
    @t_trn              = @w_trn,
    @i_ente             = @w_cliente,
    @i_mercado_objetivo = @w_mercado_objetivo,-- Urbana Rural               
    @i_subtipo_mo       = @w_subtipo_mo,
    -- 002-Servicios Catalogo: cl_subtipo_mercado, relacionado con tabla cl_asociacion_actividad  
    @i_actividad        = @w_actividad_mer_obj,
    -- Referencia tabla cl_asociacion_actividad, segun el tipo de persona  
    @i_banca            = @w_banca,-- Microempresa               
    @i_segmento         = @w_segmento,-- Formacion               
    @i_subsegmento      = @w_subsegmento,-- Por definir               
    @i_actprincipal     = null,
    -- De 1069038 registros, 965039 tienen los 3 datos con null  
    @i_actividad2       = null,
    @i_actividad3       = null,
    @i_crea_ext         = 'S',
    @o_msg_msv          = @o_retorno_ext output

  if @@error <> 0
      or @w_return <> 0
  begin
    -- Manejo de error no controlado
    if isnull(@w_return,
              0) = 0
    begin
      select
        @o_retorno_ext = 'Error no controlado - sp_banmer. '
      select
        @o_error_ext = 1
      goto ERROR
    end

    select
      @o_error_ext = @w_return
    if isnull(@o_retorno_ext,
              '') <> ''
      select
        @o_retorno_ext = @o_retorno_ext
    else
      select
        @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_banmer.'
      from   cobis..cl_errores
      where  numero = @o_error_ext
    goto ERROR
  end

  if @w_bandera_seg = 'S'
    select
      '2sp_banmer - Update' + ' ced:' + @i_ced_ruc
  commit tran

  CLIENTE_EXISTE:

  -------------------------------------------------------------------------------------------------------------------  
  ------------------------------- RELACION DE CLIENTE - ALIANZA - CARGA ---------------------------------------------         
  -- No se tiene manejo de errores pues el sp sp_asociacion_alianza, lo controla internamente.  
  if @w_bandera_seg = 'S'
    select
      '1cobis..sp_asociacion_alianza ' + ' ced:' + @i_ced_ruc
  select
    @w_user = isnull(@w_user,
                     'usermsv')
  exec @w_return = cobis..sp_asociacion_alianza
    -- sp_helpcode sp_asociacion_alianza  
    @s_user     = @w_user,
    @i_carga    = @i_id_carga,
    @i_alianza  = @i_id_alianza,
    @i_cliente  = @w_cliente,
    @i_crea_ext = 'S',
    @o_msg_msv  = @o_retorno_ext output

  if @@error <> 0
      or @w_return <> 0
  begin
    -- Manejo de error no controlado
    if isnull(@w_return,
              0) = 0
    begin
      select
        @o_retorno_ext = 'Error no controlado - sp_asociacion_alianza. '
      select
        @o_error_ext = 1
      goto ERROR
    end

    select
      @o_error_ext = @w_return
    if isnull(@o_retorno_ext,
              '') <> ''
      select
        @o_retorno_ext = @o_retorno_ext
    else
      select
        @o_retorno_ext = ltrim(rtrim(mensaje)) + ' - sp_asociacion_alianza.'
      from   cobis..cl_errores
      where  numero = @o_error_ext
    goto ERROR
  end
  if @w_bandera_seg = 'S'
    select
      '2cobis..sp_asociacion_alianza ' + ' ced:' + @i_ced_ruc

  return 0

  ERROR:

  while @@trancount > 0
    rollback

  if @o_error_ext <> 0 -- Codigo de error  
    select
      @o_retorno_ext = @o_retorno_ext + '. Cod.Error: ' + cast (@o_error_ext as
                              varchar) -- ltrim(rtrim(mensaje)) de error   

  --select * from cobis..ca_msv_error order by me_fecha desc  
  if @w_bandera_seg = 'S'
    select
      @o_retorno_ext + ' ced:' + @i_ced_ruc

  return 0 -- @o_error_ext  

go

