/* **********************************************************************/
/*      Archivo:                clinfxmlcf.sp                           */
/*      Stored procedure:       sp_extraer_inf_xml_cf                   */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Wilson Romero / Gabriel Alvis           */
/*      Fecha de escritura:     09-abr-2010                             */
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
/*  Inserción en tablas temp Centralizadas de datos de estructuras XML  */
/*  05/11/2010    c.ballen    req 108 CIFIN                             */
/*  CIFIN maneja tipo de registro y por cada uno productos asociados    */
/* **********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_extraer_inf_xml_cf')
  drop proc sp_extraer_inf_xml_cf
go

create proc sp_extraer_inf_xml_cf
(
  @i_ente       int = null,
  @i_num_doc    varchar(20) = null,
  @i_type_doc   varchar(10) = null,
  @i_operacion  char(1) = null,
  @i_secuencial int = null,
  @i_batch      char(1) = 'N',
  @i_orden      int = 0,
  @o_secuencial int = null out,
  @o_orden      int = null out
)
as
  set CONCAT_NULL_YIELDS_NULL on
  set ANSI_WARNINGS on
  set ANSI_PADDING on
  set ARITHABORT on

  declare
    @w_respuesta        varchar(2),
    @w_respuesta_vali   nvarchar(max),
    @w_retornar_vali    varchar(10),
    @w_return           int,
    @w_xml              xml,
    @w_genero           varchar(50),
    @w_Extranjero       varchar(50),
    @w_nomCompleto      varchar(200),
    @w_primerApellido   varchar(40),
    @w_segundoApellido  varchar(40),
    @w_nombres          varchar(40),
    @w_nombres_jna      varchar(40),
    @w_nombres_jex      varchar(40),
    @w_fecha_expedicion varchar(40),
    @w_nombre_total     varchar(500),
    @w_tip_doc          varchar(2),
    @w_ente             int,
    @w_secuencial       int,
    @w_msg              varchar(254),
    @w_sp_name          varchar(20),
    @w_procedencia      char(2),
    @w_id_numero        varchar(30),
    @w_orden            int

  select
    @w_sp_name = 'sp_extraer_inf_xml_cf'

/*-------------------------------------------*/
/*------------ OPERACION D ------------------*/
  /*-------------------------------------------*/
  if @i_operacion = 'D'
  begin
    if exists(select
                1
              from   cobis..cl_ws_ente_tmp with(nolock)
              where  we_secuencial = @i_secuencial)
    begin
      delete cobis..cl_ws_ente_tmp with (rowlock)
      from   cobis..cl_ws_ente_tmp with(index = idx1)
      where  we_secuencial = @i_secuencial
      delete cobis..cl_ws_alerta_tmp with (rowlock)
      from   cobis..cl_ws_alerta_tmp with(index = idx1)
      where  wa_secuencial = @i_secuencial
      delete cobis..cl_ws_score_tmp with (rowlock)
      from   cobis..cl_ws_score_tmp with(index = idx1)
      where  ws_secuencial = @i_secuencial
      delete cobis..cl_ws_obligacion_tmp with (rowlock)
      from   cobis..cl_ws_obligacion_tmp with(index = idx1)
      where  wo_secuencial = @i_secuencial
      delete cobis..cl_ws_endeuda_tmp with (rowlock)
      from   cobis..cl_ws_endeuda_tmp with(index = idx1)
      where  we_secuencial = @i_secuencial
      delete cobis..cl_ws_consulta_tmp with (rowlock)
      from   cobis..cl_ws_consulta_tmp with(index = idx1)
      where  wc_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_encab_tmp with (rowlock)
      from   cobis..cl_ws_endeu_encab_tmp with(index = idx1)
      where  wee_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_cons_tmp with (rowlock)
      from   cobis..cl_ws_endeu_cons_tmp with(index = idx1)
      where  wec_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_contig_tmp with (rowlock)
      from   cobis..cl_ws_endeu_contig_tmp with(index = idx1)
      where  wet_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_det_tmp with (rowlock)
      from   cobis..cl_ws_endeu_det_tmp with(index = idx1)
      where  wed_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_reest_tmp with (rowlock)
      from   cobis..cl_ws_endeu_reest_tmp with(index = idx1)
      where  wer_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_cast_tmp with (rowlock)
      from   cobis..cl_ws_endeu_cast_tmp with(index = idx1)
      where  wec_secuencial = @i_secuencial
      delete cobis..cl_ws_endeu_cmp_tmp with (rowlock)
      from   cobis..cl_ws_endeu_cmp_tmp with(index = idx1)
      where  wem_secuencial = @i_secuencial
    end
  end -- operacion 'D'

