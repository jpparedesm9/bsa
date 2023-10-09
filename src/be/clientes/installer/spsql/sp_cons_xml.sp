/************************************************************************/
/*      Archivo:                sp_cons_xml.sp                          */
/*      Stored procedure:       sp_consultar_xml                        */
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
/*    Lecturas Centralizadas de datos de estructuras XML                */
/* **********************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER on
GO

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if exists (select
             *
           from   sysobjects
           where  name = 'sp_consultar_xml')
           drop proc sp_consultar_xml
go

create proc sp_consultar_xml
  @i_ente         int = null,
  @i_num_doc      varchar(20) = null,
  @i_type_doc     varchar(10) = null,
  @i_tservice     varchar(10) = '01',
  @i_tquery       varchar(10) = '01',
  @i_id_block     int = null,
  @i_xml          xml = null,
  @i_central      varchar(10) = null,
  @i_tramite      int = null,
  @t_show_version bit         = 0,
  -- PAQUETE 2: REQ 260 - MIR VINCULANTE CALIFICACION - 01/JUL/2011
  @o_est_consulta varchar(10) = null out,
  @o_est_id       varchar(50) = null out,
  @o_trama_error  char(1) = null out,
  @o_sec_error    int = null out
as
  declare
    @w_return        int,
    @w_xml           xml,
    @w_des_error     varchar(100),
    @w_len_block     int,
    @w_ini_str       int,
    @w_data_out      nvarchar(max),
    @w_nodo          nvarchar(max),
    @w_respuesta     nvarchar(max),
    @w_respuesta1    nvarchar(max),
    @w_total_tdc     money,
    @w_total_cca     money,
    @w_endeudamiento money,
    @w_ser_pub_vig   money,
    @w_ser_pub_mora  money,
    @w_cartera_viv   money,
    @w_mascara       varchar(16),
    @w_tram_err      bit,
    @w_cumplimiento  varchar(30),
    @w_nivel         varchar(30),
    @w_msg           varchar(255),
    @w_resp          char(1),
    @w_cliente       int,
    @w_estado        char(1),
    @w_debug         char(1),
    @w_id_numero     varchar(30),
    @w_secuencial    int,
    @w_alto_riesgo   varchar(30),
    @w_sp_name       varchar(30)

  select
    @w_sp_name = 'sp_consultar_xml'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_len_block = 1000,--valor m›nimo recomendable de 1000
    @w_ini_str = 0,
    @w_mascara = '00000000000'
  -- MASCARA DE DOCUMENTO DE IDENTIFICACION PARA DATACREDITO

  set CONCAT_NULL_YIELDS_NULL on
  set ANSI_WARNINGS on
  set ANSI_PADDING on
  set ARITHABORT on

  if @i_central = '1' -- CIFIN
  begin
    if @i_tquery = '00' -- TIPO DE RESPUESTA Y ESTADO DEL DOCUMENTO
    begin
      select
        @w_xml = @i_xml

      if @@rowcount = 0
      begin
        select
          @w_return = 1,
          @w_des_error = 'No hay trama a interpretar'

        return @w_return
      end

      -- REVISION DE TRAMA CON ERROR
      select
        @w_tram_err = @w_xml.exist('/CifinError')

      if @w_tram_err = 1
      begin
        select
          @o_trama_error = 'S'
        return 0
      end

    /****  ESTADO DE CONSULTA  ****/
      -- 01 TITULAR NO EXISTE CIFIN
      -- 02 CONSULTA EXITOSA
      -- 03 CONSULTA NO EXITOSA
      select
        @w_respuesta = @w_xml.value(N'(/CIFIN/Tercero/RespuestaConsulta)[1]',
                                    'varchar(10)')

      -- ESTADO DOCUMENTO VALIDO: 'VIGENTE'
      select
        @w_respuesta1 = @w_xml.value(N'(/CIFIN/Tercero/Estado)[1]',
                                     'varchar(50)')

      select
        @o_est_consulta = isnull(convert(varchar(10), @w_respuesta),
                                 'XX')
      select
        @o_est_id = isnull(convert(varchar(50), @w_respuesta1),
                           'XX')
    end

    if @i_tquery = '08'
    begin
      select
        @w_xml = @i_xml

      --INSERTA INCONSISTENCIAS REGISTRADAS AL MOMENTO DE EJECUTAR LA CONSULTA
      select
        codigo = isnull(
        @w_xml.value(N'(/CIFIN/consultasic/consultaic/codigo)[1]',
                     'varchar(4)'),
        ''),
        mensaje = isnull(
        @w_xml.value(N'(/CIFIN/consultasic/consultaic/mensaje)[1]',
                     'varchar(100)'),
        ''),
        error = isnull(@w_xml.value(N'(/CIFIN/consultasic/consultaic/error)[1]',
                                    'varchar(3000)'),
                       ''),
        tipo_registro = 'CTAMENSAJE' --cuenta mensaje
      into   #mensaje_gmf

      --DATOS GENERALES DEL CLIENTE DUE–O DE LA CUENTA
      create table #dato_cliente_cf_gmf
      (
        id                 int identity,
        tipoid             varchar(max) null,
        id_numero          varchar(max) null,
        nombre_largo       varchar(max) null,
        estado_dcto        varchar(max) null,
        id_fechaExpedicion varchar(max) null,
        id_LugarExpedicion varchar(max) null,
        id_mensaje         varchar(max) null,
        desc_mensaje       varchar(max) null,
        tipo_registro      varchar(max) null
      )
      insert into #dato_cliente_cf_gmf
        select
          tipoid = isnull(
          @w_xml.value(N'(/CIFIN3XM/tercero/tipo_identificacion)[1]',
                       'varchar(4)'),
          ''),id_numero = isnull(
          @w_xml.value(N'(/CIFIN3XM/tercero/numero_identificacion)[1]',
                      'varchar(20)'),
                             ''),nombre_largo = isnull(
                                 @w_xml.value(N'(/CIFIN3XM/tercero/nombre)[1]',
                                             'varchar(254)'),
                                ''),estado_dcto = isnull(
          @w_xml.value(N'(/CIFIN3XM/tercero/estado_identificacion)[1]',
                  'varchar(30)'),
                               ''),id_fechaExpedicion = isnull(
          @w_xml.value(N'(/CIFIN3XM/tercero/fecha_expedicion)[1]',
                          'varchar(10)'),
             ''),
          id_LugarExpedicion = isnull(
          @w_xml.value(N'(/CIFIN3XM/tercero/lugar_expedicion)[1]',
                       'varchar(30)'),
          ''),id_mensaje = isnull(
              @w_xml.value(N'(/CIFIN3XM/tercero/codigo_mensaje)[1]',
                       'char(2)'),
                              ''),desc_mensaje = isnull(
          @w_xml.value(N'(/CIFIN3XM/tercero/mensaje)[1]',
                     'varchar(254)'),
                                ''),tipo_registro = 'DATTITULAR'

      select
        @w_id_numero = isnull(id_numero,
                              0)
      from   #dato_cliente_cf_gmf

      if @w_id_numero <> ''
      begin
        insert into cl_marc_cifin_gen with(rowlock)
                    (mcg_tipo_ide,mcg_num_ide,mcg_nom_cli,mcg_est_ide,
                     mcg_fec_exp,
                     mcg_lug_exp,mcg_cod_msg,mcg_desc_msg)
          select
            tipoid,id_numero,nombre_largo,estado_dcto,id_fechaExpedicion,
            id_LugarExpedicion,id_mensaje,desc_mensaje
          from   #dato_cliente_cf_gmf

        if @@error <> 0
        begin
          select
            @w_msg = 'ERROR INSERTAR MARCA.CIFIN.GEN cl_marc_cifin_gen'
          rollback tran
        --goto ERROR
        end

        -- MANEJO SI HAY ERROR
        if @w_respuesta not in ('02')
        --02(cons.exitosa). (01(no existe, 03(cons no exitosa)) error
        begin
          select
            @w_id_numero = @i_num_doc
        end

        select
          @w_secuencial = ident_current('cobis..cl_marc_cifin_gen')
      end
      else
        select
          @w_secuencial = isnull(max(wa_secuencial), 0) + 1
        from   cl_ws_alerta_tmp
        where  wa_tipo_registro = 'CTAMENSAJE'

      --DATOS DE LA(AS) CUENTA(S) REGISTRADAS EN CIFIN
      select
        tipo_entidad = nCol.value(N'(./tipo_entidad)[1]',
                                  'varchar(10)'),
        entidad = nCol.value(N'(./nombre_entidad)[1]',
                             'varchar(100)'),
        num_cuenta = nCol.value(N'(./numero_obligacion)[1]',
                                'varchar(24)'),
        fecha_inicio_exencion = nCol.value(N'(./inicio_exencion)[1]',
                                           'varchar(10)'),
        fecha_fin_exencion = nCol.value(N'(./fin_exencion)[1]',
                                        'varchar(10)'),
        sucursal = nCol.value(N'(./nombre_sucursal)[1]',
                              'varchar(100)'),
        estado_cuenta = nCol.value(N'(./estado_cuenta)[1]',
                                   'char(2)'),
        --NO ESTA EN LA TRAMA esta en la hoja guia
        tipo_registro = 'CTAEXENTA' --cuenta vigente
      into   #dato_obliga_ctaexe
      from   @w_xml.nodes('CIFIN3XM/tercero/cuentas/cuentas_row') as nTable(nCol
             )

      if @@rowcount <> 0
      begin
        insert into cobis..cl_marc_cifin_ctas with(rowlock)
                    (mcc_cod,mcc_tipo_ent,mcc_nom_ent,mcc_num_cta,
                     mcc_fec_ini_exe,
                     mcc_fec_fin_exe,mcc_nom_suc,mcc_cod_est_cta)
          select
            @w_secuencial,tipo_entidad,entidad,num_cuenta,fecha_inicio_exencion,
            fecha_fin_exencion,sucursal,estado_cuenta
          from   #dato_obliga_ctaexe

        if @@error <> 0
        begin
          select
            @w_msg = 'ERROR INSERTAR MARCA.CIFIN.CTAS cl_marc_cifin_ctas'
          rollback tran
        --goto ERROR
        end
      end

      select
        @w_id_numero = isnull(codigo,
                              0)
      from   #mensaje_gmf

      if @w_id_numero <> 0
      begin
        insert into cobis..cl_ws_alerta_tmp with(rowlock)
                    (wa_item,wa_secuencial,wa_codigo_alerta,wa_texto,
                     wa_tipo_registro)
          select
            1,@w_secuencial,codigo,error,tipo_registro
          from   #mensaje_gmf

        if @@error <> 0
        begin
          select
            @w_msg = 'ERROR INSERTAR MENSAJES TERCERO cl_ws_alerta_tmp'
          rollback tran
        --goto ERROR
        end
        select
          @o_sec_error = @w_secuencial
      end
    end

    if @i_tservice = '04' -- HISTORIA DE CREDITO
    begin
      if @i_tquery = '01' -- ENDEUDAMIENTO
      begin
        create table #tmp_oblig_cf
        (
          tip_producto   char(4) null,
          num_obliga     varchar(10) null,
          saldo_oblig    money null,
          saldo_mora     money null,
          calidad        char(4) null,
          valor_inicial  money null,
          valor_cuota    money null,
          modalidad_cred char(20) null,
          linea_credito  varchar(4) null,
          tipo_entidad   varchar(4) null,
          tipo_registro  varchar(10) null
        )

        select
          @w_xml = in_trama_xml,
          @w_respuesta = in_respuesta_con
        from   cl_ente,
               cl_orden_consulta_ext,
               cl_informacion_ext
        where  en_ente      = @i_ente
           and oc_tipo_ced  = en_tipo_ced
           and oc_ced_ruc   = en_ced_ruc
           and oc_tconsulta = @i_tservice
           and oc_estado    = 'PRO'
           and in_orden     = oc_secuencial

        if @@rowcount = 0
        begin
          select
            @w_return = 1,
            @w_des_error =
            'No Existen Datos Externos para el Cliente Consultado'

          return @w_return
        end

        --*******************************************************************************************
        -- GUARDAMOS INFORMACION QUE TRAE LA TRAMA PARA PASAR LOS PRODUCTOS QUE AFECTAN ENDEUDAMIENTO
        --*******************************************************************************************
        select
          tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                    'char(4)'),
          --indica linea credito --tipo cuenta
          num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                                  'varchar(10)'),
          saldo_oblig = 1000 * isnull(nCol.value(N'(./SaldoObligacion)[1]',
                                                 'money'),
                                      0),
          saldo_mora = 1000 * isnull(nCol.value(N'(./ValorMora)[1]',
                                                'money'),
                                     0),
          calidad = nCol.value(N'(./Calidad)[1]',
                               'char(4)'),
          --garante (cartera) amparada (tarjeta credito)
          valor_inicial = 1000 * nCol.value(N'(./ValorInicial)[1]',
                                            'money'),--cupo aprobado
          valor_cuota = 1000 * nCol.value(N'(./ValorCuota)[1]',
                                          'money'),--pago minimo
          modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                      'char(20)'),--modalida credito tabla7
          linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                     'varchar(4)'),--linea credito tabla6
          tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                    'varchar(4)'),--tipo entidad tabla15
          tipo_registro = 'SECTFALDIA' --sector financiero dia
        into   #dat_tmp_sfd
        from   @w_xml.nodes('CIFIN/Tercero/SectorFinancieroAlDia/Obligacion') as
               nTable(nCol)

        select
          tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                    'char(4)'),
          --indica linea credito --tipo cuenta
          num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                                  'varchar(10)'),
          saldo_oblig = 1000 * isnull(nCol.value(N'(./SaldoObligacion)[1]',
                                                 'money'),
                                      0),
          saldo_mora = 1000 * isnull(nCol.value(N'(./ValorMora)[1]',
                                                'money'),
                                     0),
          calidad = nCol.value(N'(./Calidad)[1]',
                               'char(4)'),
          --garante (cartera) amparada (tarjeta credito)
          valor_inicial = 1000 * nCol.value(N'(./ValorInicial)[1]',
                                            'money'),--cupo aprobado
          valor_cuota = 1000 * nCol.value(N'(./ValorCuota)[1]',
                                          'money'),--pago minimo
          modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                      'char(20)'),--modalida credito tabla7
          linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                     'varchar(4)'),--linea credito tabla6
          tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                    'varchar(4)'),--tipo entidad tabla15
          tipo_registro = 'SECFENMORA' --sector financiero en mora
        into   #dat_tmp_sfm
        from   @w_xml.nodes('CIFIN/Tercero/SectorFinancieroEnMora/Obligacion')
               as
               nTable(nCol)

        select
          tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                    'char(4)'),
          --indica linea credito --tipo cuenta
          num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                                  'varchar(10)'),
          saldo_oblig = 1000 * isnull(nCol.value(N'(./SaldoObligacion)[1]',
                                                 'money'),
                                      0),
          saldo_mora = 1000 * isnull(nCol.value(N'(./ValorMora)[1]',
                                                'money'),
                                     0),
          calidad = nCol.value(N'(./Calidad)[1]',
                               'char(4)'),
          --garante (cartera) amparada (tarjeta credito)
          valor_inicial = 1000 * nCol.value(N'(./ValorInicial)[1]',
                                            'money'),--cupo aprobado
          valor_cuota = 1000 * nCol.value(N'(./ValorCuota)[1]',
                                          'money'),--pago minimo
          modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                      'char(20)'),--modalida credito tabla7
          linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                     'varchar(4)'),--linea credito tabla6
          tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                    'varchar(4)'),--tipo entidad tabla15
          tipo_registro = 'SECTRALDIA' --sector real al dia
        into   #dat_tmp_srd
        from   @w_xml.nodes('CIFIN/Tercero/SectorRealAlDia/Obligacion') as
               nTable(
               nCol
               )

        select
          tip_producto = nCol.value(N'(./PaqueteInformacion)[1]',
                                    'char(4)'),
          --indica linea credito --tipo cuenta
          num_obliga = nCol.value(N'(./NumeroObligacion)[1]',
                                  'varchar(10)'),
          saldo_oblig = 1000 * isnull(nCol.value(N'(./SaldoObligacion)[1]',
                                                 'money'),
                                      0),
          saldo_mora = 1000 * isnull(nCol.value(N'(./ValorMora)[1]',
                                                'money'),
                                     0),
          calidad = nCol.value(N'(./Calidad)[1]',
                               'char(4)'),
          --garante (cartera) amparada (tarjeta credito)
          valor_inicial = 1000 * nCol.value(N'(./ValorInicial)[1]',
                                            'money'),--cupo aprobado
          valor_cuota = 1000 * nCol.value(N'(./ValorCuota)[1]',
                                          'money'),--pago minimo
          modalidad_cred = nCol.value(N'(./ModalidadCredito)[1]',
                                      'char(20)'),--modalida credito tabla7
          linea_credito = nCol.value(N'(./LineaCredito)[1]',
                                     'varchar(4)'),--linea credito tabla6
          tipo_entidad = nCol.value(N'(./TipoEntidad)[1]',
                                    'varchar(4)'),--tipo entidad tabla15
          tipo_registro = 'SECRENMORA' --sector  real en mora
        into   #dat_tmp_srm
        from   @w_xml.nodes('CIFIN/Tercero/SectorRealEnMora/Obligacion') as
               nTable
               (
               nCol)

        --*************************************************************************************************************************
        -- INSERTAMOS LA INFORMACION SOLMANTE DE LOS PRODUCTO DE TARJETA Y CARTERA SEGUN TABLA ENTREGADA POR CIFIN PARA IDENTIFICAR
        -- LOS PRODUCTOS QUE EXISTEN POR CADA TIPO DE REGISTRO.
        --*************************************************************************************************************************

        insert into #tmp_oblig_cf
          select
            tip_producto,num_obliga,saldo_oblig,saldo_mora,calidad,
            valor_inicial,valor_cuota,modalidad_cred,linea_credito,tipo_entidad,
            tipo_registro
          from   #dat_tmp_sfd
          where  tip_producto in ('0002', -- TARJETAS CREDITO
                                  '0006', -- CARTERA TOTAL
                                  '0013', -- CARTERA TOTAL - LEASING
                                  '0014', -- CARTERA TOTAL - FIDUCIARIO
                                  '0019', -- SECTOR ASEGURADOR CARTERA
                                  '0021') -- SECTOR SOLIDARIO COOPERATIVO

        insert into #tmp_oblig_cf
          select
            tip_producto,num_obliga,saldo_oblig,saldo_mora,calidad,
            valor_inicial,valor_cuota,modalidad_cred,linea_credito,tipo_entidad,
            tipo_registro
          from   #dat_tmp_sfm
          where  tip_producto in ('0002', -- TARJETAS CREDITO
                                  '0006', -- CARTERA TOTAL
                                  '0013', -- CARTERA TOTAL - LEASING
                                  '0014', -- CARTERA TOTAL - FIDUCIARIO
                                  '0019', -- SECTOR ASEGURADOR CARTERA
                                  '0021') -- SECTOR SOLIDARIO COOPERATIVO

        insert into #tmp_oblig_cf
          select
            tip_producto,num_obliga,saldo_oblig,saldo_mora,calidad,
            valor_inicial,valor_cuota,modalidad_cred,linea_credito,tipo_entidad,
            tipo_registro
          from   #dat_tmp_srd
          where  tip_producto in ('0011', -- CARTERA SERVICIOS
                                  '0012') -- CARTERA COMERCIO O PRESTAMOS

        insert into #tmp_oblig_cf
          select
            tip_producto,num_obliga,saldo_oblig,saldo_mora,calidad,
            valor_inicial,valor_cuota,modalidad_cred,linea_credito,tipo_entidad,
            tipo_registro
          from   #dat_tmp_srm
          where  tip_producto in ('0011', -- CARTERA SERVICIOS
                                  '0012') -- CARTERA COMERCIO O PRESTAMOS

        set ANSI_WARNINGS off
        -- SE DESHABILITA PARA EVITAR MENSAJES EN EL MANEJO DE AGRUPACIONES

      /* ENDEUDAMIENTO = SECTOR FINANCIERO(SIN VIVIENDA) + SECTOR REAL(SIN TELECOMUNICACIONES) + VALOR EN MORA DE TELECOMUNICACIONES */
        -- DEUDA GLOBAL
        select
          @w_endeudamiento = sum(saldo_oblig)
        from   #tmp_oblig_cf
        where  isnull(calidad,
                      '') in ('', 'PRIN')
        -- SOLO OBLIGACIONES EN LAS QUE ES TITULAR

        -- SALDOS TOTAL Y EN MORA DE LAS TELCOS
        select
          @w_ser_pub_vig = isnull(sum(saldo_oblig),
                                  0),
          @w_ser_pub_mora = isnull(sum(saldo_mora),
                                   0)
        from   #tmp_oblig_cf
        where  isnull(calidad,
                      '') in ('', 'PRIN')
           -- SOLO OBLIGACIONES EN LAS QUE ES TITULAR
           and tip_producto in ('0011', '0012')
           -- SETOR REAL - SERVICIOS / COMERCIO / PRESTAMOS
           and isnull(tipo_entidad,
                      '') in ('COMU', 'CCEL') -- EMPRESAS DE TELECOMUNICACIONES

        select
          @w_cartera_viv = isnull(sum(saldo_oblig),
                                  0)
        from   #tmp_oblig_cf
        where  isnull(calidad,
                      '') in ('', 'PRIN')
           -- SOLO OBLIGACIONES EN LAS QUE ES TITULAR
           and isnull(modalidad_cred,
                      '') = 'VIVI' -- VIVIENDA

        insert into #endeu_tmp
                    (te_endeudamiento,te_vivienda,te_serpubdia,te_serpubmora)
        values     ( isnull(@w_endeudamiento,
                            0),isnull(@w_cartera_viv,
                            0),isnull(@w_ser_pub_vig,
                            0),isnull(@w_ser_pub_mora,
                            0))

      end

      if @i_tquery = '03' -- DATOS PERSONALES
      begin
        select
          @w_xml = in_trama_xml
        from   cl_orden_consulta_ext,
               cl_informacion_ext
        where  oc_tipo_ced  = isnull(@i_type_doc,
                                     '')
           and oc_ced_ruc   = isnull(@i_num_doc,
                                     '')
           and oc_tconsulta = @i_tservice
           and oc_estado    = 'PRO'
           and in_orden     = oc_secuencial

        if @@rowcount = 0
        begin
          select
            @w_return = 1,
            @w_des_error =
            'No Existen Datos Externos para el Cliente Consultado'

          return @w_return
        end

        insert into #datos_cliente
                    (nombres,cod_tipoid,id_numero,tipoid,id_fechaExpedicion,
                     id_LugarExpedicion,id_estado,id_departamento,id_ciudad,
                     cod_ciiu
                     ,
                     rango_edad,fecha_cons,hora_cons,nro_informe)
          select
            nombre = @w_xml.value(N'(/CIFIN/Tercero/NombreTitular)[1]',
                                  'varchar(96)'),cod_tipoid =
            @w_xml.value(N'(/CIFIN/Tercero/CodigoTipoIndentificacion)[1]',
                                      'varchar(4)'),id_numero =
            @w_xml.value(N'(/CIFIN/Tercero/NumeroIdentificacion)[1]',
                                     'varchar(20)'),tipoid =
            @w_xml.value(N'(/CIFIN/Tercero/TipoIdentificacion)[1]',
                                  'varchar(4)'),id_fechaExpedicion =
            @w_xml.value(N'(/CIFIN/Tercero/FechaExpedicion)[1]',
                                              'varchar(20)'),
            id_LugarExpedicion =
            @w_xml.value(N'(/CIFIN/Tercero/LugarExpedicion)[1]',
                         'varchar(30)'),id_estado =
            @w_xml.value(N'(/CIFIN/Tercero/EstadoTitular)[1]',
                                     'varchar(30)'),id_departamento =
            @w_xml.value(N'(/CIFIN/Tercero/CodigoDepartamento)[1]',
                                           'varchar(30)'),id_ciudad =
            @w_xml.value(N'(/CIFIN/Tercero/CodigoMunicipio)[1]',
                                     'varchar(30)'),id_cod_ciiu =
            @w_xml.value(N'(/CIFIN/Tercero/CodigoCiiu)[1]',
                                       'varchar(30)'),
            rango_edad = @w_xml.value(N'(/CIFIN/Tercero/RangoEdad)[1]',
                                      'varchar(10)'),fecha_cons =
            @w_xml.value(N'(/CIFIN/Tercero/Fecha)[1]',
                                      'varchar(10)'),hora_cons =
            @w_xml.value(N'(/CIFIN/Tercero/Hora)[1]',
                                     'varchar(20)'),nro_informe =
            @w_xml.value(N'(/CIFIN/Tercero/NumeroInforme)[1]',
                                       'varchar(100)')
      end
    end
  end

  if @i_central = '2' -- DATACREDITO
  begin
    if @i_tquery = '00' -- TIPO DE RESPUESTA Y ESTADO DEL DOCUMENTO
    begin
      select
        @w_xml = @i_xml
      if @@rowcount = 0
      begin
        select
          @w_return = 1,
          @w_des_error = 'No hay trama a interpretar'

        return @w_return
      end

      select
        @w_respuesta = @w_xml.value(N'(/informe/@respuesta)[1]',
                                    'varchar(10)')
      select
        @w_respuesta1 =
        @w_xml.value(N'(/informe/naturalNacional/identificacion/@estado)[1]',
                                     'varchar(50)')
      select
        @o_est_consulta = isnull(convert(varchar(10), @w_respuesta),
                                 'XX')
      select
        @o_est_id = isnull(convert(varchar(50), @w_respuesta1),
                           'XX')
    end

    if @i_tservice = '02' -- HISTORIA CREDITICIA CLIENTE
    begin
      if @i_tquery = '01' -- ENDEUDAMIENTO
      begin
        create table #tmp_tdc
        (
          tc_numero       varchar(20) null,
          tc_saldo_actual money null,
          tc_garante      varchar(10) null
        )

        create table #tmp_cca
        (
          cca_numero_obligacion varchar(20) null,
          cca_saldo_actual      money null,
          cca_saldo_mora        money null,
          cca_garante           varchar(10) null,
          cca_tipo_cuenta       varchar(10) null
        )

        select
          @w_xml = in_trama_xml,
          @w_respuesta = in_respuesta_con
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
            @w_return = 1,
            @w_des_error =
            'No Existen Datos Externos para el Cliente Consultado'

          return @w_return
        end

        select
          num_oblig = nCol.value(N'(@numero)[1]',
                                 'varchar(20)'),
          amparada = nCol.value(N'(@amparada)[1]',
                                'varchar(10)'),
          detalle = nCol.query('./valores')
        into   #dat_tmp
        from   @w_xml.nodes('/informe/tarjetaCredito') as nTable(nCol)

        insert into #tmp_tdc
          select
            num_oblig,saldo_act = isnull(
                      detalle.value(N'(/valores/@saldoActual)[1]',
                          'money'),
                               0),amparada
          from   #dat_tmp

        select
          num_oblig = nCol.value(N'(@numeroObligacion)[1]',
                                 'varchar(20)'),
          garante = nCol.value(N'(@garante)[1]',
                               'varchar(10)'),
          tcuenta = nCol.value(N'(@tipoCuenta)[1]',
                               'varchar(10)'),
          detalle = nCol.query('./valores')
        into   #dat_tmp1
        from   @w_xml.nodes('/informe/cuentaCartera') as nTable(nCol)

        insert into #tmp_cca
          select
            num_oblig,saldo_act = isnull(
                      detalle.value(N'(/valores/@saldoActual)[1]',
                          'money'),
                               0),saldo_mor = isnull(
                                  detalle.value(N'(/valores/@saldoMora)[1]',
                                             'money'),
                               0),garante,tcuenta
          from   #dat_tmp1

        set ANSI_WARNINGS off
        -- SE DESHABILITA PARA EVITAR MENSAJES EN EL MANEJO DE AGRUPACIONES

        -- DEUDA GLOBAL TC
        select
          @w_total_tdc = sum(tc_saldo_actual)
        from   #tmp_tdc
        where  upper(tc_garante) = 'FALSE'

        -- DEUDA GLOBAL CARTERA
        select
          @w_total_cca = sum(cca_saldo_actual)
        from   #tmp_cca
        where  cca_garante = '00'

        select
          @w_endeudamiento = isnull(@w_total_tdc, 0) + isnull(@w_total_cca, 0)

        select
          @w_ser_pub_vig = isnull(sum(cca_saldo_actual),
                                  0),
          @w_ser_pub_mora = isnull(sum(cca_saldo_mora),
                                   0)
        from   #tmp_cca
        where  cca_tipo_cuenta in ('CTC', 'CSP', 'CDC')
           and cca_garante = '00'

        select
          @w_cartera_viv = isnull(sum(cca_saldo_actual),
                                  0)
        from   #tmp_cca
        where  cca_tipo_cuenta = 'CAV'
           and cca_garante     = '00'

        insert into #endeu_tmp
                    (te_endeudamiento,te_vivienda,te_serpubdia,te_serpubmora)
        values     ( isnull(@w_endeudamiento,
                            0),isnull(@w_cartera_viv,
                            0),isnull(@w_ser_pub_vig,
                            0),isnull(@w_ser_pub_mora,
                            0))

      end

      if @i_tquery = '03' -- DATOS PERSONALES
      begin
        --Leer la Trama
        select
          @w_xml = in_trama_xml
        from   cl_orden_consulta_ext,
               cl_informacion_ext
        where  oc_tipo_ced  = isnull(@i_type_doc,
                                     '')
           and oc_ced_ruc   = isnull(@i_num_doc,
                                     '')
           and oc_tconsulta = @i_tservice
           and oc_estado    = 'PRO'
           and in_orden     = oc_secuencial

        if @@rowcount = 0
        begin
          select
            @w_return = 1,
            @w_des_error =
            'No Existen Datos Externos para el Cliente Consultado'

          return @w_return
        end

        insert into #datos_cliente
                    (nombres,primerApellido,segundoApellido,genero,ecivil,
                     id_estado,id_fechaExpedicion,id_ciudad,id_departamento,
                     id_numero,
                     edad_min,edad_max,nombres_nex,id_numero_nex,
                     nacionalidad_nex,
                     nombres_jna,id_numero_jna,nombres_jex,id_numero_jex)
          select
            nombres = @w_xml.value(N'(/informe/naturalNacional/@nombres)[1]',
                                   'varchar(40)'),primerApellido =
            @w_xml.value(N'(/informe/naturalNacional/@primerApellido)[1]',
                                          'varchar(40)'),segundoApellido =
            @w_xml.value(N'(/informe/naturalNacional/@segundoApellido)[1]',
                                           'varchar(40)'),genero =
            @w_xml.value(N'(/informe/naturalNacional/@genero)[1]',
                                  'varchar(10)'),ecivil =
            @w_xml.value(N'(/informe/naturalNacional/@estadoCivil)[1]',
                                  'varchar(10)'),
            id_estado =
