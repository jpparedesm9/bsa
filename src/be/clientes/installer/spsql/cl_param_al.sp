/***********************************************************************/
/*      Archivo:                    cl_param_al.sp                     */
/*      Stored procedure:           sp_param_alianza_cli               */
/*      Base de Datos:              cobis                              */
/*      Producto:                   MIS                                */
/*      Disenado por:               Jorge Tellez Caceres               */
/*      Fecha de Documentacion:     01/Mar/2013                        */
/***********************************************************************/
/*                          IMPORTANTE                                 */
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
/*                           PROPOSITO                                 */
/*      Este procedimiento consulta los parametros default de la       */
/*      alianza comercial, dependiendo si el tramite es original,      */
/*      cupo, utilizacion o unificacion                                */
/***********************************************************************/
/*                        MODIFICACIONES                               */
/*      FECHA            AUTOR                RAZON                    */
/*  01/Mar/20013   Jorge Tellez C.  JTC. 535. Emision Inicial.         */
/*                                  Parametros de Alianzas comerciales.*/
/*                                  para creacion de cliente           */
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
           where  name = 'sp_param_alianza_cli')
  drop proc sp_param_alianza_cli
go

create proc sp_param_alianza_cli
(
  @s_ssn               int = null,
  @s_date              datetime = null,
  @s_user              login = null,
  @s_term              descripcion = null,
  @s_ofi               smallint = null,
  @s_srv               varchar(30) = null,
  @s_lsrv              varchar(30) = null,
  @t_rty               char(1) = null,
  @t_trn               smallint = null,
  @t_debug             char(1) = 'N',
  @t_file              varchar(14) = null,
  @t_show_version      bit = 0,
  @t_from              varchar(30) = null,
  @i_operacion         char(1),

  -- Variables del archivo plano 
  @i_id_carga          numero = null,
  @i_id_alianza        numero = null,
  @i_ced_ruc           numero = null,
  @i_tipo_ced          varchar(2) = null,
  @i_hijo              char(2) = null,

  -- Parametros de salida para variables default 
  @o_user              login = null out,
  @o_term              varchar(30) = null out,
  @o_srv               varchar(30) = null out,
  @o_lsrv              varchar(30) = null out,
  @o_rol               int = null out,

  --   @o_digito               char(1)    = null out,
  @o_pais              smallint = null out,
  @o_filial            tinyint = null out,
  @o_tipo              catalogo = null out,
  @o_retencion         char(1) = null out,

  -- Sujeto a retenci¾n                     
  @o_exc_sipla         char(1) = null out,-- Exento FOE                     
  @o_exc_por2          char(1) = null out,

  -- Exento GMF (Exento 4x1000)                     
  @o_tipo_vincul       catalogo = null out,
  @o_mala_referen      char(1) = null out,
  @o_situacion_cli     catalogo = null out,
  @o_pais_emi          smallint = null out,
  @o_pensionado        char(1) = null out,
  @o_impuesto_vtas     char(1) = null out,
  @o_accion            varchar(10) = null out,
  @o_procedencia       varchar(10) = null out,

  -- Procedencia de la vinculaci¾n. catalogo cl_procedencia.
  @o_num_hijos         smallint = null out,

  -- dir
  @o_parroquia         smallint = null out,
  @o_barrio            char(40) = null out,
  @o_observacion       char(80) = null out,

  -- telefono       
  @o_prefijo           catalogo = null out,

  -- Prefijo: 314 concel, 315 movistar,etc             

  -- origen_fondos  
  @o_producto          mensaje = null out,

  -- Variables del archivo plano 
  @o_oficina           smallint = null out,
  @o_nombre            varchar(32) = null out,
  @o_p_apellido        varchar(16) = null out,
  @o_s_apellido        varchar(16) = null out,
  @o_sexo              char(1) = null out,
  @o_fecha_nac         datetime = null out,

  --@w_tipo_ced              varchar(2)   = null out,
  --@w_ced_ruc               numero       = null out, 
  @o_ciudad_nac        int = null out,
  @o_lugar_doc         int = null out,
  @o_estado_civil      catalogo = null out,
  @o_actividad         catalogo = null out,

  -- Referencia tabla cl_asociacion_actividad , segun el tipo de persona
  @o_fecha_emision     datetime = null out,
  @o_sector            catalogo = null out,
  @o_tipo_productor    catalogo = null out,
  @o_regimen_fiscal    catalogo = null out,
  @o_antiguedad        smallint = null out,
  @o_estrato           varchar(10) = null out,
  @o_recurso_pub       char(1) = null out,
  @o_influencia        char(1) = null out,
  @o_persona_pub       char(1) = null out,
  @o_victima           char(1) = null out,

  --Dir 
  @o_descripcion       varchar(254) = null out,
  @o_tipo_dir          catalogo = null out,

  -- 002-RESIDENCIA 003-EMPRESA  011-NEGOCIO             
  @o_provincia         smallint = null out,-- 11-DISTRITO CAPITAL             
  @o_principal         char(1) = null out,
  @o_ciudad_dir        int = null out,
  @o_rural_urb         char(1) = null out,-- Urbana    Rural             

  --Tel
  @o_valor_tel         varchar(16) = null out,
  @o_tipo_telefono     char(1) = null out,-- C-celular  D-directo             

  --Orig. Fondos
  @o_origen_fondos     mensaje = null out,

  --Merc. Objetivo
  @o_mercado_objetivo  catalogo = null out,-- Urbana Rural             
  @o_subtipo_mo        catalogo = null out,

  -- 002-Servicios Catalogo: cl_subtipo_mercado, relacionado con tabla cl_asociacion_actividad
  @o_actividad_mer_obj catalogo = null out,
  @o_banca             catalogo = null out,-- Microempresa             
  @o_segmento          catalogo = null out,-- Formacion             
  @o_subsegmento       catalogo = null out,-- Por definir             
  @o_profesion         catalogo = null out,

  -- 'profesion'  --  Profesión 000 sin profesión -> p_profesion
  @o_nivel_estudio     catalogo = null out,

  -- 'niv_estud'  --  Nivel estudios 001 Ninguno  -> p_nivel_estudio
  @o_ocupacion         catalogo = null out,

  -- 'ocupacion'  --  Ocupación 004 Independiente -> en_concordato
  @o_error_ext         int = null out,
  @o_retorno_ext       varchar(250) = null out
)
as
  declare
    @w_sp_name           char(30),
    @w_today             datetime,/* FECHA DEL DIA */
    @w_return            int,/* VALOR QUE RETORNA */
    @w_tabla             int,
    @w_quitar_caract_rar char(1) /* QUITAR CARACTERES RAROS*/

  select
    @w_sp_name = 'sp_param_alianza_cli'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_quitar_caract_rar = 'S' -- Quitar caracteres raros
  select
    @o_error_ext = 0
  select
    @o_retorno_ext = null

  --set nocount on

  ------------------  VARIABLES DEFAULT  -------------------------------
  if @i_operacion = 'V'
  begin
    select
      @w_tabla = codigo
    from   cobis..cl_tabla with (nolock)
    where  tabla = 'cl_default_cli'

    select
      @o_user = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'usuario' --  'sa'  
    select
      @o_term = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'term' --  'TERM'
    select
      @o_srv = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'srv' --  'SRV' 
    select
      @o_lsrv = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'lsrv' --  'LSRV'
    select
      @o_rol = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'rol' --  '13'  
    select
      @o_pais = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'pais' --  '1'   
    select
      @o_filial = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'filial' --  '1'   
    select
      @o_tipo = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'tipo' --  '001' 
    select
      @o_retencion = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'retencion' --  'S'   
    select
      @o_exc_sipla = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'exec_sipla' --  'S'   
    select
      @o_exc_por2 = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'exec_por2' --  'N'   
    select
      @o_tipo_vincul = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'tipo_vinc' --  '001' 
    select
      @o_mala_referen = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'mala_refer' --  'N'   
    select
      @o_situacion_cli = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'situac_cli' --  'NOR' 
    select
      @o_pais_emi = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'pais_emi' --  '1'   
    select
      @o_pensionado = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'pensionado' --  'N'   
    select
      @o_impuesto_vtas = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'impues_vta' --  'N'   
    select
      @o_accion = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'accion' --  'NIN' 
    select
      @o_procedencia = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'procedenc' --  'RFA' 
    select
      @o_num_hijos = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'nro_hijos' --  '0'   
    select
      @o_parroquia = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'parroquia' --  '-1'  
    select
      @o_barrio = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'barrio' --  null,  
    select
      @o_observacion = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'observac'
    --  'INGRESO POR CARGUE DE ALIANZAS ESTRATEGICAS' 

    select
      @o_profesion = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'profesion' --  Profesión 000 sin profesión -> p_profesion
    select
      @o_nivel_estudio = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'niv_estud'
    --  Nivel estudios 001 Ninguno  -> p_nivel_estudio
    select
      @o_ocupacion = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'ocupacion'
    --  Ocupación 004 Independiente  -> en_concordato

    -- telefono                                                                                            
    select
      @o_prefijo = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'prefijo' --  null,  
    -- origen fondos                                                                                      
    select
      @o_producto = valor
    from   cl_catalogo with (nolock)
    where  tabla  = @w_tabla
       and codigo = 'producto' --  'MIS' 

  end

  ------------------  VARIABLES DEL ARCHIVO PLANO -------------------------------
  if @i_operacion = 'A'
  begin
    select
      @o_oficina = mc_ofi,
      @o_nombre = upper(mc_nombre),
      @o_p_apellido = upper(mc_p_apellido),
      @o_s_apellido = upper(mc_s_apellido),
      @o_sexo = mc_sexo,
      @o_fecha_nac = mc_fecha_nac,
      @o_ciudad_nac = mc_ciudad_nac,
      @o_lugar_doc = mc_lugar_doc,
      -- Ciudad de donde es el documento de identidad
      @o_estado_civil = mc_estado_civil,
      @o_actividad = mc_actividad,-- Relacionado con catalogo cl_actividad
      @o_fecha_emision = mc_fecha_emision,
      @o_sector = mc_sector,
      @o_tipo_productor = mc_tipo_productor,
      @o_regimen_fiscal = mc_regimen_fiscal,
      @o_antiguedad = mc_antiguedad,
      @o_estrato = mc_estrato,
      @o_recurso_pub = mc_recurso_pub,
      @o_influencia = mc_influencia,
      @o_persona_pub = mc_persona_pub,
      @o_victima = mc_victima,
      --Dir
      @o_descripcion = upper(mc_descripcion),
      @o_tipo_dir = mc_tipo,
      -- 002-RESIDENCIA 003-EMPRESA  011-NEGOCIO             
      @o_principal = mc_principal,
      @o_ciudad_dir = mc_ciudad,
      @o_rural_urb = mc_rural_urb,-- Urbana    Rural             
      --Tel
      @o_valor_tel = mc_valor,
      @o_tipo_telefono = mc_tipo_telefono,-- C-celular  D-directo             
      --Orig. Fondos
      @o_origen_fondos = upper(mc_origen_fondos),
      --Merc. Objetivo
      @o_mercado_objetivo = mc_mercado_objetivo,-- Urbana Rural             
      @o_subtipo_mo = mc_subtipo_mo,
      -- 002-Servicios Catalogo: cl_subtipo_mercado  relacionado con tabla cl_asociacion_actividad
      @o_actividad_mer_obj = mc_actividad,
      -- Se toma la misma actividad que se ingresa para el cliente. Referencia tabla cl_asociacion_actividad, segun el tipo de persona
      @o_banca = mc_banca,-- Microempresa             
      @o_segmento = mc_segmento,-- Formacion             
      @o_subsegmento = mc_subsegmento -- Por definir             
    from   cl_msv_crear with (nolock)
    where  mc_id_carga   = @i_id_carga
       and mc_id_Alianza = @i_id_alianza
       and mc_cedula     = @i_ced_ruc
       and mc_tipo_ced   = @i_tipo_ced

    if @@rowcount = 0
    begin
      select
        @o_error_ext = 1
      select
        @o_retorno_ext = 'NO SE ENCONTRO INF. PARA CARGAR CLIENTE. Carga: ' +
                         cast
                         (
                                                     @i_id_carga as
                                                     varchar )
                         + ', Alianza: ' + cast(@i_id_alianza as varchar) +
                         ', Ced: '
                         +
                                                     @i_ced_ruc + ', TipoId: '
                         + @i_tipo_ced
      return 1
    end

    /*
       select @o_oficina              = 4030
       select @o_nombre               = 'Pedro'    
       select @o_p_apellido           = 'Jaramillo'    
       select @o_s_apellido           = 'Perez'   
       select @o_sexo                 = 'M'
       select @o_fecha_nac            = '01/01/1975'
       --   select @o_tipo_ced             = 'CC'
       --   select @o_ced_ruc              = '79248321'
       select @o_ciudad_nac           = 11001 
       select @o_lugar_doc            = 11010                 -- Ciudad de donde es el documento de identidad
       select @o_estado_civil         = 'SO' 
       select @o_actividad            = '001000'
       select @o_fecha_emision        = '01/01/1998'
       select @o_sector               = '000010'               -- 000010 - OTRAS CLASIFICACIONES
       select @o_tipo_productor       = '000'         
       select @o_regimen_fiscal       = '0003'       
       select @o_antiguedad           = 10                      -- ANTIGUEDAD EN MESES lo minimo es 6 meses
       select @o_estrato              = '03'           
       select @o_recurso_pub          = null           
       select @o_influencia           = null           
       select @o_persona_pub          = null           
       select @o_victima              = null            
       --Dir
       select @o_descripcion          = 'AV 99 O 999 99 IN 99878..'             
       select @o_tipo_dir             = '002'                   -- 002-RESIDENCIA 003-EMPRESA  011-NEGOCIO=Solo puede quedar con 1 dir de estas....             
       select @o_principal            = 'S'
       select @o_ciudad_dir           = 11001             
       select @o_rural_urb            = 'U'                     -- Urbana    Rural             
       --Tel
       select @o_valor_tel            = '3103695349'             
       select @o_tipo_telefono        = 'C'                     -- C-celular  D-directo             
       --Orig. Fondos
       select @o_origen_fondos        = 'TRABAJADOOoOoOoOoOoOoO'             
       --Merc. Objetivo
       select @o_mercado_objetivo     = 'U'            -- Urbana Rural             
       select @o_subtipo_mo           = '002'          -- 002-Servicios Catalogo: cl_subtipo_mercado, relacionado con tabla cl_asociacion_actividad
       select @o_actividad_mer_obj    = '001000'       -- Referencia tabla cl_asociacion_actividad, segun el tipo de persona
       select @o_banca                = '1'            -- Microempresa             
       select @o_segmento             = '01'           -- Formacion             
       select @o_subsegmento          = '001'          -- Por definir             
    */

    if @w_quitar_caract_rar = 'S' -- Quitar caracteres raros
    begin
      select
        @o_nombre = replace(@o_nombre,
                            char(c.codigo),
                            char(c.valor))
      from   cobis..cl_catalogo c,
             cobis..cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      select
        @o_p_apellido = replace(@o_p_apellido,
                                char(c.codigo),
                                char(c.valor))
      from   cobis..cl_catalogo c,
             cobis..cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      select
        @o_s_apellido = replace(@o_s_apellido,
                                char(c.codigo),
                                char(c.valor))
      from   cobis..cl_catalogo c,
             cobis..cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      select
        @o_descripcion = replace(@o_descripcion,
                                 char(c.codigo),
                                 char(c.valor))
      from   cobis..cl_catalogo c,
             cobis..cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'
    end
  end

  return 0

go