/*-------------------------------------------*/
/*------------ OPERACION I ------------------*/
  /*-------------------------------------------*/
  if @i_operacion = 'I'
  begin
    if @i_ente is not null
    begin
      select
        @i_type_doc = oc_tipo_ced,
        @i_num_doc = oc_ced_ruc
      from   cl_ente,
             cl_orden_consulta_ext,
             cl_informacion_ext
      where  en_ente      = @i_ente
         and oc_tipo_ced  = en_tipo_ced
         and oc_ced_ruc   = en_ced_ruc
         and oc_tconsulta = '04' -- INFORMACION COMERCIAL CIFIN
         and oc_estado    = 'PRO'
         and in_orden     = oc_secuencial
    end

    if @i_orden > 0
    begin
      select
        @w_xml = in_trama_xml,
        @w_respuesta = in_respuesta_con,
        @w_tip_doc = in_tipo_ced,
        @w_ente = in_ente,
        @w_orden = in_orden
      from   cl_orden_consulta_ext,
             cl_informacion_ext
      where  in_orden     = @i_orden
         and oc_tconsulta = '04' -- INFORMACION COMERCIAL CIFIN
         and oc_estado    = 'PRO'
         and in_orden     = oc_secuencial

      if @@rowcount = 0
      begin
        if @i_batch = 'S'
        begin
          select
            @w_xml = inh_trama_xml,
            @w_respuesta = inh_respuesta_con,
            @w_tip_doc = inh_tipo_ced,
            @w_ente = inh_ente,
            @w_orden = inh_orden
          from   cl_orden_consulta_ext,
                 cl_informacion_ext_his
          where  inh_orden    = @i_orden
             and oc_tconsulta = '04' -- INFORMACION COMERCIAL CIFIN
             and oc_estado    = 'PRO'
             and inh_orden    = oc_secuencial

          if @@rowcount = 0
          begin
            select
              @w_return = 1,
              @w_msg = 'No Existen Datos Externos para el Cliente Consultado'
            goto ERROR
          end
        end
      end
    end
    else
    begin
      select
        @w_xml = in_trama_xml,
        @w_respuesta = in_respuesta_con,
        @w_tip_doc = in_tipo_ced,
        @w_ente = in_ente,
        @w_orden = in_orden
      from   cl_orden_consulta_ext,
             cl_informacion_ext
      where  oc_tipo_ced  = isnull(@i_type_doc,
                                   in_tipo_ced)
         and oc_ced_ruc   = isnull(@i_num_doc,
                                   in_ced_ruc)
         and oc_tconsulta = '04' -- INFORMACION COMERCIAL CIFIN
         and oc_estado    = 'PRO'
         and in_orden     = oc_secuencial

      if @@rowcount = 0
      begin
        if @i_batch = 'S'
        begin
          select
            @w_xml = inh_trama_xml,
            @w_respuesta = inh_respuesta_con,
            @w_tip_doc = inh_tipo_ced,
            @w_ente = inh_ente,
            @w_orden = inh_orden
          from   cl_orden_consulta_ext,
                 cl_informacion_ext_his
          where  oc_tipo_ced  = isnull(@i_type_doc,
                                       inh_tipo_ced)
             and oc_ced_ruc   = isnull(@i_num_doc,
                                       inh_ced_ruc)
             and oc_tconsulta = '04' -- INFORMACION COMERCIAL CIFIN
             and oc_estado    = 'PRO'
             and inh_orden    = oc_secuencial

          if @@rowcount = 0
          begin
            select
              @w_return = 1,
              @w_msg = 'No Existen Datos Externos para el Cliente Consultado'
            goto ERROR
          end
        end
      end
    end

    /*********************  D A T O S   C L I E N T E    *************************/
    create table #dato_cliente_cf
    (
      id                 int identity,
      identificalinea    varchar(max) null,
      nombre_largo       varchar(max) null,
      cod_tipoid         varchar(max) null,
      id_numero          varchar(max) null,
      tipoid             varchar(max) null,
      estado_dcto        varchar(max) null,
      id_fechaExpedicion varchar(max) null,
      id_LugarExpedicion varchar(max) null,
      id_estado          varchar(max) null,
      id_cod_dpto        varchar(max) null,
      id_cod_ciudad      varchar(max) null,
      id_cod_ciiu        varchar(max) null,
      nombre_ciiu        varchar(max) null,
      rango_edad         varchar(max) null,
      fecha_cons         varchar(max) null,
      hora_cons          varchar(max) null,
      nro_informe        varchar(max) null,
      entidad            varchar(max) null,
      cons_rpta          varchar(max) null,
      tipo_registro      varchar(max) null
    )
    insert into #dato_cliente_cf
      select
        identificalinea = isnull(
        @w_xml.value(N'(/CIFIN/Tercero/IdentificadorLinea)[1]',
                     'varchar(100)'),
        ''),nombre_largo = isnull(
            @w_xml.value(N'(/CIFIN/Tercero/NombreTitular)[1]',
                  'varchar(254)'),
                              ''),cod_tipoid = isnull(
        @w_xml.value(N'(/CIFIN/Tercero/CodigoTipoIndentificacion)[1]',
               'varchar(4)'),
                            ''),id_numero = isnull(
        @w_xml.value(N'(/CIFIN/Tercero/NumeroIdentificacion)[1]',
                'varchar(20)'),
                           ''),tipoid = isnull(
        @w_xml.value(N'(/CIFIN/Tercero/TipoIdentificacion)[1]',
              'varchar(4)'),
                        ''),
        estado_dcto = isnull(@w_xml.value(N'(/CIFIN/Tercero/Estado)[1]',
                                          'varchar(30)'),
                             ''),id_fechaExpedicion = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/FechaExpedicion)[1]',
                    'varchar(20)'),
       ''),id_LugarExpedicion = isnull(
           @w_xml.value(N'(/CIFIN/Tercero/LugarExpedicion)[1]',
                    'varchar(30)'),
       ''),id_estado = isnull(
           @w_xml.value(N'(/CIFIN/Tercero/EstadoTitular)[1]',
           'varchar(30)'),
    ''),id_cod_dpto = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/CodigoDepartamento)[1]',
             'varchar(30)'),
    ''),
    id_cod_ciudad = isnull(@w_xml.value(N'(/CIFIN/Tercero/CodigoMunicipio)[1]',
               'varchar(30)'),
    ''),id_cod_ciiu = isnull(
      @w_xml.value(N'(/CIFIN/Tercero/CodigoCiiu)[1]',
             'varchar(30)'),
    ''),nombre_ciiu = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/NombreCiiu)[1]',
             'varchar(254)'),
    ''),rango_edad = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/RangoEdad)[1]',
            'varchar(20)'),
    ''),fecha_cons = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/Fecha)[1]',
            'varchar(10)'),
    ''),
    hora_cons = isnull(@w_xml.value(N'(/CIFIN/Tercero/Hora)[1]',
           'varchar(20)'),
    ''),nro_informe = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/NumeroInforme)[1]',
             'varchar(100)'),
    ''),entidad = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/Entidad)[1]',
         'varchar(100)'),
    ''),cons_rpta = isnull(
    @w_xml.value(N'(/CIFIN/Tercero/RespuestaConsulta)[1]',
           'varchar(2)'),
    ''),tipo_registro = 'DATTITULAR'

    select
      @w_id_numero = id_numero
    from   #dato_cliente_cf

    -- manejo si hay error
    if @w_respuesta not in ('02')
    --02(cons.exitosa). (01(no existe, 03(cons no exitosa)) error
    begin
      select
        @w_id_numero = @i_num_doc
    end

    /********************* 1.TIPO REGISTRO CUENTAS VIGENTES DE AHORRO/CORRIENTES  *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),--indica tipo de cuenta ah/cc
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(20)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_cuenta = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_terminacion = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(64) '),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      chq_devueltos = nCol.value(N'(./ChequesDevueltos)[1]',
                                 'int'),
      dias_cartera = nCol.value(N'(./DiasCartera)[1]',
                                'int'),
      cupo_sobregiro = nCol.value(N'(./CupoSobregiro)[1]',
                                  'money'),
      --NO ESTA EN LA TRAMA esta en la hoja guia como son los nombre trama??                  
      dias_aut_sobregiro = nCol.value(N'(./DiasAutorizadosSobregiro)[1]',
                                      'int'),
      --NO ESTA EN LA TRAMA esta en la hoja guia                    
      tipo_registro = 'CTAVIGENTE' --cuenta vigente
    into   #dato_obliga_ctavig
    from   @w_xml.nodes('CIFIN/Tercero/CuentasVigentes/Obligacion') as nTable(
           nCol )

    /********************* 2. TIPO REGISTRO CUENTAS EXTINGUIDAS DE AHORRO/CORRIENTES  *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),--indica ah(0023)/cc(0001)
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(20)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_cuenta = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_terminacion = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(64) '),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      chq_devueltos = nCol.value(N'(./ChequesDevueltos)[1]',
                                 'int'),
      dias_cartera = nCol.value(N'(./DiasCartera)[1]',
                                'int'),
      cupo_sobregiro = nCol.value(N'(./CupoSobregiro)[1]',
                                  'money'),
      dias_aut_sobregiro = nCol.value(N'(./DiasAutorizadosSobregiro)[1]',
                                      'int'),
      tipo_registro = 'CTAEXTINGI' --cuenta extinguida
    into   #dato_obliga_ctaext
    from   @w_xml.nodes('CIFIN/Tercero/CuentasExtinguidas/Obligacion') as nTable
           (
           nCol)

    /********************* 3. TIPO REGISTRO SECTOR FINANCIERO AL DIA (LINEAS DE CREDITO) *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),
      --indica linea credito (tarjeta credito(0002), obligaciones credito(6,21,19)      
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(4)'),
      estado_contrato = nCol.value(N'(./EstadoContrato)[1]',
                                   'varchar(4)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      calidad = nCol.value(N'(./Calidad)[1]',
                           'char(4)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                  'char(20)'),
      linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                 'varchar(4)'),
      periodicidad = nCol.value(N'(./Periodicidad)[1]',
                                'char(3)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_vencimiento = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      calificacion = nCol.value(N'(./Calificacion)[1]',
                                'varchar(2)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      saldo_oblig = nCol.value(N'(./SaldoObligacion)[1]',
                               'money'),
      saldo_mora = nCol.value(N'(./ValorMora)[1]',
                              'money'),
      valor_cuota = nCol.value(N'(./ValorCuota)[1]',
                               'money'),
      tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                               'varchar(2)'),
      nro_cuotas_cancl = nCol.value(N'(./CuotasCanceladas)[1]',
                                    'int'),
      tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                                 'char(4)'),
      cubrim_garantia = nCol.value(N'(./CubrimientoGarantia)[1]',
                                   'varchar(10)'),
      max_mora = nCol.value(N'(./MoraMaxima)[1]',
                            'varchar(4)'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(74)'),
      participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                                    'int'),
      ProbabilidadNoPago = nCol.value(N'(./ProbabilidadNoPago)[1]',
                                      'int'),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      modo_extincion = nCol.value(N'(./ModoExtincion)[1]',
                                  'varchar(3)'),
      fecha_pago = nCol.value(N'(./FechaPago)[1]',
                              'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      nro_restructu = nCol.value(N'(./NumeroReestructuraciones)[1]',
                                 'int'),
      nat_restructu = nCol.value(N'(./NaturalezaReestructuracion)[1]',
                                 'varchar(4)'),
      restructurado = nCol.value(N'(./Reestructurado)[1]',
                                 'varchar(2)'),
      tipoent_orig_cart = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                                     'varchar(6)'),
      ent_orig_cart = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                                 'varchar(60)'),
      tipo_pago = nCol.value(N'(./TipoPago)[1]',
                             'varchar(3)'),
      estado_tit = nCol.value(N'(./EstadoTitular)[1]',
                              'varchar(4)'),
      nro_cuota_pactada = nCol.value(N'(./NumeroCuotasPactadas)[1]',
                                     'int'),
      dias_cartera = nCol.value(N'(./NumeroCuotasMora)[1]',
                                'int'),
      marca_tarj = nCol.value(N'(./MarcaTarjeta)[1]',
                              'varchar(3)'),
      clase_tarj = nCol.value(N'(./ClaseTarjeta)[1]',
                              'varchar(3)'),
      tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                                    'varchar(4)'),
      nro_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                                   'varchar(4)'),
      tipo_registro = 'SECTFALDIA'
    --sector financiero dia                        
    into   #dato_obliga_sfdia
    from   @w_xml.nodes('CIFIN/Tercero/SectorFinancieroAlDia/Obligacion') as
           nTable(nCol)

    /********************* 4. TIPO REGISTRO SECTOR FINANCIERO EN MORA (LINEAS DE CREDITO) *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),
      --indica linea credito (tarjeta credito, obligaciones credito)
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(4)'),
      estado_contrato = nCol.value(N'(./EstadoContrato)[1]',
                                   'varchar(4)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      calidad = nCol.value(N'(./Calidad)[1]',
                           'char(4)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                  'char(20)'),
      linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                 'varchar(4)'),
      periodicidad = nCol.value(N'(./Periodicidad)[1]',
                                'char(3)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_vencimiento = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      calificacion = nCol.value(N'(./Calificacion)[1]',
                                'varchar(2)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      saldo_oblig = nCol.value(N'(./SaldoObligacion)[1]',
                               'money'),
      saldo_mora = nCol.value(N'(./ValorMora)[1]',
                              'money'),
      valor_cuota = nCol.value(N'(./ValorCuota)[1]',
                               'money'),
      tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                               'varchar(2)'),
      nro_cuotas_cancl = nCol.value(N'(./CuotasCanceladas)[1]',
                                    'int'),
      tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                                 'char(4)'),
      cubrito_garant = nCol.value(N'(./CubrimientoGarantia)[1]',
                                  'varchar(10)'),
      max_mora = nCol.value(N'(./MoraMaxima)[1]',
                            'varchar(4)'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(74)'),
      participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                                    'int'),
      ProbabilidadNoPago = nCol.value(N'(./ProbabilidadNoPago)[1]',
                                      'int'),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      modo_extincion = nCol.value(N'(./ModoExtincion)[1]',
                                  'varchar(3)'),
      fecha_pago = nCol.value(N'(./FechaPago)[1]',
                              'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      nro_restructu = nCol.value(N'(./NumeroReestructuraciones)[1]',
                                 'int'),
      nat_restructu = nCol.value(N'(./NaturalezaReestructuracion)[1]',
                                 'varchar(4)'),
      tipoent_orig_cart = nCol.value(N'(./TipoEntidadOriginadoraCartera )[1]',
                                     'varchar(6)'),
      ent_orig_cart = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                                 'varchar(60)'),
      tipo_pago = nCol.value(N'(./TipoPago)[1]',
                             'varchar(3)'),
      estado_tit = nCol.value(N'(./EstadoTitular)[1]',
                              'varchar(4)'),
      nro_cuota_pactada = nCol.value(N'(./NumeroCuotasPactadas)[1]',
                                     'int'),
      dias_cartera = nCol.value(N'(./NumeroCuotasMora)[1]',
                                'int'),
      restructurado = nCol.value(N'(./Reestructurado)[1]',
                                 'varchar(2)'),
      marca_tarj = nCol.value(N'(./MarcaTarjeta)[1]',
                              'varchar(3)'),
      clase_tarj = nCol.value(N'(./ClaseTarjeta)[1]',
                              'varchar(3)'),
      tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                                    'varchar(4)'),
      nro_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                                   'varchar(4)'),
      tipo_registro = 'SECFENMORA' --sector financiero en mora
    into   #dato_obliga_sfmora
    from   @w_xml.nodes('CIFIN/Tercero/SectorFinancieroEnMora/Obligacion') as
           nTable(nCol)

    /********************* 5. TIPO REGISTRO SECTOR FINANCIERO EXTINGUIDAS (LINEAS DE CREDITO) *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),
      --indica linea credito (tarjeta credito, obligaciones credito)
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(4)'),
      estado_contrato = nCol.value(N'(./EstadoContrato)[1]',
                                   'varchar(4)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      calidad = nCol.value(N'(./Calidad)[1]',
                           'char(4)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                  'char(20)'),
      linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                 'varchar(4)'),
      periodicidad = nCol.value(N'(./Periodicidad)[1]',
                                'char(3)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_vencimiento = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      calificacion = nCol.value(N'(./Calificacion)[1]',
                                'varchar(2)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      saldo_oblig = nCol.value(N'(./SaldoObligacion)[1]',
                               'money'),
      saldo_mora = nCol.value(N'(./ValorMora)[1]',
                              'money'),
      valor_cuota = nCol.value(N'(./ValorCuota)[1]',
                               'money'),
      tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                               'varchar(2)'),
      nro_cuotas_cancl = nCol.value(N'(./CuotasCanceladas)[1]',
                                    'int'),
      tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                                 'char(4)'),
      cubrim_garantia = nCol.value(N'(./CubrimientoGarantia)[1]',
                                   'varchar(10)'),
      max_mora = nCol.value(N'(./MoraMaxima)[1]',
                            'varchar(4)'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(74)'),
      participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                                    'int'),
      ProbabilidadNoPago = nCol.value(N'(./ProbabilidadNoPago)[1]',
                                      'int'),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      modo_extincion = nCol.value(N'(./ModoExtincion)[1]',
                                  'varchar(3)'),
      fecha_pago = nCol.value(N'(./FechaPago)[1]',
                              'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      nro_restructu = nCol.value(N'(./NumeroReestructuraciones)[1]',
                                 'int'),
      nat_restructu = nCol.value(N'(./NaturalezaReestructuracion)[1]',
                                 'varchar(4)'),
      tipoent_orig_cart = nCol.value(N'(./TipoEntidadOriginadoraCartera )[1]',
                                     'varchar(6)'),
      ent_orig_cart = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                                 'varchar(60)'),
      tipo_pago = nCol.value(N'(./TipoPago)[1]',
                             'varchar(3)'),
      estado_tit = nCol.value(N'(./EstadoTitular)[1]',
                              'varchar(4)'),
      dias_sobregiro = nCol.value(N'(./NumeroCuotasPactadas)[1]',
                                  'int'),
      dias_cartera = nCol.value(N'(./NumeroCuotasMora)[1]',
                                'int'),
      restructurado = nCol.value(N'(./Reestructurado)[1]',
                                 'varchar(2)'),
      tipo_registro = 'SECFEXTING' --sector financiero extinguido     
    into   #dato_obliga_sfext
    from   @w_xml.nodes('CIFIN/Tercero/SectorFinancieroExtinguidas/Obligacion')
           as
           nTable(
           nCol)

    /********************* 6. TIPO REGISTRO SECTOR REAL AL DIA (LINEAS DE CREDITO) *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),
      --indica linea credito (tarjeta credito, obligaciones credito)
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(4)'),
      estado_contrato = nCol.value(N'(./EstadoContrato)[1]',
                                   'varchar(4)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      calidad = nCol.value(N'(./Calidad)[1]',
                           'char(4)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                 'varchar(4)'),
      periodicidad = nCol.value(N'(./Periodicidad)[1]',
                                'char(3)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_terminacion = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      saldo_oblig = nCol.value(N'(./SaldoObligacion)[1]',
                               'money'),
      saldo_mora = nCol.value(N'(./ValorMora)[1]',
                              'money'),
      valor_cuota = nCol.value(N'(./ValorCuota)[1]',
                               'money'),
      nro_cuotas_cancl = nCol.value(N'(./CuotasCanceladas)[1]',
                                    'int'),
      max_mora = nCol.value(N'(./MoraMaxima)[1]',
                            'varchar(4)'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(74)'),
      participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                                    'int'),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      modo_extincion = nCol.value(N'(./ModoExtincion)[1]',
                                  'varchar(3)'),
      fecha_pago = nCol.value(N'(./FechaPago)[1]',
                              'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      chq_devueltos = nCol.value(N'(./ChequesDevueltos)[1]',
                                 'int'),
      plazo = nCol.value(N'(./Plazo)[1]',
                         'varchar(6)'),
      dias_cartera = nCol.value(N'(./DiasCartera)[1]',
                                'int'),
      tipo_pago = nCol.value(N'(./TipoPago)[1]',
                             'varchar(3)'),
      estado_tit = nCol.value(N'(./EstadoTitular)[1]',
                              'varchar(4)'),
      nro_cuota_pactada = nCol.value(N'(./NumeroCuotasPactadas)[1]',
                                     'int'),
      nro_cuota_mora = nCol.value(N'(./NumeroCuotasMora)[1]',
                                  'int'),
      valor_cargo_fijo = nCol.value(N'(./ValorCargoFijo)[1]',
                                    'money'),
      clausu_perm = nCol.value(N'(./ClausulaPermanencia)[1]',
                               'char(4)'),
      restructurado = nCol.value(N'(./Reestructurado)[1]',
                                 'varchar(2)'),
      vigencia = nCol.value(N'(./Vigencia )[1]',
                            'char(3)'),
      nro_meses_contrato = nCol.value(N'(./NumeroMesesContrato)[1]',
                                      'int'),
      nro_meses_clausula = nCol.value(N'(./NumeroMesesClausula)[1]',
                                      'varchar(4)'),
      tipo_registro = 'SECTRALDIA' --sector financiero real al dia     
    into   #dato_obliga_sfreald
    from   @w_xml.nodes('CIFIN/Tercero/SectorRealAlDia/Obligacion') as nTable(
           nCol )

    /********************* 7. TIPO REGISTRO SECTOR REAL EN MORA (LINEAS DE CREDITO) *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),
      --indica linea credito (tarjeta credito, obligaciones credito)
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(4)'),
      estado_contrato = nCol.value(N'(./EstadoContrato)[1]',
                                   'varchar(4)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      calidad = nCol.value(N'(./Calidad)[1]',
                           'char(4)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                 'varchar(4)'),
      periodicidad = nCol.value(N'(./Periodicidad)[1]',
                                'char(3)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      fecha_terminacion = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      valor_inicial = nCol.value(N'(./ValorInicial)[1]',
                                 'money'),
      saldo_oblig = nCol.value(N'(./SaldoObligacion)[1]',
                               'money'),
      saldo_mora = nCol.value(N'(./ValorMora)[1]',
                              'money'),
      valor_cuota = nCol.value(N'(./ValorCuota)[1]',
                               'money'),
      cuotas_canceladas = nCol.value(N'(./CuotasCanceladas)[1]',
                                     'int'),
      max_mora = nCol.value(N'(./MoraMaxima)[1]',
                            'varchar(4)'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(74)'),
      participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                                    'int'),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      modo_extincion = nCol.value(N'(./ModoExtincion)[1]',
                                  'varchar(3)'),
      fecha_pago = nCol.value(N'(./FechaPago)[1]',
                              'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      chq_devueltos = nCol.value(N'(./ChequesDevueltos)[1]',
                                 'int'),
      cubrito_garant = nCol.value(N'(./plazo)[1]',
                                  'int'),
      dias_cartera = nCol.value(N'(./DiasCartera)[1]',
                                'smallint'),
      tipo_pago = nCol.value(N'(./TipoPago)[1]',
                             'varchar(3)'),
      estado_tit = nCol.value(N'(./EstadoTitular)[1]',
                              'varchar(4)'),
      nro_cuota_pactada = nCol.value(N'(./NumeroCuotasPactadas)[1]',
                                     'int'),
      nro_cuota_mora = nCol.value(N'(./NumeroCuotasMora)[1]',
                                  'int'),
      valor_cargo_fijo = nCol.value(N'(./ValorCargoFijo)[1]',
                                    'money'),
      clausu_perm = nCol.value(N'(./ClausulaPermanencia)[1]',
                               'char(4)'),
      restructurado = nCol.value(N'(./Reestructurado)[1]',
                                 'varchar(2)'),
      vigencia = nCol.value(N'(./Vigencia )[1]',
                            'char(3)'),
      nro_meses_contrato = nCol.value(N'(./NumeroMesesContrato)[1]',
                                      'int'),
      nro_meses_clausula = nCol.value(N'(./NumeroMesesClausula)[1]',
                                      'varchar(4)'),
      tipo_registro = 'SECRENMORA' --sector real en mora     
    into   #dato_obliga_sfrealm
    from   @w_xml.nodes('CIFIN/Tercero/SectorRealEnMora/Obligacion') as nTable(
           nCol)

    /********************* 8. TIPO REGISTRO SECTOR REAL EXTINGUIDAS (LINEAS DE CREDITO) *************************/
    select
      tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                'char(4)'),
      --indica linea credito (tarjeta credito, obligaciones credito)
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      tipo_contrato = nCol.value(N'(./TipoContrato)[1]',
                                 'char(4)'),
      estado_contrato = nCol.value(N'(./EstadoContrato)[1]',
                                   'varchar(4)'),
      tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                'varchar(10)'),
      entidad = nCol.value(N'(./NombreEntidad)[1]',
                           'varchar(100)'),
      ciudad = nCol.value(N'(./Ciudad)[1]',
                          'varchar(100)'),
      sucursal = nCol.value(N'(./Sucursal)[1]',
                            'varchar(100)'),
      num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                              'varchar(10)'),
      calidad = nCol.value(N'(./Calidad)[1]',
                           'char(4)'),
      estado_oblig = nCol.value(N'(./EstadoObligacion)[1]',
                                'char(5)'),
      linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                 'varchar(4)'),
      periodicidad = nCol.value(N'(./Periodicidad)[1]',
                                'char(3)'),
      fecha_apertura = nCol.value(N'(./FechaApertura)[1]',
                                  'varchar(16)'),
      cupo = nCol.value(N'(./ValorInicial)[1]',
                        'money'),
      saldo_oblig = nCol.value(N'(./SaldoObligacion)[1]',
                               'money'),
      saldo_mora = nCol.value(N'(./ValorMora)[1]',
                              'money'),
      valor_cuota = nCol.value(N'(./ValorCuota)[1]',
                               'money'),
      cuotas_canceladas = nCol.value(N'(./CuotasCanceladas)[1]',
                                     'int'),
      max_mora = nCol.value(N'(./MoraMaxima)[1]',
                            'varchar(4)'),
      comportamiento = nCol.value(N'(./Comportamientos)[1]',
                                  'varchar(74)'),
      participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                                    'int'),
      fecha_corte = nCol.value(N'(./FechaCorte)[1]',
                               'varchar(16)'),
      modo_extincion = nCol.value(N'(./ModoExtincion)[1]',
                                  'varchar(3)'),
      fecha_pago = nCol.value(N'(./FechaPago)[1]',
                              'varchar(16)'),
      fecha_permanencia = nCol.value(N'(./FechaPermanencia)[1]',
                                     'varchar(16)'),
      chq_devueltos = nCol.value(N'(./ChequesDevueltos)[1]',
                                 'int'),
      tipo_pago = nCol.value(N'(./TipoPago)[1]',
                             'varchar(3)'),
      estado_tit = nCol.value(N'(./EstadoTitular)[1]',
                              'varchar(4)'),
      nro_cuota_pactada = nCol.value(N'(./NumeroCuotasPactadas)[1]',
                                     'int'),
      nro_cuota_mora = nCol.value(N'(./NumeroCuotasMora)[1]',
                                  'int'),
      valor_cargo_fijo = nCol.value(N'(./ValorCargoFijo)[1]',
                                    'money'),
      clausu_perm = nCol.value(N'(./ClausulaPermanencia)[1]',
                               'char(4)'),
      restructurado = nCol.value(N'(./Reestructurado)[1]',
                                 'varchar(2)'),
      vigencia = nCol.value(N'(./Vigencia )[1]',
                            'char(3)'),
      nro_meses_contrato = nCol.value(N'(./NumeroMesesContrato)[1]',
                                      'int'),
      nro_meses_clausula = nCol.value(N'(./NumeroMesesClausula)[1]',
                                      'varchar(4)'),
      dias_cartera = nCol.value(N'(./DiasCartera)[1]',
                                'int'),
      plazo = nCol.value(N'(./plazo)[1]',
                         'int'),
      fecha_terminacion = nCol.value(N'(./FechaTerminacion)[1]',
                                     'varchar(16)'),
      tipo_registro = 'SECREXTING' --sector REAL extinguidas
    into   #dato_obliga_srealext
    from   @w_xml.nodes('CIFIN/Tercero/SectorRealExtinguidas/Obligacion') as
           nTable(nCol)

    /*************************** 9.TIPO REGISTRO MENSAJES Y RECLAMOS TITULAR**************************/
    select
      paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                               'varchar(4)'),
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      descripcion = nCol.value(N'(./Descripcion)[1]',
                               'varchar(400)'),
      tipo_registro = 'TITMENSAJE' --tercero mensaje
    into   #mensaje_titular
    from   @w_xml.nodes('CIFIN/Tercero/Mensajes/Mensaje') as nTable(nCol)
    /*************************** 9a.TIPO REGISTRO MENSAJES Y RECLAMOS CTAS VIGENTES**************************/
    select
      paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                               'varchar(4)'),
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      descripcion = nCol.value(N'(./Descripcion)[1]',
                               'varchar(400)'),
      tipo_registro = 'CTAVIGMENS' --Cuenta vigente dia mensaje
    into   #mensaje_ctavig
    from
     @w_xml.nodes('CIFIN/Tercero/CuentasVigentes/Obligacion/Mensajes/Mensaje')
     as
     nTable(nCol)

    /*************************** 9b.TIPO REGISTRO MENSAJES Y RECLAMOS CTAS EXTINGUIDAS***********************/
    select
      paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                               'varchar(4)'),
      identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                                   'varchar(100)'),
      --identifica rela con mensajes
      descripcion = nCol.value(N'(./Descripcion)[1]',
                               'varchar(400)'),
      tipo_registro = 'CTAEXTMENS' --cuenta extinguida mensaje
    into   #mensaje_ctaext
    from
