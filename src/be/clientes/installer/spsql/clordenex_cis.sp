/************************************************************************/
/*  Archivo:            clordenex_cis.sp                                */
/*  Stored procedure:   sp_orden_consulta_cis                           */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:       Andres Diab - Carlos Hernandez                  */
/*  Fecha de escritura: 12/Ene/2012                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Realizar el manejo de las peticiones y respuestas de consulta a     */
/*  servicios externos como Georeferenciador                            */
/*  Catalogo 'cl_tipo_consulta_ext'                                     */
/*  @i_tconsulta = 07 GEOREFERENCIADOR (dat.personales)                 */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR                    RAZON                        */
/* 12/01/2012     A. Diab - C. Hernandez   REQ-232 Paquete 3            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if object_id('sp_orden_consulta_cis') is not null
  drop proc sp_orden_consulta_cis
go

create proc sp_orden_consulta_cis
  @s_user          login = null,
  @s_ofi           smallint = null,
  @s_date          datetime = null,
  @s_ssn           int = null,
  @s_term          descripcion = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_trn           int = null,
  @t_show_version  bit = 0,
  @i_user          login = null,
  @i_ofi           smallint = null,
  @i_modo          char(1) = null,
  @i_tipo_ced      char(2) = null,
  @i_ced_ruc       numero = null,
  @i_p_apellido    varchar(16) = null,
  @i_ente          int = null,
  @i_batch         char(1) = 'N',--MAL02222012
  @i_tconsulta     varchar(10) = null,
  @i_orden         int = null,
  @i_observacion   varchar(255) = null,-- GAL 30/AGO/2010 - ORD. SER. 000057
  @i_tramite       int = null,-- GAL 22/ABR/2010 - REQ 132: GESTOR MIR
  @i_motivo        varchar(10) = '24',
  @i_cuenta        cuenta = null,--CEH 05/MAR/2012 - REQ 315: GMF
  @i_exenta        tinyint = null,--CEH 05/MAR/2012 - REQ 315: GMF
  @i_fec_marcacion datetime = null,
  @o_orden         int = null out,
  @o_respuesta     char(1) = null out,
  @o_msg           varchar(255) = null out,
  @o_sec_error     int = null out --CEH 05/MAR/2012 - REQ 315: GMF

as
  declare
    @w_return                int,
    @w_error                 int,
    @w_sp_name               varchar(32),
    @w_rowcount              int,
    @w_tipo_ced              char(2),
    @w_ced_ruc               numero,
    @w_p_apellido            varchar(16),
    @w_orden                 int,
    @w_tconsulta             catalogo,
    @w_fecha_real_resp       datetime,
    @w_vig_datos_pers        smallint,
    @w_vig_datos_fina        smallint,
    @w_ente                  int,
    @w_tipo_ced_ext          catalogo,
    @w_exenta                varchar(10),
    @w_fecha_aper            datetime,
    @w_fecha_crea            datetime,
    @w_fecha_corte           datetime,
    @w_fecha_ini_marca       varchar(10),
    @w_fecha_fin_marca       varchar(10),
    @w_usa_fecha_real        char(1),
    @w_nombre                varchar(30),
    @w_estado_cta            char(2),
    @w_xml                   xml,
    @w_version_xml           tinyint,
    @w_comando               varchar(255),
    @w_producto              tinyint,
    @w_intento               tinyint,
    @w_mx_intentos_cext      tinyint,
    @w_mx_intent_cons_ext    tinyint,
    @w_est_consulta          varchar(10),
    @w_est_id                varchar(50),
    @w_mensaje               varchar(2000),
    @w_fecha_proceso         datetime,
    @w_fecha_error           datetime,
    @w_modo                  varchar(10),
    @w_estado                char(3),
    @w_tipo_cuenta           char(2),
    @w_motivo_consulta       tinyint,
    @w_direccion             varchar(254),
    @w_telefono              varchar(20),
    @w_ciudad                int,
    @w_ciudad_desc           varchar(50),
    @w_oficina               smallint,
    @w_depto_cliente         varchar(50),
    @w_dig_doc_dc            tinyint,
    @w_fecha_hora_real       datetime,
    @w_fecha_real_error      datetime,
    @w_sec_ejec              int,
    @w_tramite               int,
    @w_reintento             char(1),
    @w_user                  login,
    @w_mx_intent_cons_ext_gm tinyint,
    -- INI CIFIN
    @w_vig_datos_pers_cf     smallint,
    @w_vig_datos_fina_cf     smallint,
    @w_central               smallint,
    @w_version_xml_cf        tinyint,
    @w_mx_intent_cons_ext_cf tinyint,
    -- FIN CIFIN
    @w_max_espera_cr         int,
    -- GAL 02/JUL/2010 - VERSION UNIFICADA PAQ 2 Y PAQ 3
    @w_activa_req_paq3       char(1),
    -- GAL 21/JUL/2010 - VERSION UNIFICADA PAQ 2 Y PAQ 3
    @w_vig_datos             smallint,
    -- GAL 19/AGO/2010 - VERSION UNIFICADA PAQ 2 Y PAQ 3
    @w_sec_error             smallint,
    -- GAL 31/AGO/2010 - VERSION UNIFICADA PAQ 2 Y PAQ 3
    @w_activa_req_paq2       char(1),
    -- GAL 13/SEP/2010 - VERSION UNIFICADA PAQ 2 Y PAQ 3
    @w_ced_ruc_env           numero,
    -- GAL 15/SEP/2010 - VERSION UNIFICADA PAQ 2 Y PAQ 3
    @w_trama_error           char(1),-- GAL 18/NOV/2010 - REQ 108 - CIFIN
    @w_msg                   varchar(255),
    @wo_codigo               varchar(3000),
    @wo_mensaje              varchar(300),
    @w_respuesta             char(1),
    @w_debug_ws              char(1),
    -- ADI: PARAMETRO DE MONITOREO PARA WEB SERVICES
    @w_error_prueba          int,
    @wo_usuario              varchar(50),
    @wo_password             varchar(50),
    @w_usergeo               varchar(30),
    -- ADI: PARAMETRO USUARIO CTS-GEORREFERENCIADOR
    @w_rolgeo                tinyint,--MARCAR/DESMARCAR GMF
    @w_rol                   tinyint,
    @w_usuario               varchar(14),
    /********  MIGRACION CTS  **************/
    @w_version_cts_trn       varchar(30),
    @w_version_cts_base      varchar(30)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Parametro de version base cts
  select
    @w_version_cts_base = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'VCTSB'

  if @w_version_cts_base is null
  begin
    select
      @w_error = 101077 -- No existe parámetro
    goto ERROR
  end