@w_xml.value(N'(/informe/naturalNacional/identificacion/@estado)[1]',
             'varchar(10)'),id_fechaExpedicion =
@w_xml.value(N'(/informe/naturalNacional/identificacion/@fechaExpedicion)[1]',
'varchar(20)'),id_ciudad =
@w_xml.value(N'(/informe/naturalNacional/identificacion/@ciudad)[1]',
'varchar(30)'),id_departamento =
@w_xml.value(N'(/informe/naturalNacional/identificacion/@departamento)[1]',
'varchar(30)'),id_numero =
@w_xml.value(N'(/informe/naturalNacional/identificacion/@numero)[1]',
'varchar(20)'),
edad_min = @w_xml.value(N'(/informe/naturalNacional/edad/@min)[1]',
              'varchar(20)'),edad_max =
@w_xml.value(N'(/informe/naturalNacional/edad/@max)[1]',
              'varchar(20)'),nombres_nex =
@w_xml.value(N'(/informe/naturalExtranjera/@nombre)[1]',
                 'varchar(40)'),id_numero_nex =
@w_xml.value(N'(/informe/naturalExtranjera/@identificacion)[1]',
                   'varchar(20)'),nacionalidad_nex =
@w_xml.value(N'(/informe/naturalExtranjera/@nacionalidad)[1]',
                      'varchar(20)'),
