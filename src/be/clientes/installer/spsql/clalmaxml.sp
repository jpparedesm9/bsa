/************************************************************************/
/*  Archivo:            clalmaxml.sp                                    */
/*  Stored procedure:   sp_almacenar_xml                                */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S.                                          */
/*  Disenado por:       Andres Diab                                     */
/*  Fecha de escritura: 20/Feb/2012                                     */
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
/*  Realizar el almacenamiento de tramas xml, producto de consultas a   */
/*  servicios externos, utilizando la plataforma CTS - CIS.             */
/*  Catalogo 'cl_tipo_consulta_ext'                                     */
/*  @i_tconsulta = 01 DATACREDITO (dat.personales)                      */
/*                 02 DATACREDITO (dat.financiero)                      */
/*                 03 CIFIN       (dat.personales)                      */
/*                 04 CIFIN       (dat.financiero)                      */
/*                 05 GESTOR MIR                                        */
/*                 07 GEORREFERENCIADOR                                 */
/*                 08 CIFIN GMF                                         */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*      FECHA         AUTOR             RAZON                           */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
/************************************************************************/

use cobis
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if object_id('sp_almacenar_xml') is not null
  drop proc sp_almacenar_xml
go

create proc sp_almacenar_xml
  @s_user         login = null,
  @s_ofi          smallint = null,
  @s_date         datetime = null,
  @s_term         varchar(30) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_trn          int,
  @t_show_version bit = 0,
  @i_user         login = null,
  @i_ofi          smallint = null,
  @i_tipo_ced     char(2) = null,
  @i_ced_ruc      numero = null,
  @i_p_apellido   varchar(16) = null,
  @i_ente         int = null,
  @i_tconsulta    varchar(10),
  @i_orden        int,
  @i_xml          xml --= null
as
  declare
    @w_return        int,
    @w_error         int,
    @w_sp_name       varchar(32),
    @w_tipo_ced      char(2),
    @w_ced_ruc       numero,
    @w_p_apellido    varchar(16),
    @w_ente          int,
    @w_xml           xml,
    @w_fecha_proceso datetime,
    @w_dig_doc_dc    tinyint,
    @w_mensaje       varchar(254)

