/* **********************************************************************/
/*      Archivo:                clinfxml.sp                             */
/*      Stored procedure:       sp_extraer_inf_xml                      */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Wilson Romero / Gabriel Alvis           */
/*      Fecha de escritura:     09-abr-2010                             */
/* **********************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/* **********************************************************************/
/*                             PROPOSITO                                */
/*    Inserción en tablas temp Centralizadas de datos de estructuras XML*/
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR               RAZON                               */
/* 05/20/2010   CCB      Req 108 se modifica insert x nuevos campos     */
/*                       tablas                                         */
/* 24.OCT.2014  Andres Muñoz      CCA 452 suprimir score datacredito    */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/* **********************************************************************/

use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_extraer_inf_xml')
  drop proc sp_extraer_inf_xml
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

create proc sp_extraer_inf_xml
  @t_show_version bit = 0,
  @i_ente         int = null,
  @i_num_doc      varchar(20) = null,
  @i_type_doc     varchar(10) = null,
  @i_operacion    char(1) = null,
  @i_secuencial   int = null,
  @i_batch        char(1) = 'N',
  @i_orden        int = 0,
  @o_secuencial   int = null out,
  @o_orden        int = null out
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
    @w_ced_ruc          numero,
    @w_orden            int

  select
    @w_sp_name = 'sp_extraer_inf_xml'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

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
        @i_type_doc = en_tipo_ced,
        @w_ced_ruc = right('00000000000' + rtrim(ltrim(en_ced_ruc)),
                           11)
      from   cobis..cl_ente with (nolock)
      where  en_ente = @i_ente

      select
        @i_num_doc = oc_ced_ruc --en_ced_ruc
      from   cl_orden_consulta_ext with(nolock),
             cl_informacion_ext with(nolock)
      where  oc_tipo_ced  = @i_type_doc
         and oc_ced_ruc   = @w_ced_ruc
         and oc_tconsulta = '02' -- INFORMACION COMERCIAL DATACREDITO
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
      from   cl_orden_consulta_ext with(nolock),
             cl_informacion_ext with(nolock)
      where  in_orden     = @i_orden
         and oc_tconsulta = '02' -- INFORMACION COMERCIAL DATACREDITO
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
          from   cl_orden_consulta_ext with(nolock),
                 cl_informacion_ext_his with(nolock)
          where  inh_orden    = @i_orden
             and oc_tconsulta = '02' -- INFORMACION COMERCIAL CIFIN
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
      from   cl_orden_consulta_ext with(nolock),
             cl_informacion_ext with(nolock)
      where  oc_tipo_ced  = @i_type_doc
         and oc_ced_ruc   = @i_num_doc
         and oc_tconsulta = '02' -- INFORMACION COMERCIAL DATACREDITO
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
          from   cl_orden_consulta_ext with(nolock),
                 cl_informacion_ext_his with(nolock)
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
    create table #dato_cliente
    (
      id                 int identity,
      genero             varchar(max) null,
      nom_completo       varchar(max) null,
      primerApellido     varchar(max) null,
      segundoApellido    varchar(max) null,
      Nombres            varchar(max) null,
      ecivil             varchar(max) null,
      id_estado          varchar(max) null,
      id_fechaExpedicion varchar(max) null,
      id_ciudad          varchar(max) null,
      id_departamento    varchar(max) null,
      id_numero          varchar(max) null,
      edad_min           varchar(max) null,
      edad_max           varchar(max) null,
      nombres_nex        varchar(max) null,
      id_numero_nex      varchar(max) null,
      nacionalidad_nex   varchar(max) null,
      nombres_jna        varchar(max) null,
      id_numero_jna      varchar(max) null,
      nombres_jex        varchar(max) null,
      id_numero_jex      varchar(max) null,
      fechaconsulta      varchar(max) null
    )

    insert into #dato_cliente
      select
        genero = isnull(@w_xml.value(N'(/informe/naturalNacional/@genero)[1]',
                                     'varchar(10)'),
                        '0'),nom_completo = isnull(
        @w_xml.value(N'(/informe/naturalNacional/@nombreCompleto)[1]',
                      'varchar(200)'),
         'N'),primerApellido = isnull(
              @w_xml.value(N'(/informe/naturalNacional/@primerApellido)[1]',
                        'varchar(40)'),
           ''),segundoApellido = isnull(
               @w_xml.value(N'(/informe/naturalNacional/@segundoApellido)[1]',
                         'varchar(40)'),
            ''),Nombres = isnull(
                @w_xml.value(N'(/informe/naturalNacional/@nombres)[1]',
                 'varchar(80)'),
                         ''),
        ecivil = isnull(
        @w_xml.value(N'(/informe/naturalNacional/@estadoCivil)[1]',
                     'varchar(10)'),
        ''),id_estado =
        @w_xml.value(N'(/informe/naturalNacional/identificacion/@estado)[1]',
             'varchar(10)'),id_fechaExpedicion =
  @w_xml.value(N'(/informe/naturalNacional/identificacion/@fechaExpedicion)[1]',
                'varchar(20)'),id_ciudad = isnull(
  @w_xml.value(N'(/informe/naturalNacional/identificacion/@ciudad)[1]',
              'varchar(30)'),
                     ''),id_departamento = isnull(
  @w_xml.value(N'(/informe/naturalNacional/identificacion/@departamento)[1]',
  'varchar(30)'),
  ''),
  id_numero = isnull(
  @w_xml.value(N'(/informe/naturalNacional/identificacion/@numero)[1]',
               'varchar(20)'),
  ''),edad_min = isnull(
      @w_xml.value(N'(/informe/naturalNacional/edad/@min)[1]',
               'varchar(20)'),
                    ''),edad_max = isnull(
  @w_xml.value(N'(/informe/naturalNacional/edad/@max)[1]',
          'varchar(20)'),
  ''),nombres_nex = isnull(
  @w_xml.value(N'(/informe/naturalExtranjera/@nombre)[1]',
             'varchar(40)'),
  'N'),id_numero_nex = isnull(
  @w_xml.value(N'(/informe/naturalExtranjera/@identificacion)[1]',
  'varchar(20)'),
  ''),
  nacionalidad_nex = isnull(
  @w_xml.value(N'(/informe/naturalExtranjera/@nacionalidad)[1]',
  'varchar(20)'),
  ''),nombres_jna = isnull(
  @w_xml.value(N'(/informe/juridicaNacional/@nombre)[1]',
  'varchar(40)'),
  ''),id_numero_jna = isnull(
  @w_xml.value(N'(/informe/juridicaNacional/@identificacion)[1]',
  'varchar(20)'),
  ''),nombres_jex = isnull(
      @w_xml.value(N'(/informe/juridicaExtranjera/@nombre)[1]',
             'varchar(40)'),
  ''),id_numero_jex = isnull(
  @w_xml.value(N'(/informe/juridicaExtranjera/@identificacion)[1]',
  'varchar(20)'),
  ''),
  fechaconsulta = isnull(@w_xml.value(N'(/informe/@fechaConsulta)[1]',
               'varchar(20)'),
  '0')

  select
   @w_genero = genero,
   @w_Extranjero = nombres_nex,
   @w_nomCompleto = nom_completo,
   @w_primerApellido = primerApellido,
   @w_segundoApellido = segundoApellido,
   @w_nombres = Nombres,
   @w_nombres_jna = nombres_jna,
   @w_nombres_jex = nombres_jex,
   @w_fecha_expedicion = id_fechaExpedicion,
   @w_id_numero = id_numero
  from   #dato_cliente

  if @w_Extranjero = 'N' -- CUANDO ES EXTRANJERO 'N' NO ENTRA EN ESTE IF
  begin
   if @w_nomCompleto = 'N'
   begin
     if @w_nombres_jna <> '' -- JURIDICA NACIONAL
     begin
       select
         @w_procedencia = 'JN'

       update #dato_cliente
       set    nom_completo = @w_nombres_jna,
              id_numero = id_numero_jna

       select
         @w_nomCompleto = @w_nombres_jna
       select
         @w_id_numero = id_numero
       from   #dato_cliente
     end
     else if @w_nombres_jex <> ''
     begin
       select
         @w_procedencia = 'JE'
       update #dato_cliente
       set    id_numero = id_numero_jex,
              Nombres = @w_nombres_jex

       select
         @w_id_numero = id_numero
       from   #dato_cliente
     end
     else
     begin
       update #dato_cliente
       set    nom_completo = @w_primerApellido + ' ' + @w_segundoApellido + ' '
                             +
                             @w_nombres +
                                    '.'

       select
         @w_nomCompleto = @w_primerApellido + ' ' + @w_segundoApellido + ' ' +
                          @w_nombres
                                                                    + '.'
     end
   end

   if @w_genero = '0'
   begin
     update #dato_cliente
     set    genero = '9'
   end
  end

  if @w_nomCompleto <> 'N'
  begin
   select
     @w_procedencia = 'NA'
   if @w_fecha_expedicion is not null
     select
       @w_fecha_expedicion = dbo.FormatoFecha('dd/mm/yyyy',
                                              @w_fecha_expedicion)
  end

  if @w_Extranjero <> 'N'
  begin
   select
     @w_procedencia = 'NE',
     @w_fecha_expedicion = null

   update #dato_cliente
   set    id_numero = id_numero_nex,
          Nombres = nombres_nex

   select
     @w_nomCompleto = Nombres,
     @w_id_numero = id_numero
   from   #dato_cliente
  end

  if @w_respuesta not in ('13', '14')
  begin
   select
     @w_id_numero = @i_num_doc
  --       return 1
  end

  select
   @w_respuesta_vali = @w_xml.value(N'(/informe/naturalNacional/@validada)[1]',
                                    'varchar(10)')

  --falso = 0
  if ltrim(rtrim(@w_respuesta_vali)) = 'true'
   select
     @w_retornar_vali = '1'
  else
   select
     @w_retornar_vali = '0'

  /********************* T A R J E T A    DE   C R E D I T O  *************************/
  select
   estado = nCol.value(N'(@estado)[1]',
                       'varchar(20)'),
   entidad = nCol.value(N'(@entidad)[1]',
                        'varchar(100)'),
   ultimaActualizacion = nCol.value(N'(@ultimaActualizacion)[1]',
                                    'varchar(20)'),
   numero = nCol.value(N'(@numero)[1]',
                       'varchar(20)'),
   fechaApertura = nCol.value(N'(@fechaApertura)[1]',
                              'varchar(20)'),
   fechaVencimiento = nCol.value(N'(@fechaVencimiento)[1]',
                                 'varchar(20)'),
   bloqueada = nCol.value(N'(@bloqueada)[1]',
                          'varchar(20)'),
   positivoNegativo = nCol.value(N'(@positivoNegativo)[1]',
                                 'varchar(1)'),
   comportamiento = nCol.value(N'(@comportamiento)[1]',
                               'varchar(64)'),
   amparada = nCol.value(N'(@amparada)[1]',
                         'varchar(20)'),
   formaPago = nCol.value(N'(@formaPago)[1]',
                          'varchar(20)'),
   situacionTitular = nCol.value(N'(@situacionTitular)[1]',
                                 'varchar(20)'),
   oficina = nCol.value(N'(@oficina)[1]',
                        'varchar(100)'),
   estadoOrigen = nCol.value(N'(@estadoOrigen)[1]',
                             'varchar(20)'),
   detalle = nCol.query('./valores')
  into   #dato_obliga_tar
  from   @w_xml.nodes('/informe/tarjetaCredito') as nTable(nCol)

  /********************* C U E N T A S     DE    C A R T E R A  *************************/
  select
   estado = nCol.value(N'(@estado)[1]',
                       'varchar(20)'),
   entidad = nCol.value(N'(@entidad)[1]',
                        'varchar(100)'),
   ultimaActualizacion = nCol.value(N'(@ultimaActualizacion)[1]',
                                    'varchar(20)'),
   numero = nCol.value(N'(@numeroObligacion)[1]',
                       'varchar(20)'),
   tipoCuenta = nCol.value(N'(@tipoCuenta)[1]',
                           'varchar(10)'),
   periodicidad = nCol.value(N'(@periodicidad)[1]',
                             'varchar(10)'),
   fechaApertura = nCol.value(N'(@fechaApertura)[1]',
                              'varchar(20)'),
   fechaVencimiento = nCol.value(N'(@fechaVencimiento)[1]',
                                 'varchar(20)'),
   bloqueada = nCol.value(N'(@bloqueada)[1]',
                          'varchar(20)'),
   positivoNegativo = nCol.value(N'(@positivoNegativo)[1]',
                                 'varchar(1)'),
   tipoObligacion = nCol.value(N'(@tipoObligacion)[1]',
                               'varchar(1)'),
   garante = nCol.value(N'(@garante)[1]',
                        'varchar(10)'),
   comportamiento = nCol.value(N'(@comportamiento)[1]',
                               'varchar(64)'),
   amparada = nCol.value(N'(@amparada)[1]',
                         'varchar(20)'),
   formaPago = nCol.value(N'(@formaPago)[1]',
                          'varchar(20)'),
   situacionTitular = nCol.value(N'(@situacionTitular)[1]',
                                 'varchar(20)'),
   oficina = nCol.value(N'(@oficina)[1]',
                        'varchar(100)'),
   estadoOrigen = nCol.value(N'(@estadoOrigen)[1]',
                             'varchar(10)'),
   detalle = nCol.query('./valores')
  into   #dato_obliga_car
  from   @w_xml.nodes('/informe/cuentaCartera') as nTable(nCol)

  /********************* C U E N T A S     DE    A H O R R O  *************************/
  select
   estado = nCol.value(N'(@estado)[1]',
                       'varchar(20)'),
   entidad = nCol.value(N'(@entidad)[1]',
                        'varchar(100)'),
   ultimaActualizacion = nCol.value(N'(@ultimaActualizacion)[1]',
                                    'varchar(20)'),
   numero = nCol.value(N'(@numeroCuenta)[1]',
                       'varchar(20)'),
   fechaApertura = nCol.value(N'(@fechaApertura)[1]',
                              'varchar(20)'),
   ciudad = nCol.value(N'(@ciudad)[1]',
                       'varchar(100)'),
   oficina = nCol.value(N'(@oficina)[1]',
                        'varchar(100)'),
   bloqueada = nCol.value(N'(@bloqueada)[1]',
                          'varchar(20)')
  into   #dato_obliga_aho
  from   @w_xml.nodes('/informe/cuentaAhorro') as nTable(nCol)

  /************************ C U E N T A S     C O R R I E N T E  **** ***********************/
  select
   estado = nCol.value(N'(@estado)[1]',
                       'varchar(10)'),
   entidad = nCol.value(N'(@entidad)[1]',
                        'varchar(100)'),
   ultimaActualizacion = nCol.value(N'(@ultimaActualizacion)[1]',
                                    'varchar(20)'),
   numero = nCol.value(N'(@numeroCuenta)[1]',
                       'varchar(20)'),
   fechaApertura = nCol.value(N'(@fechaApertura)[1]',
                              'varchar(100)'),
   oficina = nCol.value(N'(@oficina)[1]',
                        'varchar(100)'),
   ciudad = nCol.value(N'(@ciudad)[1]',
                       'varchar(100)'),
   bloqueada = nCol.value(N'(@bloqueada)[1]',
                          'varchar(20)')
  into   #dato_obliga_cte
  from   @w_xml.nodes('/informe/cuentaCorriente') as nTable(nCol)

  --/*************************** S C O R E S ***************************************/
  --select
  --tipo                   = nCol.value(N'(@tipo)[1]',               'varchar(20)')  ,
  --puntaje                = nCol.value(N'(@puntaje)[1]',            'varchar(20)')  ,
  --clasificacion          = nCol.value(N'(@clasificacion)[1]',      'varchar(20)')  ,
  --codigo                 = nCol.query('./fuente')
  --into #dato_score
  --from @w_xml.nodes('/informe/score') as nTable(nCol)

  /*************************** A L E R T A S ***************************************/
  select
   colocacion = nCol.value(N'(@colocacion)[1]',
                           'varchar(20)'),
   vencimiento = nCol.value(N'(@vencimiento)[1]',
                            'varchar(20)'),
   modificacion = nCol.value(N'(@modificacion)[1]',
                             'varchar(20)'),
   codigo = nCol.value(N'(@codigo)[1]',
                       'varchar(20)'),
   texto = nCol.value(N'(@texto)[1]',
                      'varchar(200)'),
   detalle = nCol.query('./fuente')
  into   #dato_alerta
  from   @w_xml.nodes('/informe/alerta') as nTable(nCol)

  /*************************** C O N S U L T A S ***************************************/
  select
   fecha = nCol.value(N'(@fecha)[1]',
                      'varchar(20)'),
   entidad = nCol.value(N'(@entidad)[1]',
                        'varchar(100)'),
   oficina = nCol.value(N'(@oficina)[1]',
                        'varchar(100)'),
   ciudad = nCol.value(N'(@ciudad)[1]',
                       'varchar(100)'),
   razon = nCol.value(N'(@razon)[1]',
                      'varchar(10)'),
   tipoCuenta = nCol.value(N'(@tipoCuenta)[1]',
                           'varchar(10)')
  into   #dato_consulta
  from   @w_xml.nodes('/informe/consulta') as nTable(nCol)

  /*************************** E N D E U D A M I E N T O *********************************/
  select
   calificacion = nCol.value(N'(@calificacion)[1]',
                             'varchar(10)'),
   saldoPendiente = nCol.value(N'(@saldoPendiente)[1]',
                               'money'),
   tipoCredito = nCol.value(N'(@tipoCredito)[1]',
                            'varchar(10)'),
   moneda = nCol.value(N'(@moneda)[1]',
                       'varchar(3)'),
   numeroCreditos = nCol.value(N'(@numeroCreditos)[1]',
                               'varchar(3)'),
   fechaReporte = nCol.value(N'(@fechaReporte)[1]',
                             'varchar(20)'),
   entidad = nCol.value(N'(@entidad)[1]',
                        'varchar(100)'),
   garantia = nCol.value(N'(@garantia)[1]',
                         'varchar(100)')
  into   #dato_endeuda
  from   @w_xml.nodes('/informe/endeudamientoGlobal') as nTable(nCol)

  -----------------------------------
  begin tran
  -----------------------------------

  /*********************  D A T O S   C L I E N T E    *************************/
  insert into cobis..cl_ws_ente_tmp with (rowlock)
             (we_nomlar,we_ced_ruc,we_tip_ced,we_procedencia,we_nacional,
              we_p_apellido,we_s_apellido,we_nombres,we_genero,we_ecivil,
              we_edad_min,we_edad_max,we_id_estado,we_id_validada,
              we_id_fecha_exp
              ,
              we_id_ciudad_exp,we_id_dpto_exp,we_ente_int,
              we_cod_fin_consulta,we_fecha_consulta)
   select
     @w_nomCompleto,@w_id_numero,@w_tip_doc,@w_procedencia,nacionalidad_nex,
     primerApellido,segundoApellido,Nombres,@w_genero,@w_genero,
     edad_min,edad_max,id_estado,@w_retornar_vali,@w_fecha_expedicion,
     id_ciudad,id_departamento,@w_ente,@w_respuesta,
     dbo.FormatoFecha('dd/mm/yyyy',
                      fechaconsulta)
   from   #dato_cliente

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR ENTE EN cl_ws_ente_tmp'
   rollback tran
   goto ERROR
  end

  select
   @w_secuencial = ident_current('cobis..cl_ws_ente_tmp')

  /********************* T A R J E T A    DE   C R E D I T O  ******************/
  insert into cobis..cl_ws_obligacion_tmp with(rowlock)
             (wo_secuencial,wo_estado,wo_tip_producto,wo_entidad,-- 1
              wo_fecha_apertura,
              wo_fecha_ult_actualiza,-- 2
              wo_fecha_vencimiento,wo_num_cuenta,wo_oficina,-- 3
              wo_ciudad,
              wo_cod_suscriptor,wo_bloqueada,-- 4
              wo_periodicidad,wo_comportamiento,wo_amparada,
              wo_tipo_obigacion,-- 5
              wo_tipo_cuenta,wo_garante,wo_forma_pago,wo_pos_neg,-- 6
              wo_cuota,wo_tot_cuotas,wo_cuotas_canceladas,-- 7
              wo_cupo,wo_saldo_mora,-- 8
              wo_saldo_act,wo_valor_inicial,-- 9
              wo_max_mora) -- 10
   select
     @w_secuencial,estado,'TCR',entidad,-- 1
     dbo.FormatoFecha('yyyymm',
                      fechaApertura),
     dbo.FormatoFecha('yyyymm',
                      ultimaActualizacion),-- 2
     dbo.FormatoFecha('yyyymm',
                      fechaVencimiento),numero,oficina,-- 3
     null,
     null,case -- 4
       when bloqueada = 'true' then '1'
       when bloqueada = 'false' then '0'
       else '0'
     end,null,comportamiento,amparada,
     null,-- 5
     'TDC',null,formaPago,positivoNegativo,-- 6
     detalle.value(N'(/valores/@cuota)[1]',
                   'money'),null,null,-- 7
     detalle.value(N'(/valores/@cupo)[1]',
                   'money'),detalle.value(N'(/valores/@saldoMora)[1]',
                   'money'),-- 8
     detalle.value(N'(/valores/@saldoActual)[1]',
                   'money'),null,-- 9
     null -- 10
   from   #dato_obliga_tar

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR OBLIG. TARJ.CREDITO EN cl_ws_obligacion_tmp'
   rollback tran
   goto ERROR
  end

  /********************* C U E N T A S     DE    C A R T E R A  ****************/
  insert into cobis..cl_ws_obligacion_tmp with(rowlock)
             (wo_secuencial,wo_estado,wo_tip_producto,wo_entidad,-- 1
              wo_fecha_apertura,
              wo_fecha_ult_actualiza,-- 2
              wo_fecha_vencimiento,wo_num_cuenta,wo_oficina,-- 3
              wo_ciudad,
              wo_cod_suscriptor,wo_bloqueada,-- 4
              wo_periodicidad,wo_comportamiento,wo_amparada,
              wo_tipo_obigacion,-- 5
              wo_tipo_cuenta,wo_garante,wo_forma_pago,wo_pos_neg,-- 6
              wo_cuota,wo_tot_cuotas,-- 7
              wo_cuotas_canceladas,wo_cupo,-- 8
              wo_saldo_mora,
              wo_saldo_act,-- 9
              wo_valor_inicial,wo_max_mora) -- 10
   select
     @w_secuencial,estado,'CAR',entidad,-- 1
     dbo.FormatoFecha('yyyymm',
                      fechaApertura),
     dbo.FormatoFecha('yyyymm',
                      ultimaActualizacion),-- 2
     dbo.FormatoFecha('yyyymm',
                      fechaVencimiento),numero,oficina,-- 3
     null,
     null,case -- 4
       when bloqueada = 'true' then '1'
       when bloqueada = 'false' then '0'
       else '0'
     end,periodicidad,comportamiento,null,
     tipoObligacion,-- 5
     tipoCuenta,garante,formaPago,positivoNegativo,-- 6
     detalle.value(N'(/valores/@cuota)[1]',
                   'money'),detalle.value(N'(/valores/@totalCuotas)[1]',
                   'money'),-- 7
     detalle.value(N'(/valores/@cuotasCanceladas)[1]',
                   'money'),detalle.value(N'(/valores/@cupo)[1]',
                   'money'),-- 8
     detalle.value(N'(/valores/@saldoMora)[1]',
                   'money'),
     detalle.value(N'(/valores/@saldoActual)[1]',
                   'money'),-- 9
     detalle.value(N'(/valores/@valorInicial)[1]',
                   'money'),detalle.value(N'(/valores/@maximaMora)[1]',
                   'money') -- 10
   from   #dato_obliga_car

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR OBLIG. CARTEERA EN cl_ws_obligacion_tmp'
   rollback tran
   goto ERROR
  end

  /********************* C U E N T A S     DE    A H O R R O  ******************/
  insert into cobis..cl_ws_obligacion_tmp with(rowlock)
             (wo_secuencial,wo_estado,wo_tip_producto,wo_entidad,-- 1
              wo_fecha_apertura,
              wo_fecha_ult_actualiza,-- 2
              wo_fecha_vencimiento,wo_num_cuenta,wo_oficina,wo_ciudad,-- 3
              wo_cod_suscriptor,wo_bloqueada,-- 4
              wo_periodicidad,wo_comportamiento,wo_amparada,
              wo_tipo_obigacion,-- 5
              wo_tipo_cuenta,wo_garante,wo_forma_pago,wo_pos_neg,-- 6
              wo_cuota,wo_tot_cuotas,wo_cuotas_canceladas,wo_cupo,-- 7
              wo_saldo_mora,
              wo_saldo_act,wo_valor_inicial,wo_max_mora) -- 8
   select
     @w_secuencial,estado,'AHO',entidad,-- 1
     dbo.FormatoFecha('yyyymm',
                      fechaApertura),
     dbo.FormatoFecha('yyyymm',
                      ultimaActualizacion),-- 2
     null,numero,oficina,ciudad,-- 3
     null,case -- 4
       when bloqueada = 'true' then '1'
       when bloqueada = 'false' then '0'
       else '0'
     end,null,null,null,
     null,-- 5
     'AHO',null,null,null,-- 6
     null,null,null,null,-- 7
     null,
     null,null,null --- VALORES         -- 8
   from   #dato_obliga_aho

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR OBLIG. CTAS AHORRO EN cl_ws_obligacion_tmp'
   rollback tran
   goto ERROR
  end

  /************************ C U E N T A S     C O R R I E N T E  **** ************/
  insert into cobis..cl_ws_obligacion_tmp with(rowlock)
             (wo_secuencial,wo_estado,wo_tip_producto,wo_entidad,-- 1
              wo_fecha_apertura,
              wo_fecha_ult_actualiza,-- 2
              wo_fecha_vencimiento,wo_num_cuenta,wo_oficina,wo_ciudad,-- 3
              wo_cod_suscriptor,wo_bloqueada,-- 4
              wo_periodicidad,wo_comportamiento,wo_amparada,
              wo_tipo_obigacion,-- 5
              wo_tipo_cuenta,wo_garante,wo_forma_pago,wo_pos_neg,-- 6
              wo_cuota,wo_tot_cuotas,wo_cuotas_canceladas,wo_cupo,-- 7
              wo_saldo_mora,
              wo_saldo_act,wo_valor_inicial,wo_max_mora) -- 8
   select
     @w_secuencial,estado,'CTE',entidad,-- 1
     dbo.FormatoFecha('yyyymm',
                      fechaApertura),
     dbo.FormatoFecha('yyyymm',
                      ultimaActualizacion),-- 2
     null,numero,oficina,ciudad,-- 3
     null,case -- 4
       when bloqueada = 'true' then '1'
       when bloqueada = 'false' then '0'
       else '0'
     end,null,null,null,
     null,-- 5
     'CCB',null,null,null,-- 6
     null,null,null,null,-- 7
     null,
     null,null,null --- VALORES         -- 8
   from   #dato_obliga_cte

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR OBLIG. CTA CORRIENTE EN cl_ws_obligacion_tmp'
   rollback tran
   goto ERROR
  end

  --/*************************** S C O R E S ***************************************/
  --insert into cobis..cl_ws_score_tmp  with(rowlock) (
  --ws_secuencial,          ws_tipo,                ws_puntaje,             ws_calificacion,
  --ws_codigos)
  --select
  --@w_secuencial,          tipo,                   puntaje,                clasificacion,
  --isnull(codigo.value(N'(/score/@codigo)[1]',         'varchar(100)'),'')
  --from #dato_score

  --if @@error <> 0
  --begin
  --   select @w_msg = 'ERROR INSERTAR SCORES EN cl_ws_alerta_tmp'
  --   rollback tran
  --   goto ERROR
  --end

  /*************************** A L E R T A S *************************************/
  insert into cobis..cl_ws_alerta_tmp with(rowlock)
             (wa_secuencial,wa_item,wa_fecha_colocacion,wa_fecha_vencimiento,
              wa_fecha_modificacion,
              wa_codigo_alerta,wa_texto,wa_codifo_fuente,wa_desc_fuente)
   select
     @w_secuencial,row_number()
       over(
         order by codigo),dbo.FormatoFecha('yyyymm',
                      colocacion),dbo.FormatoFecha('yyyymm',
                      vencimiento),dbo.FormatoFecha('yyyymm',
                      modificacion),
     codigo,texto,isnull(detalle.value(N'(/fuente/@codigo)[1]',
                          'varchar(20)'),
            ''),isnull(detalle.value(N'(/fuente/@nombre)[1]',
                          'varchar(20)'),
            '')
   from   #dato_alerta

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR ALERTAS EN cl_ws_alerta_tmp'
   rollback tran
   goto ERROR
  end

  /*************************** C O N S U L T A S *********************************/
  insert into cl_ws_consulta_tmp with(rowlock)
             (wc_secuencial,wc_fecha,wc_tipo_cuenta,wc_entidad,wc_oficina,
              wc_ciudad)
   select
     @w_secuencial,dbo.FormatoFecha('dd/mm/yyyy',
                      fecha),tipoCuenta,entidad,oficina,
     ciudad
   from   #dato_consulta

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR CONSULTAS EN cl_ws_consulta_tmp'
   rollback tran
   goto ERROR
  end

  /*************************** E N D E U D A M I E N T O *********************************/
  insert into cl_ws_endeuda_tmp with(rowlock)
             (we_secuencial,we_calificacion,we_saldo_pendiente,we_tipo_credito,
              we_moneda,
              we_numero_creditos,we_fecha_reporte,we_entidad,we_garantia)
   select
     @w_secuencial,calificacion,saldoPendiente,tipoCredito,moneda,
     numeroCreditos,dbo.FormatoFecha('yyyy/mm',
                      fechaReporte),entidad,garantia
   from   #dato_endeuda

  if @@error <> 0
  begin
   select
     @w_msg = 'ERROR INSERTAR ENDEUDAMIENTO EN cl_ws_endeuda_tmp'
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

  return 1

  end -- operacion 'I'

go

