/************************************************************************/
/*  Archivo:            clordenex.sp                                    */
/*  Stored procedure:   sp_orden_consulta_ext                           */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:       Gabriel Alvis                                   */
/*  Fecha de escritura: 15/Oct/2009                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Realizar el manejo de las peticiones y respuestas de consulta a     */
/*  servicios externos como centrales de riesgo Datacredito/Cifin       */
/*  o evaluacion de riesgo (Gestor MIR)                                 */
/*  Catalogo 'cl_tipo_consulta_ext'                                     */
/*  @i_tconsulta = 01 DATACREDITO (dat.personales)                      */
/*                 02 DATACREDITO (dat.financiero)                      */
/*                 03 CIFIN       (dat.personales)                      */
/*                 04 CIFIN       (dat.financiero)                      */
/*                 05 GESTOR MIR                                        */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR             RAZON                               */
/* 04/30/2010     C.Ballen         REQ-CIFIN                            */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if object_id('sp_orden_consulta_ext') is not null
  drop proc sp_orden_consulta_ext
go

create proc sp_orden_consulta_ext
  @s_user         login = null,
  @s_ofi          smallint = null,
  @s_date         datetime = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_trn          int = null,
  @t_show_version bit = 0,
  @i_user         login = null,
  @i_ofi          smallint = null,
  @i_modo         char(1) = null,
  @i_tipo_ced     char(2) = null,
  @i_ced_ruc      numero = null,
  @i_p_apellido   varchar(16) = null,
  @i_ente         int = null,
  @i_tconsulta    varchar(10) = null,
  @i_orden        int = null,
  @i_frontend     char(1) = 'N',
  @i_observacion  varchar(255) = null,-- GAL 30/AGO/2010 - ORD. SER. 000057
  @i_tramite      int = null,-- GAL 22/ABR/2010 - REQ 132: GESTOR MIR
  @i_motivo       varchar(10) = '24',

  -- GAL 19/AGO/2010 - REQ 108: CIFIN (DEFAULT: OTRO)
  @i_masivo       char(1) = 'N',--REQ440
  @i_diario       int = 1,--REQ440
  @o_orden        int = null out,
  @o_respuesta    char(1) = null out,
  @o_msg          varchar(255) = null out -- GAL 11/ABR/2011 - REQ 216/231

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
    @w_xml                   xml,
    @w_version_xml           tinyint,
    @w_comando               varchar(255),
    @w_producto              tinyint,
    @w_intento               tinyint,
    @w_mx_intent_cons_ext    tinyint,
    @w_est_consulta          varchar(10),
    @w_est_id                varchar(50),
    @w_mensaje               varchar(2000),
    @w_fecha_proceso         datetime,
    @w_fecha_error           datetime,
    @w_modo                  varchar(10),
    @w_estado                char(3),
    @w_dig_doc_dc            tinyint,
    @w_fecha_hora_real       datetime,
    @w_fecha_real_error      datetime,
    @w_sec_ejec              int,
    @w_tramite               int,-- GAL 27/ABR/2010 - REQ 132: GESTOR MIR
    @w_reintento             char(1),-- GAL 30/ABR/2010 - REQ 132: GESTOR MIR
    @w_mx_intent_cons_ext_gm tinyint,-- GAL 24/JUN/2010 - REQ 132: GESTOR MIR
    @w_user                  login,-- GAL 26/AGO/2010 - REQ 132: GESTOR MIR
    -- INI CIFIN
    @w_vig_datos_pers_cf     smallint,
    @w_vig_datos_fina_cf     smallint,
    @w_central               smallint,
    @w_version_xml_cf        tinyint,
    @w_mx_intent_cons_ext_cf tinyint,
    @w_mx_intentos_cext      tinyint,
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
    @w_debug_ws              char(1)
  -- ADI: PARAMETRO DE MONITOREO PARA WEB SERVICES

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/**************/
/* PARAMETROS */
  /**************/
  select
    @w_sp_name = 'sp_orden_consulta_ext',
    @w_error = 0,
    @w_mensaje = '',
    @w_dig_doc_dc = 11,
    -- CANTIDAD DE DIGITOS QUE TIENE TODO DOCUMENTO PARA DATACREDITO
    @w_fecha_hora_real = getdate(),
    @w_reintento = 'N',-- GAL 30/ABR/2010 - REQ 132: GESTOR MIR
    @w_p_apellido = '',
    @s_user = isnull(@s_user,
                     @i_user),
    -- GAL 24/NOV/2010 - LLS 13589: ORDENES SIN ASOCIACION
    @s_ofi = isnull(@s_ofi,
                    @i_ofi)
  -- GAL 24/NOV/2010 - LLS 13589: ORDENES SIN ASOCIACION

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
    @w_debug_ws = pa_char -- VIGENCIA DATOS PERSONALES DATACREDITO
  from   cl_parametro
  where  pa_producto = 'MIS'
     and pa_nemonico = 'DEBWS'

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
  select
    @w_activa_req_paq2 = pa_char
  -- PARAMETRO DE ACTIVACION DE FUNCIONALIDAD PAQUETE 2
  from   cobis..cl_parametro
  where  pa_producto = 'CRE'
     and pa_nemonico = 'ACTRP2'

  if @w_activa_req_paq2 is null
    select
      @w_activa_req_paq2 = 'N'

  select
    @w_activa_req_paq3 = pa_char
  -- PARAMETRO DE ACTIVACION DE FUNCIONALIDAD PAQUETE 3
  from   cobis..cl_parametro
  where  pa_producto = 'CRE'
     and pa_nemonico = 'ACTRP3'

  if @w_activa_req_paq3 is null
    select
      @w_activa_req_paq3 = 'N'

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
         and oc_estado in ('ING', 'XRE', 'PPR', 'PRO')
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
         and oc_estado in ('ING', 'XRE', 'PPR', 'PRO')
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

    if @w_rowcount <> 0
    begin
      if @w_estado in ('ING', 'XRE', 'PPR')
      begin
        if not exists(select
                        1
                      from   ad_proceso_system_op
                      where  ps_id = @w_sec_ejec
                         and ps_estado in ('I', 'P'))
        begin
          select
            @w_comando =
            'SP:cobis..sp_orden_consulta_ext @i_modo = ''E'', @i_orden = '
            + cast(@w_orden as varchar) + ', @i_diario = ' + cast(@i_diario
            as
                   varchar)
            + ', @i_masivo = ''' + cast(@i_masivo as varchar) + ''''

          begin tran

          save tran reproc_solicitud

          insert into ad_proceso_system_op
                      (ps_sec_sinc,ps_cmd,ps_producto,ps_estado,ps_hora_inicio)
          values      ( @w_orden,@w_comando,convert(int, @i_tconsulta),
                        --@w_producto,
                        'I',@w_fecha_hora_real )

          if @@error <> 0
          begin
            rollback tran reproc_solicitud
            commit tran
            select
              @w_error = 107202,
              @w_sec_error = 115
            goto ERROR
          end

          update cl_orden_consulta_ext with (rowlock)
          set    oc_sec_ejec = @@identity
          from   cl_orden_consulta_ext with (index = idx1)
          where  oc_secuencial = @w_orden

          if @@error <> 0
          begin
            rollback tran reproc_solicitud
            commit tran
            select
              @w_error = 107207,
              @w_sec_error = 120
            goto ERROR
          end

          commit tran
        end

        select
          @o_orden = @w_orden,
          @o_respuesta = 'N' -- AUN NO SE TIENE RESPUESTA

        return 0
      end
      else
      begin
        if @w_estado = 'PRO'
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
    end

    begin tran

    save tran reg_solicitud

    -- INSERCION DE LA ORDEN
    insert into cl_orden_consulta_ext
                (oc_tipo_ced,oc_ced_ruc,oc_p_apellido,oc_ente,oc_tconsulta,
                 oc_fecha_ing,oc_usuario,oc_oficina,oc_estado,oc_fecha_real_ing,
                 oc_observacion)
    -- GAL 30/AGO/2010 - ORD. SER. 000057 - oc_observacion
    values      ( @w_tipo_ced,@w_ced_ruc,@w_p_apellido,@i_ente,@i_tconsulta,
                  @w_fecha_proceso,@s_user,@s_ofi,'ING',@w_fecha_hora_real,
                  @i_observacion)
    -- GAL 30/AGO/2010 - ORD. SER. 000057 - @i_observacion

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

    select
      @w_comando =
      'SP:cobis..sp_orden_consulta_ext @i_modo = ''E'', @i_orden = '
      + cast(@o_orden as varchar) + ', @i_diario = ' + cast(@i_diario
      as
                                    varchar)
      + ', @i_masivo = ''' + cast(@i_masivo as varchar) + ''''

    insert into ad_proceso_system_op
                (ps_sec_sinc,ps_cmd,ps_producto,ps_estado,ps_hora_inicio)
    values      ( @o_orden,@w_comando,convert(int, @i_tconsulta),--@w_producto,
                  'I',@w_fecha_hora_real )

    if @@error <> 0
    begin
      rollback tran reg_solicitud
      commit tran
      select
        @w_error = 107202,
        @w_sec_error = 130
      goto ERROR
    end

    update cl_orden_consulta_ext with (rowlock)
    set    oc_sec_ejec = @@identity
    from   cl_orden_consulta_ext with (index = idx1)
    where  oc_secuencial = @o_orden

    if @@error <> 0
    begin
      rollback tran reg_solicitud
      commit tran
      select
        @w_error = 107207,
        @w_sec_error = 135
      goto ERROR
    end

    commit tran
  end

/*******************************/
/* CONSULTA ESTADO DE LA ORDEN */
  /*******************************/

  if @i_modo = 'C'
  begin
    select
      @w_estado = oc_estado,
      @w_tconsulta = oc_tconsulta,
      @w_fecha_real_resp = oc_fecha_real_resp
    from   cl_orden_consulta_ext with (nolock)
    where  oc_secuencial = @i_orden

    if @@rowcount <> 0
    begin
      if left(@w_estado,
              1) = 'E'
        select
          @o_respuesta = 'E' -- ERROR

      if @w_estado = 'PRO'
      begin
        if @w_tconsulta = '01'
          -- CONSULTA DE DATOS PERSONALES (PUBLICA) DATACREDITO
          select
            @w_vig_datos = @w_vig_datos_pers
        if @w_tconsulta = '02'
          -- CONSULTA DE HISTORIA CREDITICIA (PRIVADA) DATACREDITO
          select
            @w_vig_datos = @w_vig_datos_fina
        if @w_tconsulta = '03' -- CONSULTA DE DATOS PERSONALES (PUBLICA) CIFIN
          select
            @w_vig_datos = @w_vig_datos_pers_cf
        if @w_tconsulta = '04'
          -- CONSULTA DE HISTORIA CREDITICIA (PRIVADA) CIFIN
          select
            @w_vig_datos = @w_vig_datos_fina_cf

        if dateadd(dd,
                   @w_vig_datos,
                   @w_fecha_real_resp) >= @w_fecha_hora_real
          select
            @o_respuesta = 'S' -- RESPUESTA VIGENTE
        else
          select
            @o_respuesta = 'F' -- RESPUESTA FUERA DE LA VIGENCIA
      end

      if @w_estado in ('ING', 'XRE', 'PPR')
        select
          @o_respuesta = 'N' -- AUN NO SE TIENE RESPUESTA
    end
    else
      select
        @o_respuesta = 'I' -- ORDEN INEXISTENTE
  end

/*******************************************/
/* ENVIO DE LA SOLICITUD A ENTIDAD EXTERNA */
  /*******************************************/

  if @i_modo = 'E'
  begin
    if @i_orden is null
    begin
      set rowcount 1

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
      where  oc_estado in ('ING', 'XRE', 'PPR')
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
         and oc_estado in ('ING', 'XRE', 'PPR')

      if @@rowcount = 0
      begin
        select
          @w_error = 2600105,
          @w_sec_error = 200,
          @w_orden = @i_orden,
          @w_modo = 'E-INT:0'
        goto ERROR
      end
    end

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

    select
      @w_modo = @i_modo + '-INT:' + convert(varchar(2), isnull(@w_intento, 0) +
                1)
      ,
      @w_estado = 'PRO' -- POR DEFAULT LA CONSULTA EXITOSA AL WS ES PROCESADA

    update cl_orden_consulta_ext with (rowlock)
    set    oc_estado = 'PPR'
    from   cl_orden_consulta_ext with (index = idx1)
    where  oc_secuencial = @w_orden

    if @@error <> 0
    begin
      select
        @w_error = 107207,
        @w_sec_error = 205
      goto ERROR
    end

    -- AJUSTE DE CONDICIONES DE ENVIO
    if @w_tconsulta in ('01', '02', '03', '04')
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

      if @w_tconsulta in ('03', '04')
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

    begin try
      if @w_tconsulta = '01'
      -- CONSULTA A DATACREDITO DE DATOS PERSONALES (PUBLICA)
      begin
        exec cob_wservices..sp_consultar
          @i_tipoid   = @w_tipo_ced_ext,
          @i_id       = @w_ced_ruc_env,
          @i_papelido = @w_p_apellido,
          @o_xml      = @w_xml out
      end

      if @w_tconsulta = '02'
      -- CONSULTA A DATACREDITO DE HISTORIA CREDITICIA (PRIVADA)
      begin
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'entrada DATACREDITO(1)')
        end

        exec cob_wservices..sp_consultarHC
          @i_tipoid   = @w_tipo_ced_ext,
          @i_id       = @w_ced_ruc_env,
          @i_papelido = @w_p_apellido,
          @o_xml      = @w_xml out

        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'salida DATACREDITO(1)')
        end
      end

      if @w_tconsulta = '03' -- CONSULTA A CIFIN DE DATOS PERSONALES (PUBLICA)
      begin
        exec cob_wservices..sp_consultaXml
          @i_tipo_ced = @w_tipo_ced_ext,
          @i_ced_ruc  = @w_ced_ruc_env,
          @i_motivo   = @i_motivo,
          @i_cod_info = '154',
          @o_xml      = @w_xml out
      end

      if @w_tconsulta = '04'
      -- CONSULTA A CIFIN DE HISTORIA CREDITICIA (PRIVADA)
      begin
        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'entrada CIFIN(1)')
        end

        exec cob_wservices..sp_consultaXml
          @i_tipo_ced = @w_tipo_ced_ext,
          @i_ced_ruc  = @w_ced_ruc_env,
          @i_motivo   = @i_motivo,
          @i_cod_info = '154',
          @o_xml      = @w_xml out

        if @w_debug_ws = 'S'
        begin
          insert into reloj_ws with(rowlock)
          values      (@w_orden,getdate(),'salida CIFIN(1)')
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
          @i_masivo          = @i_masivo,--REQ440
          @i_diario          = @i_diario,
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

    end try
    begin catch
      select
        @w_error = @@error,
        @w_mensaje = error_message()
    end catch

    begin tran

    select
      @w_fecha_hora_real = getdate()
    -- REGISTRO DE HORA POSTERIOR A LA RESPUESTA DEL WS

    save tran rta_solicitud

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

        select
          @w_comando =
          'SP:cobis..sp_orden_consulta_ext @i_modo = ''E'', @i_orden = '
          + cast(@w_orden as varchar)

        insert into ad_proceso_system_op
                    (ps_sec_sinc,ps_cmd,ps_producto,ps_estado,ps_hora_inicio)
        values      ( @w_orden,@w_comando,convert(int, @i_tconsulta),
                      --@w_producto,
                      'I',@w_fecha_hora_real)

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107202,
            @w_sec_error = 230
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

      if @w_xml is null
         and @w_error = 0
        select
          @w_error = 107203

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
        values      (@w_orden,getdate(),'salida RESPUESTA DATACREDITO(1)')
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
          @w_comando =
          'SP:cobis..sp_orden_consulta_ext @i_modo = ''E'', @i_orden = '
          + cast(@w_orden as varchar)

        insert into ad_proceso_system_op
                    (ps_sec_sinc,ps_cmd,ps_producto,ps_estado,ps_hora_inicio)
        values      ( @w_orden,@w_comando,convert(int, @i_tconsulta),
                      --@w_producto,
                      'I',@w_fecha_hora_real)

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran
          select
            @w_error = 107202,
            @w_sec_error = 265
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
            @w_sec_error = 270
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
      if exists(select
                  1
                from   cl_informacion_ext
                where  in_tipo_ced  = @w_tipo_ced
                   and in_ced_ruc   = @w_ced_ruc
                   and in_tconsulta = @w_tconsulta)
      begin
        insert into cl_informacion_ext_his
                    (inh_tipo_ced,inh_ced_ruc,inh_ente,inh_tconsulta,inh_fecha,
                     inh_orden,inh_trama_xml,inh_version_xml,inh_respuesta_con,
                     inh_estado_doc,
                     inh_fecha_real)
          select
            in_tipo_ced,in_ced_ruc,in_ente,in_tconsulta,in_fecha,
            in_orden,in_trama_xml,in_version_xml,in_respuesta_con,in_estado_doc,
            in_fecha_real
          from   cl_informacion_ext
          where  in_tipo_ced  = @w_tipo_ced
             and in_ced_ruc   = @w_ced_ruc
             and in_tconsulta = @w_tconsulta

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran

          update cl_orden_consulta_ext with (rowlock)
          set    oc_estado = 'ERH'
          from   cl_orden_consulta_ext with (index = idx1)
          where  oc_secuencial = @w_orden

          select
            @w_error = 107204,
            @w_sec_error = 280
          goto ERROR
        end

        delete cl_informacion_ext with (rowlock)
        from   cl_informacion_ext with (index = idx1)
        where  in_tipo_ced  = @w_tipo_ced
           and in_ced_ruc   = @w_ced_ruc
           and in_tconsulta = @w_tconsulta

        if @@error <> 0
        begin
          rollback tran rta_solicitud
          commit tran

          update cl_orden_consulta_ext with (rowlock)
          set    oc_estado = 'EEH'
          from   cl_orden_consulta_ext with (index = idx1)
          where  oc_secuencial = @w_orden

          select
            @w_error = 107205,
            @w_sec_error = 285
          goto ERROR
        end
      end

      insert into cl_informacion_ext
                  (in_tipo_ced,in_ced_ruc,in_ente,in_tconsulta,in_fecha,
                   in_orden,in_trama_xml,in_version_xml,in_respuesta_con,
                   in_estado_doc
                   ,
                   in_fecha_real)
      values      ( @w_tipo_ced,@w_ced_ruc,@w_ente,@w_tconsulta,@w_fecha_proceso
                    ,
                    @w_orden,@w_xml,@w_version_xml,
                    @w_est_consulta,@w_est_id,
                    @w_fecha_hora_real )

      if @@error <> 0
      begin
        rollback tran rta_solicitud
        commit tran

        update cl_orden_consulta_ext with (rowlock)
        set    oc_estado = 'EII'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        select
          @w_error = 107206,
          @w_sec_error = 290
        goto ERROR
      end

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
  end

/*************************************************/
/* RECHAZO MASIVO DE ORDENES DE CONSULTA EXTERNA */
  /*************************************************/

  if @i_modo = 'X'
  begin
    -- ORDENES DE CONSULTA QUE QUEDARON EN ETAPAS INICIALES
    -- SE MARCAN CON ERROR SI SUPERAN DETERMINADO TIEMPO

    select
      oa_secuencial = oc_secuencial,
      oa_id = ps_id,
      oa_ente = oc_ente
    into   #ord_x_act
    from   cl_orden_consulta_ext,
           ad_proceso_system_op
    where  oc_estado in ('ING', 'XRE', 'PPR')
       and ps_id            = oc_sec_ejec
       and ps_estado        = 'P'
       and @w_max_espera_cr < datediff(mi,
                                       ps_hora_inicio,
                                       @w_fecha_hora_real)

    if @@error <> 0
    begin
      select
        @w_mensaje = 'Error en insercion de ordenes por actualizar',
        @w_error = 107212,
        @w_sec_error = 400
      goto ERROR
    end

    begin tran

    save tran rechazo_masivo

    update cl_orden_consulta_ext
    set    oc_estado = 'EBA'
    from   #ord_x_act
    where  oc_secuencial = oa_secuencial

    if @@error <> 0
    begin
      rollback tran rechazo_masivo
      commit tran
      select
        @w_mensaje = 'Error en actualizacion masiva de ordenes de consulta',
        @w_error = 107207,
        @w_sec_error = 405
      goto ERROR
    end

    update ad_proceso_system_op
    set    ps_estado = 'E',
           ps_hora_fin = @w_fecha_hora_real,
           ps_result_code = 708197,
           ps_msg = @w_mensaje
    from   #ord_x_act
    where  ps_id = oa_id

    if @@error <> 0
    begin
      rollback tran rechazo_masivo
      commit tran
      select
        @w_mensaje =
        'Error en actualizacion masiva de instrucciones de procesamiento'
        ,
        @w_error = 107213,
        @w_sec_error = 410
      goto ERROR
    end

    commit tran

    select
      @w_mensaje = 'Tiempo de espera de procesamiento de la orden excedido',
      @w_modo = @i_modo

    insert into cl_error_logws
                (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                 er_descripcion)
      select
        @w_fecha_hora_real,708197,convert(varchar(14), oa_id),oa_secuencial,
        @w_modo,
        @w_mensaje
      from   #ord_x_act

  end

  return 0

  ERROR:

  -- VALIDACION DE TRAMA REGISTRADA
  if @w_xml is not null
  begin
    -- SI LA TRAMA NO FUE ALMACENADA
    if not exists(select
                    1
                  from   cl_informacion_ext
                  where  in_tipo_ced  = @w_tipo_ced
                     and in_ced_ruc   = @w_ced_ruc
                     and in_tconsulta = @w_tconsulta
                     and in_orden     = @w_orden)
    begin
      insert into cl_informacion_ext_his
                  (inh_tipo_ced,inh_ced_ruc,inh_ente,inh_tconsulta,inh_fecha,
                   inh_orden,inh_trama_xml,inh_version_xml,inh_respuesta_con,
                   inh_estado_doc,
                   inh_fecha_real)
        select
          in_tipo_ced,in_ced_ruc,in_ente,in_tconsulta,in_fecha,
          in_orden,in_trama_xml,in_version_xml,in_respuesta_con,in_estado_doc,
          in_fecha_real
        from   cl_informacion_ext
        where  in_tipo_ced  = @w_tipo_ced
           and in_ced_ruc   = @w_ced_ruc
           and in_tconsulta = @w_tconsulta

      if @@error <> 0
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_estado = 'ERH'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        select
          @w_error = 107204,
          @w_sec_error = 280

        select
          @w_mensaje = mensaje
        from   cl_errores
        where  numero = @w_error

        select
          @w_mensaje = convert(varchar(6), @w_sec_error) + ' ERROR  - ' + isnull
                       (
                                                         @w_mensaje, '')

        select
          @o_msg = left(@w_mensaje,
                        255)

        insert into cl_error_logws
                    (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                     er_descripcion)
        values      ( @w_fecha_hora_real,@w_error,
                      convert(varchar(14), @w_sec_ejec
                      ),
                      @w_orden,@w_modo,
                      @w_mensaje)

        return @w_error
      end

      delete cl_informacion_ext with (rowlock)
      from   cl_informacion_ext with (index = idx1)
      where  in_tipo_ced  = @w_tipo_ced
         and in_ced_ruc   = @w_ced_ruc
         and in_tconsulta = @w_tconsulta

      if @@error <> 0
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_estado = 'EEH'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        select
          @w_error = 107205,
          @w_sec_error = 285

        select
          @w_mensaje = mensaje
        from   cl_errores
        where  numero = @w_error

        select
          @w_mensaje = convert(varchar(6), @w_sec_error) + ' ERROR  - ' + isnull
                       (
                                                         @w_mensaje, '')

        select
          @o_msg = left(@w_mensaje,
                        255)

        insert into cl_error_logws
                    (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                     er_descripcion)
        values      ( @w_fecha_hora_real,@w_error,
                      convert(varchar(14), @w_sec_ejec
                      ),
                      @w_orden,@w_modo,
                      @w_mensaje)

        return @w_error
      end

      insert into cl_informacion_ext
                  (in_tipo_ced,in_ced_ruc,in_ente,in_tconsulta,in_fecha,
                   in_orden,in_trama_xml,in_version_xml,in_respuesta_con,
                   in_estado_doc
                   ,
                   in_fecha_real)
      values      ( @w_tipo_ced,@w_ced_ruc,@w_ente,@w_tconsulta,@w_fecha_proceso
                    ,
                    @w_orden,@w_xml,@w_version_xml,isnull(
                    @w_est_consulta,
                           'XX'),isnull(@w_est_id,
                           'XX'),
                    @w_fecha_hora_real )

      if @@error <> 0
      begin
        update cl_orden_consulta_ext with (rowlock)
        set    oc_estado = 'EII'
        from   cl_orden_consulta_ext with (index = idx1)
        where  oc_secuencial = @w_orden

        select
          @w_error = 107206,
          @w_sec_error = 290

        select
          @w_mensaje = mensaje
        from   cl_errores
        where  numero = @w_error

        select
          @w_mensaje = convert(varchar(6), @w_sec_error) + ' ERROR  - ' + isnull
                       (
                                                         @w_mensaje, '')

        select
          @o_msg = left(@w_mensaje,
                        255)

        insert into cl_error_logws
                    (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                     er_descripcion)
        values      ( @w_fecha_hora_real,@w_error,
                      convert(varchar(14), @w_sec_ejec
                      ),
                      @w_orden,@w_modo,
                      @w_mensaje)

        return @w_error
      end

      update cl_orden_consulta_ext with (rowlock)
      set    oc_fecha_resp = @w_fecha_proceso,
             oc_intentos = isnull(@w_intento, 0) + 1,
             oc_estado = 'EIT',-- ERROR EN INFORMACION DE LA TRAMA XML
             oc_fecha_real_resp = @w_fecha_hora_real
      from   cl_orden_consulta_ext with (index = idx1)
      where  oc_secuencial = @w_orden
    end
  end

  if @i_frontend = 'S'
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error

    return 1
  end
  else
  begin
    if isnull(@w_mensaje,
              '') = ''
      select
        @w_mensaje = mensaje
      from   cl_errores
      where  numero = @w_error

    select
      @w_mensaje = convert(varchar(6), @w_sec_error) + ' - ' + isnull(@w_mensaje
                   ,
                   ''
                   )

    select
      @o_msg = left(@w_mensaje,
                    255)

    insert into cl_error_logws
                (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                 er_descripcion)
    values      ( @w_fecha_hora_real,@w_error,convert(varchar(14), @w_sec_ejec),
                  @w_orden,@w_modo,
                  @w_mensaje )
  end

  return @w_error

go