@w_xml.nodes('CIFIN/Tercero/CuentasExtinguidas/Obligacion/Mensajes/Mensaje')
as
nTable(nCol)

/*************************** 9c.TIPO REGISTRO MENSAJES Y RECLAMOS SF DIA*********************************/
select
 paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                          'varchar(4)'),
 identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                              'varchar(100)'),--identifica rela con mensajes
 descripcion = nCol.value(N'(./Descripcion)[1]',
                          'varchar(400)'),
 tipo_registro = 'SFDIAMENSA' --sector financiero diario mensajes   
into   #mensaje_sfdia
from
@w_xml.nodes('CIFIN/Tercero/SectorFinancieroAlDia/obligacion/Mensajes/Mensaje')
as nTable(nCol)

/*************************** 9d.TIPO REGISTRO MENSAJES Y RECLAMOS SF MORA*********************************/
select
 paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                          'varchar(4)'),
 identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                              'varchar(100)'),--identifica rela con mensajes
 descripcion = nCol.value(N'(./Descripcion)[1]',
                          'varchar(400)'),
 tipo_registro = 'SFMORAMENS' --sector financiero mora mensajes   
into   #mensaje_sfmora
from
@w_xml.nodes('CIFIN/Tercero/SectorFinancieroEnMora/Obligacion/Mensajes/Mensaje')
as nTable(nCol)

/*************************** 9e.TIPO REGISTRO MENSAJES Y RECLAMOS SR DIA*********************************/
select
 paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                          'varchar(4)'),
 identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                              'varchar(100)'),--identifica rela con mensajes
 descripcion = nCol.value(N'(./Descripcion)[1]',
                          'varchar(400)'),
 tipo_registro = 'SRDIAMENSA' --sector real dia mensaje
into   #mensaje_srdia
from
@w_xml.nodes('CIFIN/Tercero/SectorRealAlDia/Obligacion/Mensajes/Mensaje') as
nTable(nCol)

/*************************** 9f.TIPO REGISTRO MENSAJES Y RECLAMOS SR MORA********************************/
select
 paquete_reg = nCol.value(N'(./PaqueteRegistro)[1]',
                          'varchar(4)'),
 identificalinea = nCol.value(N'(./IdentificadorLinea)[1]',
                              'varchar(100)'),--identifica rela con mensajes
 descripcion = nCol.value(N'(./Descripcion)[1]',
                          'varchar(400)'),
 tipo_registro = 'SRMORMENSA' --sector real mora mensajes
into   #mensaje_srmora
from
@w_xml.nodes('CIFIN/Tercero/SectorRealEnMora/Obligacion/Mensajes/Mensaje') as
nTable(nCol)

/*************************** 10.TIPO REGISTRO CONSOLIDADO PRINCIPAL*********************************/
select
 tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                           'varchar(100)'),
 numero_obliga = nCol.value(N'(./NumeroObligaciones)[1]',
                            'int'),
 total_saldo = nCol.value(N'(./TotalSaldo)[1]',
                          'money'),
 participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                               'int'),
 numero_obli_dia = nCol.value(N'(./NumeroObligacionesDia)[1]',
                              'int'),
 saldo_obli_dia = nCol.value(N'(./SaldoObligacionesDia)[1]',
                             'money'),
 cuota_obli_dia = nCol.value(N'(./CuotaObligacionesDia)[1]',
                             'money'),
 cant_obli_mora = nCol.value(N'(./CantidadObligacionesMora)[1]',
                             'int'),
 saldo_Obli_mora = nCol.value(N'(./SaldoObligacionesMora)[1]',
                              'money'),
 cuota_Obli_mora = nCol.value(N'(./CuotaObligacionesMora)[1]',
                              'money'),
 valor_mora = nCol.value(N'(./ValorMora)[1]',
                         'money'),
 tipo_registro = 'CONSOLPRIN' -- consolidado principal   
into   #dato_consolidado_ppal
from   @w_xml.nodes('CIFIN/Tercero/Consolidado/ResumenPrincipal/Registro') as
      nTable(
      nCol)

/*************************** 10A.TIPO REGISTRO CONSOLIDADO CODEUDOR*********************************/
select
 tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                           'varchar(100)'),
 numero_obliga = nCol.value(N'(./NumeroObligaciones)[1]',
                            'int'),
 total_saldo = nCol.value(N'(./TotalSaldo)[1]',
                          'money'),
 participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                               'int'),
 numero_obli_dia = nCol.value(N'(./NumeroObligacionesDia)[1]',
                              'int'),
 saldo_obli_dia = nCol.value(N'(./SaldoObligacionesDia)[1]',
                             'money'),
 cuota_obli_dia = nCol.value(N'(./CuotaObligacionesDia)[1]',
                             'money'),
 cant_obli_mora = nCol.value(N'(./CantidadObligacionesMora)[1]',
                             'int'),
 saldo_Obli_mora = nCol.value(N'(./SaldoObligacionesMora)[1]',
                              'money'),
 cuota_Obli_mora = nCol.value(N'(./CuotaObligacionesMora)[1]',
                              'money'),
 valor_mora = nCol.value(N'(./ValorMora)[1]',
                         'money'),
 tipo_registro = 'CONSOLCODE' -- consolidado codeudor   