/**************/
/* PARAMETROS */
  /**************/
  select
    @w_sp_name = 'sp_orden_consulta_cis',
    @w_error = 0,
    @w_mensaje = '',
    @w_fecha_hora_real = getdate(),
    @w_reintento = 'N',
    @s_user = isnull(@s_user,
                     @i_user),
    @s_ofi = isnull(@s_ofi,
                    @i_ofi),
    @w_ciudad = 0,
    @w_ciudad_desc = '',
    @w_direccion = '',
    @w_telefono = '',
    @w_depto_cliente = '',
    @w_dig_doc_dc = 11

  select
    @w_usuario = pa_char,
    @w_rol = pa_tinyint
  from   cobis..cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'URGEO'

  --VARIABLES MASCARA OBLIGATORIAS
  select
    @wo_codigo = replicate('X',
                           3000)
  select
    @wo_mensaje = replicate('X',
                            300)

  if @s_date is null
  begin
    select
      @w_fecha_proceso = fp_fecha
    from   ba_fecha_proceso
  end
  else
  begin
    select
      @w_fecha_proceso = @s_date
  end

  select
    @w_producto = pd_producto
  from   cl_producto
  where  pd_abreviatura = 'MIS'

  if @@rowcount = 0
  begin
    select
      @w_error = 101032,
      @w_sec_error = 5
    goto ERROR
  end

  select
    @w_usa_fecha_real = pa_char
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'FECGMF'

  -- INI PARAMETROS DATACREDITO

  select
    @w_vig_datos_pers = pa_smallint -- VIGENCIA DATOS PERSONALES DATACREDITO
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'VIDPDC'

  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_sec_error = 10
    goto ERROR
  end

  select
    @w_vig_datos_fina = pa_smallint -- VIGENCIA DATOS FINANCIEROS DATACREDITO
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'VIDFDC'

  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_sec_error = 15
    goto ERROR
  end

  select
    @w_version_xml = pa_tinyint -- VERSION XML DATACREDITO
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'VXMLDC'

  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_sec_error = 20
    goto ERROR
  end

  select
    @w_mx_intent_cons_ext = pa_tinyint
  -- MAXIMO NUMERO DE REINTENTOS AUTOMATICOS DE CONSULTA DATACREDITO
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'MXINDC'

  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_sec_error = 25
    goto ERROR
  end

  -- FIN PARAMETROS DATACREDITO

  -- INI PARAMETROS CIFIN
  if @w_activa_req_paq3 = 'S'
  begin
    select
      @w_vig_datos_pers_cf = pa_smallint -- VIGENCIA DATOS PERSONALES CIFIN
    from   cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'VIDPCF'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077,
        @w_sec_error = 30
      goto ERROR
    end

    select
      @w_vig_datos_fina_cf = pa_smallint -- VIGENCIA DATOS FINANCIEROS CIFIN
    from   cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'VIDFCF'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077,
        @w_sec_error = 35
      goto ERROR
    end

    select
      @w_version_xml_cf = pa_tinyint -- VERSION XML CIFIN
    from   cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'VXMLCF'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077,
        @w_sec_error = 40
      goto ERROR
    end

    select
      @w_mx_intent_cons_ext_cf = pa_tinyint
    -- MAXIMO NUMERO DE REINTENTOS AUTOMATICOS DE CONSULTA CIFIN
    from   cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'MXINCF'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077,
        @w_sec_error = 45
      goto ERROR
    end
  end
  -- FIN PARAMETROS CIFIN

  -- INI PARAMETROS GESTOR MIR

  if @w_activa_req_paq2 = 'S'
  begin
    select
      @w_mx_intent_cons_ext_gm = pa_tinyint
    -- MAXIMO NUMERO DE REINTENTOS AUTOMATICOS DE CONSULTA GESTOR MIR
    from   cl_parametro
    where  pa_producto = 'CRE'
       and pa_nemonico = 'MXINMI'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077,
        @w_sec_error = 50
      goto ERROR
    end
  end

  -- FIN PARAMETROS GESTOR MIR

  select
    @w_max_espera_cr = pa_int
  -- MAXIMO TIEMPO DE ESPERA (EN MINUTOS) EN RESPUESTA DE UNA CONSULTA A CENTRAL DE RIESGO
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'TMXPOR'

  if @@rowcount = 0
  begin
    select
      @w_error = 101077,
      @w_sec_error = 55
    goto ERROR
  end