nombres_jna = @w_xml.value(N'(/informe/juridicaNacional/@nombre)[1]',
                 'varchar(40)'),id_numero_jna =
@w_xml.value(N'(/informe/juridicaNacional/@identificacion)[1]',
                   'varchar(20)'),nombres_jex =
@w_xml.value(N'(/informe/juridicaExtranjera/@nombre)[1]',
                 'varchar(40)'),id_numero_jex =
@w_xml.value(N'(/informe/juridicaExtranjera/@identificacion)[1]',
                   'varchar(20)')
end
end
end

  -- INI - PAQUETE 2 - REQ 214 - IOM 20/JUN/2010
  if @i_central = '3' -- MIR
  begin
    if @i_tquery = '00' -- TIPO DE RESPUESTA Y ESTADO DEL DOCUMENTO
    begin
      select
        @w_xml = @i_xml

      select
        @w_respuesta =
@w_xml.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (/Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:dictamenDespues)[1]',
             'varchar(10)')
 select
   @w_respuesta1 =
@w_xml.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (/Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:pd)[1]',
             'varchar(50)')
 select
   @o_est_consulta = isnull(convert(varchar(10), @w_respuesta),
                            'XX')
 select
   @o_est_id = isnull(convert(varchar(50), @w_respuesta1),
                      'XX')

 if @o_est_consulta = 'XX'
     or @o_est_id = 'XX'
   select
     @o_trama_error = 'S'
 end

 if @i_tquery = '01' -- VARIABLES DE DECISION DEL TRAMITE
 begin
   if @i_xml is null
     select
       @w_xml = in_trama_xml
     from   cl_orden_consulta_ext,
            cl_informacion_ext
     where  oc_tipo_ced  = 'TR'
        and oc_ced_ruc   = convert(varchar(10), @i_tramite)
        and oc_tconsulta = @i_tservice
        and oc_estado    = 'PRO'
        and in_orden     = oc_secuencial
   else
     select
       @w_xml = @i_xml

   if @w_xml is null
     return 107203

   select
     @w_cumplimiento =