into   #dato_consolidado_cod
from
@w_xml.nodes('CIFIN/Tercero/Consolidado/ResumenDiferentePrincipal/Registro')
as
nTable(nCol)

/*************************** 10B.TIPO REGISTRO CONSOLIDADO TOTAL (PPAL/CODEUDOR)*********************************/
select
 tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                           'varchar(100)'),
 numero_obliga = nCol.value(N'(./NumeroObligaciones)[1]',
                            'int'),
 total_saldo = nCol.value(N'(./TotalSaldo)[1]',
                          'money'),
 participac_deuda = nCol.value(N'(./ParticipacionDeuda)[1]',
                               'int'),
 numero_obli_dia = nCol.value(N'(./NumeroObligacionesDia)[1]',
                              'int'),
 saldo_obli_dia = nCol.value(N'(./SaldoObligacionesDia)[1]',
                             'money'),
 cuota_obli_dia = nCol.value(N'(./CuotaObligacionesDia)[1]',
                             'money'),
 cant_obli_mora = nCol.value(N'(./CantidadObligacionesMora)[1]',
                             'int'),
 saldo_Obli_mora = nCol.value(N'(./SaldoObligacionesMora)[1]',
                              'money'),
 cuota_Obli_mora = nCol.value(N'(./CuotaObligacionesMora)[1]',
                              'money'),
 valor_mora = nCol.value(N'(./ValorMora)[1]',
                         'money'),
 tipo_registro = 'TOTALPRICO' -- consolidado TOTALES
into   #dato_totales
from   @w_xml.nodes('CIFIN/Tercero/Consolidado/Registro') as nTable(nCol)

/***************************11. TIPO REGISTRO S C O R E S ***************************************/
--en que clase de registro existe en las tramas enviadas solo estaba en una la que maneja NIT
select
 ind_score = nCol.value(N'(./IndicadorScore)[1]',
                        'int'),
 tipo = nCol.value(N'(./TipoScore)[1]',
                   'varchar(64)'),
 codigo = nCol.value(N'(./CodigoScore)[1]',
                     'varchar(64)'),
 puntaje = nCol.value(N'(./Puntaje)[1]',
                      'varchar(20)'),
 tasa_morosidad = nCol.value(N'(./TasaMorosidad)[1]',
                             'varchar(20)'),
 ind_default = nCol.value(N'(./IndicadorDefault)[1]',
                          'varchar(6)'),
 sub_pobl = nCol.value(N'(./SubPoblacion)[1]',
                       'int'),
 Politica = nCol.value(N'(./Politica )[1]',
                       'int'),
 observacion = nCol.value(N'(./Observacion)[1]',
                          'varchar(254)')
into   #dato_score
from   @w_xml.nodes('CIFIN/Tercero/Score') as nTable(nCol)

/*************************** 12. TIPO REGISTRO HUELLA CONSULTA***************************************/
select
 fecha = nCol.value(N'(./FechaConsulta)[1]',
                    'varchar(16)'),
 tipo_cuenta = nCol.value(N'(./NombreTipoEntidad)[1]',
                          'varchar(10)'),
 entidad = nCol.value(N'(./NombreEntidad)[1]',
                      'varchar(100)'),
 sucursal = nCol.value(N'(./Sucursal)[1]',
                       'varchar(100)'),
 ciudad = nCol.value(N'(./Ciudad)[1]',
                     'varchar(100)'),
 motivi_cons = nCol.value(N'(./MotivoConsulta)[1]',
                          'varchar(100)'),
 cod_tipo_ent = nCol.value(N'(./CodigoTipoEntidad)[1]',
                           'int'),
 cod_ent = nCol.value(N'(./CodigoEntidad)[1]',
                      'int')
into   #dato_hconsulta
from   @w_xml.nodes('CIFIN/Tercero/HuellaConsulta/Consulta') as nTable(nCol)

/*************************** 13. TIPO REGISTRO ENCABEZADO ENDEUDAMIENTO GLOBAL*******************************/
select
 ent_trim1 = nCol.value(N'(./NumeroEntidadesTrimestreI)[1]',
                        'int'),
 fecha_trim1 = nCol.value(N'(./FechaTrimestreI)[1]',
                          'varchar(12)'),
 ent_trim2 = nCol.value(N'(./NumeroEntidadesTrimestreII)[1]',
                        'int'),
 fecha_trim2 = nCol.value(N'(./FechaTrimestreII)[1]',
                          'varchar(12)'),
 ent_trim3 = nCol.value(N'(./NumeroEntidadesTrimestreIII)[1]',
                        'int'),
 fecha_trim3 = nCol.value(N'(./FechaTrimestreIII)[1]',
                          'varchar(12)'),
 cmp_trim1 = nCol.value(N'(./NumeroComprasTrimestreI)[1]',
                        'int'),
 cmp_trim2 = nCol.value(N'(./NumeroComprasTrimestreII)[1]',
                        'int'),
 cmp_trim3 = nCol.value(N'(./NumeroComprasTrimestreIII)[1]',
                        'int'),
 ree_trim1 = nCol.value(N'(./NumeroReestructuracionesTrimestreI)[1]',
                        'int'),
 ree_trim2 = nCol.value(N'(./NumeroReestructuracionesTrimestreII)[1]',
                        'int'),
 ree_trim3 = nCol.value(N'(./NumeroReestructuracionesTrimestreIII)[1]',
                        'int'),
 cas_trim1 = nCol.value(N'(./NumeroCastigosTrimestreI)[1]',
                        'int'),
 cas_trim2 = nCol.value(N'(./NumeroCastigosTrimestreII)[1]',
                        'int'),
 cas_trim3 = nCol.value(N'(./NumeroCastigosTrimestreIII)[1]',
                        'int')
into   #endeuda_encabezado
from   @w_xml.nodes('CIFIN/Tercero/Endeudamiento/EncabezadoEndeudamiento') as
      nTable(
      nCol)

/******************* 13A. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CONSOLIDADO *****************************/
select
 calificacion = nCol.value(N'(./Calificacion)[1]',
                           'varchar(5)'),
 tipo_moneda = nCol.value(N'(./TipoModena)[1]',
                          'varchar(5)'),
 num_op_comercial = nCol.value(N'(./NumeroOperacionesComercial)[1]',
                               'int'),
 num_op_consumo = nCol.value(N'(./NumeroOperacionesConsumo)[1]',
                             'int'),
 num_op_vivienda = nCol.value(N'(./NumeroOperacionesVivienda)[1]',
                              'int'),
 num_op_micro = nCol.value(N'(./NumeroOperacionesMicrocredito)[1]',
                           'int'),
 val_deu_comercial = nCol.value(N'(./ValorDeudaComercial)[1]',
                                'varchar(20)'),
 val_deu_consumo = nCol.value(N'(./ValorDeudaConsumo)[1]',
                              'varchar(20)'),
 val_deu_vivienda = nCol.value(N'(./ValorDeudaVivienda)[1]',
                               'varchar(20)'),
 val_deu_micro = nCol.value(N'(./ValorDeudaMicrocredito)[1]',
                            'varchar(20)'),
 total = nCol.value(N'(./Total)[1]',
                    'varchar(21)'),
 par_tot_deudas = nCol.value(N'(./ParticipacionTotalDeudas)[1]',
                             'varchar(5)'),
 cub_gar_comercial = nCol.value(N'(./CubrimientoGarantiaComercial)[1]',
                                'varchar(6)'),
 cub_gar_consumo = nCol.value(N'(./CubrimientoGarantiaConsumo)[1]',
                              'varchar(6)'),
 cub_gar_vivienda = nCol.value(N'(./CubrimientoGarantiaVivienda)[1]',
                               'varchar(6)'),
 cub_gar_micro = nCol.value(N'(./CubrimientoGarantiaMicrocredito)[1]',
                            'varchar(6)'),
 tipo_registro = 'TRIMI'
into   #endeuda_cons_trim1
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimI/Endeudamiento71')
as nTable(nCol)

/******************* 13B. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CONSOLIDADO *****************************/
select
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoModena)[1]',
                       'varchar(5)'),
num_op_comercial = nCol.value(N'(./NumeroOperacionesComercial)[1]',
                            'int'),
num_op_consumo = nCol.value(N'(./NumeroOperacionesConsumo)[1]',
                          'int'),
num_op_vivienda = nCol.value(N'(./NumeroOperacionesVivienda)[1]',
                           'int'),
num_op_micro = nCol.value(N'(./NumeroOperacionesMicrocredito)[1]',
                        'int'),
val_deu_comercial = nCol.value(N'(./ValorDeudaComercial)[1]',
                             'varchar(20)'),
val_deu_consumo = nCol.value(N'(./ValorDeudaConsumo)[1]',
                           'varchar(20)'),
val_deu_vivienda = nCol.value(N'(./ValorDeudaVivienda)[1]',
                            'varchar(20)'),
val_deu_micro = nCol.value(N'(./ValorDeudaMicrocredito)[1]',
                         'varchar(20)'),
total = nCol.value(N'(./Total)[1]',
                 'varchar(21)'),
par_tot_deudas = nCol.value(N'(./ParticipacionTotalDeudas)[1]',
                          'varchar(5)'),
cub_gar_comercial = nCol.value(N'(./CubrimientoGarantiaComercial)[1]',
                             'varchar(6)'),
cub_gar_consumo = nCol.value(N'(./CubrimientoGarantiaConsumo)[1]',
                           'varchar(6)'),
cub_gar_vivienda = nCol.value(N'(./CubrimientoGarantiaVivienda)[1]',
                            'varchar(6)'),
cub_gar_micro = nCol.value(N'(./CubrimientoGarantiaMicrocredito)[1]',
                         'varchar(6)'),
tipo_registro = 'TRIMII'
into   #endeuda_cons_trim2
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimII/Endeudamiento81')
as nTable(nCol)

/******************* 13C. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CONSOLIDADO *****************************/
select
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoModena)[1]',
                       'varchar(5)'),
num_op_comercial = nCol.value(N'(./NumeroOperacionesComercial)[1]',
                            'int'),
num_op_consumo = nCol.value(N'(./NumeroOperacionesConsumo)[1]',
                          'int'),
num_op_vivienda = nCol.value(N'(./NumeroOperacionesVivienda)[1]',
                           'int'),
num_op_micro = nCol.value(N'(./NumeroOperacionesMicrocredito)[1]',
                        'int'),
val_deu_comercial = nCol.value(N'(./ValorDeudaComercial)[1]',
                             'varchar(20)'),
val_deu_consumo = nCol.value(N'(./ValorDeudaConsumo)[1]',
                           'varchar(20)'),
val_deu_vivienda = nCol.value(N'(./ValorDeudaVivienda)[1]',
                            'varchar(20)'),
val_deu_micro = nCol.value(N'(./ValorDeudaMicrocredito)[1]',
                         'varchar(20)'),
total = nCol.value(N'(./Total)[1]',
                 'varchar(21)'),
par_tot_deudas = nCol.value(N'(./ParticipacionTotalDeudas)[1]',
                          'varchar(5)'),
cub_gar_comercial = nCol.value(N'(./CubrimientoGarantiaComercial)[1]',
                             'varchar(6)'),
cub_gar_consumo = nCol.value(N'(./CubrimientoGarantiaConsumo)[1]',
                           'varchar(6)'),
cub_gar_vivienda = nCol.value(N'(./CubrimientoGarantiaVivienda)[1]',
                            'varchar(6)'),
cub_gar_micro = nCol.value(N'(./CubrimientoGarantiaMicrocredito)[1]',
                         'varchar(6)'),
tipo_registro = 'TRIMIII'
into   #endeuda_cons_trim3
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimIII/Endeudamiento91')
as nTable(nCol)

/******************* 13D. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CONTINGENCIAS *****************************/
select
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(10)'),
num_contingencias = nCol.value(N'(./NumeroContingencias)[1]',
                             'int'),
val_contingencias = nCol.value(N'(./ValorContingencias)[1]',
                             'varchar(20)'),
cuota_esperada = nCol.value(N'(./CuotaEsperada)[1]',
                          'varchar(20)'),
cuota_cumplimiento = nCol.value(N'(./CumplimientoCuota)[1]',
                              'varchar(10)'),
tipo_registro = 'TRIMI'
into   #endeuda_cont_trim1
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimI/Endeudamiento72')
as nTable(nCol)

/******************* 13E. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CONTINGENCIAS *****************************/
select
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(10)'),
num_contingencias = nCol.value(N'(./NumeroContingencias)[1]',
                             'int'),
val_contingencias = nCol.value(N'(./ValorContingencias)[1]',
                             'varchar(20)'),
cuota_esperada = nCol.value(N'(./CuotaEsperada)[1]',
                          'varchar(20)'),
cuota_cumplimiento = nCol.value(N'(./CumplimientoCuota)[1]',
                              'varchar(10)'),
tipo_registro = 'TRIMII'
into   #endeuda_cont_trim2
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimII/Endeudamiento82')
as nTable(nCol)

/******************* 13F. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CONTINGENCIAS *****************************/
select
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(10)'),
num_contingencias = nCol.value(N'(./NumeroContingencias)[1]',
                             'int'),