/***********************************/
/* INGRESO DE LA ORDEN DE CONSULTA */
  /***********************************/

  if @i_modo = 'I'
  begin
    /* VALIDACIONES */
    if @i_tconsulta in ('01', '02') -- DATACREDITO
    begin
      -- DETERMINACION DE TIPO Y NUMERO DE DOCUMENTO DEL CLIENTE (ELEMENTOS DE TRABAJO)
      if @i_ente is not null
      begin
        select
          @w_tipo_ced = en_tipo_ced,
          @w_ced_ruc = en_ced_ruc,
          @w_p_apellido = isnull(p_p_apellido,
                                 '')
        from   cl_ente
        where  en_ente = @i_ente
      end
      else
      begin
        select
          @w_tipo_ced = @i_tipo_ced,
          @w_ced_ruc = @i_ced_ruc,
          @w_p_apellido = isnull(@i_p_apellido,
                                 '')
      end

      if nullif(rtrim(ltrim(@w_tipo_ced)),
                '') is null
          or nullif(rtrim(ltrim(@w_ced_ruc)),
                    '') is null
      begin
        select
          @w_error = 107200,
          @w_sec_error = 100
        goto ERROR
      end

      select
        @w_ced_ruc = right(replicate('0', @w_dig_doc_dc) + rtrim(ltrim(
                           @w_ced_ruc
                           )
                           )
                     ,
                           @w_dig_doc_dc)
    -- ENMASCARADO DEL NUMERO DE DOCUMENTO A LA CANTIDAD DE DIGITOS ESTANDAR DE DATACREDITO

    end

    if @i_tconsulta in ('03', '04') -- CIFIN
    begin
      -- DETERMINACION DE TIPO Y NUMERO DE DOCUMENTO DEL CLIENTE (ELEMENTOS DE TRABAJO)
      if @i_ente is not null
      begin
        select
          @w_tipo_ced = en_tipo_ced,
          @w_ced_ruc = en_ced_ruc
        from   cl_ente
        where  en_ente = @i_ente
      end
      else
      begin
        select
          @w_tipo_ced = @i_tipo_ced,
          @w_ced_ruc = @i_ced_ruc
      end

      if nullif(rtrim(ltrim(@w_tipo_ced)),
                '') is null
          or nullif(rtrim(ltrim(@w_ced_ruc)),
                    '') is null
      begin
        select
          @w_error = 107200,
          @w_sec_error = 105
        goto ERROR
      end
    end

    if @i_tconsulta = '05'
    begin
      if @i_tramite is null
      begin
        select
          @w_error = 107201,
          @w_sec_error = 110
        goto ERROR
      end

      select
        @w_tipo_ced = 'TR',
        @w_ced_ruc = convert(varchar(30), @i_tramite)
    end

    if @i_tconsulta in ('08') -- GMF
    begin
      select
        @w_ente = ah_cliente,
        @w_fecha_aper = ah_fecha_aper,
        @w_fecha_corte = ah_fecha_ult_corte,
        @w_nombre = replace(replace(replace(ah_nombre,
                                            '¾',
                                            'N'),
                                    '¥',
                                    'N'),
                            '¤',
                            'n'),
        @w_estado_cta = ah_estado,
        @w_tipo_cuenta = case ah_ctitularidad
                           when 'I' then '03'
                           when 'M' then '02'
                         end,
        @w_oficina = ah_oficina,
        @w_tipo_ced = en_tipo_ced,
        @w_ced_ruc = en_ced_ruc
      from   cob_ahorros..ah_cuenta,
             cl_ente
      where  ah_cta_banco = @i_cuenta
         and en_ente      = ah_cliente

      select
        @w_ciudad = ci_ciudad,
        @w_ciudad_desc = replace(replace(replace(ci_descripcion,
                                                 '¾',
                                                 'N'),
                                         '¥',
                                         'N'),
                                 '¤',
                                 'n'),
        @w_direccion = replace(replace(replace(di_descripcion,
                                               '¾',
                                               'N'),
                                       '¥',
                                       'N'),
                               '¤',
                               'n'),
        @w_telefono = (select
                         te_valor
                       from   cobis..cl_telefono
                       where  te_direccion  = 1
                          and te_secuencial = 1
                          and te_ente       = @w_ente)
      from   cl_ente,
             cl_direccion,
             cl_ciudad
      where  en_ente      = @w_ente
         and en_ente      = di_ente
         and di_principal = 'S'
         and ci_ciudad    = di_ciudad

      select
        @w_depto_cliente = replace(replace(replace(pv_descripcion,
                                                   '¾',
                                                   'N'),
                                           '¥',
                                           'N'),
                                   '¤',
                                   'n')
      from   cl_provincia,
             cl_ciudad
      where  ci_ciudad    = @w_ciudad
         and ci_provincia = pv_provincia

      --Reemplazar en las variables con descripciones, caracteres extraÏos

      /*@w_nombre*/
      select
        @w_nombre = replace(@w_nombre,
                            char(c.codigo),
                            char(c.valor))
      from   cobis..cl_catalogo c,
             cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      /*@w_ciudad_desc*/
      select
        @w_ciudad_desc = replace(@w_ciudad_desc,
                                 char(c.codigo),
                                 char(c.valor))
      from   cobis..cl_catalogo c,
             cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      /*@w_direccion*/
      select
        @w_direccion = replace(@w_direccion,
                               char(c.codigo),
                               char(c.valor))
      from   cobis..cl_catalogo c,
             cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      /*@w_depto_cliente*/
      select
        @w_depto_cliente = replace(@w_depto_cliente,
                                   char(c.codigo),
                                   char(c.valor))
      from   cobis..cl_catalogo c,
             cl_tabla t
      where  t.codigo = c.tabla
         and t.tabla  = 'cl_conv_ascii'

      select
        @w_motivo_consulta = 20

      if @w_usa_fecha_real = 'S'
        select
          @w_fecha_proceso = getdate()

      if @i_exenta = 1
      begin
        if exists (select
                     1
                   from   cl_catalogo c,
                          cl_tabla t
                   where  t.codigo = c.tabla
                      and t.tabla  = 'ah_estados_marcacion_gmf'
                      and c.codigo = @w_estado_cta)
        begin
          select
            @w_estado_cta = '01'
          select
            @w_fecha_ini_marca = convert(varchar(10), @w_fecha_proceso, 103),
            @w_exenta = 'TRUE'
        end
        else
        begin
          select
            @w_error = 251131,
            @w_sec_error = 115
          goto ERROR
        end
      end
      else
      begin
        if exists (select
                     1
                   from   cl_catalogo c,
                          cl_tabla t
                   where  t.codigo = c.tabla
                      and t.tabla  = 'ah_estados_desmarcacion_gmf'
                      and c.codigo = @w_estado_cta)
        begin
          select
            @w_estado_cta = '01',
            @w_exenta = 'FALSE'
          select
            @w_fecha_fin_marca = convert(varchar(10), @w_fecha_proceso, 103)
          select
            @w_fecha_ini_marca = convert(varchar(10), eg_fecha_marca, 103)
          from   cob_ahorros..ah_exenta_gmf
          where  eg_cta_banco = @i_cuenta
        end
        else
        begin
          select
            @w_error = 251132,
            @w_sec_error = 120
          goto ERROR
        end
      end

    end

    /* REVISION DE ORDEN EXISTENTE (RESPONDIDA O NO) */

    if @i_tconsulta in ('01', '02')
    begin
      set rowcount 1

      select
        @w_orden = oc_secuencial,
        @w_tconsulta = oc_tconsulta,
        @w_fecha_real_resp = oc_fecha_real_resp,
        @w_estado = oc_estado,
        @w_sec_ejec = oc_sec_ejec
      from   cl_orden_consulta_ext
      where  oc_tipo_ced   = @w_tipo_ced
         and oc_ced_ruc    = @w_ced_ruc
         and oc_p_apellido = @w_p_apellido
         and oc_tconsulta  = @i_tconsulta
         and oc_estado in ('ING', 'XRE', 'PRO')
      order  by isnull(oc_fecha_real_resp,
                       dateadd(dd,
                               1,
                               @w_fecha_hora_real)) desc,
                oc_fecha_real_ing desc

      select
        @w_rowcount = @@rowcount

      set rowcount 0

    end

    -- INICIO - GAL 18/JUN/2010 - REQ 132: GESTOR MIR / REQ 108: CIFIN

    if @i_tconsulta in ('03', '04', '05')
    begin
      set rowcount 1

      select
        @w_orden = oc_secuencial,
        @w_tconsulta = oc_tconsulta,
        @w_fecha_real_resp = oc_fecha_real_resp,
        @w_estado = oc_estado,
        @w_sec_ejec = oc_sec_ejec
      from   cl_orden_consulta_ext
      where  oc_tipo_ced  = @w_tipo_ced
         and oc_ced_ruc   = @w_ced_ruc
         and oc_tconsulta = @i_tconsulta
         and oc_estado in ('ING', 'XRE', 'PRO')
      order  by isnull(oc_fecha_real_resp,
                       dateadd(dd,
                               1,
                               @w_fecha_hora_real)) desc,
                oc_fecha_real_ing desc

      select
        @w_rowcount = @@rowcount

      set rowcount 0
    end
    -- FIN - GAL 22/ABR/2010 - REQ 132: GESTOR MIR

    if @i_tconsulta in ('08')
    begin
      set rowcount 1

      select
        @w_orden = oc_secuencial,
        @w_tconsulta = oc_tconsulta,
        @w_fecha_real_resp = oc_fecha_real_resp,
        @w_estado = oc_estado,
        @w_sec_ejec = oc_sec_ejec
      from   cl_orden_consulta_ext
      where  oc_tipo_ced  = @w_tipo_ced
         and oc_ced_ruc   = @w_ced_ruc
         and oc_tconsulta = @i_tconsulta
         and oc_estado in ('ING', 'XRE', 'PRO')
      order  by isnull(oc_fecha_real_resp,
                       dateadd(dd,
                               1,
                               @w_fecha_hora_real)) desc,
                oc_fecha_real_ing desc

      select
        @w_rowcount = @@rowcount

      set rowcount 0
    end

    if @w_tconsulta is null
      select
        @w_tconsulta = @i_tconsulta

    if @w_rowcount = 0
    begin
      select
        @o_orden = @w_orden,
        @o_respuesta = 'N' -- AUN NO SE TIENE RESPUESTA
    end
    else
    begin
      if @w_estado in ('ING', 'XRE')
      begin
        select
          @o_orden = @w_orden,
          @o_respuesta = 'N' -- AUN NO SE TIENE RESPUESTA

        --return 0
        goto CONSUMO

      end
      else
      begin
        if @i_tconsulta = '01'
          -- CONSULTA DE DATOS PERSONALES (PUBLICA) DATACREDITO
          select
            @w_vig_datos = @w_vig_datos_pers
        if @i_tconsulta = '02'
          -- CONSULTA DE HISTORIA CREDITICIA (PRIVADA) DATACREDITO
          select
            @w_vig_datos = @w_vig_datos_fina
        if @i_tconsulta = '03' -- CONSULTA DE DATOS PERSONALES (PUBLICA) CIFIN
          select
            @w_vig_datos = @w_vig_datos_pers_cf
        if @i_tconsulta = '04'
          -- CONSULTA DE HISTORIA CREDITICIA (PRIVADA) CIFIN
          select
            @w_vig_datos = @w_vig_datos_fina_cf

        if dateadd(dd,
                   @w_vig_datos,
                   @w_fecha_real_resp) >= @w_fecha_hora_real
        begin
          select
            @o_orden = @w_orden,
            @o_respuesta = 'S'

          return 0
        end
      end
    end

    begin tran

    save tran reg_solicitud

    -- INSERCION DE LA ORDEN
    insert into cl_orden_consulta_ext
                (oc_tipo_ced,oc_ced_ruc,oc_p_apellido,oc_ente,oc_tconsulta,
                 oc_fecha_ing,oc_usuario,oc_oficina,oc_estado,oc_fecha_real_ing)
    values      ( @w_tipo_ced,@w_ced_ruc,@w_p_apellido,@w_ente,@i_tconsulta,
                  @w_fecha_proceso,@s_user,@s_ofi,'ING',@w_fecha_hora_real)

    if @@error <> 0
    begin
      rollback tran reg_solicitud
      commit tran
      select
        @w_error = 107201,
        @w_sec_error = 125
      goto ERROR
    end

    select
      @o_orden = @@identity,
      @o_respuesta = 'N'

    commit tran

    CONSUMO:

    select
      @w_orden = @o_orden

    -- INI DEFINICION DE CANTIDAD MAXIMA DE REINTENTOS
    if @w_tconsulta in ('01', '02') -- DATACREDITO
      select
        @w_mx_intentos_cext = @w_mx_intent_cons_ext

    if @w_tconsulta in ('03', '04') -- CIFIN
      select
        @w_mx_intentos_cext = @w_mx_intent_cons_ext_cf

    if @w_tconsulta = '05' -- GESTOR MIR
    begin
      select
        @w_mx_intentos_cext = @w_mx_intent_cons_ext_gm
    end

    -- FIN DEFINICION DE CANTIDAD MAXIMA DE REINTENTOS

    /* AJUSTE DE DATOS PARA CONSUMO DE WEB SERVICE */
    if @w_tconsulta in ('01', '02', '03', '04', '08')
    begin
      if @w_tconsulta in ('01', '02')
      begin
        select
          @w_central = 2 -- DATACREDITO

        if @w_tipo_ced in ('N', 'NI')
          select
            @w_ced_ruc_env = '0' + left(rtrim(ltrim(@w_ced_ruc)), len(rtrim(
                             ltrim
                             (
                                                                  @w_ced_ruc )))
                             - 1
                             )
        -- SIN DIGITO DE VERIFICACION
        else
          select
            @w_ced_ruc_env = rtrim(ltrim(@w_ced_ruc))

      end

      if @w_tconsulta in ('03', '04', '08')
      begin
        select
          @w_central = 1 -- CIFIN

        if @w_tipo_ced in ('N', 'NI')
          select
            @w_ced_ruc_env = left(rtrim(ltrim(@w_ced_ruc)),
                                  len(rtrim(ltrim(@w_ced_ruc))) - 1)
        -- SIN DIGITO DE VERIFICACION
        else
          select
            @w_ced_ruc_env = rtrim(ltrim(@w_ced_ruc))
      end

      select
        @w_tipo_ced_ext = eq_codigo
      from   cl_equivalencia_ws
      where  eq_tabla        = 'Tipo id'
         and eq_central      = @w_central
         and eq_equivalencia = @w_tipo_ced

      if @@rowcount = 0
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_estado = 'EEQ'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        select
          @w_error = 107208,
          @w_sec_error = 210
        goto ERROR
      end
    end

    /* BLOQUE DE EJECUCIONES DE CONECTORES CIS PARA CONSUMO DE WEB SERVICES */
    begin try
      if @w_tconsulta = '02'
      -- CONSULTA A DATACREDITO DE HISTORIA CREDITICIA (PRIVADA)
      begin
        select
          @w_version_cts_trn = valor
        from   cobis..cl_catalogo c,
               cobis..cl_tabla t
        where  c.tabla  = t.codigo
           and t.tabla  = 'ws_version_cts'
           and c.codigo = 26512
           and c.estado = 'V'

        if @@rowcount = 0
          select
            @w_version_cts_trn = @w_version_cts_base --Valor por defecto

        if @w_version_cts_trn = @w_version_cts_base
        begin
          exec @w_return = CTSXPSERVER.cob_procesador..sp_cons_datacredito
            @t_trn       = 26512,-- TRANSACCION CTS
            @s_ofi       = 1,-- OFICINA QUE EJECUTA LA TRN
            @s_user      = @w_usuario,-- USUARIO CTS
            @s_rol       = @w_rol,-- ROL USUARIO CTS
            -- VARIABLES DE CONSULTA DEL WEB SERVICE
            @i_xp_tipo   = '2',
            @o_xp_usu    = @wo_usuario out,
            @o_xp_pws    = @wo_password out,
            @i_tipoid    = @w_tipo_ced_ext,
            @i_id        = @w_ced_ruc_env,
            @i_papellido = @w_p_apellido,
            @i_tipo_ced  = @w_tipo_ced,
            @i_cliente   = @i_ente,
            @i_tconsulta = '02',
            @i_orden     = @w_orden,
            @o_xml       = @wo_codigo out,
            @o_mensaje   = @wo_mensaje out
        end
        else
        begin
          exec @w_return = CTSXPSERVER2.cob_procesador..sp_cons_datacredito
            @t_trn       = 26512,-- TRANSACCION CTS
            @s_ofi       = 1,-- OFICINA QUE EJECUTA LA TRN
            @s_user      = @w_usuario,-- USUARIO CTS
            @s_rol       = @w_rol,-- ROL USUARIO CTS
            -- VARIABLES DE CONSULTA DEL WEB SERVICE
            @i_xp_tipo   = '2',
            @o_xp_usu    = @wo_usuario out,
            @o_xp_pws    = @wo_password out,
            @i_tipoid    = @w_tipo_ced_ext,
            @i_id        = @w_ced_ruc_env,
            @i_papellido = @w_p_apellido,
            @i_tipo_ced  = @w_tipo_ced,
            @i_cliente   = @i_ente,
            @i_tconsulta = '02',
            @i_orden     = @w_orden,
            @o_xml       = @wo_codigo out,
            @o_mensaje   = @wo_mensaje out
        end

        if @w_return <> 0
        begin
          select
            @w_error = @w_return,
            @w_sec_error = 215,
            @w_mensaje = 'ERROR CONSUMIENDO DATACREDITO CIS. ' + @wo_mensaje
          goto ERROR
        end
      end

      if @w_tconsulta = '04'
      -- CONSULTA A CIFIN DE HISTORIA CREDITICIA (PRIVADA)
      begin
        select
          @w_version_cts_trn = valor
        from   cobis..cl_catalogo c,
               cobis..cl_tabla t
        where  c.tabla  = t.codigo
           and t.tabla  = 'ws_version_cts'
           and c.codigo = 26511
           and c.estado = 'V'

        if @@rowcount = 0
          select
            @w_version_cts_trn = @w_version_cts_base --Valor por defecto

        if @w_version_cts_trn = @w_version_cts_base
        begin
          exec @w_return = CTSXPSERVER.cob_procesador..sp_cons_cifin
            @t_trn                =26511,
            @s_ofi                =1,
            @s_user               = @w_usuario,-- USUARIO CTS
            @s_rol                = @w_rol,-- ROL USUARIO CTS
            @i_codigoInformacion  = '154',
            @i_motivoConsulta     = @i_motivo,
            @i_tipoIdentificacion = @w_tipo_ced_ext,
            @i_tipo_ced           = @w_tipo_ced,
            @i_ced_ruc            = @w_ced_ruc_env,
            @i_ente               = @i_ente,
            @i_tconsulta          = '04',
            @i_orden              = @w_orden,
            @i_xp_tipo            = 4,
            @o_xp_usu             = @wo_usuario out,
            @o_xp_pws             = @wo_password out,
            @o_xml                = @wo_codigo out,
            @o_mensaje            = @wo_mensaje out
        end
        else
        begin
          exec @w_return = CTSXPSERVER2.cob_procesador..sp_cons_cifin
            @t_trn                =26511,
            @s_ofi                =1,
            @s_user               = @w_usuario,-- USUARIO CTS
            @s_rol                = @w_rol,-- ROL USUARIO CTS
            @i_codigoInformacion  = '154',
            @i_motivoConsulta     = @i_motivo,
            @i_tipoIdentificacion = @w_tipo_ced_ext,
            @i_tipo_ced           = @w_tipo_ced,
            @i_ced_ruc            = @w_ced_ruc_env,
            @i_ente               = @i_ente,
            @i_tconsulta          = '04',
            @i_orden              = @w_orden,
            @i_xp_tipo            = 4,
            @o_xp_usu             = @wo_usuario out,
            @o_xp_pws             = @wo_password out,
            @o_xml                = @wo_codigo out,
            @o_mensaje            = @wo_mensaje out
        end

        if @w_return <> 0
        begin
          select
            @w_error = @w_return,
            @w_sec_error = 215,
            @w_mensaje = 'ERROR CONSUMIENDO CIFIN CIS. ' + @wo_mensaje
          goto ERROR
        end
      end

      -- INICIO - GAL 28/ABR/2010 - REQ 132: GESTOR MIR
      if @w_tconsulta = '05' -- CONSULTA SERVICIO GESTOR MIR
      begin
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'entrada GESTOR MIR(1)')
        end

        select
          @w_tramite = convert(int, @w_ced_ruc)

        exec @w_return = cob_credito..sp_conexion_mir
          @i_orden           = @w_orden,
          @i_tramite         = @w_tramite,
          @i_user            = @w_user,
          @i_fecha_hora_real = @w_fecha_hora_real,
          @o_mensaje         = @w_mensaje out,
          @o_xml             = @w_xml out

        if @w_return <> 0
        begin
          select
            @w_error = @w_return,
            @w_sec_error = 215
        end

        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'salida GESTOR MIR(1)')
        end
      end
      -- FIN - GAL 28/ABR/2010 - REQ 132: GESTOR MIR
      if @w_tconsulta = '08' -- CONSULTA GMF
      begin
        select
          @w_version_cts_trn = valor
        from   cobis..cl_catalogo c,
               cobis..cl_tabla t
        where  c.tabla  = t.codigo
           and t.tabla  = 'ws_version_cts'
           and c.codigo = 26515
           and c.estado = 'V'

        if @@rowcount = 0
          select
            @w_version_cts_trn = @w_version_cts_base --Valor por defecto

        if @w_version_cts_trn = @w_version_cts_base
        begin
          exec @w_return = CTSXPSERVER.cob_procesador..sp_cons_cifin_gmf
            --@i_idsus='79105840',
            --@i_clasus='71KJK',
            @i_codigoInformacion    = 5300,
            @i_esConsulta           = 'N',
            @i_estadoCuenta         = @w_estado_cta,
            @i_exenta               = @i_exenta,
            @i_fechaApertura        = @w_fecha_aper,
            @i_fechaCorte           = @w_fecha_corte,
            @i_fechaFinExencion     = @w_fecha_fin_marca,
            @i_fechaInicioExencion  = @w_fecha_ini_marca,
            @i_motivoConsulta       = @w_motivo_consulta,
            @i_nombre               = @w_nombre,
            @i_numeroCuentaAhorro   = @i_cuenta,
            @i_numeroIdentificacion = @w_ced_ruc_env,
            @i_tipoCuenta           = @w_tipo_cuenta,
            @i_tipoIdentificacion   = @w_tipo_ced_ext,
            @i_tipoResultado        = 1,
            @i_version              = @w_version_xml_cf,
            @i_ciudadEmpresa        = @w_ciudad_desc,
            @i_ciudadCasa           = @w_ciudad_desc,
            @i_codigoSucursal       = @w_oficina,
            @i_departamentoCasa     = @w_depto_cliente,
            @i_departamentoEmpresa  = @w_depto_cliente,
            @i_direccionCasa        = @w_direccion,
            @i_direccionEmpresa     = @w_direccion,
            @i_fechaTerminacion     = '31/12/2015',
            @i_nombreEmpresa        = @w_nombre,
            @i_telefonoCasa         = @w_telefono,
            @i_telefonoEmpresa      = @w_telefono,
            @t_trn                  = 26515,
            @s_ofi                  = 1,
            @s_user                 = @w_usuario,
            @s_rol                  = @w_rol,
            @i_user                 = @w_usuario,
            @i_ofi                  = 4030,
            @i_tipo_ced             = @w_tipo_ced,
            @i_ced_ruc              = @w_ced_ruc,
            @i_p_apellido           = null,
            @i_ente                 = @w_ente,
            @i_tconsulta            = @i_tconsulta,
            @i_orden                = @w_orden,
            @i_xp_tipo              = 4,
            @o_xp_usu               = @wo_usuario out,
            @o_xp_pws               = @wo_password out,
            @o_xml                  = @wo_codigo out,
            @o_mensaje              = @wo_mensaje out
        end
        else
        begin
          exec @w_return = CTSXPSERVER2.cob_procesador..sp_cons_cifin_gmf
            --@i_idsus='79105840',
            --@i_clasus='71KJK',
            @i_codigoInformacion    = 5300,
            @i_esConsulta           = 'N',
            @i_estadoCuenta         = @w_estado_cta,
            @i_exenta               = @i_exenta,
            @i_fechaApertura        = @w_fecha_aper,
            @i_fechaCorte           = @w_fecha_corte,
            @i_fechaFinExencion     = @w_fecha_fin_marca,
            @i_fechaInicioExencion  = @w_fecha_ini_marca,
            @i_motivoConsulta       = @w_motivo_consulta,
            @i_nombre               = @w_nombre,
            @i_numeroCuentaAhorro   = @i_cuenta,
            @i_numeroIdentificacion = @w_ced_ruc_env,
            @i_tipoCuenta           = @w_tipo_cuenta,
            @i_tipoIdentificacion   = @w_tipo_ced_ext,
            @i_tipoResultado        = 1,
            @i_version              = @w_version_xml_cf,
            @i_ciudadEmpresa        = @w_ciudad_desc,
            @i_ciudadCasa           = @w_ciudad_desc,
            @i_codigoSucursal       = @w_oficina,
            @i_departamentoCasa     = @w_depto_cliente,
            @i_departamentoEmpresa  = @w_depto_cliente,
            @i_direccionCasa        = @w_direccion,
            @i_direccionEmpresa     = @w_direccion,
            @i_fechaTerminacion     = '31/12/2015',
            @i_nombreEmpresa        = @w_nombre,
            @i_telefonoCasa         = @w_telefono,
            @i_telefonoEmpresa      = @w_telefono,
            @t_trn                  = 26515,
            @s_ofi                  = 1,
            @s_user                 = @w_usuario,
            @s_rol                  = @w_rol,
            @i_user                 = @w_usuario,
            @i_ofi                  = 4030,
            @i_tipo_ced             = @w_tipo_ced,
            @i_ced_ruc              = @w_ced_ruc,
            @i_p_apellido           = null,
            @i_ente                 = @w_ente,
            @i_tconsulta            = @i_tconsulta,
            @i_orden                = @w_orden,
            @i_xp_tipo              = 4,
            @o_xp_usu               = @wo_usuario out,
            @o_xp_pws               = @wo_password out,
            @o_xml                  = @wo_codigo out,
            @o_mensaje              = @wo_mensaje out
        end

        if @w_return <> 0
        begin
          select
            @w_error = @w_return,
            @w_sec_error = 215,
            @w_mensaje = 'ERROR CONSUMIENDO CIFIN GMF. ' + @wo_mensaje
          goto ERROR
        end

        select
          @wo_codigo  'Respuesta',
          @wo_mensaje 'Mensaje'

      end

    end try
    begin catch
      select
        @w_error = @w_return,
        @w_mensaje = error_message()
      goto ERROR
    end catch

  /* FIN - BLOQUE DE EJECUCIONES DE CONECTORES CIS */

  end

