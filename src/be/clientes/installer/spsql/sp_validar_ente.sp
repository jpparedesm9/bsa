/* **********************************************************************/
/*      Archivo:                sp_validar_datext.sp                    */
/*      Stored procedure:       sp_validar_datext                       */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Francisco Antonio Lopez Sosa            */
/*      Fecha de escritura:     19-OCT-2009                             */
/* **********************************************************************/
/*                            IMPORTANTE                                */
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
/* **********************************************************************/
/*                             PROPOSITO                                */
/*    Validación de COBIS vs. Datos Externos                            */
/* **********************************************************************/
/*                           MODIFICACIONES                             */
/* Fecha       Autor             Razon                                  */
/* 05/03/2010  c.ballen          REQ 108 CIFIN                          */
/* 08/20/2010  Alfredo Zuluaga   Control de Cambio 166                  */
/* **********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_validar_datext')
           drop proc sp_validar_datext
go

create proc sp_validar_datext
  @s_ssn          int = null,
  @s_date         datetime = null,
  @s_user         login = null,
  @s_term         descripcion = null,
  @s_corr         char(1) = null,
  @s_ssn_corr     int = null,
  @s_ofi          smallint = null,
  @s_sesn         int = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_rty          char(1) = null,
  @t_trn          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(30) = null,
  @t_show_version bit = 0,
  @i_online       varchar(10) = 'N',
  @i_ente         int = null,
  @i_num_doc      varchar(20),
  @i_type_doc     varchar(10),
  @i_tservice     varchar(10) = '01',--dato enviado X sp_val_ente
  @i_central      varchar(10) = '2',--dato enviado X sp_val_ente
  @i_operation    varchar(1),
  @i_formato      tinyint = 101
as
  declare
    @w_return              int,
    @w_sp_name             varchar(20),
    @w_today               datetime,
    @w_des_error           varchar(255),
    @w_des_novedad         varchar(255),
    @w_trama               xml,
    @w_nombres             varchar(40),
    @w_primerApellido      varchar(40),
    @w_segundoApellido     varchar(40),
    @w_genero              varchar(10),
    @w_id_estado           varchar(40),
    @w_id_fechaExpedicion  varchar(20),
    @w_id_ciudad           varchar(30),
    @w_id_ciudad_cod       varchar(30),
    @w_id_departamento     varchar(30),
    @w_id_numero           varchar(20),
    @w_edad_min            varchar(20),
    @w_edad_max            varchar(20),
    @w_nombres_cob         varchar(40),
    @w_primerApellido_cob  varchar(40),
    @w_segundoApellido_cob varchar(40),
    @w_genero_cob          varchar(10),
    @w_id_fechaExp_cob     datetime,
    @w_id_ciudad_cob       varchar(10),
    @w_id_depto_cob        varchar(10),
    @w_fecha_nac_cob       datetime,
    @w_nacionalidad        varchar(40),
    @w_subtipo             varchar(10),
    @w_subtipo_cob         varchar(10),
    @w_tipo_nodo           varchar(10),
    @w_ecivil              varchar(10),
    @w_ecivil_cob          varchar(10),
    @w_val_est             varchar(10),
    @w_nombres_nex         varchar(40),
    @w_id_numero_nex       varchar(20),
    @w_nacionalidad_nex    varchar(20),
    @w_nombres_jna         varchar(40),
    @w_id_numero_jna       varchar(20),
    @w_nombres_jex         varchar(40),
    @w_id_numero_jex       varchar(20),
    @w_nacionalidad_cob    varchar(10),
    @w_estado_doc          varchar(50),
    @w_doc                 varchar(11),
    @w_mascara             varchar(16),
    @w_fecha_proceso       datetime,
    @w_doc_validado        char(1),
    @w_ssn                 int,
    @w_desc_est_doc        varchar(100),
    @w_ced_ruc             numero,
    @w_observacion         varchar(60),--cifin
    @w_origen              varchar(10),--cifin central
    @w_nombre_nval         varchar(5),--cifin
    @w_descripcion_nval    varchar(64),--cifin
    @w_documto_nval        varchar(5),--cifin
    @w_estadoi             varchar(10),--cifin
    @w_cod_ciiu            varchar(20),--cifin
    @w_nom_larg            varchar(96),--cifin
    @w_rango_edad          varchar(20),--cifin
    @w_nro_inf             varchar(100),--cifin
    @w_id_LugarExpedicion  varchar(30),--cifin
    @w_tipoid              varchar(4),--cifin
    @w_tipo_ced            varchar(10)

  select
    @w_sp_name = 'sp_validar_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set NOCOUNT on

  /*Asignaciones Generales*/
  select
    @w_return = 0,
    @w_des_error = '',
    @w_today = getdate(),
    @w_des_novedad = '',
    @w_val_est = 'S',
    @w_mascara = '00000000000',
    -- MASCARA DE DOCUMENTO DE IDENTIFICACION PARA DATACREDITO
    @w_doc = '',
    --cifin
    @w_observacion = '',
    @w_origen = '',
    @w_estadoi = '',
    @w_documto_nval = '',
    @w_nombre_nval = '',
    @w_nom_larg = ''

  select
    @w_fecha_proceso = convert(varchar(10), fp_fecha, 101)
  from   cobis..ba_fecha_proceso
  if @@rowcount = 0
  begin
    select
      @w_des_error = 'No se pudo obtener fecha de proceso modulo',
      @w_return = 1
    goto error_gen
  end

  --Obtener Trama
  if @i_tservice in ('01', '02', '03', '04')
  begin
    create table #datos_cliente
    (
      nombres            varchar(96) null,
      --naturalNacional cifin 1apellido+2apellido+nombre
      primerApellido     varchar(40) null,
      segundoApellido    varchar(40) null,
      genero             varchar(10) null,
      ecivil             varchar(10) null,
      id_estado          varchar(30) null,--cifin amplio a 30 estaba 10
      id_fechaExpedicion varchar(20) null,
      id_ciudad          varchar(30) null,
      id_departamento    varchar(30) null,
      id_numero          varchar(20) null,
      edad_min           varchar(20) null,
      edad_max           varchar(20) null,
      nombres_nex        varchar(40) null,--naturalExtranjera
      id_numero_nex      varchar(20) null,
      nacionalidad_nex   varchar(20) null,
      nombres_jna        varchar(40) null,--juridicaNacional
      id_numero_jna      varchar(20) null,
      nombres_jex        varchar(40) null,--juridicaExtranjera
      id_numero_jex      varchar(20) null,
      cod_tipoid         varchar(2) null,--cifin
      tipoid             varchar(4) null,--cifin
      cod_ciiu           varchar(20) null,--cifin
      id_LugarExpedicion varchar(30) null,--cifin
      fecha_cons         varchar(10) null,--cifin
      hora_cons          varchar(20) null,--cifin
      rango_edad         varchar(10) null,--cifin
      nro_informe        varchar(100) null --cifin
    )

    if rtrim(ltrim(@i_tservice)) in ('01', '02') -- datacredito
    begin
      select
        @w_doc = right(@w_mascara + rtrim(ltrim(@i_num_doc)),
                       len(@w_mascara)),
        @w_observacion = 'VALIDACION AUTOMATICA DATACREDITO',
        @w_origen = '002',-- datacredito (catalogo cl_refinh)
        @w_estadoi = '020',
        -- estado documento con problema datacredito (catalogo cl_estado_refinh)
        @w_documto_nval = '01',-- cod.novedad documento no valido datacredito
        @w_descripcion_nval = 'Documento No Validado-Datcredito',
        @w_nombre_nval = '02'
      -- cod.novedad nombre/apellido no valido datacredito

      exec @w_return = sp_consultar_xml
        @i_num_doc  = @w_doc,
        @i_type_doc = @i_type_doc,
        @i_central  = '2',
        @i_tservice = @i_tservice,
        @i_tquery   = '03'

      if @w_return <> 0
      begin
        select
          @w_des_error = 'No Existen Datos Externos para el Cliente Consultado'
        goto error_gen
      end
    end

    if rtrim(ltrim(@i_tservice)) in ('03', '04') --cifin
    begin
      select
        @w_doc = @i_num_doc,
        @w_observacion = 'VALIDACION AUTOMATICA CIFIN',
        @w_origen = '003',--cifin (catalogo cl_refinh)
        @w_estadoi = '021',
        --estado documento con problema cifin(catalogo cl_estado_refinh)
        @w_documto_nval = '03',--cod novedad documento no valido cifin
        @w_descripcion_nval = 'Documento No Validado-Cifin',
        @w_nombre_nval = '04' --cod novedad nombre/apellido no valido cifin

      exec @w_return = sp_consultar_xml
        @i_num_doc  = @w_doc,
        @i_type_doc = @i_type_doc,
        @i_central  = '1',
        @i_tservice = @i_tservice,
        @i_tquery   = '03'

      if @w_return <> 0
      begin
        select
          @w_des_error = 'No Existen Datos Externos para el Cliente Consultado'
        goto error_gen
      end
    end

    select
      @w_nombres = nombres,
      @w_primerApellido = primerApellido,
      @w_segundoApellido = segundoApellido,
      @w_genero = genero,
      @w_ecivil = ecivil,
      @w_id_estado = isnull(id_estado,
                            'X'),
      @w_id_fechaExpedicion = id_fechaExpedicion,
      @w_id_ciudad = id_ciudad,
      @w_id_departamento = id_departamento,
      @w_cod_ciiu = cod_ciiu,--cifin
      @w_id_numero = id_numero,
      @w_edad_min = edad_min,
      @w_edad_max = edad_max,
      @w_tipoid = tipoid,--cifin
      @w_nombres_nex = nombres_nex,
      @w_id_numero_nex = id_numero_nex,
      @w_nacionalidad_nex = nacionalidad_nex,
      @w_nombres_jna = nombres_jna,
      @w_id_numero_jna = id_numero_jna,
      @w_nombres_jex = nombres_jex,
      @w_id_numero_jex = id_numero_jex,
      @w_rango_edad = rango_edad,
      @w_nro_inf = nro_informe,
      @w_id_LugarExpedicion = id_LugarExpedicion --cifin ciudad expedicion
    from   #datos_cliente

    if @w_id_estado is null
    begin
      select
        @w_des_error = 'estado con null con X'
      goto error_gen
    end

    if rtrim(ltrim(@i_tservice)) in ('01', '02') --datacredito
    begin
      if not @w_id_numero is null
      begin
        select
          @w_subtipo = 'P',
          @w_tipo_nodo = 'NN'
      end
      else if not @w_id_numero_nex is null
      begin
        select
          @w_subtipo = 'P',
          @w_tipo_nodo = 'NE',
          @w_id_numero = @w_id_numero_nex,
          @w_nombres = @w_nombres_nex
      end
      else if not @w_id_numero_jna is null
      begin
        select
          @w_subtipo = 'C',
          @w_tipo_nodo = 'JN',
          @w_id_numero = @w_id_numero_jna,
          @w_nombres = @w_nombres_jna
      end
      else if not @w_id_numero_jex is null
      begin
        select
          @w_subtipo = 'C',
          @w_tipo_nodo = 'JE',
          @w_id_numero = @w_id_numero_jex,
          @w_nombres = @w_nombres_jex
      end

      --Control de Existencia de Datos
      if @w_subtipo is null
      begin
        select
          @w_des_error = 'Datos Externos del Cliente Inconsistentes o Nulos [' +
                                @i_num_doc + ']'
        goto error_gen
      end
    end
  end

  /*Recuperar datos Externos de un Cliente*/
  if @i_operation = 'Q'
     and rtrim(ltrim(@i_tservice)) in ('01', '02', '03', '04')
  --datacredito/cifin
  begin
    if @w_nombres in (null, '')
        or @w_primerApellido in (null, '')
      select
        @w_subtipo = null

    select
      @w_tipo_nodo,
      @w_id_numero,
      @w_nombres,
      @w_primerApellido,
      @w_segundoApellido,
      @w_subtipo

    if @i_operation = 'Q'
      return 0
  end

  /*Validar Datos de un Cliente*/
  if @i_operation = 'V'
     and rtrim(ltrim(@i_tservice)) in ('01', '02', '03', '04')
  begin
    begin tran

    if @i_tservice in ('01', '02')
    begin
      select
        @w_nombres_cob = en_nombre,
        @w_primerApellido_cob = p_p_apellido,
        @w_segundoApellido_cob = p_s_apellido,
        @w_subtipo_cob = en_subtipo,
        @w_tipo_ced = en_tipo_ced,
        @w_ced_ruc = en_ced_ruc,
        @w_estado_doc = isnull(in_estado_doc,
                               'Y'),
        @w_doc_validado = en_doc_validado
      from   cl_ente,
             cl_orden_consulta_ext,
             cl_informacion_ext
      where  en_ente      = @i_ente
         and oc_tipo_ced  = en_tipo_ced
         and oc_ced_ruc   = right(@w_mascara + rtrim(ltrim(en_ced_ruc)),
                                  len(@w_mascara))
         and oc_tconsulta = @i_tservice
         and oc_estado    = 'PRO'
         and in_orden     = oc_secuencial

      if @@rowcount = 0
      begin
        select
          @w_return = 30,
          @w_des_error = 'Ente no encontrado [' + convert(varchar, @i_ente) +
                         ']'
        goto error_gen
      end
    end

    if @i_tservice in ('03', '04')
    begin
      select
        @w_nombres_cob = en_nombre,
        @w_primerApellido_cob = p_p_apellido,
        @w_segundoApellido_cob = p_s_apellido,
        @w_subtipo_cob = en_subtipo,
        @w_tipo_ced = en_tipo_ced,
        @w_ced_ruc = en_ced_ruc,
        @w_estado_doc = isnull(in_estado_doc,
                               'Y'),
        @w_doc_validado = en_doc_validado
      from   cl_ente,
             cl_orden_consulta_ext,
             cl_informacion_ext
      where  en_ente      = @i_ente
         and oc_tipo_ced  = en_tipo_ced
         and oc_ced_ruc   = en_ced_ruc --quita ceros a la izq para comparar
         and oc_tconsulta = @i_tservice
         and oc_estado    = 'PRO'
         and in_orden     = oc_secuencial

      if @@rowcount = 0
      begin
        select
          @w_return = 30,
          @w_des_error = 'Ente no encontrado [' + convert(varchar, @i_ente) +
                         ']'
        goto error_gen
      end
    end

    select
      @w_desc_est_doc = eq_codigo1
    from   cl_equivalencia_ws
    where  eq_codigo  = @w_estado_doc
       and eq_central = convert(smallint, @i_central)
       and eq_tabla   = 'Vigencia Cedula'

    if @w_desc_est_doc is not null
      select
        @w_desc_est_doc = ' - Estado de Documento Invalido: ' + @w_desc_est_doc
    else
      select
        @w_desc_est_doc = ''

    --Ajuste por control de cambio 166 Persona Juridica
    if @w_subtipo_cob = 'P'
    begin
      if (ltrim(rtrim(@w_estado_doc)) <> '00'
          and (@w_tipo_ced = 'CC')
          and @i_central = '2') -- DATACREDITO
          or (ltrim(rtrim(@w_estado_doc)) not in (
              'VIGENTE', 'NO APLICA', 'NO SUMINISTRADO',
                   'EN PROCESO DE ELABOR')
              and @i_central = '1') --CIFIN
      begin
        --Inserta Novedad

        insert into cobis..cl_novedad_ente
                    (ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
                     ne_datac,ne_fec_aplica,ne_cod_novedad)
        values     ( @i_central,@i_ente,@w_documto_nval,@w_descripcion_nval +
                     @w_desc_est_doc,
                     @w_estado_doc,
                     @w_estado_doc,getdate(),1)

        if @@error <> 0
        begin
          select
            @w_return = 31,
            @w_des_error = 'Error Ingesando Novedad Ente 01 [' + convert(varchar
                           ,
                           @i_ente)
                           +
                           ']'
          goto error_gen
        end

        select
          @w_ssn = se_numero + 1
        from   cobis..ba_secuencial

        if @@rowcount = 0
        begin
          select
            @w_return = 32,
            @w_des_error = 'ERROR AL OBTENER SECUENCIAL INICIAL SSN'
          goto error_gen
        end

        --Insertar Referencia Inhibitoria
        exec @w_return = cobis..sp_refinh_dml
          @s_ssn         = @w_ssn,
          @t_trn         = 1280,
          @i_operacion   = 'I',
          @i_tipo_cli    = @w_subtipo_cob,
          @i_ced_ruc     = @w_ced_ruc,
          @i_tipo_ced    = @i_type_doc,
          @i_nombre      = @w_nombres_cob,
          @i_p_apellido  = @w_primerApellido_cob,
          @i_s_apellido  = @w_segundoApellido_cob,
          @i_sexo        = @w_genero_cob,
          @i_observacion = @w_observacion,
          @i_fecharef    = @w_fecha_proceso,
          @i_origen      = @w_origen,
          @i_estadori    = @w_estadoi

        if @w_return <> 0
            or @@error <> 0
        begin
          select
            @w_return = 32,
            @w_des_error = 'Error Ingesando Referencia Inhibitoria Ente [' +
                           convert
                           (
                           varchar
                           , @i_ente) +
                           ']'
          goto error_gen
        end

        update cobis..ba_secuencial
        set    se_numero = @w_ssn

        if @@rowcount <> 1
        begin
          select
            @w_return = 32,
            @w_des_error = 'ERROR AL ACTUALIZAR SECUENCIAL INICIAL SSN'
          goto error_gen
        end

        select
          @w_val_est = 'N'
      end
    end

    --validacion para persona juridicas y naturales cifin (guarda todo el nombre completo)
    if rtrim(ltrim(@i_tservice)) in ('03', '04') --CIFIN
    begin
      select
        @w_nom_larg = isnull(@w_primerApellido_cob + ' ', '') + isnull(
                             @w_segundoApellido_cob + ' ',
                             '')
                      + isnull(@w_nombres_cob, '')
      if ltrim(rtrim(@w_nombres)) <> ltrim(rtrim(@w_nom_larg))
      begin
        select
          @w_des_novedad = '[ NOMBRES ] '
        if @w_des_novedad <> ""
        begin
          insert into cobis..cl_novedad_ente
                      (ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
                       ne_datac,ne_fec_aplica,ne_cod_novedad)
          values      ( @i_central,@i_ente,@w_nombre_nval,@w_des_novedad,
                        @w_nom_larg
                        ,
                        @w_nombres,getdate(),2)

          if @@error <> 0
          begin
            select
              @w_return = 33,
              @w_des_error = 'Error Ingesando Novedad Ente 01 [' + convert(
                             varchar
                             ,
                             @i_ente)
                             +
                             ']'
            goto error_gen
          end
        end
        select
          @w_val_est = 'N'
      end--<> nombre
    end

    if rtrim(ltrim(@i_tservice)) in ('01', '02')
    begin
      if ltrim(rtrim(@w_nombres)) <> ltrim(rtrim(@w_nombres_cob))
      begin
        select
          @w_des_novedad = '[ NOMBRES ] '
        if @w_des_novedad <> ""
        begin
          insert into cobis..cl_novedad_ente
                      (ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
                       ne_datac,ne_fec_aplica,ne_cod_novedad)
          values      ( @i_central,@i_ente,@w_nombre_nval,@w_des_novedad,
                        @w_nombres_cob,
                        @w_nombres,getdate(),2)

          if @@error <> 0
          begin
            select
              @w_return = 33,
              @w_des_error = 'Error Ingesando Novedad Ente 01 [' + convert(
                             varchar
                             ,
                             @i_ente)
                             +
                             ']'
            goto error_gen
          end
        end
        select
          @w_val_est = 'N'
      end--<> nombre

      --Solo Aplica para Personas naturalNacional
      if @w_subtipo_cob = 'P'
      begin
        if ltrim(rtrim(@w_primerApellido)) <>
           ltrim(rtrim(@w_primerApellido_cob))
        begin
          select
            @w_des_novedad = '[ P_APELLIDO ] '
          insert into cobis..cl_novedad_ente
                      (ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
                       ne_datac,ne_fec_aplica,ne_cod_novedad)
          values      ( @i_central,@i_ente,@w_nombre_nval,@w_des_novedad,
                        @w_primerApellido_cob,
                        @w_primerApellido,getdate(),3)
          if @@error <> 0
          begin
            select
              @w_return = 33,
              @w_des_error = 'Error Ingesando Novedad Ente 01 [' + convert(
                             varchar
                             ,
                             @i_ente)
                             +
                             ']'
            goto error_gen
          end
          select
            @w_val_est = 'N'
        end--papellido

        if ltrim(rtrim(@w_segundoApellido)) <>
           ltrim(rtrim(@w_segundoApellido_cob))
        begin
          select
            @w_des_novedad = '[ S_APELLIDO ] '
          insert into cobis..cl_novedad_ente
                      (ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
                       ne_datac,ne_fec_aplica,ne_cod_novedad)
          values      ( @i_central,@i_ente,@w_nombre_nval,@w_des_novedad,
                        @w_segundoApellido_cob,
                        @w_segundoApellido,getdate(),4)
          if @@error <> 0
          begin
            select
              @w_return = 33,
              @w_des_error = 'Error Ingesando Novedad Ente 01 [' + convert(
                             varchar
                             ,
                             @i_ente)
                             +
                             ']'
            goto error_gen
          end
          select
            @w_val_est = 'N'
        end -- sapellido
      end --P
    end --tipo servicio

    update cobis..cl_ente
    set    en_doc_validado = @w_val_est
    where  en_ente = @i_ente
    if @@error <> 0
    begin
      select
        @w_return = 34,
        @w_des_error = 'Error Actualizando Estado de Validacion del cliente [' +
                       convert
                       (varchar,
                       @i_ente)
                       + ']'
      goto error_gen
    end
    else
    begin
      insert into cl_actualiza
                  (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                   ac_campo,ac_valor_ant,
                   ac_valor_nue,ac_transaccion)
      values     ( @i_ente,getdate(),'cl_ente','en_doc_validado',@w_doc_validado
                   ,
                   @w_val_est,'U')
      if @@error != 0
      begin
        select
          @w_return = 34,
          @w_des_error = 'Error Ingesando Log de Auditoria [' + convert(varchar,
                         @i_ente
                         )
                         + ']'
        goto error_gen
      end
    end

    commit tran
  end --operacion V

  goto end_proc

  /*Manejo de Errores*/
  error_gen:
  if @i_online = 'N'
  begin
    if @i_operation = 'V'
       and @i_tservice in ('01', '02', '03', '04')
       and @w_return between 30 and 34
      rollback tran
    insert into cobis..cl_error_logws
    values      (@w_today,null,'proc_val_ente',null,null,
                 @w_des_error)

    return @w_return
  end
  else
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_return

    return @w_return
  end

  end_proc:
  return 0

go