val_contingencias = nCol.value(N'(./ValorContingencias)[1]',
                             'varchar(20)'),
cuota_esperada = nCol.value(N'(./CuotaEsperada)[1]',
                          'varchar(20)'),
cuota_cumplimiento = nCol.value(N'(./CumplimientoCuota)[1]',
                              'varchar(10)'),
tipo_registro = 'TRIMIII'
into   #endeuda_cont_trim3
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimIII/Endeudamiento92')
as nTable(nCol)

/******************* 13G. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - DETALLADO *****************************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(5)'),
num_operadores = nCol.value(N'(./NumeroOperadores)[1]',
                          'varchar(5)'),
valor_deuda = nCol.value(N'(./ValorDeuda)[1]',
                       'varchar(20)'),
par_tot_deudas = nCol.value(N'(./ParticipacionTotalDeudas)[1]',
                          'varchar(5)'),
cubrim_garantia = nCol.value(N'(./CubrimientoGarantia)[1]',
                           'varchar(10)'),
tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                         'varchar(10)'),
fecha_ult_avaluo = nCol.value(N'(./FechaUltimoAvaluo)[1]',
                            'varchar(15)'),
cuota_esperada = nCol.value(N'(./CuotaEsperada)[1]',
                          'varchar(15)'),
cumplim_cuota = nCol.value(N'(./CumplimientoCuota)[1]',
                         'varchar(10)'),
tipo_registro = 'TRIMI'
into   #endeuda_det_trim1
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimI/Endeudamiento73')
as nTable(nCol)

/******************* 13H. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - DETALLADO *****************************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(5)'),
num_operadores = nCol.value(N'(./NumeroOperadores)[1]',
                          'varchar(5)'),
valor_deuda = nCol.value(N'(./ValorDeuda)[1]',
                       'varchar(20)'),
par_tot_deudas = nCol.value(N'(./ParticipacionTotalDeudas)[1]',
                          'varchar(5)'),
cubrim_garantia = nCol.value(N'(./CubrimientoGarantia)[1]',
                           'varchar(10)'),
tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                         'varchar(10)'),
fecha_ult_avaluo = nCol.value(N'(./FechaUltimoAvaluo)[1]',
                            'varchar(15)'),
cuota_esperada = nCol.value(N'(./CuotaEsperada)[1]',
                          'varchar(15)'),
cumplim_cuota = nCol.value(N'(./CumplimientoCuota)[1]',
                         'varchar(10)'),
tipo_registro = 'TRIMII'
into   #endeuda_det_trim2
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimII/Endeudamiento83')
as nTable(nCol)

/******************* 13I. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - DETALLADO *****************************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(5)'),
num_operadores = nCol.value(N'(./NumeroOperadores)[1]',
                          'varchar(5)'),
valor_deuda = nCol.value(N'(./ValorDeuda)[1]',
                       'varchar(20)'),
par_tot_deudas = nCol.value(N'(./ParticipacionTotalDeudas)[1]',
                          'varchar(5)'),
cubrim_garantia = nCol.value(N'(./CubrimientoGarantia)[1]',
                           'varchar(10)'),
tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                         'varchar(10)'),
fecha_ult_avaluo = nCol.value(N'(./FechaUltimoAvaluo)[1]',
                            'varchar(15)'),
cuota_esperada = nCol.value(N'(./CuotaEsperada)[1]',
                          'varchar(15)'),
cumplim_cuota = nCol.value(N'(./CumplimientoCuota)[1]',
                         'varchar(10)'),
tipo_registro = 'TRIMIII'
into   #endeuda_det_trim3
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimIII/Endeudamiento93')
as nTable(nCol)

/********** 13J. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - REESTRUCTURACIONES **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
id_credito = nCol.value(N'(./IdentificacionCredito)[1]',
                      'varchar(20)'),
monto = nCol.value(N'(./Monto)[1]',
                 'varchar(20)'),
fecha_formaliza = nCol.value(N'(./FechaFormalizacion)[1]',
                           'varchar(10)'),
fecha_termina = nCol.value(N'(./FechaTerminacion)[1]',
                         'varchar(10)'),
numero_veces = nCol.value(N'(./NumeroVeces)[1]',
                        'int'),
tipo_reestruc = nCol.value(N'(./TipoReestructuracion)[1]',
                         'varchar(5)'),
peri_gracia_cap = nCol.value(N'(./PeriodoGraciaCapital)[1]',
                           'int'),
peri_gracia_int = nCol.value(N'(./PeriodoGraciaIntereses)[1]',
                           'int'),
factor_reest = nCol.value(N'(./FactorReestructuracion)[1]',
                        'varchar(5)'),
tipo_registro = 'TRIMI'
into   #endeuda_reest_trim1
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimI/Endeudamiento75')
as nTable(nCol)

/********** 13K. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - REESTRUCTURACIONES **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
id_credito = nCol.value(N'(./IdentificacionCredito)[1]',
                      'varchar(20)'),
monto = nCol.value(N'(./Monto)[1]',
                 'varchar(20)'),
fecha_formaliza = nCol.value(N'(./FechaFormalizacion)[1]',
                           'varchar(10)'),
fecha_termina = nCol.value(N'(./FechaTerminacion)[1]',
                         'varchar(10)'),
numero_veces = nCol.value(N'(./NumeroVeces)[1]',
                        'int'),
tipo_reestruc = nCol.value(N'(./TipoReestructuracion)[1]',
                         'varchar(5)'),
peri_gracia_cap = nCol.value(N'(./PeriodoGraciaCapital)[1]',
                           'int'),
peri_gracia_int = nCol.value(N'(./PeriodoGraciaIntereses)[1]',
                           'int'),
factor_reest = nCol.value(N'(./FactorReestructuracion)[1]',
                        'varchar(5)'),
tipo_registro = 'TRIMII'
into   #endeuda_reest_trim2
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimII/Endeudamiento85')
as nTable(nCol)

/********** 13L. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - REESTRUCTURACIONES **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
id_credito = nCol.value(N'(./IdentificacionCredito)[1]',
                      'varchar(20)'),
monto = nCol.value(N'(./Monto)[1]',
                 'varchar(20)'),
fecha_formaliza = nCol.value(N'(./FechaFormalizacion)[1]',
                           'varchar(10)'),
fecha_termina = nCol.value(N'(./FechaTerminacion)[1]',
                         'varchar(10)'),
numero_veces = nCol.value(N'(./NumeroVeces)[1]',
                        'int'),
tipo_reestruc = nCol.value(N'(./TipoReestructuracion)[1]',
                         'varchar(5)'),
peri_gracia_cap = nCol.value(N'(./PeriodoGraciaCapital)[1]',
                           'int'),
peri_gracia_int = nCol.value(N'(./PeriodoGraciaIntereses)[1]',
                           'int'),
factor_reest = nCol.value(N'(./FactorReestructuracion)[1]',
                        'varchar(5)'),
tipo_registro = 'TRIMIII'
into   #endeuda_reest_trim3
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimIII/Endeudamiento95')
as nTable(nCol)

/********** 13M. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CASTIGADOS **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
tipo_castigo = nCol.value(N'(./TipoCastigo)[1]',
                        'varchar(5)'),
num_acta_aprob = nCol.value(N'(./NumeroActaAprobacion)[1]',
                          'varchar(10)'),
calidad = nCol.value(N'(./Calidad)[1]',
                   'varchar(5)'),
fecha_otorg_ini = nCol.value(N'(./FechaOtorgamientoInicial)[1]',
                           'varchar(10)'),
valor_ini_oblig = nCol.value(N'(./ValorInicialObligacion)[1]',
                           'varchar(20)'),
valor_castigado = nCol.value(N'(./ValorCastigado)[1]',
                           'varchar(20)'),
tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                         'varchar(10)'),
valor_garantia = nCol.value(N'(./ValorGarantia)[1]',
                          'varchar(20)'),
tipo_registro = 'TRIMI'
into   #endeuda_cast_trim1
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimI/Endeudamiento77')
as nTable(nCol)

/********** 13N. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CASTIGADOS **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
tipo_castigo = nCol.value(N'(./TipoCastigo)[1]',
                        'varchar(5)'),
num_acta_aprob = nCol.value(N'(./NumeroActaAprobacion)[1]',
                          'varchar(10)'),
calidad = nCol.value(N'(./Calidad)[1]',
                   'varchar(5)'),
fecha_otorg_ini = nCol.value(N'(./FechaOtorgamientoInicial)[1]',
                           'varchar(10)'),
valor_ini_oblig = nCol.value(N'(./ValorInicialObligacion)[1]',
                           'money'),
valor_castigado = nCol.value(N'(./ValorCastigado)[1]',
                           'money'),
tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                         'varchar(10)'),
valor_garantia = nCol.value(N'(./ValorGarantia)[1]',
                          'money'),
tipo_registro = 'TRIMII'
into   #endeuda_cast_trim2
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimII/Endeudamiento87')
as nTable(nCol)

/********** 13O. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - CASTIGADOS **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
tipo_castigo = nCol.value(N'(./TipoCastigo)[1]',
                        'varchar(5)'),
num_acta_aprob = nCol.value(N'(./NumeroActaAprobacion)[1]',
                          'varchar(10)'),
calidad = nCol.value(N'(./Calidad)[1]',
                   'varchar(5)'),
fecha_otorg_ini = nCol.value(N'(./FechaOtorgamientoInicial)[1]',
                           'varchar(10)'),
valor_ini_oblig = nCol.value(N'(./ValorInicialObligacion)[1]',
                           'money'),
valor_castigado = nCol.value(N'(./ValorCastigado)[1]',
                           'money'),
tipo_garantia = nCol.value(N'(./TipoGarantia)[1]',
                         'varchar(10)'),
valor_garantia = nCol.value(N'(./ValorGarantia)[1]',
                          'money'),
tipo_registro = 'TRIMIII'
into   #endeuda_cast_trim3
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimIII/Endeudamiento97')
as nTable(nCol)

/********** 13P. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - COMPRA VENTA **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(5)'),
valor_deuda = nCol.value(N'(./ValorDeuda)[1]',
                       'varchar(20)'),
tipo_operacion = nCol.value(N'(./TipoOperacion)[1]',
                          'varchar(10)'),
clase_operacion = nCol.value(N'(./ClaseOperacion)[1]',
                           'varchar(10)'),
cond_contrato = nCol.value(N'(./CondicionContrato)[1]',
                         'varchar(10)'),
tipo_comp_vend = nCol.value(N'(./TipoCompradorVendedor)[1]',
                          'varchar(10)'),
tipo_ent_operacion = nCol.value(N'(./TipoEntidadOperacion)[1]',
                              'varchar(5)'),
nom_ent_operacion = nCol.value(N'(./NombreEntidadOperacion)[1]',
                             'varchar(15)'),
tipo_registro = 'TRIMI'
into   #endeuda_cmp_trim1
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimI/Endeudamiento78')
as nTable(nCol)

/********** 13Q. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - COMPRA VENTA **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(5)'),
valor_deuda = nCol.value(N'(./ValorDeuda)[1]',
                       'varchar(20)'),
tipo_operacion = nCol.value(N'(./TipoOperacion)[1]',
                          'varchar(10)'),
clase_operacion = nCol.value(N'(./ClaseOperacion)[1]',
                           'varchar(10)'),
cond_contrato = nCol.value(N'(./CondicionContrato)[1]',
                         'varchar(10)'),
tipo_comp_vend = nCol.value(N'(./TipoCompradorVendedor)[1]',
                          'varchar(10)'),
tipo_ent_operacion = nCol.value(N'(./TipoEntidadOperacion)[1]',
                              'varchar(5)'),
nom_ent_operacion = nCol.value(N'(./NombreEntidadOperacion)[1]',
                             'varchar(15)'),
tipo_registro = 'TRIMII'
into   #endeuda_cmp_trim2
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimII/Endeudamiento88')
as nTable(nCol)

/********** 13R. TIPO REGISTRO ENDEUDAMIENTO GLOBAL - COMPRA VENTA **********************/
select
tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                        'varchar(5)'),
nom_entidad = nCol.value(N'(./NombreEntidad)[1]',
                       'varchar(20)'),
tipo_ent_orig_car = nCol.value(N'(./TipoEntidadOriginadoraCartera)[1]',
                             'varchar(5)'),
nom_ent_orig_car = nCol.value(N'(./EntidadOriginadoraCartera)[1]',
                            'varchar(20)'),
tipo_fideicomiso = nCol.value(N'(./TipoFideicomiso)[1]',
                            'varchar(10)'),
num_fideicomiso = nCol.value(N'(./NumeroFideicomiso)[1]',
                           'varchar(15)'),
mod_credito = nCol.value(N'(./ModalidadCredito)[1]',
                       'varchar(5)'),
calificacion = nCol.value(N'(./Calificacion)[1]',
                        'varchar(5)'),
tipo_moneda = nCol.value(N'(./TipoMoneda)[1]',
                       'varchar(5)'),
valor_deuda = nCol.value(N'(./ValorDeuda)[1]',
                       'varchar(20)'),
tipo_operacion = nCol.value(N'(./TipoOperacion)[1]',
                          'varchar(10)'),