/*******************************************/
/* ENVIO DE LA SOLICITUD A ENTIDAD EXTERNA */
  /*******************************************/

  if @i_modo = 'E'
  begin
    select
      @w_tconsulta = @i_tconsulta,
      @w_orden = @i_orden

    if @i_orden is null
    begin
      set rowcount 1

      select
        @w_orden = oc_secuencial,
        @w_tconsulta = oc_tconsulta,
        @w_tipo_ced = oc_tipo_ced,
        @w_ced_ruc = oc_ced_ruc,
        @w_ente = oc_ente,
        @w_intento = oc_intentos,
        @w_sec_ejec = oc_sec_ejec,
        @w_user = oc_usuario
      from   cl_orden_consulta_ext with (nolock)
      where  oc_estado in ('ING', 'XRE')
         and oc_tconsulta = @i_tconsulta
      order  by isnull(oc_intentos,
                       0),
                oc_secuencial

      select
        @w_rowcount = @@rowcount

      set rowcount 0

      if @w_rowcount = 0
        return 0
    end
    else
    begin
      select
        @w_orden = oc_secuencial,
        @w_tconsulta = oc_tconsulta,
        @w_tipo_ced = oc_tipo_ced,
        @w_ced_ruc = oc_ced_ruc,
        @w_p_apellido = oc_p_apellido,
        @w_ente = oc_ente,
        @w_intento = oc_intentos,
        @w_sec_ejec = oc_sec_ejec,
        @w_user = oc_usuario
      from   cl_orden_consulta_ext with (nolock)
      where  oc_secuencial = @i_orden
         and oc_tconsulta  = @i_tconsulta
         and oc_estado in ('ING', 'XRE')

      if @@rowcount > 0
      begin
        select
          @w_error = 2600105,
          @w_sec_error = 200,
          @w_orden = @i_orden,
          @w_modo = 'E-INT:0'
        goto ERROR
      end
    end

    begin tran

    select
      @w_fecha_hora_real = getdate()
    -- REGISTRO DE HORA POSTERIOR A LA RESPUESTA DEL WS

    select
      @w_modo = @i_modo + '-INT:' + convert(varchar(2), isnull(@w_intento, 0) +
                1)
      ,
      @w_estado = 'PRO' -- POR DEFAULT LA CONSULTA EXITOSA AL WS ES PROCESADA

    save tran rta_solicitud

    select
      @w_xml = in_trama_xml
    from   cobis..cl_informacion_ext with (nolock)
    where  in_orden     = @i_orden
       and in_tconsulta = @i_tconsulta

    if @w_xml is null
        or @w_error <> 0
    begin
      if @w_error = 0
      begin
        select
          @w_fecha_error = @w_fecha_proceso,
          @w_fecha_real_error = @w_fecha_hora_real
      end
      else
      begin
        select
          @w_fecha_error = null,
          @w_fecha_real_error = null
      end

      if isnull(@w_intento, 0) + 1 >= @w_mx_intentos_cext
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_fecha_resp = @w_fecha_error,
               oc_intentos = isnull(@w_intento, 0) + 1,
               oc_estado = 'ERE',
               oc_fecha_real_resp = @w_fecha_real_error
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107207,
            @w_sec_error = 220
          goto ERROR
        end
      end
      else
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_intentos = isnull(@w_intento, 0) + 1,
               oc_estado = 'XRE'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107207,
            @w_sec_error = 225
          goto ERROR
        end

        update cl_orden_consulta_ext with (rowlock)
        set    oc_sec_ejec = @@identity
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107207,
            @w_sec_error = 235
          goto ERROR
        end

      end

      commit tran

      if @w_sec_error is null
        select
          @w_sec_error = 240
      goto ERROR
    end

    -- CONSULTA DE LA RESPUESTA DE DATACREDITO
    if @w_tconsulta in ('01', '02')
    begin
      if @w_debug_ws = 'S'
      begin
        insert into reloj_ws with(rowlock)
        values      (@w_orden,getdate(),'entrada RESPUESTA DATACREDITO(1)')
      end

      exec @w_return = sp_consultar_xml
        @i_xml          = @w_xml,
        @i_tquery       = '00',-- TIPO DE RESPUESTA Y ESTADO DEL DOCUMENTO
        @i_central      = '2',
        @o_est_consulta = @w_est_consulta out,
        @o_est_id       = @w_est_id out

      if @w_return <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'error RESPUESTA DATACREDITO(E)')
        end
        select
          @w_error = @w_return,
          @w_sec_error = 245
        goto ERROR
      end

      if rtrim(ltrim(@w_est_consulta)) = '23'
        -- ESTADO QUE SOLICITA REINTENTO PARA DATACREDITO
        select
          @w_reintento = 'S'
      else
        select
          @w_reintento = 'N'

      if @w_debug_ws = 'S'
      begin
        insert into reloj_ws with(rowlock)
        values      (@w_orden,getdate(),'salida RESPUESTA DATACREDITO(1)')
      end

      update cl_informacion_ext with(rowlock)
      set    in_version_xml = 1,
             in_respuesta_con = @w_est_consulta,
             in_estado_doc = @w_est_id
      where  in_orden     = @w_orden
         and in_tconsulta = @w_tconsulta
      if @@error <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'error RESPUESTA DATACREDITO(E)')
        end
        select
          @w_error = @w_return,
          @w_sec_error = 246,
          @w_mensaje = 'ERROR ACTUALIZANDO ESTADO DOCUMENTO DATACREDITO.ORDEN: '
                       + convert(varchar, @w_orden)
        goto ERROR
      end
    end

    -- CONSULTA DE LA RESPUESTA DE CIFIN
    if @w_tconsulta in ('03', '04')
    begin
      if @w_debug_ws = 'S'
      begin
        insert into reloj_ws with(rowlock)
        values      (@w_orden,getdate(),'entrada RESPUESTA CIFIN(1)')
      end

      exec @w_return = sp_consultar_xml
        @i_xml          = @w_xml,
        @i_tquery       = '00',-- TIPO DE RESPUESTA Y ESTADO DEL DOCUMENTO
        @i_central      = '1',
        @o_est_consulta = @w_est_consulta out,
        @o_est_id       = @w_est_id out,
        @o_trama_error  = @w_trama_error out

      if @w_return <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'error RESPUESTA CIFIN(E)')
        end
        select
          @w_error = @w_return,
          @w_sec_error = 250
        goto ERROR
      end

      if @w_trama_error = 'S'
        select
          @w_estado = 'ETR'
      -- SE ALMACENA LA TRAMA CON DETALLE DEL ERROR PERO SE MARCA LA CONSULTA COMO FALLIDA

      if @w_debug_ws = 'S'
      begin
        insert into reloj_ws with(rowlock)
        values      (@w_orden,getdate(),'salida RESPUESTA CIFIN(1)')
      end

      update cl_informacion_ext with(rowlock)
      set    in_version_xml = 1,
             in_respuesta_con = @w_est_consulta,
             in_estado_doc = @w_est_id
      where  in_orden     = @w_orden
         and in_tconsulta = @w_tconsulta
      if @@error <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        select
          @w_error = @w_return,
          @w_sec_error = 251,
          @w_mensaje = 'ERROR ACTUALIZANDO ESTADO DOCUMENTO CIFIN.ORDEN: ' +
                       convert
                       (
                       varchar,
                       @w_orden)
        goto ERROR
      end
    end

    -- CONSULTA DE LA RESPUESTA MIR
    if @w_tconsulta = '05'
    begin
      if @w_debug_ws = 'S'
      begin
        insert into reloj_ws with(rowlock)
        values      (@w_orden,getdate(),'entrada RESPUESTA GESTOR MIR(1)')
      end

      exec @w_return = sp_consultar_xml
        @i_xml          = @w_xml,
        @i_tquery       = '00',-- DECISION DEL GESTOR Y PD
        @i_central      = '3',
        @o_est_consulta = @w_est_consulta out,
        @o_est_id       = @w_est_id out,
        @o_trama_error  = @w_trama_error out

      if @w_return <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'error RESPUESTA GESTOR MIR(1)')
        end
        select
          @w_error = @w_return,
          @w_sec_error = 252
        goto ERROR
      end

      if @w_trama_error = 'S'
        select
          @w_estado = 'ETR'
      -- SE ALMACENA LA TRAMA CON DETALLE DEL ERROR PERO SE MARCA LA CONSULTA COMO FALLIDA

      if @w_debug_ws = 'S'
      begin
        insert into reloj_ws with(rowlock)
        values      (@w_orden,getdate(),'salida RESPUESTA GESTOR MIR(1)')
      end
    end

    --CONSULTA MARCA/DESMARCA GMF
    if @w_tconsulta in ('08')
    begin
      exec @w_return = sp_consultar_xml
        @i_xml       = @w_xml,
        @i_tquery    = '08',-- TIPO DE RESPUESTA Y ESTADO DEL DOCUMENTO
        @i_central   = '1',
        @o_sec_error = @w_sec_error out

      select
        @o_sec_error = @w_sec_error

      if @w_return <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        select
          @w_error = @w_return,
          @w_sec_error = 250
        goto ERROR
      end

      if @w_trama_error = 'S'
        select
          @w_estado = 'ETR'
    -- SE ALMACENA LA TRAMA CON DETALLE DEL ERROR PERO SE MARCA LA CONSULTA COMO FALLIDA
    end

    if @w_reintento = 'S'
    begin
      if isnull(@w_intento, 0) + 1 >= @w_mx_intentos_cext
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_fecha_resp = @w_fecha_proceso,
               oc_intentos = isnull(@w_intento, 0) + 1,
               oc_estado = 'ERE',
               oc_fecha_real_resp = @w_fecha_hora_real
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107207,
            @w_sec_error = 255
          goto ERROR
        end

        select
          @w_mensaje = 'Maximo numero de reintentos alcanzado'
      end
      else
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_intentos = isnull(@w_intento, 0) + 1,
               oc_estado = 'XRE'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107207,
            @w_sec_error = 260
          goto ERROR
        end

        select
          @w_mensaje = 'Solicitud de reintento de la central'

      end

      commit tran

      select
        @w_error = 107211,
        @w_sec_error = 275
      goto ERROR
    end
    else
    begin
      select
        @w_intento = isnull(@w_intento, 0) + 1

      update cl_orden_consulta_ext with (rowlock)
      set    oc_fecha_resp = @w_fecha_proceso,
             oc_intentos = @w_intento,
             oc_estado = @w_estado,
             oc_fecha_real_resp = @w_fecha_hora_real
      from   cl_orden_consulta_ext with (index = idx1)
      where  oc_secuencial = @w_orden

      if @@error <> 0
      begin
        rollback tran rta_solicitud
        commit tran
        select
          @w_error = 107207,
          @w_sec_error = 295
        goto ERROR
      end
    end

    commit tran

    select
      @o_orden = @w_orden,
      @o_respuesta = 'S'
  end

  return 0

  ERROR:

  if isnull(@w_mensaje,
            '') = ''
    select
      @w_mensaje = mensaje
    from   cl_errores
    where  numero = @w_error

  if @w_sec_error is null
    select
      @w_sec_error = 0

  select
    @w_mensaje = convert(varchar(6), @w_sec_error) + ' - ' + isnull(@w_mensaje,
                 ''
                 )

  select
    @o_msg = left(@w_mensaje,
                  255),
    @o_respuesta = 'N'

  insert into cl_error_logws
              (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
               er_descripcion)
  values      ( @w_fecha_hora_real,@w_error,convert(varchar(14), @w_sec_ejec),
                @w_orden,@w_modo,
                @w_mensaje )

  return @w_error

go

