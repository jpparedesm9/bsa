/************************************************************************/
/*  Archivo:            clcrecligen.sp                                  */
/*  Stored procedure:   sp_crea_cliente_gen                             */
/*  Base de datos:      cobis                                           */
/*  Producto:           M.I.S                                           */
/*  Disenado por:       Luis Carlos Moreno                              */
/*  Fecha de escritura: 15-May-2014                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                            PROPOSITO                                 */
/* Este programa realiza la creacion asincrona de clientes, solicitudes */
/* recibidas desde servicios web y atendidas por Batchrunner            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR         RAZON                                 */
/*  15/May/2014     L. Moreno     Emision Inicial                       */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_crea_cliente_gen')
  drop proc sp_crea_cliente_gen
go

create proc sp_crea_cliente_gen
(
  @t_show_version bit = 0,
  @i_secuencial   int = null
)
as
  declare
    @w_sp_name            varchar(32),
    @w_error              int,
    @w_msg                descripcion,
    @w_retorno            int,
    @w_return             int,
    @w_comando            varchar(255),
    @w_orden              int,
    @w_fecha_hora_real    datetime,
    --Variables para tabla creacion de clientes
    @w_secuencial         int,
    @w_adquiriente        varchar(13),
    @w_tipo_doc           varchar(2),
    @w_num_doc            varchar(30),
    @w_sexo               char(1),
    @w_mensaje            varchar(255),
    --Insercion de cliente
    @w_canal              smallint,
    @w_oficina            smallint,
    @w_tipo_pers          char(1),
    @w_tipo_cliente       varchar(10),
    @w_fecha_nac          datetime,
    @w_digito             char(1),
    @w_fecha_emision      datetime,
    @w_fecha_expira       datetime,
    @w_es_jefe_fam        char(1),
    @w_pais_emi_doc       smallint,
    @w_dpto_emi_doc       smallint,
    @w_ciudad_emi_doc     int,
    @w_pais_nac           smallint,
    @w_dpto_nac           smallint,
    @w_ciudad_nac         int,
    @w_nombre             varchar(64),
    @w_p_apellido         varchar(16),
    @w_s_apellido         varchar(16),
    @w_tipo_soc           varchar(10),
    @w_nat_juridica       varchar(10),
    @w_accion             varchar(10),
    @w_cobert_salud       varchar(10),
    @w_estado_civil       varchar(10),
    @w_profesion          varchar(10),
    @w_ocupacion          varchar(10),
    @w_actividad          varchar(10),
    @w_sector             varchar(10),
    @w_nivel_estudio      varchar(10),
    @w_tipo_vivienda      varchar(10),
    @w_num_personas       tinyint,
    @w_num_hijos          smallint,
    @w_pais_empresa       smallint,
    @w_antiguedad         smallint,
    @w_estrato            varchar(10),
    @w_influencia         char(1),
    @w_victima            char(1),
    @w_opInter            char(1),
    @w_recurso_pub        char(1),
    @w_persona_pub        char(1),
    @w_categoria          varchar(10),
    @w_tipo_vinculacion   varchar(10),
    @w_tipo_productor     varchar(10),
    @w_regimen_fiscal     varchar(10),
    @w_procedencia        varchar(10),
    @w_exc_sipla          char(1),
    @w_exc_gmf            char(1),
    @w_retencion          char(1),
    @w_impuesto_vtas      char(1),
    @w_pensionado         char(1),
    @w_rioe               char(1),
    @w_otringr            varchar(10),
    @w_preferen           char(1),
    @w_pas_finan          money,
    @w_fpas_finan         datetime,
    @w_exento_cobro       char(1),
    @w_numempleados       smallint,
    @w_comentario         varchar(254),
    @w_grupo              int,
    @w_referido           smallint,
    @w_total_activos      money,
    @w_nivel_ing          money,
    @w_nivel_egr          money,
    @w_gran_contribuyente char(1),
    @w_situacion_cliente  varchar(10),
    @w_patrim_bruto       money,
    @w_fecha_patrim_bruto datetime,
    @w_oficial            int,
    @w_origen_fondos      varchar(255),
    @w_mercado_objetivo   varchar(10),
    @w_subtipo_mercado    varchar(10),
    @w_act_ppal           varchar(10),
    @w_act_2              varchar(10),
    @w_act_3              varchar(10),
    @w_banca              varchar(10),
    @w_segmento           varchar(10),
    @w_microsegmento      varchar(10),
    @w_refTexto1          varchar(64),
    @w_refTexto2          varchar(64),
    @w_refTexto3          varchar(64),
    @w_refTexto4          varchar(64),
    @w_refTexto5          varchar(64),
    @w_fecha_proceso      datetime,
    @w_fecha_real         datetime,
    @w_estado             char(1),
    @w_registros          int,
    @w_contador           int,
    @w_ssn                int,
    @w_operacion          char(1),
    @w_user               varchar(20),
    @w_term               varchar(20),
    @w_fecha              datetime,
    @w_srv                varchar(20),
    @w_lsrv               varchar(20),
    @w_cliente            int,
    @o_retorno_ext        varchar(255),
    @w_secu               int,
    @w_valida_nit         char(1)

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_crea_cliente_gen'

  select
    *
  into   #cl_error_aux
  from   cobis..cl_error_crea_cli
  where  1 = 2

  select
    *
  into   #cl_crea_cliente_copia
  from   cobis..cl_crea_cliente with (nolock)
  where  cc_secuencial_carga = isnull(@i_secuencial,
                                      cc_secuencial_carga)
     and cc_estado           = 'I'

  /*VALIDA CAMPO TIPO PERSONA ENTRADA*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO PERSONA DEBE SE N o J ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   cobis..cl_crea_cliente A
    where  A.cc_tipo_pers not in ('N', 'J')
       and A.cc_secuencial_carga = @i_secuencial

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO PERSONA DEBE SE N o J'
    goto ERROR_FIN
  end

  update #cl_crea_cliente_copia
  set    cc_tipo_pers = case
                          when cc_tipo_pers = 'J' then 'C'
                          when cc_tipo_pers = 'N' then 'P'
                        end
  where  cc_estado = 'I'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DEBE ENVIAR INFORMACION TIPO CLIENTE'
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   cobis..cl_crea_cliente A
    where  A.cc_tipo_cliente is null
       and A.cc_secuencial_carga = @i_secuencial

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO CLIENTE'
    goto ERROR_FIN
  end

  select
    *
  into   #aplica_tipo_persona
  from   cobis..cl_aplica_tipo_persona
  where  atp_aplica         = 'S'
     and atp_caracteristica = 'CLI'
     and atp_t_objeto       = 'C'
     and atp_tpersona in
         (select
            cc_tipo_cliente
          from   #cl_crea_cliente_copia
          where  cc_estado = 'I')
     and atp_car_parametro is not null

  /*CAMBIO DE ESTADO*/

  update cobis..cl_crea_cliente
  set    cc_estado = 'P',
         cc_fecha_proceso = getdate(),
         cc_fecha_real = getdate()
  where  cc_estado           = 'I'
     and cc_secuencial_carga = @i_secuencial

  --insert into rastro values('1: '+convert(varchar,@i_secuencial))

  /*** INICIO: VALIDA OFICINA EXISTENTE ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'OFICINA, NO EXISTE. ' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar)
                                         , 0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_oficina'
       and A.cc_oficina not in (select
                                  of_oficina
                                from   cobis..cl_oficina)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR EN TABLA DE ERROR POR OFICINA NO EXISTENTE.'
    goto ERROR_FIN
  end

  --insert into rastro values('2: '+convert(varchar,@i_secuencial))

  /*** INICIO: VALIDA TIPO DE PERSONA PERMITIDO ***/

  select
    c.codigo
  into   #codigo_tpersona
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cc_tipo_banca'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE PERSONA NO PERMITIDO. ' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_pers'
       and A.cc_tipo_pers not in (select
                                    codigo
                                  from   #codigo_tpersona)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE PERSONA NO PERMITIDO.'
    goto ERROR_FIN
  end

  --insert into rastro values('3: '+convert(varchar,@i_secuencial))

  /*** INICIO: VALIDA TIPO DE CLIENTE PERMITIDO ***/

  select
    c.codigo
  into   #codigo_tcliente
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_ptipo'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE CLIENTE NO PERMITIDO. ' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_Cliente'
       and A.cc_tipo_cliente not in (select
                                       codigo
                                     from   #codigo_tcliente)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE PERSONA NO PERMITIDO.'
    goto ERROR_FIN
  end

  --insert into rastro values('4: '+convert(varchar,@i_secuencial))

  /*VALIDA CAMPO FECHA DE NACIMIENTO*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'FECHA DE NACIMIENTO NULA. ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_fecha_nac'
       and A.cc_fecha_nac is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR FECHA DE NACIMIENTO NULA'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA TIPO DE DOCUMENTO PERMITIDO ***/
  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DOCUMENTO NO PERMITIDO. ' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_doc'
       and A.cc_tipo_doc not in (select
                                   ct_codigo
                                 from   cobis..cl_tipo_documento
                                 where  ct_estado = 'V')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DOC. NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA DIGITO DE CHEQUEO ***/
  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DOCUMENTO NO ACEPTA DIGITO DE CHEQUEO ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_doc'
       and A.cc_digito is not null
       and A.cc_tipo_doc in
           (select
              ct_codigo
            from   cobis..cl_tipo_documento
            where  ct_estado     = 'V'
               and ct_subtipo    = A.cc_tipo_pers
               and ct_valida_nit = 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DOC. NO PERMITIDO.'
    goto ERROR_FIN
  end

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DOCUMENTO VALIDA DIGITO DE CHEQUEO '
                       + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_doc'
       and A.cc_digito is null
       and A.cc_tipo_doc in
           (select
              ct_codigo
            from   cobis..cl_tipo_documento
            where  ct_estado     = 'V'
               and ct_subtipo    = A.cc_tipo_pers
               and ct_valida_nit = 'S')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DOC. NO PERMITIDO.'
    goto ERROR_FIN
  end
  /*** INICIO: VALIDA SEXO ***/

  select
    c.codigo
  into   #codigo_sexo
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_sexo'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO SEXO NO EXISTE.' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar), 0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_sexo'
       and A.cc_sexo not in (select
                               codigo
                             from   #codigo_sexo)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE SEXO NO PERMITIDO.'
    goto ERROR_FIN
  end

  --insert into rastro values('5: '+convert(varchar,@i_secuencial))

  /*VALIDA CAMPO CEDULA*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'NUMERO DE CEDULA NULA. ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_num_doc'
       and A.cc_num_doc is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR NUMERO DE CEDULA NULA'
    goto ERROR_FIN
  end

/*************************************************/
  /*VALIDA CORRESPONDENCIA DE NUMERO CEDULA Y SEXO */
  select
    secuencia = cc_secuencial_carga,
    tipo_ced = cc_tipo_doc,
    cedula = cc_num_doc,
    sexo = cc_sexo
  into   #cl_Cedu_Vs_Sex
  from   #cl_crea_cliente_copia

  while exists (select
                  1
                from   #cl_Cedu_Vs_Sex)
  begin
    select
      @w_secuencial = null
    select
      @w_tipo_doc = null
    select
      @w_num_doc = null
    select
      @w_sexo = null
    select
      @w_return = 0
    select
      @w_mensaje = null
    select
      @w_retorno = null

    set rowcount 1
    select
      @w_secuencial = secuencia,
      @w_tipo_doc = tipo_ced,
      @w_num_doc = cedula,
      @w_sexo = sexo
    from   #cl_Cedu_Vs_Sex
    set rowcount 0

    delete #cl_Cedu_Vs_Sex
    where  @w_secuencial = secuencia
       and @w_tipo_doc   = tipo_ced
       and @w_num_doc    = cedula
    --and   @w_sexo         = sexo

    if @@error <> 0
    begin
      select
        @w_error = 201242,
        @w_msg = 'ERROR AL VERIFICAR RELACION NUMERO CEDULA vs SEXO.'
      goto ERROR_FIN
    end

    exec @w_return = cobis..sp_val_doc
      @t_trn              = 1116,
      @i_numero_documento = @w_num_doc,
      @i_tipo_documento   = @w_tipo_doc,
      @i_sexo             = @w_sexo,
      @i_subtipo          = 'P',
      @i_tram_ext         = 'S',
      @o_mensaje          = @w_mensaje out,
      @o_retorno          = @w_retorno out

    if @@error <> 0
    begin
      select
        @w_error = 201242,
        @w_msg = 'ERROR AL VERIFICAR RELACION NUMERO CEDULA vs SEXO..'
      goto ERROR_FIN
    end

    if @w_return > 0
    begin
      /*VALIDA NRO CEDULA VS SEXO */
      insert into #cl_error_aux
                  (er_fecha,er_secuencial,er_referencia,er_tipo_proceso,
                   er_procedimiento,
                   er_codigo_err,er_descripcion,er_tipo_doc,er_num_doc)
      values      ( getdate(),@w_secuencial,@w_num_doc + '-' + @w_tipo_doc,'C',
                    'sp_crea_cliente_gen'
                    ,
                    0,@w_mensaje,@w_tipo_doc,@w_num_doc )

      if @@error <> 0
      begin
        select
          @w_error = 201242,
          @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR Nro. CEDULA Vs SEXO.'
        goto ERROR_FIN
      end

    end

  end

  /*VALIDA MAYORIA DE EDAD (FECHA DE EMICION)*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'NO POSEE EDAD SUFICIENTE. ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente                               = B.atp_tpersona
       and A.cc_tipo_pers                                  = B.atp_tipo
       and B.atp_car_parametro                             = '@i_fecha_emision'
       and datediff (mm,
                     cc_fecha_nac,
                     cc_fecha_emision) / 12 < 18

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR, NO POSEE EDAD SUFICIENTE.'
    goto ERROR_FIN
  end

  --insert into rastro values('6: '+convert(varchar,@i_secuencial))

  /*VALIDA CAMPO FECHA DE EXPIRACION*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'FECHA DE EXPIRACION NULA. ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_fecha_expira'
       and A. cc_fecha_expira is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR FECHA DE EXPIRACION NULA'
    goto ERROR_FIN
  end

  /*VALIDA CAMPO PENCIONADA*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA PENCIONADO. '
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_pensionado'
       and A.cc_pensionado not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA PENCIONADO'
    goto ERROR_FIN
  end

  /*VALIDA CAMPO JEFE DE FAMILIA*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA JEFE DE FAMILIA. ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_es_jefe_fam'
       and A.cc_es_jefe_fam not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO ERRADO PARA JEFE DE FAMILIA'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA PAIS EMISION DOC ***/

  select
    c.codigo
  into   #codigo_pais
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_pais'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO PAIS NO EXISTE.' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar), 0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_pais_emi_doc'
       and A.cc_pais_emi_doc not in (select
                                       codigo
                                     from   #codigo_pais)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE PAIS NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA DEPARTAMENTO EMISION DOC ***/

  select
    c.codigo
  into   #codigo_departa
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_provincia'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DEPARTAMENTO NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_dpto_emi_doc'
       and A.cc_dpto_emi_doc not in (select
                                       codigo
                                     from   #codigo_departa)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE DEPARTAMENTO NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA CIUDAD EMISION DOC ***/

  select
    c.codigo
  into   #codigo_ciudad
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_ciudad'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO CIUDAD NO EXISTE.' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_ciudad_emi_doc'
       and A.cc_ciudad_emi_doc not in (select
                                         codigo
                                       from   #codigo_ciudad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE CIUDAD NO PERMITIDO.'
    goto ERROR_FIN
  end

  --insert into rastro values('7: '+convert(varchar,@i_secuencial))

  /*** INICIO: VALIDA PAIS NACIMIENTO ***/

  select
    c.codigo
  into   #codigo_pais_nac
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_pais'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO PAIS DE NACIMIENTO NO EXISTE.'
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_pais_nac'
       and A.cc_pais_nac not in (select
                                   codigo
                                 from   #codigo_pais_nac)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE PAIS NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA DEPARTAMENTO NACIMIENTO ***/

  select
    c.codigo
  into   #codigo_departa_nac
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_provincia'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'CODIGO DEPARTAMENTO DE NACIMIENTO NO EXISTE.' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_dpto_nac'
       and A.cc_dpto_nac not in (select
                                   codigo
                                 from   #codigo_departa_nac)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE DEPARTAMENTO NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA CIUDAD NACIMIENTO ***/

  select
    c.codigo
  into   #codigo_ciudad_nac
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_ciudad'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'CODIGO CIUDAD DE NACIMIENTO NO EXISTE.'
                       +
                       'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_ciudad_nac'
       and A.cc_ciudad_nac not in (select
                                     codigo
                                   from   #codigo_ciudad_nac)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE CIUDAD NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*VALIDA CAMPO NOMBRE*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'NOMBRE NULO. ' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga
                                         as varchar), 0) +
                                         ' CED: '
                       + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc,
                                         ''),er_tipo_doc = A.cc_tipo_doc,
      er_num_doc
      = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_nombre'
       and A. cc_nombre is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR NOMBRE NULO'
    goto ERROR_FIN
  end

  /*VALIDA CAMPO PRIMER APELLIDO*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'PRIMER APELLIDO NULO. ' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar), 0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_p_apellido'
       and A. cc_p_apellido is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR PRIMER APELLIDO NULO'
    goto ERROR_FIN
  end

  /*VALIDA CAMPO SEGUNDO APELLIDO*/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'SEGUNDO APELLIDO NULO. ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_s_apellido'
       and A. cc_s_apellido is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR SEGUNDO APELLIDO NULO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA TIPO DE SOCIEDADES ***/

  select
    c.codigo
  into   #codigo_tsociedad
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tip_soc'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO TIPO SOCIEDAD NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_soc'
       and A.cc_tipo_soc not in (select
                                   codigo
                                 from   #codigo_tsociedad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE TIPO SOCIEDAD NO PERMITIDO.'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA NATURALEZA DE JURIDICA ***/

  select
    c.codigo
  into   #codigo_njuridica
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_nat_jur'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'CODIGO NATURALEZA DE JURIDICA NO EXISTE.'
                       + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_nat_juridica'
       and A.cc_nat_juridica not in (select
                                       codigo
                                     from   #codigo_njuridica)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE NATURALEZA DE JURIDICA NO PERMITIDO.'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA ACCION DE CLIENTE ***/

  select
    c.codigo
  into   #codigo_accion
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_accion_cliente'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO ACCION DE CLIENTE NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_accion'
       and A.cc_accion not in (select
                                 codigo
                               from   #codigo_accion)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ACCION DE CLIENTE NO PERMITIDO.'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA COBERTURA SALUD ***/

  select
    c.codigo
  into   #codigo_cober_salud
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_cobertura_salud'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO COBERTURA SALUD NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_cobert_salud'
       and A.cc_cobert_salud not in (select
                                       codigo
                                     from   #codigo_cober_salud)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE COBERTURA SALUD NO PERMITIDO.'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA ESTADO CIVIL ***/

  select
    c.codigo
  into   #codigo_esta_civil
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_ecivil'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO ESTADO CIVIL NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_estado_civil'
       and A.cc_estado_civil not in (select
                                       codigo
                                     from   #codigo_esta_civil)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ESTADO CIVIL NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA PROFECION ***/

  select
    c.codigo
  into   #codigo_profesion
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_profesion'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO PROFESION NO EXISTE.' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_profesion'
       and A.cc_profesion not in (select
                                    codigo
                                  from   #codigo_profesion)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE PROFESION NO PERMITIDO.'
goto ERROR_FIN
end

  /*** INICIO: VALIDA OCUPACION ***/

  select
    c.codigo
  into   #codigo_ocupacion
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tipo_empleo'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO OCUPACION NO EXISTE.' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_ocupacion'
       and A.cc_ocupacion not in (select
                                    codigo
                                  from   #codigo_ocupacion)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE OCUPACION NO PERMITIDO.'
goto ERROR_FIN
end

  /*** INICIO: VALIDA ACTIVIDAD ***/

  select
    c.codigo
  into   #codigo_actividad
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_actividad'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO ACTIVIDAD NO EXISTE.' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_actividad'
       and A.cc_actividad not in (select
                                    codigo
                                  from   #codigo_actividad)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ACTIVIDAD NO PERMITIDO.'
goto ERROR_FIN
end

  /*** INICIO: VALIDA SECTOR ***/

  select
    c.codigo
  into   #codigo_sector
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_sectoreco'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO SECTOR NO EXISTE.' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_sector'
       and A.cc_sector not in (select
                                 codigo
                               from   #codigo_sector)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE SECTOR NO PERMITIDO.'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA NIVEL DE ESTUDIO ***/

  select
    c.codigo
  into   #codigo_nestudio
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_nivel_estudio'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO NIVEL DE ESTUDIO NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_nivel_estudio'
       and A.cc_nivel_estudio not in (select
                                        codigo
                                      from   #codigo_nestudio)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE NIVEL DE ESTUDIO NO PERMITIDO.'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA TIPO VIVIENDA ***/

  select
    c.codigo
  into   #codigo_tvivienda
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tipo_vivienda'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO TIPO VIVIENDA NO EXISTE.' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_vivienda'
       and A.cc_tipo_vivienda not in (select
                                        codigo
                                      from   #codigo_tvivienda)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE TIPO VIVIENDA NO PERMITIDO.'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA PERSONAS A CARGO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'NUMERO PERSONAS A CARGO VACIO' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_num_personas'
       and A.cc_num_personas is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR NUMERO PERSONAS A CARGO VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA HIJOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'NUMERO HIJOS VACIO' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar),
                                         0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_num_hijos'
       and A.cc_num_hijos is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR NUMERO HIJOS A CARGO VACIO'
    goto ERROR_FIN
  end

  --insert into rastro values('8: '+convert(varchar,@i_secuencial))

  /*** INICIO: VALIDA PAIS DE EMPRESA ***/

  select
    c.codigo
  into   #codigo_pais_emp
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_pais'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE PAIS DE EMPRESA NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_pais_empresa'
       and A.cc_pais_empresa not in (select
                                       codigo
                                     from   #codigo_pais_emp)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE PAIS DE EMPRESA NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA ANTIGUEDAD ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO ANTIGUEDAD VACIA' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar
                                         ), 0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_antiguedad'
       and A.cc_antiguedad is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO ANTIGUEDAD VACIA'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA ESTRATO ***/

  select
    c.codigo
  into   #codigo_estrato
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_estrato'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE ESTRATO NO EXISTE' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_estrato'
       and A.cc_estrato not in (select
                                  codigo
                                from   #codigo_estrato)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ESTRATO NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA INFLUENCIA ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA INFLUENCIA' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_influencia'
       and A.cc_influencia not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA INFLUENCIA'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA VICTIMAS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA VICTIMAS' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_victima'
       and A.cc_victima not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA VICTIMAS'
goto ERROR_FIN
end

  /*** INICIO: VALIDA OPERACIONES MON. EXTRANGERA ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA OPERACIONES MON. EXTRANGERA' +
                       'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_opInter'
       and A.cc_opInter not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA OPERACIONES MON. EXTRANGERA'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA RECURSOS PUBLICOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA RECURSOS PUBLICOS ' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_recurso_pub'
       and A.cc_recurso_pub not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA RECURSOS PUBLICOS'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA RECURSOS PUBLICOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA PERSONA PUBLICA '
                       + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_persona_pub'
       and A.cc_persona_pub not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA PERSONA PUBLICA'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA CATEGORIA ***/

  select
    c.codigo
  into   #codigo_categoria
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tipo_cliente'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE CATEGORIA NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_categoria'
       and A.cc_categoria not in (select
                                    codigo
                                  from   #codigo_categoria)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE CATEGORIA NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA RELACION CON INSTITUCION ***/

  select
    c.codigo
  into   #codigo_relacion
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_relacion_banco'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'CODIGO DE RELACION CON INSTITUCION NO EXISTE' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_vinculacion'
       and A.cc_tipo_vinculacion not in (select
                                           codigo
                                         from   #codigo_relacion)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE RELACION CON INSTITUCION NO EXISTE'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA TIPO PRODUCTOR ***/

  select
    c.codigo
  into   #codigo_tproductor
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_tipo_productor'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE TIPO PRODUCTOR NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_tipo_productor'
       and A.cc_tipo_productor not in (select
                                         codigo
                                       from   #codigo_tproductor)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE TIPO PRODUCTOR NO EXISTE'
goto ERROR_FIN
end

  /*** INICIO: REGIMEN FISCAL ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE REGIMEN FISCAL NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_regimen_fiscal'
       and A.cc_regimen_fiscal not in (select
                                         rf_codigo
                                       from   cob_conta..cb_regimen_fiscal)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE REGIMEN FISCAL NO EXISTE'
goto ERROR_FIN
end

  /*** INICIO: VALIDA PROCEDENCIA ***/

  select
    c.codigo
  into   #codigo_procedencia
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_procedencia'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE PROCEDENCIA NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_procedencia'
       and A.cc_procedencia not in (select
                                      codigo
                                    from   #codigo_procedencia)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE PROCEDENCIA NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA EXCLUYE SIPLA ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA EXCLUYE SIPLA'
                       +
                       'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_exc_sipla'
       and A.cc_exc_sipla not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA EXCLUYE SIPLA'
  goto ERROR_FIN
end

  --insert into rastro values('9: '+convert(varchar,@i_secuencial))

  /*** INICIO: VALIDA EXCLUYE GMF ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA EXCLUYE GMF'
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_exc_gmf'
       and A.cc_exc_gmf not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA EXCLUYE GMF'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA RETENCION ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA RETENCION' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_retencion'
       and A.cc_retencion not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA RETENCION'
goto ERROR_FIN
end

  /*** INICIO: VALIDA IMPUESTOS A VENTAS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA IMPUESTOS A VENTAS' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_impuesto_vtas'
       and A.cc_impuesto_vtas not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA IMPUESTOS A VENTAS'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA PENSIONADO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA PENSIONADO' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_pensionado'
       and A.cc_pensionado not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA PENSIONADO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA EXENTO RIOE ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'TIPO DE DATO ERRADO PARA EXENTO RIOE'
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_rioe'
       and A.cc_rioe not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA EXENTO RIOE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA OTROS INGRESOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO ERRADO PARA OTROS INGRESOS' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_otringr'
       and A.cc_otringr not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO OTROS INGRESOS'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA CLIENTE PREFERENCIAL ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'TIPO DE DATO ERRADO PARA CLIENTE PREFERENCIAL' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_preferen'
       and A.cc_preferen not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR TIPO DE DATO ERRADO PARA CLIENTE PREFERENCIAL'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA ENDEUDAMIENTO FINAN. ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO ENDEUDAMIENTO FINAN. VACIA' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_pas_finan'
       and A.cc_pas_finan is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO ENDEUDAMIENTO FINAN. VACIA'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA FECHA ENDEUDAMIENTO FINAN. ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO FECHA ENDEUDAMIENTO VACIA' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_fpas_finan'
       and A.cc_fpas_finan is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO FECHA ENDEUDAMIENTO VACIA'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA EXENTO COBRO CERTIFICADOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'DATO ERRADO PARA EXENTO COBRO CERTIFICADOS' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                       ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_exento_cobro'
       and A.cc_exento_cobro not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO ERRADO PARA EXENTO COBRO CERTIFICADOS'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA NUMERO DE EMPLEADOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO NUMERO DE EMPLEADOS VACIO' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_numempleados'
       and A.cc_numempleados is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO NUMERO DE EMPLEADOS VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA COMENTARIO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO COMENTARIO VACIO' + 'SEC: ' +
                                         isnull(cast(A.cc_secuencial_carga as
                                         varchar
                                         ), 0)
                       + ' CED: ' + isnull(A.cc_num_doc, '') + ' TIPO: ' +
                                         isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_comentario'
       and A.cc_comentario is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO COMENTARIO VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA GRUPO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO GRUPO VACIO O EN CERO' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_grupo'
       and (A.cc_grupo is null
             or A.cc_grupo          = 0)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO GRUPO VACIO O EN CERO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA REFERIDO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO REFERIDO VACIO O EN CERO' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_referido'
       and (A.cc_referido is null
             or A.cc_referido       = 0)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO REFERIDO VACIO O EN CERO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA TOTAL ACTIVOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO TOTAL ACTIVOS VACIO' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_total_activos'
       and A.cc_total_activos is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO TOTAL ACTIVOS VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA NIVEL INGRESOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO NIVEL INGRESOS VACIO' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_nivel_ing'
       and A.cc_nivel_ing is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO NIVEL INGRESOS VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA NIVEL EGRESOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO NIVEL EGRESOS VACIO' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_nivel_egr'
       and A.cc_nivel_egr is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO NIVEL EGRESOS VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA GRAN CONTRIBUYENTE ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO ERRADO PARA GRAN CONTRIBUYENTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_gran_contribuyente'
       and A.cc_gran_contribuyente not in ('S', 'N')

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO ERRADO PARA GRAN CONTRIBUYENTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA SITUACION CLIENTE ***/

  select
    c.codigo
  into   #codigo_situa_cli
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_situacion_cliente'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE SITUACION CLIENTE NO EXISTE'
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_situacion_cliente'
       and A.cc_situacion_cliente not in (select
                                            codigo
                                          from   #codigo_situa_cli)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE SITUACION CLIENTE NO EXISTE'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA PATRIMONIO BRUTO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO PATRIMONIO BRUTO VACIO' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_patrim_bruto'
       and A.cc_patrim_bruto is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO PATRIMONIO BRUTO VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA FECHA PATRIMONIO BRUTO ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO FECHA PATRIMONIO BRUTO VACIA' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_fecha_patrim_bruto'
       and A.cc_fecha_patrim_bruto is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO FECHA PATRIMONIO BRUTO VACIA'
goto ERROR_FIN
end

  /*VALIDACION POR OFICIAL*/

  select
    oc_oficial,
    fu_oficina,
    cc_num_doc,
    cc_tipo_doc
  into   #oficial
  from   cobis..cc_oficial,
         cobis..cl_funcionario,
         #cl_crea_cliente_copia
  where  oc_funcionario = fu_funcionario
     and oc_oficial     = cc_oficial
     and fu_oficina     = cc_oficina
     and fu_estado      = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO FECHA PATRIMONIO BRUTO VACIA' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_oficial'
       and A.cc_oficial not in (select
                                  oc_oficial
                                from   #oficial)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg = 'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO OFICIAL NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA ORIGEN FONDOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'DATO ORIGEN FONDOS VACIO' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_origen_fondos'
       and A.cc_origen_fondos is null

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR DATO ORIGEN FONDOS VACIO'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA MERCADO OBJETIVO ***/

  select
    c.codigo
  into   #codigo_mercado
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_mercado_objetivo'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE MERCADO OBJETIVO NO EXISTE'
                                         +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_mercado_objetivo'
       and A.cc_mercado_objetivo not in (select
                                           codigo
                                         from   #codigo_mercado)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE MERCADO OBJETIVO NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA SUBTIPO MERCADO ***/

  select
    c.codigo
  into   #codigo_submercado
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_subtipo_mercado'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE SUBTIPO MERCADO NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_subtipo_mercado'
       and A.cc_subtipo_mercado not in (select
                                          codigo
                                        from   #codigo_submercado)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
  'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE SUBTIPO MERCADO NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA ACTIVIDAD PRINCIPAL ***/

  select
    c.codigo
  into   #codigo_activi_prin
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_actividad_finagro'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,
      er_descripcion = 'CODIGO DE ACTIVIDAD PRINCIPAL NO EXISTE'
                       +
                       'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_act_ppal'
       and A.cc_act_ppal not in (select
                                   codigo
                                 from   #codigo_activi_prin)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ACTIVIDAD PRINCIPAL NO EXISTE'
  goto ERROR_FIN
end

  /*** INICIO: VALIDA ACTIVIDAD DOS ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE ACTIVIDAD 2 NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_act_2'
       and A.cc_act_2 not in (select
                                codigo
                              from   #codigo_activi_prin)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ACTIVIDAD 2 NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA ACTIVIDAD TRES ***/

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE ACTIVIDAD 3 NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_act_3'
       and A.cc_act_3 not in (select
                                codigo
                              from   #codigo_activi_prin)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
      'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE ACTIVIDAD 3 NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA BANCA ***/

  select
    c.codigo
  into   #codigo_banca
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_banca_cliente'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE BANCA NO EXISTE' + 'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_banca'
       and A.cc_banca not in (select
                                codigo
                              from   #codigo_banca)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE BANCA NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA SEGMENTO ***/

  select
    c.codigo
  into   #codigo_segmento
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_segmento'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE SEGMENTO NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_segmento'
       and A.cc_segmento not in (select
                                   codigo
                                 from   #codigo_segmento)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
    'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE SEGMENTO NO EXISTE'
    goto ERROR_FIN
  end

  /*** INICIO: VALIDA MICROSEGMENTO ***/

  select
    c.codigo
  into   #codigo_microsegmento
  from   cobis..cl_catalogo c,
         cobis..cl_tabla t
  where  c.tabla  = t.codigo
     and t.tabla  = 'cl_segmento'
     and c.estado = 'V'

  insert into #cl_error_aux
    select
      er_fecha = getdate(),er_secuencial = A.cc_secuencial_carga,
      er_referencia = A.cc_num_doc + '-' + A.cc_tipo_doc,
      er_tipo_proceso = 'CLIENTE',
      er_procedimiento = 'sp_crea_cliente_gen',
      er_codigo_err = 0,er_descripcion = 'CODIGO DE MICROSEGMENTO NO EXISTE' +
                                         'SEC: '
                       + isnull(cast(A.cc_secuencial_carga as varchar), 0) +
                                         ' CED: '
                                         + isnull(A.cc_num_doc, '')
                       + ' TIPO: ' + isnull(A.cc_tipo_doc, ''),er_tipo_doc =
      A.cc_tipo_doc,er_num_doc = A.cc_num_doc
    from   #cl_crea_cliente_copia A,
           #aplica_tipo_persona B
    where  A.cc_tipo_cliente   = B.atp_tpersona
       and A.cc_tipo_pers      = B.atp_tipo
       and B.atp_car_parametro = '@i_microsegmento'
       and A.cc_microsegmento not in (select
                                        codigo
                                      from   #codigo_microsegmento)

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'ERROR AL INSERTAR LA TABLA DE ERROR POR CODIGO DE MICROSEGMENTO NO EXISTE'
goto ERROR_FIN
end

  /**BORRADO DE TABLA TEMPORAL**/
  delete from #cl_crea_cliente_copia
  where  cc_secuencial_carga in
         (select
            er_secuencial
          from   #cl_error_aux)
         and cc_num_doc + '-' + cc_tipo_doc in
             (select
                er_referencia
              from   #cl_error_aux)

  /******CREACION DE CLIENTES******/
  select
    @w_registros = count(1)
  from   #cl_crea_cliente_copia

  select
    @w_contador = 1

  while @w_registros = @w_contador
  begin
    select
      @w_secu = cc_secuencial_carga,
      @w_oficina = cc_oficina,
      @w_tipo_pers = cc_tipo_pers,
      @w_tipo_cliente = cc_tipo_cliente,
      @w_fecha_nac = cc_fecha_nac,
      @w_tipo_doc = cc_tipo_doc,
      @w_num_doc = cc_num_doc,
      @w_digito = cc_digito,
      @w_fecha_emision = cc_fecha_emision,
      @w_fecha_expira = cc_fecha_expira,
      @w_es_jefe_fam = cc_es_jefe_fam,
      @w_pais_emi_doc = cc_pais_emi_doc,
      @w_dpto_emi_doc = cc_dpto_emi_doc,
      @w_ciudad_emi_doc = cc_ciudad_emi_doc,
      @w_pais_nac = cc_pais_nac,
      @w_dpto_nac = cc_dpto_nac,
      @w_ciudad_nac = cc_ciudad_nac,
      @w_nombre = cc_nombre,
      @w_p_apellido = cc_p_apellido,
      @w_s_apellido = cc_s_apellido,
      @w_tipo_soc = cc_tipo_soc,
      @w_nat_juridica = cc_nat_juridica,
      @w_accion = cc_accion,
      @w_cobert_salud = cc_cobert_salud,
      @w_sexo = cc_sexo,
      @w_estado_civil = cc_estado_civil,
      @w_profesion = cc_profesion,
      @w_ocupacion = cc_ocupacion,
      @w_actividad = cc_actividad,
      @w_sector = cc_sector,
      @w_nivel_estudio = cc_nivel_estudio,
      @w_tipo_vivienda = cc_tipo_vivienda,
      @w_num_personas = cc_num_personas,
      @w_num_hijos = cc_num_hijos,
      @w_pais_empresa = cc_pais_empresa,
      @w_antiguedad = cc_antiguedad,
      @w_estrato = cc_estrato,
      @w_influencia = cc_influencia,
      @w_victima = cc_victima,
      @w_opInter = cc_opInter,
      @w_recurso_pub = cc_recurso_pub,
      @w_persona_pub = cc_persona_pub,
      @w_categoria = cc_categoria,
      @w_tipo_vinculacion = cc_tipo_vinculacion,
      @w_tipo_productor = cc_tipo_productor,
      @w_regimen_fiscal = cc_regimen_fiscal,
      @w_procedencia = cc_procedencia,
      @w_exc_sipla = cc_exc_sipla,
      @w_exc_gmf = cc_exc_gmf,
      @w_retencion = cc_retencion,
      @w_impuesto_vtas = cc_impuesto_vtas,
      @w_pensionado = cc_pensionado,
      @w_rioe = cc_rioe,
      @w_otringr = cc_otringr,
      @w_preferen = cc_preferen,
      @w_pas_finan = cc_pas_finan,
      @w_fpas_finan = cc_fpas_finan,
      @w_exento_cobro = cc_exento_cobro,
      @w_numempleados = cc_numempleados,
      @w_comentario = cc_comentario,
      @w_grupo = case cc_grupo
                   when 0 then null
                   else cc_grupo
                 end,
      @w_referido = cc_referido,
      @w_total_activos = cc_total_activos,
      @w_nivel_ing = cc_nivel_ing,
      @w_nivel_egr = cc_nivel_egr,
      @w_gran_contribuyente = cc_gran_contribuyente,
      @w_situacion_cliente = cc_situacion_cliente,
      @w_patrim_bruto = cc_patrim_bruto,
      @w_fecha_patrim_bruto = cc_fecha_patrim_bruto,
      @w_oficial = cc_oficial,
      @w_origen_fondos = cc_origen_fondos,
      @w_mercado_objetivo = cc_mercado_objetivo,
      @w_subtipo_mercado = cc_subtipo_mercado,
      @w_act_ppal = cc_act_ppal,
      @w_act_2 = cc_act_2,
      @w_act_3 = cc_act_3,
      @w_banca = cc_banca,
      @w_segmento = cc_segmento,
      @w_microsegmento = cc_microsegmento,
      @w_refTexto1 = cc_refTexto1,
      @w_refTexto2 = cc_refTexto2,
      @w_refTexto3 = cc_refTexto3,
      @w_refTexto4 = cc_refTexto4,
      @w_refTexto5 = cc_refTexto5,
      @w_fecha_proceso = cc_fecha_proceso,
      @w_fecha_real = cc_fecha_real,
      @w_estado = cc_estado,
      @w_mensaje = cc_mensaje
    from   #cl_crea_cliente_copia

    select
      @w_cliente = null

    if @w_digito is not null
      select
        @w_num_doc = @w_num_doc + @w_digito

    select
      @w_cliente = en_ente
    from   cobis..cl_ente with (nolock)
    where  en_ced_ruc  = @w_num_doc
       and en_tipo_ced = @w_tipo_doc

    if @w_cliente is null
    begin
      select
        @w_operacion = 'I'
    end
    else
    begin
      select
        @w_operacion = 'U'
    end

    if @w_operacion = 'I'
    begin
      select
        @w_ssn = siguiente + 1
      from   cobis..cl_seqnos
      where  bdatos = 'cobis'
         and tabla  = 'cl_masivo'
      update cobis..cl_seqnos
      set    siguiente = @w_ssn
      where  bdatos = 'cobis'
         and tabla  = 'cl_masivo'
      if @w_ssn = 2147483647
      begin
        update cobis..cl_seqnos with (rowlock)
        set    @w_ssn = 1,
               siguiente = 1
        from   cobis..cl_seqnos
        where  bdatos = 'cobis'
           and tabla  = 'cl_masivo'
      end

      if @w_tipo_pers = 'P' -- PERSONA NATURAL
      begin
        exec @w_return = cobis..sp_persona_ins
          @s_ssn                = @w_ssn,
          @s_user               = @w_user,
          @s_term               = @w_term,
          @s_date               = @w_fecha,
          @s_srv                = @w_srv,
          @s_lsrv               = @w_lsrv,
          @s_ofi                = @w_oficina,
          @s_rol                = null,
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
          @i_persona            = null,--Persona publica
          @i_nombre             = @w_nombre,
          @i_p_apellido         = @w_p_apellido,
          @i_s_apellido         = @w_s_apellido,
          @i_sexo               = @w_sexo,
          @i_fecha_nac          = @w_fecha_nac,
          @i_tipo_ced           = @w_tipo_doc,
          @i_cedula             = @w_num_doc,
          @i_digito             = @w_digito,-- Solo empresas
          @i_pasaporte          = null,
          @i_pais               = @w_pais_nac,
          @i_ciudad_nac         = @w_ciudad_nac,
          @i_lugar_doc          = @w_ciudad_emi_doc,
          @i_nivel_estudio      = @w_nivel_estudio,
          @i_tipo_vivienda      = @w_tipo_vivienda,
          @i_calif_cliente      = null,
          @i_profesion          = @w_profesion,
          @i_estado_civil       = @w_estado_civil,
          @i_num_cargas         = null,
          @i_nivel_ing          = @w_nivel_ing,
          @i_nivel_egr          = @w_nivel_egr,
          @i_filial             = 1,
          @i_oficina            = @w_oficina,
          @i_tipo               = @w_tipo_cliente,
          @i_grupo              = @w_grupo,
          @i_oficial            = @w_oficial,
          @i_retencion          = @w_retencion,-- Sujeto a retención
          @i_exc_sipla          = @w_exc_sipla,-- Exento FOE
          @i_exc_por2           = @w_exc_gmf,-- Exento GMF (Exento 4x1000)
          @i_asosciada          = null,
          @i_tipo_vinculacion   = @w_tipo_vinculacion,
          @i_actividad          = @w_actividad,
          @i_comentario         = @w_comentario,
          @i_fecha_emision      = @w_fecha_emision,
          @i_fecha_expira       = @w_fecha_expira,
          @i_sector             = @w_sector,
          @i_referido           = @w_referido,
          @i_nit                = null,
          @i_mala_referencia    = 'N',
          @i_gran_contribuyente = @w_gran_contribuyente,
          @i_situacion_cliente  = @w_situacion_cliente,
          @i_patrim_tec         = @w_patrim_bruto,
          @i_fecha_patrim_bruto = @w_fecha_patrim_bruto,
          @i_total_activos      = @w_total_activos,
          @i_rep_superban       = null,
          @i_preferen           = @w_preferen,
          @i_depa_nac           = @w_dpto_nac,
          @i_pais_emi           = @w_pais_emi_doc,
          @i_depa_emi           = @w_dpto_emi_doc,
          @i_categoria          = @w_categoria,
          @i_pensionado         = @w_pensionado,
          @i_tipo_productor     = @w_tipo_productor,
          @i_regimen_fiscal     = @w_regimen_fiscal,
          @i_numempleados       = @w_numempleados,
          @i_rioe               = @w_rioe,
          @i_impuesto_vtas      = @w_impuesto_vtas,
          @i_pas_finan          = @w_pas_finan,
          @i_fpas_finan         = @w_fpas_finan,
          @i_opInter            = @w_opInter,
          @i_otringr            = @w_otringr,
          @i_doctos_carpeta     = null,
          @i_exento_cobro       = @w_exento_cobro,
          @i_tipo_empleo        = @w_ocupacion,
          @i_cod_central        = null,
          @i_doc_validado       = null,
          @o_dif_oficial        = null,
          @i_ofiprod            = @w_oficina,
          @i_accion             = @w_accion,
          @i_procedencia        = @w_procedencia,
          @i_antiguedad         = @w_antiguedad,
          @i_estrato            = @w_estrato,
          @i_num_hijos          = @w_num_hijos,
          @i_recurso_pub        = @w_recurso_pub,
          @i_influencia         = @w_influencia,
          @i_persona_pub        = @w_persona_pub,
          @i_victima            = @w_victima,
          @i_crea_ext           = 'S',
          @o_msg_msv            = @o_retorno_ext output

        if @w_return <> 0
        begin
          insert into #cl_error_aux
                      (er_fecha,er_secuencial,er_referencia,er_tipo_proceso,
                       er_procedimiento,
                       er_codigo_err,er_descripcion,er_tipo_doc,er_num_doc)
          values      ( getdate(),@w_secu,@w_num_doc + '-' + @w_tipo_doc,'C',
                        'sp_crea_cliente_gen',
                        @w_return,@o_retorno_ext,@w_tipo_doc,@w_num_doc )

          goto ERROR_FIN
        end
      end

      if @w_tipo_pers = 'C'
      begin
        -- CREACION PERSONA JURIDICA
        exec @w_return = cobis..sp_compania_ins
          @s_ssn                = @w_ssn,
          @s_user               = @w_user,
          @s_term               = @w_term,
          @s_date               = @w_fecha,
          @s_srv                = @w_srv,
          @s_lsrv               = @w_lsrv,
          @s_ofi                = @w_oficina,
          @s_rol                = null,
          @s_org_err            = null,
          @s_error              = null,
          @s_sev                = null,
          @s_msg                = null,
          @s_org                = null,
          @t_debug              = 'N',
          @t_file               = null,
          @t_from               = null,
          @t_trn                = 105,
          @i_operacion          = @w_operacion,
          @i_nombre             = @w_nombre,
          @i_actividad          = @w_actividad,
          @i_ruc                = @w_num_doc,
          @i_grupo              = @w_grupo,
          @i_pais               = @w_pais_empresa,
          @i_filial             = 1,
          @i_oficina            = @w_oficina,
          @i_tipo               = @w_nat_juridica,
          @i_oficial            = @w_oficial,
          @i_es_grupo           = 'N',
          -- POR DEFECTO NO SE CREAN GRUPOS ECONOMICOS POR WS
          @i_comentario         = @w_comentario,
          @i_retencion          = @w_retencion,
          @i_tipo_vinculacion   = @w_tipo_vinculacion,
          @i_tipo_nit           = @w_tipo_doc,
          @i_referido           = @w_referido,
          @i_sector             = @w_sector,
          @i_tipo_soc           = @w_tipo_soc,
          @i_fecha_emision      = @w_fecha_emision,
          @i_lugar_doc          = @w_ciudad_emi_doc,
          @i_total_activos      = @w_total_activos,
          @i_num_empleados      = @w_numempleados,
          @i_sigla              = ' ',
          -- NO ENVIAR NULO PARA EVITAR NULOS EN CADENAS CONCATENADAS
          @i_mala_referencia    = 'N',
          @i_situacion_cliente  = @w_situacion_cliente,
          @i_gran_contribuyente = @w_gran_contribuyente,
          @i_patrim_tec         = @w_patrim_bruto,
          @i_fecha_patrim_bruto = @w_fecha_patrim_bruto,
          @i_preferen           = @w_preferen,
          @i_exc_sipla          = @w_exc_sipla,
          @i_exc_por2           = @w_exc_gmf,
          @i_nivel_ing          = @w_nivel_ing,
          @i_nivel_egr          = @w_nivel_egr,
          @i_categoria          = @w_categoria,
          @i_tipo_productor     = @w_tipo_productor,
          @i_regimen_fiscal     = @w_regimen_fiscal,
          @i_rioe               = @w_rioe,
          @i_impuesto_vtas      = @w_impuesto_vtas,
          @i_pas_finan          = @w_pas_finan,
          @i_fpas_finan         = @w_fpas_finan,
          @i_opInter            = @w_opInter,
          @i_otringr            = @w_otringr,
          @i_doctos_carpeta     = 'N',
          @i_exento_cobro       = @w_exento_cobro,
          @i_cod_central        = null,
          @i_doc_validado       = null,
          @i_tipo_persona       = @w_tipo_cliente,
          @i_crea_ext           = 'S',
          @o_msg_msv            = @o_retorno_ext output

        if @w_return <> 0
        begin
          insert into #cl_error_aux
                      (er_fecha,er_secuencial,er_referencia,er_tipo_proceso,
                       er_procedimiento,
                       er_codigo_err,er_descripcion,er_tipo_doc,er_num_doc)
          values      ( getdate(),@w_secu,@w_num_doc + '-' + @w_tipo_doc,'C',
                        'sp_crea_cliente_gen',
                        @w_return,@o_retorno_ext,@w_tipo_doc,@w_num_doc )

          goto ERROR_FIN
        end
      end

    end

    --------------------------------------------------------------------------------------------------
    --------------------------- ACTUALIZACION DE CLIENTE --------------------------------------------------
    if @w_operacion = 'U'
    begin
      select
        @w_ssn = siguiente + 1
      from   cobis..cl_seqnos
      where  bdatos = 'cobis'
         and tabla  = 'cl_masivo'
      update cobis..cl_seqnos
      set    siguiente = @w_ssn
      where  bdatos = 'cobis'
         and tabla  = 'cl_masivo'
      if @w_ssn = 2147483647
      begin
        update cobis..cl_seqnos with (rowlock)
        set    @w_ssn = 1,
               siguiente = 1
        from   cobis..cl_seqnos
        where  bdatos = 'cobis'
           and tabla  = 'cl_masivo'
      end

      if @w_tipo_pers = 'P'
      begin
        exec @w_return = cobis..sp_persona_upd
          @s_ssn                = @w_ssn,
          @s_user               = @w_user,
          @s_term               = @w_term,
          @s_date               = @w_fecha,
          @s_srv                = @w_srv,
          @s_lsrv               = @w_lsrv,
          @s_ofi                = @w_oficina,
          @s_rol                = null,
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
          @i_tipo_ced           = @w_tipo_doc,
          @i_cedula             = @w_num_doc,
          @i_digito             = @w_digito,-- Solo empresas
          @i_pasaporte          = null,
          @i_pais               = @w_pais_nac,
          @i_ciudad_nac         = @w_ciudad_nac,
          @i_lugar_doc          = @w_ciudad_emi_doc,
          @i_nivel_estudio      = @w_nivel_estudio,
          -- Nivel estudios -> p_nivel_estudio
          @i_tipo_vivienda      = @w_tipo_vivienda,
          @i_calif_cliente      = null,
          @i_profesion          = @w_profesion,
          -- Profesión 000 sin profesi¢n -> p_profesion
          @i_estado_civil       = @w_estado_civil,
          @i_num_cargas         = null,
          @i_nivel_ing          = @w_nivel_ing,
          @i_nivel_egr          = @w_nivel_egr,
          @i_filial             = 1,
          @i_oficina            = @w_oficina,
          @i_tipo               = @w_tipo_cliente,
          @i_grupo              = @w_grupo,
          @i_oficial            = @w_oficial,
          @i_retencion          = @w_retencion,-- Sujeto a retención
          @i_exc_sipla          = @w_exc_sipla,-- Exento FOE
          @i_exc_por2           = @w_exc_gmf,-- Exento GMF (Exento 4x1000)
          @i_asosciada          = null,
          @i_tipo_vinculacion   = @w_tipo_vinculacion,
          @i_actividad          = @w_actividad,
          @i_comentario         = @w_comentario,
          @i_fecha_emision      = @w_fecha_emision,
          @i_fecha_expira       = @w_fecha_expira,
          @i_sector             = @w_sector,
          @i_referido           = @w_referido,
          @i_nit                = null,
          @i_gran_contribuyente = @w_gran_contribuyente,
          @i_situacion_cliente  = @w_situacion_cliente,
          @i_patrim_tec         = @w_patrim_bruto,
          @i_fecha_patrim_bruto = @w_fecha_patrim_bruto,
          @i_total_activos      = @w_total_activos,
          @i_rep_superban       = null,
          @i_preferen           = @w_preferen,
          @i_depa_nac           = @w_dpto_nac,
          @i_pais_emi           = @w_pais_emi_doc,
          @i_depa_emi           = @w_dpto_emi_doc,
          @i_categoria          = @w_categoria,
          @i_pensionado         = @w_pensionado,
          @i_tipo_productor     = @w_tipo_productor,
          @i_regimen_fiscal     = @w_regimen_fiscal,
          @i_numempleados       = @w_numempleados,
          @i_rioe               = @w_rioe,
          @i_impuesto_vtas      = @w_impuesto_vtas,
          @i_pas_finan          = @w_pas_finan,
          @i_fpas_finan         = @w_fpas_finan,
          @i_opInter            = @w_opInter,
          @i_otringr            = @w_otringr,
          @i_doctos_carpeta     = null,
          @i_exento_cobro       = @w_exento_cobro,
          @i_tipo_empleo        = @w_ocupacion,
          @i_doc_validado       = null,
          @o_dif_oficial        = null,
          @i_ofiprod            = @w_oficina,
          @i_accion             = @w_accion,
          @i_procedencia        = @w_procedencia,
          -- Procedencia de la vinculación. catalogo cl_procedencia.
          @i_antiguedad         = @w_antiguedad,
          @i_estrato            = @w_estrato,
          @i_num_hijos          = @w_num_hijos,
          @i_recurso_pub        = @w_recurso_pub,
          @i_influencia         = @w_influencia,
          @i_persona_pub        = @w_persona_pub,
          @i_victima            = @w_victima,
          @i_crea_ext           = 'S',
          @o_msg_msv            = @o_retorno_ext out

        if @w_return <> 0
        begin
          insert into #cl_error_aux
                      (er_fecha,er_secuencial,er_referencia,er_tipo_proceso,
                       er_procedimiento,
                       er_codigo_err,er_descripcion,er_tipo_doc,er_num_doc)
          values      ( getdate(),@w_secu,@w_num_doc + '-' + @w_tipo_doc,'C',
                        'sp_crea_cliente_gen',
                        @w_return,@o_retorno_ext,@w_tipo_doc,@w_num_doc)

          goto ERROR_FIN
        end
      end

      if @w_tipo_pers = 'C'
      begin
        -- ACTUALIZACION PERSONA JURIDICA
        exec @w_return = cobis..sp_compania_upd
          @s_ssn                = @w_ssn,
          @s_user               = @w_user,
          @s_term               = @w_term,
          @s_date               = @w_fecha,
          @s_srv                = @w_srv,
          @s_lsrv               = @w_lsrv,
          @s_ofi                = @w_oficina,
          @s_rol                = null,
          @s_org_err            = null,
          @s_error              = null,
          @s_sev                = null,
          @s_msg                = null,
          @s_org                = null,
          @t_debug              = 'N',
          @t_file               = null,
          @t_from               = null,
          @t_trn                = 106,
          @i_operacion          = @w_operacion,
          @i_nombre             = @w_nombre,
          @i_actividad          = @w_actividad,
          @i_ruc                = @w_num_doc,
          @i_grupo              = @w_grupo,
          @i_pais               = @w_pais_empresa,
          @i_filial             = 1,
          @i_oficina            = @w_oficina,
          @i_tipo               = @w_nat_juridica,
          @i_oficial            = @w_oficial,
          @i_es_grupo           = 'N',
          -- POR DEFECTO NO SE CREAN GRUPOS ECONOMICOS POR WS
          @i_comentario         = @w_comentario,
          @i_retencion          = @w_retencion,
          @i_tipo_vinculacion   = @w_tipo_vinculacion,
          @i_tipo_nit           = @w_tipo_doc,
          @i_referido           = @w_referido,
          @i_sector             = @w_sector,
          @i_tipo_soc           = @w_tipo_soc,
          @i_fecha_emision      = @w_fecha_emision,
          @i_lugar_doc          = @w_ciudad_emi_doc,
          @i_total_activos      = @w_total_activos,
          @i_num_empleados      = @w_numempleados,
          @i_sigla              = ' ',
          -- NO ENVIAR NULO PARA EVITAR NULOS EN CADENAS CONCATENADAS
          @i_mala_referencia    = 'N',
          @i_situacion_cliente  = @w_situacion_cliente,
          @i_gran_contribuyente = @w_gran_contribuyente,
          @i_patrim_tec         = @w_patrim_bruto,
          @i_fecha_patrim_bruto = @w_fecha_patrim_bruto,
          @i_preferen           = @w_preferen,
          @i_exc_sipla          = @w_exc_sipla,
          @i_exc_por2           = @w_exc_gmf,
          @i_nivel_ing          = @w_nivel_ing,
          @i_nivel_egr          = @w_nivel_egr,
          @i_categoria          = @w_categoria,
          @i_tipo_productor     = @w_tipo_productor,
          @i_regimen_fiscal     = @w_regimen_fiscal,
          @i_rioe               = @w_rioe,
          @i_impuesto_vtas      = @w_impuesto_vtas,
          @i_pas_finan          = @w_pas_finan,
          @i_fpas_finan         = @w_fpas_finan,
          @i_opInter            = @w_opInter,
          @i_otringr            = @w_otringr,
          @i_doctos_carpeta     = 'N',
          @i_exento_cobro       = @w_exento_cobro,
          @i_cod_central        = null,
          @i_doc_validado       = null,
          @i_tipo_persona       = @w_tipo_cliente,
          @i_crea_ext           = 'S',
          @o_msg_msv            = @o_retorno_ext output
        if @w_return <> 0
        begin
          insert into #cl_error_aux
                      (er_fecha,er_secuencial,er_referencia,er_tipo_proceso,
                       er_procedimiento,
                       er_codigo_err,er_descripcion,er_tipo_doc,er_num_doc)
          values      ( getdate(),@w_secu,@w_num_doc + '-' + @w_tipo_doc,'C',
                        'sp_crea_cliente_gen',
                        @w_return,@o_retorno_ext,@w_tipo_doc,@w_num_doc )

          goto ERROR_FIN
        end
      end

    end

    --CONTADOR  + 1
    select
      @w_contador = @w_contador + 1
    --BORRADO DE TABLA TEMPORAL
    delete #cl_crea_cliente_copia
    where  cc_num_doc      = @w_num_doc
       and cc_tipo_doc     = @w_tipo_doc
       and cc_tipo_pers    = @w_tipo_pers
       and cc_tipo_cliente = @w_tipo_cliente

  end
  /****INSERCION EN TABLA DEFINITIVA DE ERRORES****/
  insert into cl_error_crea_cli
    select
      *
    from   #cl_error_aux

  return 0

  ERROR_FIN:

  insert into cl_error_crea_cli
    select
      *
    from   #cl_error_aux

  return 1

go