clase_operacion = nCol.value(N'(./ClaseOperacion)[1]',
                           'varchar(10)'),
cond_contrato = nCol.value(N'(./CondicionContrato)[1]',
                         'varchar(10)'),
tipo_comp_vend = nCol.value(N'(./TipoCompradorVendedor)[1]',
                          'varchar(10)'),
tipo_ent_operacion = nCol.value(N'(./TipoEntidadOperacion)[1]',
                              'varchar(5)'),
nom_ent_operacion = nCol.value(N'(./NombreEntidadOperacion)[1]',
                             'varchar(15)'),
tipo_registro = 'TRIMIII'
into   #endeuda_cmp_trim3
from
@w_xml.nodes('CIFIN/Tercero/Endeudamiento/EndeudamientoTrimIII/Endeudamiento98')
as nTable(nCol)

/*-----------------------------------*/
begin tran
/*-----------------------------------*/
/*********************  D A T O S   C L I E N T E    *************************/
insert into cobis..cl_ws_ente_tmp with(rowlock)
        (we_nomlar,we_ced_ruc,we_tip_ced,we_id_fecha_exp,we_id_ciudad_exp,
         we_id_estado,we_id_dpto_exp,we_cod_ciudad,we_cod_ciiu,
         we_rango_edad
         ,
         we_fecha_consulta,we_hora_consulta,we_nro_inf,
         we_id_validada,we_ente_int,
         we_activid_econ,we_estado_dcto,we_identificalinea,we_nacional,
         we_tipo_registro)
select
nombre_largo,@w_id_numero,tipoid,id_fechaExpedicion,id_LugarExpedicion,
id_estado,id_cod_dpto,id_cod_ciudad,id_cod_ciiu,rango_edad,
fecha_cons,hora_cons,nro_informe,cons_rpta,@w_ente,
nombre_ciiu,estado_dcto,identificalinea,entidad,tipo_registro
from   #dato_cliente_cf

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENTE EN cl_ws_ente_tmp'
rollback tran
goto ERROR
end

select
@w_secuencial = ident_current('cobis..cl_ws_ente_tmp')

/********************* REGISTROS CUENTAS VIGENTES AHORROS/CORRIENTES******************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_tipo_entidad,
         wo_entidad,
         wo_ciudad,wo_oficina,wo_num_cuenta,wo_estado,wo_fecha_apertura,
         wo_fecha_terminacion,wo_valor_inicial,wo_comportamiento,
         wo_fecha_ult_actualiza,wo_fecha_vencimiento,
         wo_chq_devueltos,wo_dias_cartera,wo_cupo,wo_dias_aut_sobregiro,
         wo_identificalinea,
         wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,tipo_entidad,entidad,
ciudad,sucursal,num_cuenta,estado_oblig,fecha_apertura,
fecha_terminacion,valor_inicial,comportamiento,fecha_corte,
fecha_permanencia
,
chq_devueltos,dias_cartera,cupo_sobregiro,dias_aut_sobregiro,
identificalinea,
tipo_registro
from   #dato_obliga_ctavig

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR OBLIG.CUENTAS VIGENTAS cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTROS CUENTAS EXTINGUIDAS AHORROS/CORRIENTES******************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_tipo_entidad,
         wo_entidad,
         wo_ciudad,wo_oficina,wo_num_cuenta,wo_estado,wo_fecha_apertura,
         wo_fecha_terminacion,wo_valor_inicial,wo_comportamiento,
         wo_fecha_ult_actualiza,wo_fecha_vencimiento,
         wo_chq_devueltos,wo_dias_cartera,wo_cupo,wo_dias_aut_sobregiro,
         wo_identificalinea,
         wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,tipo_entidad,entidad,
ciudad,sucursal,num_cuenta,estado_oblig,fecha_apertura,
fecha_terminacion,valor_inicial,comportamiento,fecha_corte,
fecha_permanencia
,
chq_devueltos,dias_cartera,cupo_sobregiro,dias_aut_sobregiro,
identificalinea,
tipo_registro
from   #dato_obliga_ctaext

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR OBLIG.CUENTAS EXTINGUIDAS cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTRO SECTOR FINANCIERO AL DIA (LINEAS DE CREDITO) ****************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_estado_contrato,
         wo_tipo_entidad,
         wo_entidad,wo_ciudad,wo_oficina,wo_num_cuenta,wo_amparada,
         wo_estado,wo_tipo_obigacion,wo_linea_credito,wo_periodicidad,
         wo_fecha_apertura,
         wo_fecha_vencimiento,wo_calificacion,wo_cupo,wo_saldo_act,
         wo_saldo_mora,
         wo_cuota,wo_tipo_moneda,wo_nro_cuotas_cancl,wo_garante,
         wo_cubrim_garantia,
         wo_max_mora,wo_comportamiento,wo_participac_deuda,
         wo_ProbabilidadNoPago,wo_fecha_ult_actualiza,
         wo_forma_pago,wo_fecha_pago,wo_fecha_permanencia,wo_nro_restructu
         ,
         wo_nat_restructu,
         wo_tipoent_orig_cart,wo_ent_orig_cart,wo_tipo_pago,wo_estado_tit,
         wo_dias_aut_sobregiro,
         wo_dias_cartera,wo_restructurado,wo_marca_tarj,wo_clase_tarj,
         wo_tipo_fideicomiso,
         wo_nro_fideicomiso,wo_identificalinea,wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,estado_contrato,tipo_entidad,
entidad,ciudad,sucursal,num_obliga,calidad,
estado_oblig,modalidad_cred,linea_credito,periodicidad,fecha_apertura,
fecha_vencimiento,calificacion,valor_inicial,saldo_oblig,saldo_mora,
valor_cuota,tipo_moneda,nro_cuotas_cancl,tipo_garantia,cubrim_garantia,
max_mora,comportamiento,participac_deuda,ProbabilidadNoPago,fecha_corte,
modo_extincion,fecha_pago,fecha_permanencia,nro_restructu,nat_restructu,
tipoent_orig_cart,ent_orig_cart,tipo_pago,estado_tit,nro_cuota_pactada,
dias_cartera,restructurado,marca_tarj,clase_tarj,tipo_fideicomiso,
nro_fideicomiso,identificalinea,tipo_registro
from   #dato_obliga_sfdia

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR OBLIG.SECTOR FINANCIERO AL DIA cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTRO SECTOR FINANCIERO EN MORA (LINEAS DE CREDITO) ****************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_estado_contrato,
         wo_tipo_entidad,
         wo_entidad,wo_ciudad,wo_oficina,wo_num_cuenta,wo_amparada,
         wo_estado,wo_tipo_obigacion,wo_linea_credito,wo_periodicidad,
         wo_fecha_apertura,
         wo_fecha_vencimiento,wo_calificacion,wo_cupo,wo_saldo_act,
         wo_saldo_mora,
         wo_cuota,wo_tipo_moneda,wo_nro_cuotas_cancl,wo_garante,
         wo_cubrito_garant,
         wo_max_mora,wo_comportamiento,wo_participac_deuda,
         wo_ProbabilidadNoPago,wo_fecha_ult_actualiza,
         wo_forma_pago,wo_fecha_pago,wo_fecha_permanencia,wo_nro_restructu
         ,
         wo_nat_restructu,
         wo_tipoent_orig_cart,wo_ent_orig_cart,wo_tipo_pago,wo_estado_tit,
         wo_dias_aut_sobregiro,
         wo_dias_cartera,wo_restructurado,wo_marca_tarj,wo_clase_tarj,
         wo_tipo_fideicomiso,
         wo_nro_fideicomiso,wo_identificalinea,wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,estado_contrato,tipo_entidad,
entidad,ciudad,sucursal,num_obliga,calidad,
estado_oblig,modalidad_cred,linea_credito,periodicidad,fecha_apertura,
fecha_vencimiento,calificacion,valor_inicial,saldo_oblig,saldo_mora,
valor_cuota,tipo_moneda,nro_cuotas_cancl,tipo_garantia,cubrito_garant,
max_mora,comportamiento,participac_deuda,ProbabilidadNoPago,fecha_corte,
modo_extincion,fecha_pago,fecha_permanencia,nro_restructu,nat_restructu,
tipoent_orig_cart,ent_orig_cart,tipo_pago,estado_tit,nro_cuota_pactada,
dias_cartera,restructurado,marca_tarj,clase_tarj,tipo_fideicomiso,
nro_fideicomiso,identificalinea,tipo_registro
from   #dato_obliga_sfmora

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR OBLIG.SECTOR FINANCIERO EN MORA cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTRO SECTOR FINANCIERO EN EXTINCION (LINEAS DE CREDITO) ****************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_estado_contrato,
         wo_tipo_entidad,
         wo_entidad,wo_ciudad,wo_oficina,wo_num_cuenta,wo_amparada,
         wo_estado,wo_tipo_obigacion,wo_linea_credito,wo_periodicidad,
         wo_fecha_apertura,
         wo_fecha_vencimiento,wo_calificacion,wo_cupo,wo_saldo_act,
         wo_saldo_mora,
         wo_cuota,wo_tipo_moneda,wo_nro_cuotas_cancl,wo_garante,
         wo_cubrim_garantia,
         wo_max_mora,wo_comportamiento,wo_participac_deuda,
         wo_ProbabilidadNoPago,wo_fecha_ult_actualiza,
         wo_forma_pago,wo_fecha_pago,wo_fecha_permanencia,wo_nro_restructu
         ,
         wo_nat_restructu,
         wo_tipoent_orig_cart,wo_ent_orig_cart,wo_tipo_pago,wo_estado_tit,
         wo_dias_aut_sobregiro,
         wo_dias_cartera,wo_restructurado,wo_identificalinea,
         wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,estado_contrato,tipo_entidad,
entidad,ciudad,sucursal,num_obliga,calidad,
estado_oblig,modalidad_cred,linea_credito,periodicidad,fecha_apertura,
fecha_vencimiento,calificacion,valor_inicial,saldo_oblig,saldo_mora,
valor_cuota,tipo_moneda,nro_cuotas_cancl,tipo_garantia,cubrim_garantia,
max_mora,comportamiento,participac_deuda,ProbabilidadNoPago,fecha_corte,
modo_extincion,fecha_pago,fecha_permanencia,nro_restructu,nat_restructu,
tipoent_orig_cart,ent_orig_cart,tipo_pago,estado_tit,dias_sobregiro,
dias_cartera,restructurado,identificalinea,tipo_registro
from   #dato_obliga_sfext

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR OBLIG.SECTOR FINANCIERO EN EXTINCION  cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTRO SECTOR REAL AL DIA (LINEAS DE CREDITO) ****************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_estado_contrato,
         wo_tipo_entidad,
         wo_entidad,wo_ciudad,wo_oficina,wo_num_cuenta,wo_amparada,
         wo_estado,wo_linea_credito,wo_periodicidad,wo_fecha_apertura,
         wo_fecha_vencimiento,
         wo_cupo,wo_saldo_act,wo_saldo_mora,wo_cuota,wo_nro_cuotas_cancl,
         wo_max_mora,wo_comportamiento,wo_participac_deuda,
         wo_fecha_ult_actualiza,wo_forma_pago,
         wo_fecha_pago,wo_fecha_permanencia,wo_chq_devueltos,wo_plazo,
         wo_dias_cartera,
         wo_tipo_pago,wo_estado_tit,wo_dias_aut_sobregiro,
         wo_nro_cuota_mora,
         wo_valor_inicial,
         wo_clausu_perm,wo_restructurado,wo_garante,wo_nro_restructu,
         wo_nat_restructu,
         wo_identificalinea,wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,estado_contrato,tipo_entidad,
entidad,ciudad,sucursal,num_obliga,calidad,
estado_oblig,linea_credito,periodicidad,fecha_apertura,fecha_terminacion,
valor_inicial,saldo_oblig,saldo_mora,valor_cuota,nro_cuotas_cancl,
max_mora,comportamiento,participac_deuda,fecha_corte,modo_extincion,
fecha_pago,fecha_permanencia,chq_devueltos,plazo,dias_cartera,
tipo_pago,estado_tit,nro_cuota_pactada,nro_cuota_mora,valor_cargo_fijo,
clausu_perm,restructurado,vigencia,nro_meses_contrato,nro_meses_clausula,
identificalinea,tipo_registro
from   #dato_obliga_sfreald

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR OBLIG.SECTOR REAL AL DIA cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTRO SECTOR REAL MORA (LINEAS DE CREDITO) ****************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_estado_contrato,
         wo_tipo_entidad,
         wo_entidad,wo_ciudad,wo_oficina,wo_num_cuenta,wo_amparada,
         wo_estado,wo_linea_credito,wo_periodicidad,wo_fecha_apertura,
         wo_fecha_vencimiento,
         wo_cupo,wo_saldo_act,wo_saldo_mora,wo_cuota,wo_cuotas_canceladas,
         wo_max_mora,wo_comportamiento,wo_participac_deuda,
         wo_fecha_ult_actualiza,wo_forma_pago,
         wo_fecha_pago,wo_fecha_permanencia,wo_chq_devueltos,
         wo_cubrito_garant,wo_dias_cartera,
         wo_tipo_pago,wo_estado_tit,wo_dias_aut_sobregiro,
         wo_nro_cuota_mora,
         wo_valor_inicial,
         wo_clausu_perm,wo_restructurado,wo_garante,wo_nro_restructu,
         wo_nat_restructu,
         wo_identificalinea,wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,estado_contrato,tipo_entidad,
entidad,ciudad,sucursal,num_obliga,calidad,
estado_oblig,linea_credito,periodicidad,fecha_apertura,fecha_terminacion,
valor_inicial,saldo_oblig,saldo_mora,valor_cuota,cuotas_canceladas,
max_mora,comportamiento,participac_deuda,fecha_corte,modo_extincion,
fecha_pago,fecha_permanencia,chq_devueltos,cubrito_garant,dias_cartera,
tipo_pago,estado_tit,nro_cuota_pactada,nro_cuota_mora,valor_cargo_fijo,
clausu_perm,restructurado,vigencia,nro_meses_contrato,nro_meses_clausula,
identificalinea,tipo_registro
from   #dato_obliga_sfrealm

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR OBLIG.SECTOR REAL EN MORA cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/********************* REGISTRO SECTOR REAL EXTINGUIDO (LINEAS DE CREDITO) ****************/
insert into cobis..cl_ws_obligacion_tmp with(rowlock)
        (wo_secuencial,wo_tip_producto,wo_tipo_cuenta,wo_estado_contrato,
         wo_tipo_entidad,
         wo_entidad,wo_ciudad,wo_oficina,wo_num_cuenta,wo_amparada,
         wo_estado,wo_linea_credito,wo_periodicidad,wo_fecha_apertura,
         wo_cupo,
         wo_saldo_act,wo_saldo_mora,wo_cuota,wo_cuotas_canceladas,
         wo_max_mora,
         wo_comportamiento,wo_participac_deuda,wo_fecha_ult_actualiza,
         wo_forma_pago,wo_fecha_pago,
         wo_fecha_permanencia,wo_chq_devueltos,wo_tipo_pago,wo_estado_tit,
         wo_dias_aut_sobregiro,
         wo_nro_cuota_mora,wo_valor_inicial,wo_clausu_perm,
         wo_restructurado,
         wo_garante,
         wo_nro_restructu,wo_nat_restructu,wo_dias_cartera,
         wo_cubrito_garant
         ,wo_fecha_vencimiento,
         wo_identificalinea,wo_tipo_registro)
