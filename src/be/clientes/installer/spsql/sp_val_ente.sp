/* **********************************************************************/
/*      Archivo:                sp_val_ente.sp                          */
/*      Stored procedure:       sp_val_ente                             */
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
/*    Validacion Masiva de Datos de Clientes vs Origenes Externos       */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR               RAZON                               */
/*  05/03/2010  C. Ballen   REQ 108 CIFIN - segun  catalogo consulta    */
/*                          datos ext: cl_tipo_consulta_ext             */
/*                          '01' - datos personales-datacredito         */
/*                          '02' - datos financieros-datacredito        */
/*                          '03' - datos personales-cifin               */
/*                          '04' - datos financieros-ciifin             */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_val_ente')
           drop proc sp_val_ente
go

create proc sp_val_ente
  @t_show_version bit = 0,
  @i_user         varchar(20) = null,
  @i_office       int,
  @i_lote         int,
  -- CANTIDAD DE REGISTROS A PROCESAR POR CADA ITERACION [0-SINLIMITE, #]
  @i_central      varchar(10)
as
  declare
    @w_return          int,
    @w_sp_name         varchar(20),
    @w_table_prd       varchar(20),
    @w_today           datetime,
    @w_table_cat       int,
    @w_des_error       varchar(255),
    @w_services        varchar(10),
    @w_services1       varchar(10),
    @w_tservice_p      varchar(10),
    @w_ente_next       int,
    @w_type_id         varchar(10),
    @w_num_id          varchar(20),
    @w_fecha_proceso   datetime,
    @w_rowcount        int,
    @w_error           int,
    @w_respuesta       varchar(10),
    @w_central         varchar(10),
    @w_val_est_nue     char(1),
    @w_val_est_ant     char(1),
    @w_oficina         smallint,
    @w_usuario         login,
    -- CIFIN
    @w_descrip_next    varchar(255),
    @w_services3       varchar(10),
    @w_services4       varchar(10),
    @w_services_con    varchar(10),
    @w_monto_consultar money,
    @w_documto_next    varchar(10),
    @w_conslta_financ  money,
    @w_monto_tramite   money,
    @w_central_tmp     varchar(10),
    @w_activa_req_paq3 char(1),
    @w_tramite         int,
    @w_mascara         varchar(16),
    @w_tipo_doc        varchar(10),
    @w_doc_mascara     varchar(20),
    @w_evt_ente        int,
    @w_evt_p_apellido  varchar(40),
    @w_p_p_apellido    varchar(40)

  select
    @w_sp_name = 'sp_val_ente'

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
    @w_table_prd = 'cl_producto_val',
    --Listado de Productos COBIS relacionados con ente a Validar
    @w_today = getdate(),
    @w_services = '01',--WebServices para validacion de clientes-datacredito
    @w_services1 = '02',
    --WebServices para validacion de clientes desde HC-datacredito
    @w_ente_next = 0,
    --CIFIN
    @w_services3 = '03',
    --WebServices para validacion de clientes-datacredito-cifin (ctlogo cl_tipo_consulta_ext)
    @w_services4 = '04',
    --WebServices para validacion de clientes-datacredito-cifin (ctlogo cl_tipo_consulta_ext)
    @w_documto_next = '',
    @w_descrip_next = '',
    @w_central = '',
    @w_central_tmp = '',
    @w_mascara = '00000000000',
    -- MASCARA DE DOCUMENTO DE IDENTIFICACION PARA DATACREDITO
    @w_doc_mascara = '',
    @w_tipo_doc = ''

/*******************************/
/* CONSULTA DATOS PARAMETRICOS */
  /*******************************/

  select
    @w_fecha_proceso = convert(varchar(10), fp_fecha, 101)
  from   ba_fecha_proceso

  if @@rowcount = 0
  begin
    select
      @w_des_error = 'No se pudo obtener fecha de proceso modulo',
      @w_return = 5
    goto ERROR_GEN
  end

  select
    @w_activa_req_paq3 = pa_char
  -- PARAMETRO DE ACTIVACION DE FUNCIONALIDAD PAQUETE 3
  from   cl_parametro
  where  pa_producto = 'CRE'
     and pa_nemonico = 'ACTRP3'

  if @w_activa_req_paq3 is null
    select
      @w_activa_req_paq3 = 'N'

  if @w_activa_req_paq3 = 'S'
  begin
    select
      @w_conslta_financ = pa_money -- MONTO PARA DEFINIR CENTRAL DE RIESGO
    from   cl_parametro
    where  pa_producto = 'MIS'
       and pa_nemonico = 'MDEFCO'

    if @@rowcount = 0
    begin
      select
        @w_error = 101077
      goto ERROR_GEN
    end
  end

  select
    @w_table_cat = codigo
  from   cl_tabla
  where  tabla = @w_table_prd

  if @@rowcount = 0
  begin
    select
      @w_des_error =
      'Tabla de Productos COBIS Relacionados a Ente No Parametrizada'
      ,
      @w_return = 10
    goto ERROR_GEN
  end

  if not exists (select
                   1
                 from   cl_catalogo
                 where  tabla = @w_table_cat)
  begin
    select
      @w_des_error =
             'Catalogo de Productos COBIS Relacionados a Ente No Parametrizada',
      @w_return = 15
    goto ERROR_GEN
  end

  exec @w_return = sp_orden_consulta_ext -- RECHAZO DE ORDENES NO PROCESADAS
    @s_user = 'operador',
    @s_ofi  = 1,
    @i_modo = 'X'

  if @w_return != 0
  begin
    select
      @w_des_error = 'Error en rechazo de ordenes no procesadas',
      @w_return = 20
    goto ERROR_GEN
  end

  create table #tmp_validar
  (
    ente      int not null,
    type_id   varchar(10) not null,
    num_id    varchar(20) not null,
    last_name varchar(40) null,
    oficina   smallint null,-- GAL 30/AGO/2010 - ORD. SER. 000057
    usuario   varchar(14) null,-- GAL 30/AGO/2010 - ORD. SER. 000057
    tramite   int null,
    central   varchar(10) null,
    rol       varchar(10) null -- GAL 25/ENE/2011 - REQ 173: PEQUEÐA EMPRESA
  )

  create table #rel_validar
  (-- GAL 25/ENE/2011 - REQ 173: PEQUEÐA EMPRESA
    ente_sup   int not null,
    oficina    smallint null,
    usuario    varchar(14) null,
    tramite    int null,
    ente_inf   int not null,
    porcentaje float null,
    secuencial int not null
  )

/******************************************************/
/* PROCESAMIENTO: EXTRAER CLIENTES A VALIDAR X LOTES  */
/******************************************************/
  -- CLIENTES MODIFICADOS CON PRODUCTOS
  insert into #tmp_validar
              (ente,type_id,num_id,last_name,oficina,
               usuario,tramite,central)
    select
      en_ente,en_tipo_ced,en_ced_ruc,isnull(p_p_apellido,
             ''),dp_oficina,-- GAL 30/AGO/2010 - ORD. SER. 000057
      (select
         fu_login
       from   cl_funcionario,cc_oficial -- GAL 30/AGO/2010 - ORD. SER. 000057
       where  oc_oficial     = D.dp_oficial_cta
          and fu_funcionario = oc_funcionario),0,'2' -- POR DEFAULT DATACREDITO
    from   cl_ente,
           cl_cliente,
           cl_det_producto D
    where  en_doc_validado is null
       and (en_fecha_crea   >= @w_fecha_proceso
             or en_fecha_mod    >= @w_fecha_proceso)
       and cl_cliente      = en_ente
       and dp_det_producto = cl_det_producto
       and dp_estado_ser   = 'V'
       and dp_producto in
           (select
              convert(int, codigo)
            from   cl_catalogo
            where  tabla = @w_table_cat)

  if @@error <> 0
  begin
    select
      @w_des_error = 'Error en insercion de clientes por validar - Productos',
      @w_return = 35
    goto ERROR_GEN
  end

  -- CLIENTES CON TRAMITES EN CURSO ESTE APLICARIA CIFIN-DATACREDITO (TRAMITES)
  insert into #tmp_validar
              (ente,type_id,num_id,last_name,oficina,
               usuario,tramite,central,rol)
    select
      en_ente,en_tipo_ced,en_ced_ruc,isnull(p_p_apellido,
             ''),tr_oficina,
      tr_usuario,-- GAL 30/AGO/2010 - ORD. SER. 000057
      tr_tramite,'2',de_rol -- POR DEFAULT CENTRAL DATACREDITO (2)
    from   cob_credito..cr_tramite,
           cob_credito..cr_deudores,
           cl_ente
    where  tr_estado not in ('Z', 'A')
       and tr_tipo    <> 'A' --req 62 tramites de actualiza inf.
       and de_tramite = tr_tramite
       and en_ente    = de_cliente
       and en_doc_validado is null
       and (tr_alianza is null
             or (tr_alianza is not null
                 and tr_autoriza_central is not null))

  if @@error <> 0
  begin
    select
      @w_des_error =
      'Error en insercion de clientes por validar - Tramites en curso',
      @w_return = 40
    goto ERROR_GEN
  end

  /* INICIO - REQ 173 - PEQUEÐA EMPRESA - CONSULTA DE SOCIOS Y REPRESENTANTE LEGAL DE UNA PERSONA JURIDICA */
  exec @w_return = sp_relacion_validar
    @i_modo   = 'M',
    @i_valida = 'S'

  if @w_return <> 0
  begin
    select
      @w_des_error = 'Error en consulta de relaciones para validacion'
    goto ERROR_GEN
  end

  -- ELIMINACION DE SOCIOS YA VALIDADOS
  delete #rel_validar
  from   cl_ente
  where  ente_inf = en_ente
     and en_doc_validado is not null

  if @@error <> 0
  begin
    select
      @w_des_error =
      'Error en eliminacion de socios excluidos por estar validados',
      @w_return = 42
    goto ERROR_GEN
  end

  -- INSERCION DE SOCIOS EN TEMPORAL DE VALIDACION
  insert into #tmp_validar
              (ente,type_id,num_id,last_name,oficina,
               usuario,tramite,central)
    select
      en_ente,en_tipo_ced,en_ced_ruc,isnull(p_p_apellido,
             ''),oficina,
      usuario,tramite,'2'
    from   #rel_validar,
           cl_ente
    where  ente_inf = en_ente

  if @@error <> 0
  begin
    select
      @w_des_error = 'Error en insercion de personas por validar - Socios',
      @w_return = 44
    goto ERROR_GEN
  end
  /* FIN - REQ 173 - PEQUEÐA EMPRESA */

  select
    @w_tramite = 0

  while 1 = 1
  begin
    select top 1
      @w_tramite = tramite
    from   #tmp_validar
    where  tramite > @w_tramite
    order  by tramite

    if @@rowcount = 0
      break

    exec @w_return = cob_credito..sp_central_riesgo
      @i_tramite = @w_tramite,
      @i_backend = 'S',
      @o_central = @w_central out

    if @w_return <> 0
    begin
      select
        @w_des_error = 'Error en determinacion de central de riesgo',
        @w_return = 45
      goto ERROR_GEN
    end

    update #tmp_validar
    set    central = codigo_sib
    from   cob_credito..cr_corresp_sib
    where  tramite = @w_tramite
       and tabla   = 'T106'
       and codigo  = @w_central
  end

  -- ACTUALIZAR NUMERO IDENTIFICACION CON MASCARA DATACREDITO 11 DIGITOS CON CERO A IZQ.
  update #tmp_validar
  set    num_id = right(@w_mascara + rtrim(ltrim(num_id)),
                        len(@w_mascara))
  where  central = '2'

  if @@error <> 0
  begin
    select
      @w_des_error = 'Error en actualizaion tabla tmp_validar nro id',
      @w_return = 49
    goto ERROR_GEN
  end

  -- BORRAR REGISTROS QUE YA ESTAN EN TABLA cl_ente_valid_tmp DATACREDITO(CON APELLIDO LLAVE)
  delete #tmp_validar
  from   cl_ente_valid_tmp
  where  evt_central = '2'
     and central     = evt_central
     and ente        = evt_ente
     and type_id     = evt_tipo_ced
     and num_id      = evt_ced_ruc
     and last_name   = evt_p_apellido

  -- BORRAR REGISTROS QUE YA ESTAN EN TABLA cl_ente_valid_tmp CIFIN (SIN APELLIDO LLAVE)
  delete #tmp_validar
  from   cl_ente_valid_tmp
  where  evt_central = '1'
     and central     = evt_central
     and ente        = evt_ente
     and type_id     = evt_tipo_ced
     and num_id      = evt_ced_ruc

/********************************************/
/* PASO A HISTORICOS DE REGISTROS VALIDADOS */
/********************************************/
  -- PASO A HISTORICOS - DATACREDITO
  insert into cl_ente_valid_his
              (evh_ente,evh_tipo_ced,evh_ced_ruc,evh_p_apellido,evh_estado,
               evh_fecha_proc,evh_fecha_real,evh_oficina,evh_usuario,
               -- GAL 30/AGO/2010 - ORD. SER. 000057 - evh_oficina, evh_usuario
               evh_central)
    select
      evt_ente,evt_tipo_ced,evt_ced_ruc,evt_p_apellido,evt_estado,
      evt_fecha_proc,evt_fecha_real,evt_oficina,evt_usuario,
      -- GAL 30/AGO/2010 - ORD. SER. 000057 - evt_oficina, evt_usuario
      evt_central
    from   cl_ente_valid_tmp,
           #tmp_validar
    where  evt_central = '2'
       and central     = evt_central
       and type_id     = evt_tipo_ced
       and num_id      = evt_ced_ruc
       and last_name   = evt_p_apellido

  if @@error <> 0
  begin
    select
      @w_des_error = 'Error en paso a hisoricos de validaciones de cliente',
      @w_return = 50
    goto ERROR_GEN
  end

  delete cl_ente_valid_tmp
  from   #tmp_validar
  where  evt_central = '2'
     and central     = evt_central
     and type_id     = evt_tipo_ced
     and num_id      = evt_ced_ruc
     and last_name   = evt_p_apellido

  if @@error <> 0
  begin
    select
      @w_des_error =
             'Error en limpieza en paso a historicos de validaciones de cliente'
      ,
      @w_return = 55
    goto ERROR_GEN
  end

  -- PASO A HISTORICOS -CIFIN
  insert into cl_ente_valid_his
              (evh_ente,evh_tipo_ced,evh_ced_ruc,evh_p_apellido,evh_estado,
               evh_fecha_proc,evh_fecha_real,evh_oficina,evh_usuario,
               -- GAL 30/AGO/2010 - ORD. SER. 000057 - evh_oficina, evh_usuario
               evh_central)
    select
      evt_ente,evt_tipo_ced,evt_ced_ruc,evt_p_apellido,evt_estado,
      evt_fecha_proc,evt_fecha_real,evt_oficina,evt_usuario,
      -- GAL 30/AGO/2010 - ORD. SER. 000057 - evt_oficina, evt_usuario
      evt_central
    from   cl_ente_valid_tmp,
           #tmp_validar
    where  evt_central = '1'
       and central     = evt_central
       and type_id     = evt_tipo_ced
       and num_id      = evt_ced_ruc

  if @@error <> 0
  begin
    select
      @w_des_error = 'Error en paso a historicos de validaciones de cliente',
      @w_return = 50
    goto ERROR_GEN
  end

  delete cl_ente_valid_tmp
  from   #tmp_validar
  where  evt_central = '1'
     and central     = evt_central
     and type_id     = evt_tipo_ced
     and num_id      = evt_ced_ruc

  if @@error <> 0
  begin
    select
      @w_des_error =
             'Error en limpieza en paso a historicos de validaciones de cliente'
      ,
      @w_return = 55
    goto ERROR_GEN
  end

/***********************************************/
/* PASO A DEFINITIVA DE PENDIENTES POR VALIDAR */
  /***********************************************/

  set rowcount @i_lote

  insert into cl_ente_valid_tmp
              (evt_ente,evt_tipo_ced,evt_ced_ruc,evt_p_apellido,evt_estado,
               evt_fecha_proc,evt_fecha_real,evt_oficina,evt_usuario,
               -- GAL 30/AGO/2010 - ORD. SER. 000057 - evt_oficina, evt_usuario
               evt_central)
    select distinct
      ente,type_id,num_id,last_name,'I',
      @w_fecha_proceso,@w_today,oficina,usuario,
      -- GAL 30/AGO/2010 - ORD. SER. 000057 - oficina, usuario
      central
    from   #tmp_validar

  if @@error <> 0
  begin
    set rowcount 0

    select
      @w_des_error = 'Error en paso a definitiva de clientes por validar',
      @w_return = 60
    goto ERROR_GEN
  end

  set rowcount 0

/*********************************************************/
/* GENERACION DE ORDENES DE CONSULTA A CENTRAL DE RIESGO */
  /*********************************************************/

  while 1 = 1
  begin
    select
      @w_des_error = '',
      @w_error = 0

    select top 1
      @w_evt_ente = evt_ente,
      @w_oficina = evt_oficina,-- GAL 30/AGO/2010 - ORD. SER. 000057
      @w_usuario = evt_usuario,-- GAL 30/AGO/2010 - ORD. SER. 000057
      @w_central_tmp = evt_central,
      @w_evt_p_apellido = isnull(evt_p_apellido,
                                 ''),
      @w_tipo_doc = evt_tipo_ced,
      @w_doc_mascara = evt_ced_ruc
    from   cl_ente_valid_tmp with (nolock index=idx3)
    where  evt_estado in ('I', 'R')

    if @@rowcount = 0
      break

    select
      @w_ente_next = en_ente,
      @w_p_p_apellido = isnull(p_p_apellido,
                               '')
    from   cl_ente
    where  en_tipo_ced = @w_tipo_doc
       and en_ced_ruc  = substring(@w_doc_mascara,
                                   patindex('%[^0]%',
                                            @w_doc_mascara),
                                   len(@w_doc_mascara))

    /*CONTROLAR QUE EL CLIENTE EXISTA*/
    if @@rowcount = 0
    begin
      select
        @w_error = 1,
        @w_des_error = 'NO SE ENCUENTRA EL ENTE CON CEDULA: ' + @w_doc_mascara +
                       ' TDOC:' + @w_tipo_doc
      goto ERROR1
    end

    /* SOLO PARA DATACREDITO, EL PRIMER APELLIDO DEBE SER EL MISMO QUE LA ORDEN */
    if @w_central_tmp = '2'
       and @w_evt_p_apellido <> @w_p_p_apellido
    begin
      select
        @w_error = 2,
        @w_des_error = 'CONSULTA A DATACREDITO CON NOMBRE DESACTUALIZADO'
      goto ERROR1
    end

    /* MARCAR COMO ERRONEOS LOS REGISTROS QUE TENGAN CODIGO DE ENTE DISTINTO */
    if @w_evt_ente <> @w_ente_next
    begin
      select
        @w_error = 3,
        @w_des_error =
        'CONSULTA A CENTRAL DE RIESGO CON CODIGO DE ENTE DESACTUALIZADO'
      goto ERROR1
    end

    if @w_central_tmp = '1' --cifin
      select
        @w_services_con = @w_services4 --cifin -datofinanciero(04)
    else
      select
        @w_services_con = @w_services1 --datacredito-datofinanciero(02)

    -- LLAMADO SP SP_ORDEN_CONSULTA_EXT
    exec @w_error = sp_orden_consulta_ext
      @s_user        = @w_usuario,-- GAL 30/AGO/2010 - ORD. SER. 000057
      @s_ofi         = @w_oficina,-- GAL 30/AGO/2010 - ORD. SER. 000057
      @i_modo        = 'I',
      @i_ente        = @w_ente_next,
      @i_tconsulta   = @w_services_con,
      @i_observacion = 'CONSULTA POR VALIDACION AUTOMATICA DE CLIENTE'
    -- GAL 30/AGO/2010 - ORD. SER. 000057

    if @w_error <> 0
    begin
      select
        @w_des_error = 'ERROR AL GENERAR LA ORDEN DE CONSULTA'
      goto ERROR1
    end

    update cl_ente_valid_tmp
    set    evt_estado = 'O'
    where  evt_estado in ('I', 'R')
       and evt_ente                  = @w_evt_ente
       and evt_tipo_ced              = @w_tipo_doc
       and evt_ced_ruc               = @w_doc_mascara
       and evt_central               = @w_central_tmp
       and isnull(evt_p_apellido,
                  '') = @w_evt_p_apellido

    select
      @w_error = @@error

    if @w_error <> 0
    begin
      select
        @w_des_error = 'ERROR AL ACTUALIZAR TABLA DE CLIENTES EN VALIDACION'
      goto ERROR1
    end

    goto SIGUIENTE1

    ERROR1:

    update cl_ente_valid_tmp
    set    evt_estado = 'E'
    where  evt_estado in ('I', 'R')
       and evt_ente                  = @w_evt_ente
       and evt_tipo_ced              = @w_tipo_doc
       and evt_ced_ruc               = @w_doc_mascara
       and evt_central               = @w_central_tmp
       and isnull(evt_p_apellido,
                  '') = @w_evt_p_apellido

    insert into cl_error_logws
    values      ( @w_today,@w_error,'proc_val_ente',@w_ente_next,null,
                  @w_des_error)

    SIGUIENTE1:

  end

/**************************/
/* VALIDACION DE CLIENTES */
  /**************************/

  select
    @w_ente_next = 0

  while 1 = 1
  begin
    select top 1
      @w_ente_next = evt_ente,
      @w_type_id = evt_tipo_ced,
      @w_num_id = evt_ced_ruc,
      @w_tservice_p = oc_tconsulta,
      @w_respuesta = in_respuesta_con,
      @w_central = evt_central --cifin
    from   cl_ente_valid_tmp,
           cl_orden_consulta_ext,
           cl_informacion_ext
    where  evt_estado  = 'O'
       and evt_ente    > @w_ente_next
       and oc_tipo_ced = evt_tipo_ced
       and oc_ced_ruc  = evt_ced_ruc
       and oc_tconsulta in (@w_services, @w_services1, @w_services3,
                            @w_services4)
       --cifin
       and oc_estado   = 'PRO'
       and in_orden    = oc_secuencial
    order  by evt_ente

    if @@rowcount = 0
      break

    if rtrim(ltrim(@w_tservice_p)) in ('01', '02')
      select
        @w_documto_next = '01',-- DCTO NO VALIDO DATACREDITO
        @w_descrip_next =
        'Documento No Validado - Respuesta de Datacredito sin informacion'

    -- TIPO CONSULTA EXTERNA (CATALOGO cl_tipo_consulta_ext - 03 CIFIN DATOS PERSONALES / 04 CIFIN DATOS FINANCIEROS)
    if rtrim(ltrim(@w_tservice_p)) in ('03', '04')
      select
        @w_documto_next = '03',-- DCTO NO VALIDO CIFIN
        @w_descrip_next =
        'Documento No Validado - Respuesta de CIFIN sin informacion'

    if (rtrim(ltrim(@w_tservice_p)) in ('01', '02')
        and rtrim(ltrim(@w_respuesta)) not in ('13', '14'))
        or (rtrim(ltrim(@w_tservice_p)) in ('03', '04')
            and rtrim(ltrim(@w_respuesta)) not in ('02'))
    -- TRAMA CIFIN RESPUESTA 01 y 03 ERROR, 02 CONSULTA OK
    begin
      --Inserta Novedad
      insert into cl_novedad_ente
                  (ne_central,ne_ente,ne_tipo,ne_descripcion,ne_cobis,
                   ne_datac,ne_fec_aplica,ne_cod_novedad)
      values      ( @w_central,@w_ente_next,@w_documto_next,@w_descrip_next,'',
                    @w_respuesta,@w_today,1)

      select
        @w_error = @@error

      if @w_error <> 0
      begin
        update cl_ente_valid_tmp
        set    evt_estado = 'F'
        where  evt_ente   = @w_ente_next
           and evt_estado = 'O'

        select
          @w_des_error =
          'Error en registro de novedad - Respuesta sin informacion'

        insert into cl_error_logws
        values      (@w_today,@w_error,'proc_val_ente',@w_ente_next,null,
                     @w_des_error)
      end

      select
        @w_val_est_nue = 'N'

      select
        @w_val_est_ant = en_doc_validado
      from   cl_ente
      where  en_ente = @w_ente_next

      update cl_ente
      set    en_doc_validado = @w_val_est_nue
      where  en_ente = @w_ente_next

      select
        @w_error = @@error

      if @w_error <> 0
      begin
        update cl_ente_valid_tmp
        set    evt_estado = 'F'
        where  evt_ente   = @w_ente_next
           and evt_estado = 'O'

        select
          @w_des_error = 'Error en actualizacion de estado de validacion'
        insert into cl_error_logws
        values      (@w_today,@w_error,'proc_val_ente',@w_ente_next,null,
                     @w_des_error)
      end
      else
      begin
        insert into cl_actualiza
                    (ac_ente,ac_fecha,ac_tabla,--auditoria del update
                     ac_campo,ac_valor_ant,
                     ac_valor_nue,ac_transaccion)
        values      (@w_ente_next,@w_today,'cl_ente','en_doc_validado',
                     @w_val_est_ant,
                     @w_val_est_nue,'U')

        select
          @w_error = @@error

        if @w_error <> 0
        begin
          update cl_ente_valid_tmp
          set    evt_estado = 'F'
          where  evt_ente   = @w_ente_next
             and evt_estado = 'O'

          select
            @w_des_error = 'Error en registro de log de auditoria'
          insert into cl_error_logws
          values      (@w_today,@w_error,'proc_val_ente',@w_ente_next,null,
                       @w_des_error)
        end
      end

    end
    else
    -- ***********************RESPUESTAS CON INFORMACION *********************************
    begin
      --Ejecutar Validacion de datos de clientes
      exec @w_return = sp_validar_datext
        --No Hay tratamiento de return, se resuelve interna/
        @i_ente      = @w_ente_next,
        @i_num_doc   = @w_num_id,
        @i_type_doc  = @w_type_id,
        @i_tservice  = @w_tservice_p,
        @i_central   = @w_central,
        @i_operation = 'V'

      if @w_return <> 0
      begin
        update cl_ente_valid_tmp
        set    evt_estado = 'F'
        where  evt_ente   = @w_ente_next
           and evt_estado = 'O'

        select
          @w_des_error =
          'Error en registro de novedad - Respuesta con informacion'
        insert into cl_error_logws
        values      (@w_today,@w_return,'proc_val_ente',@w_ente_next,null,
                     @w_des_error)
      end
    end

    update cl_ente_valid_tmp
    set    evt_estado = 'V'
    where  evt_ente   = @w_ente_next
       and evt_estado = 'O'

    select
      @w_error = @@error

    if @w_error <> 0
    begin
      select
        @w_des_error = 'Error actualizando tabla de clientes en validacion - 2'
      insert into cl_error_logws
      values      (@w_today,@w_error,'proc_val_ente',@w_ente_next,null,
                   @w_des_error)
    end

  end

  goto end_proc

  ERROR_GEN: --Manejo General de Errores

  insert into cl_error_logws
  values      (@w_today,null,'proc_val_ente',null,null,
               @w_des_error)

  return @w_return

  end_proc:

  return 0

go

