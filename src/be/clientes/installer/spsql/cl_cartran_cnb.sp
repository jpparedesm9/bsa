/************************************************************************/
/*      Archivo:                cl_cartran_cnb.sp                       */
/*      Stored procedure:       sp_carga_tran_cnb                       */
/*      Base de datos:          cobis                                   */
/*      Producto:               clientes                                */
/*      Disenado por:           Alfredo Zamudio                         */
/*      Fecha de escritura:     23/01/2012                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa carga de un archivo plano las transacciones sin   */
/*      conciliar enviadas desde BANCAMIA.                              */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_carga_tran_cnb')
  drop proc sp_carga_tran_cnb
go

create proc sp_carga_tran_cnb
(
  @i_param1       varchar(255),-- parametro batch fecha         
  @i_param2       varchar(255),-- parametro batch nombre archivo
  @t_show_version bit = 0
)
as
  declare
    @i_fecha_p      datetime,
    @i_nom_archivo  varchar(255),
    @w_periodicidad varchar(1),
    @w_sp_name      varchar(15),
    @w_slm          money,
    @w_s_app        varchar(50),
    @w_path         varchar(60),
    @w_path_cb      varchar(60),
    @w_cmd          varchar(255),
    @w_destino      varchar(255),
    @w_errores      varchar(255),
    @w_error        int,
    @w_comando      varchar(255),
    @w_cont         int,
    @w_mensaje      varchar(255),
    @w_usuario      varchar(24),
    @w_param        varchar(10),
    @w_msg          varchar(200),
    @w_cod_cliente  int,
    @w_prod         int,
    @w_commit       char(1),
    @w_campo        varchar(4000),
    @w_codcorr      varchar(30),
    @w_int          int,
    @w_date         datetime,
    @w_tipo_tran    int,
    @w_money        money,
    @s_user         login,
    @w_frow         int,
    @w_ruta         varchar(300),
    @w_sql          varchar(300),
    @w_bulk         varchar(300),
    @t_trn          int

  select
    @w_sp_name = 'sp_carga_tran_cnb'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha_p = convert(datetime, @i_param1),
    @w_cont = 0,
    @w_commit = 'N',
    @i_nom_archivo = @i_param2,
    @w_usuario = @s_user

  if exists(select
              1
            from   sysobjects
            where  name = 'cl_cartran_temp')
    drop table cl_cartran_temp

  create table cl_cartran_temp
  (
    ct_codcnb      varchar(30) null,--codigo corresponsal
    ct_terminal    varchar(30) null,--codigo terminal
    ct_secuencia   varchar(30) null,--numero de secuencia ssn
    ct_tipo_tran   varchar(20) null,--tipo de transaccion
    ct_tipo_msg    varchar(20) null,--tipo de mensaje 
    ct_fecha       varchar(23) null,--fecha y hora de transaccion
    ct_monto       varchar(20) null,--monto
    ct_num_tarjeta varchar(24) null,--numero de tarjeta
    ct_prod_orig   varchar(24) null,--tipo de cuenta origen
    ct_banco_orig  varchar(24) null,--numero de la cuenta origen
    ct_prod_dest   varchar(20) null,--tipo cuenta destino
    ct_banco_dest  varchar(24) null,--numero cuenta destino
    ct_estado      char(20) null,--estado de la transaccion
    ct_cod_resp    varchar(20) null,--codigo de respuesta retorno
    ct_num_aprob   varchar(22) null,--numero de aprobacion sec_ext
    ct_convenio    varchar(24) null,--codigo de convenio
    ct_banco       varchar(24) null,--codigo de banco destino
    ct_id_tran     varchar(36) null,--identificador unico de transaccion ssnn
    ct_gcomision   char(10) null,--transaccion genera comision (bool)
    ct_usuario     login null,--usuario terminal
    ct_cliente     varchar(60) null,--referencia 1 tipo doc y numero doc campo1
    ct_operacion   varchar(60) null,--referencia 2 numero operacion
    ct_ref3        varchar(60) null,--referencia 3
    ct_ref4        varchar(60) null,--referencia 4
    ct_ref5        varchar(60) null,--referencia 5
    ct_ref6        varchar(60) null,--referencia 6
    ct_ref7        varchar(60) null,--referencia 7
    ct_ref8        varchar(60) null,--referencia 8
    ct_ref9        varchar(60) null,--referencia 9
    ct_ref10       varchar(60) null,--referencia 10
    ct_sec_corr    varchar(20) null
  --, --Identificador unico transaccion original(reverso)
  --ct_usuario_ext  login        null --Login del usuario externo que origin¾ la transacci¾n
  )

  if exists(select
              1
            from   sysobjects
            where  name = 'cl_cartran_cnb')
    drop table cl_cartran_cnb

  create table cl_cartran_cnb
  (
    ct_codcnb      varchar(30) null,--codigo corresponsal
    ct_terminal    varchar(30) null,--codigo terminal
    ct_secuencia   varchar(30) null,--numero de secuencia ssn
    ct_tipo_tran   varchar(20) null,--tipo de transaccion
    ct_tipo_msg    varchar(20) null,--tipo de mensaje 
    ct_fecha       varchar(23) null,--fecha y hora de transaccion
    ct_monto       varchar(20) null,--monto
    ct_num_tarjeta varchar(24) null,--numero de tarjeta
    ct_prod_orig   varchar(24) null,--tipo de cuenta origen
    ct_banco_orig  varchar(24) null,--numero de la cuenta origen
    ct_prod_dest   varchar(20) null,--tipo cuenta destino
    ct_banco_dest  varchar(24) null,--numero cuenta destino
    ct_estado      char(13) null,--estado de la transaccion
    ct_cod_resp    varchar(20) null,--codigo de respuesta retorno
    ct_num_aprob   varchar(22) null,--numero de aprobacion sec_ext
    ct_convenio    varchar(24) null,--codigo de convenio
    ct_banco       varchar(24) null,--codigo de banco destino
    ct_id_tran     varchar(36) null,--identificador unico de transaccion ssnn
    ct_gcomision   char(10) null,--transaccion genera comision (bool)
    ct_usuario     varchar(10) null,--usuario terminal
    ct_cliente     varchar(60) null,--referencia 1 tipo doc y numero doc campo1
    ct_operacion   varchar(60) null,--referencia 2 numero operacion
    ct_ref3        varchar(60) null,--referencia 3
    ct_ref4        varchar(60) null,--referencia 4
    ct_ref5        varchar(60) null,--referencia 5
    ct_ref6        varchar(60) null,--referencia 6
    ct_ref7        varchar(60) null,--referencia 7
    ct_ref8        varchar(60) null,--referencia 8
    ct_ref9        varchar(60) null,--referencia 9
    ct_ref10       varchar(60) null,--referencia 10
    ct_sec_corr    varchar(60) null,
    --Identificador unico transaccion original(reverso)
    --ct_usuario_ext  login        null, --Login del usuario externo que origin¾ la transacci¾n   
    ct_estado_car  char(1) null,
    ct_mensaje_car varchar(255) null,
    ct_accion      char(1) null
  )

  --Cargue Archivo Plano de Calificaciones Manuales

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_mensaje = 'ERROR CARGANDO PARAMETRO BCP',
      @w_error = 1000002
    goto ERRORFIN
  end

  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 204

  if @w_path is null
  begin
    select
      @w_mensaje =
      'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
      @w_error = 1000003
    goto ERRORFIN
  end

  select
    @w_path_cb = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'RUTACB'

  if @w_path_cb is null
  begin
    select
      @w_mensaje =
      'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
      @w_error = 1000003
    goto ERRORFIN
  end

  create table temp_cnb
  (
    detalle varchar(1000)
  )

  select
    @w_ruta = @w_path_cb + @i_nom_archivo + '.txt'

  set @w_sql = 'BULK INSERT temp_cnb FROM ''' + @w_ruta + ''' ' +
               '     WITH ( 
               FIRSTROW = 1,
               FIELDTERMINATOR = ''\n'',
               ROWTERMINATOR = ''\n''
            ) '
  exec (@w_sql)

  set rowcount 1
  delete temp_cnb
  set rowcount 0
  set @w_comando = @w_s_app + 's_app bcp -auto -login cobis..temp_cnb out "' +
                   @w_path
                   + 'file_test.txt"  -b1000 -c ' + /*' -t"," ' + */'-config ' +
                   @w_s_app + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  drop table temp_cnb

  set @w_bulk = 'BULK INSERT cobis..cl_cartran_temp FROM ''' + @w_path +
                'file_test.txt' + ''' '
                + '     WITH ( 
                     FIRSTROW = 1,
                     FIELDTERMINATOR = '','',
                     ROWTERMINATOR   = ''\n''
            ) '
  exec (@w_bulk)

  if @w_error <> 0
  begin
    print 'Error Cargando Archivo <' + @i_nom_archivo + '> '
    select
      @w_mensaje = 'ERROR CARGANDO EL ARCHIVO PLANO!!!!!',
      @w_error = error_number()
    goto ERRORFIN
  end

  update cobis..cl_cartran_temp
  set    ct_operacion = ltrim(rtrim(ct_operacion))

  /*VALIDACION CODIGO CORRESPONSAL*/

  set rowcount 0

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'EL CODIGO DE CORRESPONSAL ESTA NULO EN EL ARCHIVO PLANO'
      ,
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_codcnb is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION CODIGO DE CORRESPONSAL',
      @w_error = error_number()
    goto ERRORFIN
  end

/*VALIDACION USUARIO EXTERNO*/
  /*Insert into cobis..cl_cartran_cnb
  select *, ct_estado_car = '', ct_mensaje_car = 'USUARIO EXTERNO ES NULO EN EL ARCHIVO PLANO', ct_accion = 'R'
  from   cobis..cl_cartran_temp 
  where  ct_usuario_ext is NULL
  
  If @@error <> 0 begin 
     select 
     @w_mensaje = 'ERROR EN LA INSERCION DE USUARIO EXTERNO',
     @w_error   = ERROR_NUMBER()     
     goto ERRORFIN
  end  */

  delete cobis..cl_cartran_temp
  where  ct_codcnb is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION CODIGO DE CORRESPONSAL',
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car =
      'TIPO DE DATO ES INVALIDO EN EL CAMPO CODIGO DE CORRESPONSAL'
      ,ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  isnumeric(ct_codcnb) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION INVALIDO EN EL CAMPO CODIGO DE CORRESPONSAL',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  isnumeric(ct_codcnb) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'ERROR EN LA ELIMINACION INVALIDO EN EL CAMPO CODIGO DE CORRESPONSAL'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION CODIGO TERMINAL*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'EL CODIGO DE TERMINAL ESTA NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_terminal is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION TERMINAL ESTA NULO EN EL ARCHIVO PLANO',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_terminal is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION TERMINAL ESTA NULO EN EL ARCHIVO PLANO',
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION NUMERO DE SECUENCIA*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'EL NUMERO DE SECUENCIA ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_secuencia is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION SECUENCIA ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_secuencia is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION SECUENCIA ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car =
      'TIPO DE DATO ES INVALIDO EN EL CAMPO NUMERO DE SECUENCIA',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  isnumeric(ct_secuencia) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION CAMPO NUMERO DE SECUENCIA',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  isnumeric(ct_secuencia) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION CAMPO NUMERO DE SECUENCIA',
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION TIPO DE TRANSACCION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'EL TIPO DE TRANSACCION ESTA NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_tipo_tran is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION TRANSACCION ESTA NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_tipo_tran is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION TRANSACCION ESTA NULO EN EL ARCHIVO PLANO',
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car =
      'TIPO DE DATO ES INVALIDO EN EL CAMPO TIPO DE TRANSACCION',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  isnumeric(ct_tipo_tran) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION INVALIDO EN EL CAMPO TIPO DE TRANSACCION',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  isnumeric(ct_tipo_tran) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION INVALIDO EN EL CAMPO TIPO DE TRANSACCION',
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION TIPO DE MENSAJE*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'EL TIPO DE MENSAJE ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_tipo_msg is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION MENSAJE ES NULO EN EL ARCHIVO PLANO',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_tipo_msg is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION MENSAJE ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'TIPO DE DATO ES INVALIDO EN EL CAMPO TIPO DE MENSAJE',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  isnumeric(ct_tipo_msg) <> 1

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION INVALIDO EN EL CAMPO TIPO DE MENSAJE',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  isnumeric(ct_tipo_msg) <> 1

  /*VALIDACION FECHA DE TRANSACCION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'LA FECHA DE TRANSACCION ES NULA EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_fecha is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION TRANSACCION ES NULA EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_fecha is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION TRANSACCION ES NULA EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION MONTO DE TRANSACCION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car =
      'EL MONTO DE TRANSACCION ES NULO o 0.0$ EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_monto is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'ERROR EN LA INSERCION TRANSACCION ES NULO o 0.0$ EN EL ARCHIVO PLANO',
  @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_monto is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
    'ERROR EN LA ELIMINACION TRANSACCION ES NULO o 0.0$ EN EL ARCHIVO PLANO',
    @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car =
      'TIPO DE DATO ES INVALIDO EN EL CAMPO MONTO DE TRANSACCION'
      ,
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  isnumeric(ct_monto)     <> 1
        or convert(money, ct_monto) = 0
           and ct_tipo_tran            <> 26518

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION INVALIDO EN EL CAMPO MONTO DE TRANSACCION'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  isnumeric(ct_monto)     <> 1
      or convert(money, ct_monto) = 0
         and ct_tipo_tran            <> 26518

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION INVALIDO EN EL CAMPO MONTO DE TRANSACCION',
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION NUMERO DE TARJETA*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_num_tarjeta is null

  if @w_cont > 0
  begin
    print 'NUMERO DE TARJETA ES NULO EN ' + convert(varchar(5), @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  
  end

  /*VALIDACION PRODUCTO DE ORIGEN*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car =
      'NUMERO DE PRODUCTO DE ORIGEN ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_prod_orig is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'ERROR EN LA INSERCION PRODUCTO DE ORIGEN ES NULO EN EL ARCHIVO PLANO',
  @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_prod_orig is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
    'ERROR EN LA ELIMINACION PRODUCTO DE ORIGEN ES NULO EN EL ARCHIVO PLANO',
    @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION NUMERO DE OPERACION ORIGEN*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_banco_orig is null

  if @w_cont > 0
  begin
    print 'NUMERO DE OPERACION DE ORIGEN ES NULO EN ' + convert(varchar(5),
          @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  
  end

  /*VALIDACION PRODUCTO DESTINO*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_prod_dest is null

  if @w_cont > 0
  begin
    print 'CODIGO DE PRODUCTO DE DESTINO ES NULO EN ' + convert(varchar(5),
          @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  
  end

  /*VALIDACION NUMERO DE OPERACION DESTINO*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_banco_dest is null

  if @w_cont > 0
  begin
    print 'NUMERO DE OPERACION DE DESTINO ES NULO EN ' + convert(varchar(5),
          @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  
  end

  /*VALIDACION ESTADO DE TRANSACCION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'ESTADO DE TRANSACCION ES NULO EN EL ARCHIVO PLANO',
      ct_accion
      = 'R'
    from   cobis..cl_cartran_temp
    where  ct_estado is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'ERROR EN LA INSERCION TRANSACCION ES NULO EN EL ARCHIVO PLANO AC = R',
  @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_estado is null

  if @@error <> 0
  begin
    select
      @w_mensaje =
    'ERROR EN LA ELIMINACION TRANSACCION ES NULO EN EL ARCHIVO PLANO AC = R',
    @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION NUMERO DE APROBACION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'NUMERO DE APROBACION ES NULO EN EL ARCHIVO PLANO',
      ct_accion
      = 'R'
    from   cobis..cl_cartran_temp
    where  ct_num_aprob is null
       and ct_estado in ('EXITOSA', 'REVERSADA')
       and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje =
    'ERROR EN LA INSERCION NUMERO DE APROBACION ES NULO EN EL ARCHIVO PLANO',
    @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_num_aprob is null
     and ct_estado in ('EXITOSA', 'REVERSADA')
     and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA ELIMINACION NUMERO DE APROBACION ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION CODIGO DE CONVENIO*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_convenio is null

  if @w_cont > 0
  begin
    print 'CODIGO DE CONVENIO ES NULO EN ' + convert(varchar(5), @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  

  end

  /*VALIDACION CODIGO BANCO DESTINO*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_banco is null

  if @w_cont > 0
  begin
    print 'CODIGO DE BANCO DESTINO ES ' + convert(varchar(5), @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  
  end

  /*VALIDACION GENERA COMISION*/

  select
    @w_cont = count(1)
  from   cobis..cl_cartran_temp
  where  ct_gcomision is null

  if @w_cont > 0
  begin
    print 'IDENTIFICADOR GENERA COMISION ES NULO EN ' + convert(varchar(5),
          @w_cont)
          + ' REGISTROS DEL ARCHIVO PLANO '
  --goto ERRORFIN                                                                                  
  end

  /*VALIDACION USUARIO*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'USUARIO ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_usuario is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION USUARIO ES NULO EN EL ARCHIVO PLANO',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_usuario is null

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION USUARIO ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION CLIENTE*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'CLIENTE ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_cliente = '|'
        or ct_cliente = ''
           and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION tabla CLIENTE ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_cliente = '|'
      or ct_cliente = ''
         and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION CLIENTE ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
             ct_mensaje_car =
             'CODIGO OPERACION ASOCIADO A CLIENTE ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_cliente <> '|'
       and ct_cliente <> ''
       and ct_operacion is null
       and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION CODIGO OPERACION ASOCIADO A CLIENTE',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_cliente <> '|'
     and ct_cliente <> ''
     and ct_operacion is null
     and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION CODIGO OPERACION ASOCIADO A CLIENTE'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION OPERACION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'CODIGO OPERACION ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_operacion is null
       and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION CODIGO OPERACION ES NULO',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_operacion is null
     and ct_tipo_tran in (26502, 26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION CODIGO OPERACION ES NULO',
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'LA OPERACION DEL ARCHIVO PLANO NO EXISTE',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_operacion not in (select
                                  op_banco
                                from   cob_cartera..ca_operacion)
       and ct_tipo_tran = 26502

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION CODIGO OPERACION ES NULO',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_operacion not in (select
                                op_banco
                              from   cob_cartera..ca_operacion)
     and ct_tipo_tran = 26502

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION tabla cl_cartran_temp !!!!!',
      @w_error = error_number()
    goto ERRORFIN
  end

  /*VALIDACION DE CUENA DE AHORROS*/
  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'LA CUENTA DE AHORROS DEL ARCHIVO PLANO NO EXISTE',
      ct_accion
      = 'R'
    from   cobis..cl_cartran_temp
    where  ltrim(rtrim(ct_operacion)) not in (select
                                                ah_cta_banco
                                              from   cob_ahorros..ah_cuenta)
       and ct_tipo_tran in (26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION CODIGO DE CUENTA DE AHORRO ES NULO',
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_operacion not in (select
                                ah_cta_banco
                              from   cob_ahorros..ah_cuenta)
     and ct_tipo_tran in (26518, 26519, 26520)

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA ELIMINACION tabla cl_cartran_temp !!!!!',
      @w_error = error_number()
    goto ERRORFIN
  end

  --print 'tipo_tran'
  --print @w_tipo_tran                                                                           

  /*VALIDACION TIPO DE REDUCCION*/

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'TIPO DE REDUCCION ES NULO EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_ref3 is null
       and ct_tipo_tran in (26502)

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'ERROR EN LA INSERCION TIPO DE REDUCCION ES NULO EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_ref3 is null
     and ct_tipo_tran in (26502)

  if @@error <> 0
  begin
    select
      @w_mensaje =
  'ERROR EN LA ELIMINACION TIPO DE REDUCCION ES NULO EN EL ARCHIVO PLANO'
  ,
  @w_error = error_number()
    goto ERRORFIN
  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',
      ct_mensaje_car = 'TIPO DE REDUCCION NO ES VALIDA EN EL ARCHIVO PLANO',
      ct_accion = 'R'
    from   cobis..cl_cartran_temp
    where  ct_ref3 not in ('T', 'C', 'N')
       and ct_tipo_tran in (26502)

  if @@error <> 0
  begin
    select
      @w_mensaje =
      'ERROR EN LA INSERCION TIPO DE REDUCCION NO ES VALIDA EN EL ARCHIVO PLANO'
      ,
      @w_error = error_number()
    goto ERRORFIN
  end

  delete cobis..cl_cartran_temp
  where  ct_ref3 not in ('T', 'C', 'N')
     and ct_tipo_tran in (26502)

  if @@error <> 0
  begin
    select
      @w_mensaje =
'ERROR EN LA ELIMINACION TIPO DE REDUCCION NO ES VALIDA EN EL ARCHIVO PLANO'
,
@w_error = error_number()
goto ERRORFIN
end

  /*VALIDACION IDENTIFICADOR TRANSACCION UNICO ORIGINAL*/

  if @w_tipo_tran in (26502, 26518, 26519, 26520)
  begin
    select
      estado = ct_estado,
      transaccion = ct_id_tran
    into   #reverso_cobis
    from   cl_cartran_temp
    where  ct_estado = 'REVERSADA'

    insert into cobis..cl_cartran_cnb
      select
        ct_codcnb,ct_terminal,ct_secuencia,ct_tipo_tran,ct_tipo_msg,
        ct_fecha,ct_monto,ct_num_tarjeta,ct_prod_orig,ct_banco_orig,
        ct_prod_dest,ct_banco_dest,ct_estado,ct_cod_resp,ct_num_aprob,
        ct_convenio,ct_banco,ct_id_tran,ct_gcomision,ct_usuario,
        ct_cliente,ct_operacion,ct_ref3,ct_ref4,ct_ref5,
        ct_ref6,ct_ref7,ct_ref8,ct_ref9,ct_ref10,
        ct_sec_corr,ct_estado_car = '',
        ct_mensaje_car =
        'TRANSACCION DE REVERSO NO REPORTADA EN EL ARCHIVO PLANO'
        ,
        ct_accion = 'R'
      from   cobis..cl_cartran_temp,
             #reverso_cobis
      where  transaccion not in (select
                                   ct_sec_corr
                                 from   cobis..cl_cartran_temp
                                 where  ct_sec_corr is not null)
         and ct_tipo_tran in (26502, 26518, 26519, 26520)

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR EN LA INSERCION TRANSACCION DE REVERSO',
        @w_error = error_number()
      goto ERRORFIN
    end

    delete cobis..cl_cartran_temp
    from   cobis..cl_cartran_temp
           inner join #reverso_cobis
                   on transaccion <> ct_sec_corr

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR EN LA ELIMINACION TRANSACCION DE REVERSO',
        @w_error = error_number()
      goto ERRORFIN
    end

  end

  insert into cobis..cl_cartran_cnb
    select
      *,ct_estado_car = '',ct_mensaje_car = '',ct_accion = 'C'
    from   cl_cartran_temp

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR AL INSERTAR TRANSACCIONES CNB EN COBIS',
      @w_error = 103101
    goto ERRORFIN

  end

  drop table cl_cartran_temp

  if exists(select
              1
            from   sysobjects
            where  name = 'reporte_error')
    drop table reporte_error

  if exists(select
              1
            from   sysobjects
            where  name = 'detalle_error')
    drop table detalle_error

  if exists(select
              1
            from   sysobjects
            where  name = 'reg_fin')
    drop table reg_fin

  create table reporte_error
  (
    mensaje varchar(60) null,
    counter int null
  )

  create table detalle_error
  (
    ct_codcnb      varchar(30) null,--codigo corresponsal
    ct_terminal    varchar(30) null,--codigo terminal
    ct_secuencia   varchar(30) null,--numero de secuencia ssn
    ct_tipo_tran   varchar(20) null,--tipo de transaccion
    ct_tipo_msg    varchar(20) null,--tipo de mensaje 
    ct_fecha       varchar(23) null,--fecha y hora de transaccion
    ct_monto       varchar(20) null,--monto
    ct_num_tarjeta varchar(24) null,--numero de tarjeta
    ct_prod_orig   varchar(24) null,--tipo de cuenta origen
    ct_banco_orig  varchar(24) null,--numero de la cuenta origen
    ct_prod_dest   varchar(20) null,--tipo cuenta destino
    ct_banco_dest  varchar(24) null,--numero cuenta destino
    ct_estado      char(13) null,--estado de la transaccion
    ct_cod_resp    varchar(20) null,--codigo de respuesta retorno
    ct_num_aprob   varchar(22) null,--numero de aprobacion sec_ext
    ct_convenio    varchar(24) null,--codigo de convenio
    ct_banco       varchar(24) null,--codigo de banco destino
    ct_id_tran     varchar(36) null,--identificador unico de transaccion ssnn
    ct_gcomision   char(10) null,--transaccion genera comision (bool)
    ct_usuario     varchar(10) null,--usuario terminal
    ct_cliente     varchar(60) null,--referencia 1 tipo doc y numero doc campo1
    ct_operacion   varchar(60) null,--referencia 2 numero operacion
    ct_ref3        varchar(60) null,--referencia 3
    ct_ref4        varchar(60) null,--referencia 4
    ct_ref5        varchar(60) null,--referencia 5
    ct_ref6        varchar(60) null,--referencia 6
    ct_ref7        varchar(60) null,--referencia 7
    ct_ref8        varchar(60) null,--referencia 8
    ct_ref9        varchar(60) null,--referencia 9
    ct_ref10       varchar(60) null,--referencia 10
    ct_sec_corr    varchar(60) null,
    --Identificador unico transaccion original(reverso)
    --ct_usuario_ext  login        null,
    ct_estado_car  char(1) null,
    ct_mensaje_car varchar(255) null,
    ct_accion      char(1) null
  )

  create table reg_fin
  (
    detalle varchar(600)
  )

  insert into detalle_error
    select
      *
    from   cl_cartran_cnb
    where  ct_accion = 'R'

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION tabla detalle_error !!!!!',
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into reporte_error
    select
      ct_mensaje_car,count(ct_mensaje_car)
    from   cl_cartran_cnb
    where  ct_mensaje_car <> ''
    group  by ct_mensaje_car

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION tabla reporte_error !!!!!',
      @w_error = error_number()
    goto ERRORFIN
  end

  insert into reg_fin
    select
      isnull(ct_codcnb, '') + '|' + --codigo corresponsal
      isnull(ct_terminal, '') + '|' + --codigo terminal
      isnull(ct_secuencia, '') + '|'
      + --numero de secuencia ssn
      isnull(ct_tipo_tran, '') + '|' + --tipo de transaccion
      isnull(ct_tipo_msg, '') + '|' + --tipo de mensaje 
      isnull(ct_fecha, '') + '|'
      + --fecha y hora de transaccion
      isnull(ct_monto, '') + '|' + --monto
      isnull(ct_num_tarjeta, '') + '|' + --numero de tarjeta
      isnull(ct_prod_orig, '') + '|'
      + --tipo de cuenta origen
      isnull(ct_banco_orig, '') + '|' + --numero de la cuenta origen
      isnull(ct_prod_dest, '') + '|' + --tipo cuenta destino
      isnull(ct_banco_dest, '') + '|'
      + --numero cuenta destino
      isnull(ct_estado, '') + '|' + --estado de la transaccion
      isnull(ct_cod_resp, '') + '|' + --codigo de respuesta retorno
      isnull(ct_num_aprob, '') + '|'
      + --numero de aprobacion sec_ext
      isnull(ct_convenio, '') + '|' + --codigo de convenio
      isnull(ct_banco, '') + '|' + --codigo de banco destino
      isnull(ct_id_tran, '') + '|'
      + --identificador unico de transaccion ssnn
      isnull(ct_gcomision, '') + '|' + --transaccion genera comision (bool)
      isnull(ct_usuario, '') + '|' + --usuario terminal
      isnull(ct_cliente, '') + '|'
      + --referencia 1 tipo doc y numero doc campo1
      isnull(ct_operacion, '') + '|' + --referencia 2 numero operacion
      isnull(ct_ref3, '') + '|' + --referencia 3
      isnull(ct_ref4, '') + '|'
      + --referencia 4
      isnull(ct_ref5, '') + '|' + --referencia 5
      isnull(ct_ref6, '') + '|' + --referencia 6
      isnull(ct_ref7, '') + '|'
      + --referencia 7
      isnull(ct_ref8, '') + '|' + --referencia 8
      isnull(ct_ref9, '') + '|' + --referencia 9
      isnull(ct_ref10, '') + '|'
      + --referencia 10
      isnull(ct_sec_corr, '') + '|' +
      --Identificador unico transaccion original(reverso)
      isnull(ct_estado_car, '') + '|' + isnull(ct_mensaje_car, '') + '|'
      + isnull(ct_accion, '')
    from   detalle_error

  insert into reg_fin
    select
      mensaje + ' ' + convert(varchar(5), counter)
    from   reporte_error

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN LA INSERCION tabla reg_fin !!!!!',
      @w_error = error_number()
    goto ERRORFIN
  end

  set @w_comando = @w_s_app + 's_app bcp -auto -login cobis..reg_fin out "' +
                   @w_path
                   + 'REPORTE_CARGA_ERROR_' + convert(varchar(10), getdate(),
                   112)
                         + '.txt"  -b1000 -c '
                   + /*' -t"," ' + */'-config ' + @w_s_app + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  drop table reporte_error
  drop table detalle_error
  drop table reg_fin

  --select * from cobis..cl_cartran_cnb 

  return 0

  ERRORFIN:

  print 'entra ERRORFIN ' + ' ' + @w_mensaje

  set @w_mensaje = @w_sp_name + ' ---> ' + @w_mensaje

  declare @w_fecha datetime
  set @w_fecha = getdate()

  exec sp_errorlog
    @i_fecha     = @w_fecha,
    @i_error     = @w_error,
    @i_usuario   = @s_user,
    @i_tran      = @t_trn,
    @i_tran_name = @w_mensaje,
    @i_rollback  = 'N'

  return @w_error

go