select
@w_secuencial,tip_producto,tipo_contrato,estado_contrato,tipo_entidad,
entidad,ciudad,sucursal,num_obliga,calidad,
estado_oblig,linea_credito,periodicidad,fecha_apertura,cupo,
saldo_oblig,saldo_mora,valor_cuota,cuotas_canceladas,max_mora,
comportamiento,participac_deuda,fecha_corte,modo_extincion,fecha_pago,
fecha_permanencia,chq_devueltos,tipo_pago,estado_tit,nro_cuota_pactada,
nro_cuota_mora,valor_cargo_fijo,clausu_perm,restructurado,vigencia,
nro_meses_contrato,nro_meses_clausula,dias_cartera,plazo,fecha_terminacion
,
identificalinea,tipo_registro
from   #dato_obliga_srealext

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR OBLIG.SECTOR REAL EXTINGUIDO cl_ws_obligacion_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS tercero************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_titular

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES TERCERO cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS sector financiero diario************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_sfdia

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES SECTOR FIANCIERO DIA cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS sector financiero mora************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_sfmora

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES SECTOR FIANCIERO MORA  cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS sector real diario************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_srdia

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES SECTOR REAL DIARIO  cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS sector real mora************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_srmora

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES SECTOR REAL MORA cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS CUENTA VIGENTE************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_ctavig

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES CUENTA VIGENTE cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** MENSAJES POR REGISTROS CUENTA EXTINGUIDA************/
insert into cobis..cl_ws_alerta_tmp with(rowlock)
        (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
         wa_identificalinea,
         wa_tipo_registro)
select
row_number()
  over(
    order by identificalinea) [codigo],@w_secuencial,paquete_reg,
descripcion
,
identificalinea,
tipo_registro
from   #mensaje_ctaext

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR MENSAJES CUENTA EXTINGUIDA cl_ws_alerta_tmp'
rollback tran
goto ERROR
end

/*************************** S C O R E S ***************************************/
insert into cobis..cl_ws_score_tmp with(rowlock)
        (ws_secuencial,ws_ind_score,ws_tipo,ws_codigos,ws_puntaje,
         ws_tasa_morosidad,ws_ind_default,ws_sub_pobl,ws_politica,
         ws_observacion)
select
@w_secuencial,ind_score,tipo,codigo,puntaje,
tasa_morosidad,ind_default,sub_pobl,Politica,observacion
from   #dato_score

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR SCORES EN cl_ws_score_tmp'
rollback tran
goto ERROR
end

/*************************** HUELLA CONSULTAS *********************************/
insert into cobis..cl_ws_consulta_tmp with(rowlock)
        (wc_secuencial,wc_fecha,wc_tipo_cuenta,wc_entidad,wc_oficina,
         wc_ciudad,wc_motivi_cons,wc_cod_tipo_ent,wc_cod_ent)
select
@w_secuencial,fecha,tipo_cuenta,entidad,sucursal,
ciudad,motivi_cons,cod_tipo_ent,cod_ent
from   #dato_hconsulta

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR CONSULTAS EN cl_ws_consulta_tmp'
rollback tran
goto ERROR
end

/*************************** CONSOLIDADO PRINCIPAL *********************************/
insert into cobis..cl_ws_endeuda_tmp with(rowlock)
        (we_secuencial,we_tip_producto,we_numero_creditos,we_total_saldo,
         we_participac_deuda,
         we_numero_Obli_dia,we_saldo_Obli_dia,we_cuota_Obli_dia,
         we_cant_Obli_mora,we_saldo_Obli_mora,
         we_cuota_Obli_mora,we_saldo_pendiente,we_tipo_registro)
select
@w_secuencial,tip_producto,numero_obliga,total_saldo,participac_deuda,
numero_obli_dia,saldo_obli_dia,cuota_obli_dia,cant_obli_mora,
saldo_Obli_mora
,
cuota_Obli_mora,valor_mora,tipo_registro
from   #dato_consolidado_ppal

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR CONSOLIDADO PRINCIPAL cl_ws_endeuda_tmp'
rollback tran
goto ERROR
end

/*************************** CONSOLIDADO CODEUDOR *********************************/
insert into cobis..cl_ws_endeuda_tmp with(rowlock)
        (we_secuencial,we_tip_producto,we_numero_creditos,we_total_saldo,
         we_participac_deuda,
         we_numero_Obli_dia,we_saldo_Obli_dia,we_cuota_Obli_dia,
         we_cant_Obli_mora,we_saldo_Obli_mora,
         we_cuota_Obli_mora,we_saldo_pendiente,we_tipo_registro)
select
@w_secuencial,tip_producto,numero_obliga,total_saldo,participac_deuda,
numero_obli_dia,saldo_obli_dia,cuota_obli_dia,cant_obli_mora,
saldo_Obli_mora
,
cuota_Obli_mora,valor_mora,tipo_registro
from   #dato_consolidado_cod

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR CONSOLIDADO CODEUDOR cl_ws_endeuda_tmp'
rollback tran
goto ERROR
end

/*************************** CONSOLIDADO TOTAL *********************************/
insert into cobis..cl_ws_endeuda_tmp with(rowlock)
        (we_secuencial,we_tip_producto,we_numero_creditos,we_total_saldo,
         we_participac_deuda,
         we_numero_Obli_dia,we_saldo_Obli_dia,we_cuota_Obli_dia,
         we_cant_Obli_mora,we_saldo_Obli_mora,
         we_cuota_Obli_mora,we_saldo_pendiente,we_tipo_registro)
select
@w_secuencial,tip_producto,numero_obliga,total_saldo,participac_deuda,
numero_obli_dia,saldo_obli_dia,cuota_obli_dia,cant_obli_mora,
saldo_Obli_mora
,
cuota_Obli_mora,valor_mora,tipo_registro
from   #dato_totales

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR CONSOLIDADO PRINCIPAL cl_ws_endeuda_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO ENCABEZADO *********************************/
insert into cobis..cl_ws_endeu_encab_tmp with(rowlock)
        (wee_secuencial,wee_ent_trim1,wee_fecha_trim1,wee_ent_trim2,
         wee_fecha_trim2,
         wee_ent_trim3,wee_fecha_trim3,wee_cmp_trim1,wee_cmp_trim2,
         wee_cmp_trim3,
         wee_ree_trim1,wee_ree_trim2,wee_ree_trim3,wee_cas_trim1,
         wee_cas_trim2,
         wee_cas_trim3)
select
@w_secuencial,ent_trim1,fecha_trim1,ent_trim2,fecha_trim2,
ent_trim3,fecha_trim3,cmp_trim1,cmp_trim2,cmp_trim3,
ree_trim1,ree_trim2,ree_trim3,cas_trim1,cas_trim2,
cas_trim3
from   #endeuda_encabezado

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO ENCABEZADO cl_ws_endeu_encab_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CONSOLIDADO TRIM I *********************************/
insert into cobis..cl_ws_endeu_cons_tmp with(rowlock)
        (wec_secuencial,wec_calificacion,wec_tipo_moneda,
         wec_num_op_comercial,
         wec_num_op_consumo,
         wec_num_op_vivienda,wec_num_op_micro,wec_val_deu_comercial,
         wec_val_deu_consumo,wec_val_deu_vivienda,
         wec_val_deu_micro,wec_total,wec_par_tot_deudas,
         wec_cub_gar_comercial,wec_cub_gar_consumo,
         wec_cub_gar_vivienda,wec_cub_gar_micro,wec_tipo_registro)
select
@w_secuencial,calificacion,tipo_moneda,num_op_comercial,num_op_consumo,
num_op_vivienda,num_op_micro,val_deu_comercial,val_deu_consumo,
val_deu_vivienda,
val_deu_micro,total,par_tot_deudas,cub_gar_comercial,cub_gar_consumo,
cub_gar_vivienda,cub_gar_micro,tipo_registro
from   #endeuda_cons_trim1

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO CONSOLIDADO cl_ws_endeu_cons_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CONSOLIDADO TRIM II *********************************/
insert into cobis..cl_ws_endeu_cons_tmp with(rowlock)
        (wec_secuencial,wec_calificacion,wec_tipo_moneda,
         wec_num_op_comercial,
         wec_num_op_consumo,
         wec_num_op_vivienda,wec_num_op_micro,wec_val_deu_comercial,
         wec_val_deu_consumo,wec_val_deu_vivienda,
         wec_val_deu_micro,wec_total,wec_par_tot_deudas,
         wec_cub_gar_comercial,wec_cub_gar_consumo,
         wec_cub_gar_vivienda,wec_cub_gar_micro,wec_tipo_registro)
select
@w_secuencial,calificacion,tipo_moneda,num_op_comercial,num_op_consumo,
num_op_vivienda,num_op_micro,val_deu_comercial,val_deu_consumo,
val_deu_vivienda,
val_deu_micro,total,par_tot_deudas,cub_gar_comercial,cub_gar_consumo,
cub_gar_vivienda,cub_gar_micro,tipo_registro
from   #endeuda_cons_trim2

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO CONSOLIDADO cl_ws_endeu_cons_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CONSOLIDADO TRIM III *********************************/
insert into cobis..cl_ws_endeu_cons_tmp with(rowlock)
        (wec_secuencial,wec_calificacion,wec_tipo_moneda,
         wec_num_op_comercial,
         wec_num_op_consumo,
         wec_num_op_vivienda,wec_num_op_micro,wec_val_deu_comercial,
         wec_val_deu_consumo,wec_val_deu_vivienda,
         wec_val_deu_micro,wec_total,wec_par_tot_deudas,
         wec_cub_gar_comercial,wec_cub_gar_consumo,
         wec_cub_gar_vivienda,wec_cub_gar_micro,wec_tipo_registro)
select
@w_secuencial,calificacion,tipo_moneda,num_op_comercial,num_op_consumo,
num_op_vivienda,num_op_micro,val_deu_comercial,val_deu_consumo,
val_deu_vivienda,
val_deu_micro,total,par_tot_deudas,cub_gar_comercial,cub_gar_consumo,
cub_gar_vivienda,cub_gar_micro,tipo_registro
from   #endeuda_cons_trim3

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO CONSOLIDADO cl_ws_endeu_cons_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CONTIGENCIAS TRIM I *********************************/
insert into cobis..cl_ws_endeu_contig_tmp with(rowlock)
        (wet_secuencial,wet_tipo_moneda,wet_num_contingencias,
         wet_val_contingencias,
         wet_cuota_esperada,
         wet_cuota_cumplimiento,wet_tipo_registro)
select
@w_secuencial,tipo_moneda,num_contingencias,val_contingencias,
cuota_esperada
,
cuota_cumplimiento,tipo_registro
from   #endeuda_cont_trim1

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR ENDEUDAMIENTO CONTIGENCIAS cl_ws_endeu_contig_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CONTIGENCIAS TRIM II *********************************/
insert into cobis..cl_ws_endeu_contig_tmp with(rowlock)
        (wet_secuencial,wet_tipo_moneda,wet_num_contingencias,
         wet_val_contingencias,
         wet_cuota_esperada,
         wet_cuota_cumplimiento,wet_tipo_registro)