elemento.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (ns0:dictamen)[1]',
               'varchar(30)')
 from
@w_xml.nodes(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; /Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:dictamen_Regla') as trama_xml(elemento)
 where
elemento.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (ns0:codigo)[1]',
               'varchar(30)') = 'Pol_cumplimiento'

select
  @w_nivel =
elemento.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (ns0:valor)[1]',
'varchar(30)')
from
@w_xml.nodes(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; /Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:variables') as trama_xml(elemento)
where
elemento.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (ns0:codigo)[1]',
               'varchar(30)') = 'Nivel_Modelo'

   --REQ:423. Nombre de la Politica: Pol_alto_riesgo
   select
     @w_alto_riesgo =
elemento.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (ns0:dictamen)[1]',
               'varchar(30)')
 from
@w_xml.nodes(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; /Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:dictamen_Regla') as trama_xml(elemento)
 where
elemento.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (ns0:codigo)[1]',
               'varchar(30)') = 'Pol_alto_riesgo'

insert into #datos_rta_mir
            (modelo,pd,decision,cumplimiento,nivel,
             alto_riesgo)
  select
@w_xml.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (/Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:codigo_modelo)[1]',
             'varchar(30)'),
@w_xml.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (/Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:pd)[1]',
             'varchar(30)'),
@w_xml.value(N'declare namespace ns0="http://Persistencia.MIR_concesion/xsd"; (/Resultado_Calculo_Puntuacion_Propuesta_Estamento/ns0:resultado/ns0:dictamenDespues)[1]',
             'varchar(30)'),@w_cumplimiento,@w_nivel,
@w_alto_riesgo
 end
  end
  -- FIN - PAQUETE 2 - REQ 214

  return 0

go