/* VALIDACION DE TRANSACCION */
  --if @t_trn <> 1083
  --begin
  --   select @w_error     = 105504
  --   goto ERROR
  --end

  /* OBTENCION DE FECHA PROCESO */
  select
    @w_fecha_proceso = fp_fecha,
    @w_dig_doc_dc = 11,
    -- CANTIDAD DE DIGITOS QUE TIENE TODO DOCUMENTO PARA DATACREDITO
    @w_sp_name = 'sp_almacenar_xml'
  from   cobis..ba_fecha_proceso

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if not exists(select
                  1
                from   cobis..cl_orden_consulta_ext with(nolock)
                where  oc_secuencial = @i_orden)
  begin
    select
      @w_error = 2600105,
      @w_mensaje = 'Orden de Consulta Externa no existe'
    goto ERROR
  end

  if @i_xml is null
  begin
    select
      @w_error = 107203
    goto ERROR
  end

  /* EXTRACCION DE TIPO Y NUMERO DOCUMENTO SI NO SON ENVIADOS */
  if @i_tconsulta in ('01', '02') -- DATACREDITO
  begin
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
        @w_error = 107200
      goto ERROR
    end

    -- ENMASCARADO DEL NUMERO DE DOCUMENTO A LA CANTIDAD DE DIGITOS ESTANDAR DE DATACREDITO
    select
      @w_ced_ruc = right(replicate('0', @w_dig_doc_dc) + rtrim(ltrim(@w_ced_ruc)
                         )
                   ,
                         @w_dig_doc_dc)
  end

  if @i_tconsulta in ('03', '04', '07', '08')
  -- CIFIN, GEORREFERENCIADOR Y CIFIN-GMF
  begin
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
        @w_error = 107200
      goto ERROR
    end
  end

  if @i_tconsulta = '05'
  begin
    if nullif(rtrim(ltrim(@i_ced_ruc)),
              '') is null
    begin
      select
        @w_error = 107201
      goto ERROR
    end

    select
      @w_tipo_ced = 'TR',
      @w_ced_ruc = @i_ced_ruc
  end

  begin tran

  /* GUARDAR TRAMA EN HISTORICOS SI EL CLIENTE/TRAMITE YA FUE CONSULTADO */
  if exists(select
              1
            from   cl_informacion_ext
            where  in_tipo_ced  = @w_tipo_ced
               and in_ced_ruc   = @w_ced_ruc
               and in_tconsulta = @i_tconsulta)
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
         and in_tconsulta = @i_tconsulta

    if @@error <> 0
    begin
      rollback tran

      update cl_orden_consulta_ext with (rowlock)
      set    oc_estado = 'ERH'
      from   cl_orden_consulta_ext with (index = idx1)
      where  oc_secuencial = @i_orden

      select
        @w_error = 107204
      goto ERROR
    end

    delete cl_informacion_ext with (rowlock)
    from   cl_informacion_ext with (index = idx1)
    where  in_tipo_ced  = @w_tipo_ced
       and in_ced_ruc   = @w_ced_ruc
       and in_tconsulta = @i_tconsulta

    if @@error <> 0
    begin
      rollback tran

      update cl_orden_consulta_ext with (rowlock)
      set    oc_estado = 'EEH'
      from   cl_orden_consulta_ext with (index = idx1)
      where  oc_secuencial = @i_orden

      select
        @w_error = 107205
      goto ERROR
    end
  end

  /* ALMACENAR TRAMA DE RESPUESTA EN TABLA DEFINITIVA */
  insert into cl_informacion_ext
              (in_tipo_ced,in_ced_ruc,in_ente,in_tconsulta,in_fecha,
               in_orden,in_trama_xml,in_version_xml,in_respuesta_con,
               in_estado_doc
               ,
               in_fecha_real)
  values      ( @w_tipo_ced,@w_ced_ruc,@i_ente,@i_tconsulta,@w_fecha_proceso,
                @i_orden,@i_xml,null,null,null,
                getdate() )

  if @@error <> 0
  begin
    rollback tran

    update cl_orden_consulta_ext with (rowlock)
    set    oc_estado = 'EII'
    from   cl_orden_consulta_ext with (index = idx1)
    where  oc_secuencial = @i_orden

    select
      @w_error = 107206
    goto ERROR
  end

  commit tran

  /* EJECUCION PARA VALIDACION DE RESPUESTA OBTENIDA */
  if @i_xml is not null
     and @@error = 0
  begin
    print 'ENTRO A ACTUALIZAR EL ESTADO DE LA ORDEN'
    update cl_orden_consulta_ext with (rowlock)
    set    oc_fecha_resp = @w_fecha_proceso,
           oc_intentos = 1,
           oc_estado = 'PRO',
           oc_fecha_real_resp = getdate()
    from   cl_orden_consulta_ext with (index = idx1)
    where  oc_secuencial = @i_orden

    if @@error <> 0
    begin
      select
        @w_error = 107207
      goto ERROR
    end
  end

  --exec @w_return = sp_orden_consulta_cis
  --      @s_user      = @s_user,
  --      @s_term      = @s_term,
  --      @s_date      = @s_date,
  --      @s_ofi       = @s_ofi,
  --      @i_modo      = 'E',            -- MODO E - EJECUCION DE VALIDACIONES
  --      @i_ente      = @i_ente,        -- CODIGO DE ENTE
  --      @i_tipo_ced  = @i_tipo_ced,    -- TIPO DOCUMENTO
  --      @i_ced_ruc   = @i_ced_ruc,     -- No. DOCUMENTO
  --      --@i_tramite   = @i_cec_ruc,     -- TRAMITE
  --      @i_tconsulta = @i_tconsulta,--'07', -- TIPO DE CONSULTA
  --      @i_orden     = @i_orden       -- ORDEN DE CONSULTA EXTERNA
  --      --@i_batch     = 'N'       -- EJECUCION BATCH
  --
  --if @w_return <> 0
  --begin
  --   print '@w_return:' + isnull(cast(@w_return as varchar),'error')
  --   select @w_error = 999999 -- Error en validacion de respuesta consulta externa
  --   goto ERROR
  --end

  return 0

  ERROR:

  if isnull(@w_mensaje,
            '') = ''
    select
      @w_mensaje = mensaje
    from   cl_errores
    where  numero = @w_error

  select
    @w_mensaje = convert(varchar(10), @w_error) + ' - ' + isnull(@w_mensaje, '')

  insert into cobis..cl_error_logws
              (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
               er_descripcion)
  values      ( getdate(),@w_error,'proc_almaxml',@i_orden,@w_ced_ruc,
                @w_mensaje )

  /* NECESARIO PARA RETORNAR ERROR AL CONECTOR */
  exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = @w_error

  return @w_error

go