select
@w_secuencial,tipo_moneda,num_contingencias,val_contingencias,
cuota_esperada
,
cuota_cumplimiento,tipo_registro
from   #endeuda_cont_trim2

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR ENDEUDAMIENTO CONTIGENCIAS cl_ws_endeu_contig_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CONTIGENCIAS TRIM III *********************************/
insert into cobis..cl_ws_endeu_contig_tmp with(rowlock)
        (wet_secuencial,wet_tipo_moneda,wet_num_contingencias,
         wet_val_contingencias,
         wet_cuota_esperada,
         wet_cuota_cumplimiento,wet_tipo_registro)
select
@w_secuencial,tipo_moneda,num_contingencias,val_contingencias,
cuota_esperada
,
cuota_cumplimiento,tipo_registro
from   #endeuda_cont_trim3

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR ENDEUDAMIENTO CONTIGENCIAS cl_ws_endeu_contig_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO DETALLE TRIM I *********************************/
insert into cobis..cl_ws_endeu_det_tmp with(rowlock)
        (wed_secuencial,wed_tipo_entidad,wed_nom_entidad,
         wed_tipo_ent_orig_car,
         wed_nom_ent_orig_car,
         wed_tipo_fideicomiso,wed_num_fideicomiso,wed_mod_credito,
         wed_calificacion,wed_tipo_moneda,
         wed_num_operadores,wed_valor_deuda,wed_par_tot_deudas,
         wed_cubrim_garantia,wed_tipo_garantia,
         wed_fecha_ult_avaluo,wed_cuota_esperada,wed_cumplim_cuota,
         wed_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,tipo_moneda,
num_operadores,valor_deuda,par_tot_deudas,cubrim_garantia,tipo_garantia,
fecha_ult_avaluo,cuota_esperada,cumplim_cuota,tipo_registro
from   #endeuda_det_trim1

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO DETALLE cl_ws_endeu_det_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO DETALLE TRIM II *********************************/
insert into cobis..cl_ws_endeu_det_tmp with(rowlock)
        (wed_secuencial,wed_tipo_entidad,wed_nom_entidad,
         wed_tipo_ent_orig_car,
         wed_nom_ent_orig_car,
         wed_tipo_fideicomiso,wed_num_fideicomiso,wed_mod_credito,
         wed_calificacion,wed_tipo_moneda,
         wed_num_operadores,wed_valor_deuda,wed_par_tot_deudas,
         wed_cubrim_garantia,wed_tipo_garantia,
         wed_fecha_ult_avaluo,wed_cuota_esperada,wed_cumplim_cuota,
         wed_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,tipo_moneda,
num_operadores,valor_deuda,par_tot_deudas,cubrim_garantia,tipo_garantia,
fecha_ult_avaluo,cuota_esperada,cumplim_cuota,tipo_registro
from   #endeuda_det_trim2

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO DETALLE cl_ws_endeu_det_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO DETALLE TRIM III *********************************/
insert into cobis..cl_ws_endeu_det_tmp with(rowlock)
        (wed_secuencial,wed_tipo_entidad,wed_nom_entidad,
         wed_tipo_ent_orig_car,
         wed_nom_ent_orig_car,
         wed_tipo_fideicomiso,wed_num_fideicomiso,wed_mod_credito,
         wed_calificacion,wed_tipo_moneda,
         wed_num_operadores,wed_valor_deuda,wed_par_tot_deudas,
         wed_cubrim_garantia,wed_tipo_garantia,
         wed_fecha_ult_avaluo,wed_cuota_esperada,wed_cumplim_cuota,
         wed_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,tipo_moneda,
num_operadores,valor_deuda,par_tot_deudas,cubrim_garantia,tipo_garantia,
fecha_ult_avaluo,cuota_esperada,cumplim_cuota,tipo_registro
from   #endeuda_det_trim3

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO DETALLE cl_ws_endeu_det_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO REESTRUCTURACIONES TRIM I *********************************/
insert into cobis..cl_ws_endeu_reest_tmp with(rowlock)
        (wer_secuencial,wer_tipo_entidad,wer_nom_entidad,
         wer_tipo_ent_orig_car,
         wer_nom_ent_orig_car,
         wer_tipo_fideicomiso,wer_num_fideicomiso,wer_mod_credito,
         wer_calificacion,wer_id_credito,
         wer_monto,wer_fecha_formaliza,wer_fecha_termina,wer_numero_veces,
         wer_tipo_reestruc,
         wer_peri_gracia_cap,wer_peri_gracia_int,wer_factor_reest,
         wer_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,id_credito,
monto,fecha_formaliza,fecha_termina,numero_veces,tipo_reestruc,
peri_gracia_cap,peri_gracia_int,factor_reest,tipo_registro
from   #endeuda_reest_trim1

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR ENDEUDAMIENTO REESTRUCTURACIONES cl_ws_endeu_reest_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO REESTRUCTURACIONES TRIM II *********************************/
insert into cobis..cl_ws_endeu_reest_tmp with(rowlock)
        (wer_secuencial,wer_tipo_entidad,wer_nom_entidad,
         wer_tipo_ent_orig_car,
         wer_nom_ent_orig_car,
         wer_tipo_fideicomiso,wer_num_fideicomiso,wer_mod_credito,
         wer_calificacion,wer_id_credito,
         wer_monto,wer_fecha_formaliza,wer_fecha_termina,wer_numero_veces,
         wer_tipo_reestruc,
         wer_peri_gracia_cap,wer_peri_gracia_int,wer_factor_reest,
         wer_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,id_credito,
monto,fecha_formaliza,fecha_termina,numero_veces,tipo_reestruc,
peri_gracia_cap,peri_gracia_int,factor_reest,tipo_registro
from   #endeuda_reest_trim2

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR ENDEUDAMIENTO REESTRUCTURACIONES cl_ws_endeu_reest_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO REESTRUCTURACIONES TRIM III *********************************/
insert into cobis..cl_ws_endeu_reest_tmp with(rowlock)
        (wer_secuencial,wer_tipo_entidad,wer_nom_entidad,
         wer_tipo_ent_orig_car,
         wer_nom_ent_orig_car,
         wer_tipo_fideicomiso,wer_num_fideicomiso,wer_mod_credito,
         wer_calificacion,wer_id_credito,
         wer_monto,wer_fecha_formaliza,wer_fecha_termina,wer_numero_veces,
         wer_tipo_reestruc,
         wer_peri_gracia_cap,wer_peri_gracia_int,wer_factor_reest,
         wer_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,id_credito,
monto,fecha_formaliza,fecha_termina,numero_veces,tipo_reestruc,
peri_gracia_cap,peri_gracia_int,factor_reest,tipo_registro
from   #endeuda_reest_trim3

if @@error <> 0
begin
select
@w_msg =
'ERROR INSERTAR ENDEUDAMIENTO REESTRUCTURACIONES cl_ws_endeu_reest_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CASTIGOS TRIM I *********************************/
insert into cobis..cl_ws_endeu_cast_tmp with(rowlock)
        (wec_secuencial,wec_tipo_entidad,wec_nom_entidad,
         wec_tipo_ent_orig_car,
         wec_nom_ent_orig_car,
         wec_tipo_fideicomiso,wec_num_fideicomiso,wec_mod_credito,
         wec_tipo_castigo,wec_num_acta_aprob,
         wec_calidad,wec_fecha_otorg_ini,wec_valor_ini_oblig,
         wec_valor_castigado,wec_tipo_garantia,
         wec_valor_garantia,wec_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,tipo_castigo,num_acta_aprob,
calidad,fecha_otorg_ini,valor_ini_oblig,valor_castigado,tipo_garantia,
valor_garantia,tipo_registro
from   #endeuda_cast_trim1

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO CASTIGOS cl_ws_endeu_cast_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CASTIGOS TRIM II *********************************/
insert into cobis..cl_ws_endeu_cast_tmp with(rowlock)
        (wec_secuencial,wec_tipo_entidad,wec_nom_entidad,
         wec_tipo_ent_orig_car,
         wec_nom_ent_orig_car,
         wec_tipo_fideicomiso,wec_num_fideicomiso,wec_mod_credito,
         wec_tipo_castigo,wec_num_acta_aprob,
         wec_calidad,wec_fecha_otorg_ini,wec_valor_ini_oblig,
         wec_valor_castigado,wec_tipo_garantia,
         wec_valor_garantia,wec_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,tipo_castigo,num_acta_aprob,
calidad,fecha_otorg_ini,valor_ini_oblig,valor_castigado,tipo_garantia,
valor_garantia,tipo_registro
from   #endeuda_cast_trim2

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO CASTIGOS cl_ws_endeu_cast_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO CASTIGOS TRIM III *********************************/
insert into cobis..cl_ws_endeu_cast_tmp with(rowlock)
        (wec_secuencial,wec_tipo_entidad,wec_nom_entidad,
         wec_tipo_ent_orig_car,
         wec_nom_ent_orig_car,
         wec_tipo_fideicomiso,wec_num_fideicomiso,wec_mod_credito,
         wec_tipo_castigo,wec_num_acta_aprob,
         wec_calidad,wec_fecha_otorg_ini,wec_valor_ini_oblig,
         wec_valor_castigado,wec_tipo_garantia,
         wec_valor_garantia,wec_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,tipo_castigo,num_acta_aprob,
calidad,fecha_otorg_ini,valor_ini_oblig,valor_castigado,tipo_garantia,
valor_garantia,tipo_registro
from   #endeuda_cast_trim3

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO CASTIGOS cl_ws_endeu_cast_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO COMPRAS TRIM I *********************************/
insert into cobis..cl_ws_endeu_cmp_tmp with(rowlock)
        (wem_secuencial,wem_tipo_entidad,wem_nom_entidad,
         wem_tipo_ent_orig_car,
         wem_nom_ent_orig_car,
         wem_tipo_fideicomiso,wem_num_fideicomiso,wem_mod_credito,
         wem_calificacion,wem_tipo_moneda,
         wem_valor_deuda,wem_tipo_operacion,wem_clase_operacion,
         wem_cond_contrato,wem_tipo_comp_vend,
         wem_tipo_ent_operacion,wem_nom_ent_operacion,wem_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,tipo_moneda,
valor_deuda,tipo_operacion,clase_operacion,cond_contrato,tipo_comp_vend,
tipo_ent_operacion,nom_ent_operacion,tipo_registro
from   #endeuda_cmp_trim1

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO COMPRAS cl_ws_endeu_cmp_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO COMPRAS TRIM II *********************************/
insert into cobis..cl_ws_endeu_cmp_tmp with(rowlock)
        (wem_secuencial,wem_tipo_entidad,wem_nom_entidad,
         wem_tipo_ent_orig_car,
         wem_nom_ent_orig_car,
         wem_tipo_fideicomiso,wem_num_fideicomiso,wem_mod_credito,
         wem_calificacion,wem_tipo_moneda,
         wem_valor_deuda,wem_tipo_operacion,wem_clase_operacion,
         wem_cond_contrato,wem_tipo_comp_vend,
         wem_tipo_ent_operacion,wem_nom_ent_operacion,wem_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,tipo_moneda,
valor_deuda,tipo_operacion,clase_operacion,cond_contrato,tipo_comp_vend,
tipo_ent_operacion,nom_ent_operacion,tipo_registro
from   #endeuda_cmp_trim2

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO COMPRAS cl_ws_endeu_cmp_tmp'
rollback tran
goto ERROR
end

/*************************** ENDEUDAMIENTO COMPRAS TRIM III *********************************/
insert into cobis..cl_ws_endeu_cmp_tmp with(rowlock)
        (wem_secuencial,wem_tipo_entidad,wem_nom_entidad,
         wem_tipo_ent_orig_car,
         wem_nom_ent_orig_car,
         wem_tipo_fideicomiso,wem_num_fideicomiso,wem_mod_credito,
         wem_calificacion,wem_tipo_moneda,
         wem_valor_deuda,wem_tipo_operacion,wem_clase_operacion,
         wem_cond_contrato,wem_tipo_comp_vend,
         wem_tipo_ent_operacion,wem_nom_ent_operacion,wem_tipo_registro)
select
@w_secuencial,tipo_entidad,nom_entidad,tipo_ent_orig_car,nom_ent_orig_car,
tipo_fideicomiso,num_fideicomiso,mod_credito,calificacion,tipo_moneda,
valor_deuda,tipo_operacion,clase_operacion,cond_contrato,tipo_comp_vend,
tipo_ent_operacion,nom_ent_operacion,tipo_registro
from   #endeuda_cmp_trim3

if @@error <> 0
begin
select
@w_msg = 'ERROR INSERTAR ENDEUDAMIENTO COMPRAS cl_ws_endeu_cmp_tmp'
rollback tran
goto ERROR
end

-----------------------------------
commit tran
-----------------------------------
/* se retorna el numero del secuencial */
select
@w_secuencial
select
@o_secuencial = @w_secuencial
select
@o_orden = @w_orden

return 0

ERROR:
exec cobis..sp_cerror
@t_from = @w_sp_name,
@i_msg  = @w_msg,
@i_num  = 111111
return @w_msg

end -- operacion 'I'

go

