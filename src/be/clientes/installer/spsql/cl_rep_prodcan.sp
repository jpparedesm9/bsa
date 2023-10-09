/****************************************************************************/
/*   Archivo             :  cl_rep_prodcan.sp                               */
/*   Stored procedure    :  sp_rep_prodcan                                  */
/*   Base de datos       :  COBIS                                           */
/*   Producto            :  CLIENTES                                        */
/*   Disenado por        :  Liana Coto                                      */
/*   Fecha de escritura  :  SEPT/2015                                       */
/****************************************************************************/
/*                           IMPORTANTE                                     */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad            */
/*  de COBISCorp.                                                           */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como        */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus        */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.       */
/*  Este programa esta protegido por la ley de   derechos de autor          */
/*  y por las    convenciones  internacionales   de  propiedad inte-        */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para     */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir            */
/*  penalmente a los autores de cualquier   infraccion.                     */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*   Proceso Batch para reporte de productos cancelados                     */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*      FECHA           AUTOR                         RAZON                 */
/*     SEPT/2015      Julian Mendigana        Emisión Inicial --Req 534     */
/*     May/02/2016    DFu                     Migracion CEN                 */
/****************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_rep_prodcan')
  drop proc sp_rep_prodcan
go

create proc sp_rep_prodcan
  @t_show_version bit = 0,
  @i_param1       datetime,-- Fecha Inicio
  @i_param2       datetime -- Fecha Fin

as
  declare
    @w_ente            int,
    @w_fecha_ini       datetime,
    @w_fecha_fin       datetime,
    @w_fecha_proc      varchar(12),
    @w_sp_name         varchar(15),
    /*PARAMETROS BCP*/
    @w_s_app           varchar(255),
    @w_path            varchar(255),
    @w_nombre          varchar(255),
    @w_nombre_cab      varchar(255),
    @w_destino         varchar(2500),
    @w_errores         varchar(1500),
    @w_columna         varchar(100),
    @w_cabecera        varchar(2500),
    @w_nom_tabla       varchar(100),
    @w_comando         varchar(2500),
    @w_nombre_plano    varchar(2500),
    @w_path_error      varchar(2500),
    @w_fecha1          varchar(10),
    @w_cmd             varchar(2500),
    @w_anio            varchar(4),
    @w_mes             varchar(2),
    @w_dia             varchar(2),
    @w_msg             descripcion,
    @w_error           int,
    @w_col_id          int,
    @w_dias_inactiv_ah int

  select
    @w_sp_name = 'sp_rep_prodcan'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  -- INICIALIZACION DE VARIABLES
  select
    @w_fecha_ini = @i_param1,
    @w_fecha_fin = @i_param2,
    @w_dias_inactiv_ah = 0

  select
    @w_fecha_proc = convert(varchar, fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  if @w_fecha_ini is null
      or @w_fecha_fin is null
  begin
    print 'LOS PARAMETROS DE FECHA SON OBLIGATORIOS'
    select
      @w_error = 201196,
      @w_msg = 'LOS PARAMETROS DE FECHA SON OBLIGATORIOS'
    goto ERRORFIN
  end

  if @w_fecha_ini > @w_fecha_proc
      or @w_fecha_fin > @w_fecha_proc
  begin
    print 'LA FECHA INGRESADA ES MAYOR A LA FECHA DE PROCESO'
    select
      @w_error = 251020,
      @w_msg = 'LA FECHA INGRESADA ES MAYOR A LA FECHA DE PROCESO'
    goto ERRORFIN
  end

  if @w_fecha_ini > @w_fecha_fin
  begin
    print 'LA FECHA INICIAL ES MAYOR A LA FECHA FIN'
    select
      @w_error = 201065,
      @w_msg = 'LA FECHA INICIAL ES MAYOR A LA FECHA FIN'
    goto ERRORFIN
  end

  -- Obtiene el minimo de dias a validar la inactividad de la cuenta de ahorros 
  -- calculada desde el ultimo movimiento
  select
    @w_dias_inactiv_ah = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'INACAH'

  if @@rowcount = 0
  begin
    print
'NO SE ENCONTRO PARAMETRO DE DIAS DE INACTIVIDAD PARA CUENTAS DE AHORRO'
    select
      @w_error = 2609838,
      @w_msg =
      'NO SE ENCONTRO PARAMETRO DE DIAS DE INACTIVIDAD PARA CUENTAS DE AHORRO'
    goto ERRORFIN
  end

  --------------------------------------------------------------------------------------------
  ---------- OBTENIENDO LOS DATOS DEL CLIENTES CON PRODCUTOS CANCELADOS O INACTIVOS ----------
  --------------------------------------------------------------------------------------------

  -- OBTENIENDO DATOS DEL CLIENTE EN CARTERA
  select
    banco = convert(varchar(30), op_banco),
    fecha_can = convert(varchar, op_fecha_ult_proceso, 101),
    id_cliente = op_cliente,
    nombre = convert(varchar(255), op_nombre),
    cedula = convert(varchar(30), '0'),
    oficina = op_oficina,
    nom_ofi = convert(varchar(100), ''),
    producto = op_prd_cobis,
    estado = 'CANCELADO'
  into   #prod_canc
  from   cob_cartera..ca_operacion
  where  op_fecha_ult_proceso between @w_fecha_ini and @w_fecha_fin
     and op_estado = 3

  if @@error <> 0
  begin
    print 'ERROR OBTENIENDO OPERACIONES CANCELADAS'
    select
      @w_error = 253015,
      @w_msg = 'ERROR OBTENIENDO OPERACIONES CANCELADAS'
    goto ERRORFIN
  end

  -- OBTENIENDO DATOS DEL CLIENTE EN PLAZO FIJO
  insert into #prod_canc
    select
      banco = op_num_banco,fecha_can = convert(varchar, op_fecha_cancela, 101),
      id_cliente = op_ente,nombre = op_descripcion,cedula =
      convert(varchar(30), '0'),
      oficina = op_oficina,nom_ofi = convert(varchar(50), ''),
      producto = op_producto
      ,estado = 'CANCELADO'
    from   cob_pfijo..pf_operacion
    where  op_fecha_cancela between @w_fecha_ini and @w_fecha_fin
       and op_estado = 'CAN'

  if @@error <> 0
  begin
    print 'ERROR OBTENIENDO CDTS NO VIGENTES'
    select
      @w_error = 2902512,
      @w_msg = 'ERROR OBTENIENDO CDTS NO VIGENTES'
    goto ERRORFIN
  end

  -- OBTENIENDO DATOS DEL CLIENTE EN AHORROS
  insert into #prod_canc
    select
      banco = ah_cta_banco,fecha_can = convert(varchar, ah_fecha_ult_mov, 101),
      id_cliente = ah_cliente,nombre = ah_nombre,cedula = ah_ced_ruc,
      oficina = ah_oficina,nom_ofi = convert(varchar(50), ''),
      producto = ah_producto
      ,estado = case ah_estado
                 when 'I' then 'INACTIVA'
                 else 'CANCELADA'
               end
    from   cob_ahorros..ah_cuenta_tmp
    where  ah_estado in ('I', 'C')
       and (ah_fecha_ult_mov between @w_fecha_ini and @w_fecha_fin
             or dateadd(day,
                        @w_dias_inactiv_ah,
                        ah_fecha_ult_mov) between @w_fecha_ini and @w_fecha_fin)

  if @@error <> 0
  begin
    print 'ERROR 1 OBTENIENDO DATOS DEL CLIENTE EN AHORROS'
    select
      @w_error = 351010,
      @w_msg = 'ERROR OBTENIENDO DATOS DEL CLIENTE EN AHORROS'
    goto ERRORFIN
  end

  -- ELIMINANDO CLIENTES QUE TENGAN MENOS D-AS DE INACTIVIDAD SEG+N PARAMETRO
  select
    id_cliente,
    oficina
  into   #inac
  from   #prod_canc
  where  datediff(DD,
                  fecha_can,
                  @w_fecha_fin) < @w_dias_inactiv_ah
     and producto                            = 4

  if @@error <> 0
  begin
    print 'ERROR 2 OBTENIENDO DATOS DEL CLIENTE EN AHORROS'
    select
      @w_error = 351010,
      @w_msg = 'ERROR OBTENIENDO DATOS DEL CLIENTE EN AHORROS'
    goto ERRORFIN
  end

  delete from #prod_canc
  where  id_cliente in
         (select
            a.id_cliente
          from   #inac a
          where  a.id_cliente = id_cliente
             and a.oficina    = oficina)

  if @@error <> 0
  begin
    print 'ERROR 3 OBTENIENDO DATOS DEL CLIENTE EN AHORROS'
    select
      @w_error = 351010,
      @w_msg = 'ERROR OBTENIENDO DATOS DEL CLIENTE EN AHORROS'
    goto ERRORFIN
  end

  -----------------------------------------------------------------------------
  ---------- BORRANDO LOS DATOS DEL CLIENTES CON PRODUCTOS ACTIVOS ----------
  -----------------------------------------------------------------------------
  -- BORRANDO CLIENTES CON PRODUCTOS ACTIVOS EN CARTERA A LA FECHA ACTUAL
  delete from #prod_canc
  where  id_cliente in
         (select
            op_cliente
          from   cob_cartera..ca_operacion with (nolock)
          where  op_cliente = id_cliente
             and op_estado in (1, 2, 4, 9))

  if @@error <> 0
  begin
    print 'ERROR BORRANDO DATOS ACTIVOS DEL CLIENTE EN CARTERA'
    select
      @w_error = 208107,
      @w_msg = 'ERROR BORRANDO DATOS ACTIVOS DEL CLIENTE EN CARTERA'
    goto ERRORFIN
  end

  -- BORRANDO CLIENTES CON CDTS ACTIVOS A LA FECHA ACTUAL
  delete from #prod_canc
  where  id_cliente in
         (select
            op_ente
          from   cob_pfijo..pf_operacion with (nolock)
          where  op_ente = id_cliente
             and op_estado in ('ACT', 'VEN', 'ING', 'REN'))

  if @@error <> 0
  begin
    print 'ERROR BORRANDO DATOS ACTIVOS DEL CLIENTE EN PLAZO FIJO'
    select
      @w_error = 208107,
      @w_msg = 'ERROR BORRANDO DATOS ACTIVOS DEL CLIENTE EN PLAZO FIJO'
    goto ERRORFIN
  end

  -- BORRANDO CLIENTES CON PRODUCTOS AH ACTIVOS A LA FECHA ACTUAL
  delete from #prod_canc
  where  id_cliente in
         (select
            ah_cliente
          from   cob_ahorros..ah_cuenta_tmp with (nolock)
          where  ah_cliente = id_cliente
             and ah_estado  = 'A')

  if @@error <> 0
  begin
    print 'ERROR BORRANDO CLIENTES CON PRODUCTOS DE AHORROS VIGENTES'
    select
      @w_error = 208107,
      @w_msg = 'ERROR BORRANDO CLIENTES CON PRODUCTOS DE AHORROS VIGENTES'
    goto ERRORFIN
  end

  --OBTENIENDO FECHAS POR CLIENTE Y POR PRODUCTO
  select distinct
    id_cliente = id_cliente,
    oficina = oficina,
    fecha_can = max(convert(datetime, fecha_can))
  into   #fechas
  from   #prod_canc
  group  by id_cliente,
            oficina
  order  by 1,
            2

  if @@error <> 0
  begin
    print 'ERROR OBTENIENDO LAS FECHAS'
    select
      @w_error = 351010,
      @w_msg = 'ERROR OBTENIENDO LAS FECHAS'
    goto ERRORFIN
  end

  -- OBTENIENDO FECHAS POR CLIENTE, PRODUCTO Y OFICINA
  select
    a.id_cliente,
    a.fecha_can,
    a.producto,
    a.oficina
  into   #prodcan
  from   #prod_canc a,
         #fechas b
  where  a.id_cliente = b.id_cliente
     and a.fecha_can  = b.fecha_can
     and a.oficina    = b.oficina
  group  by a.id_cliente,
            a.producto,
            a.oficina,
            a.fecha_can
  order  by 1

  if @@error <> 0
  begin
    print 'ERROR OBTENIENDO LOS CLIENTES POR PRODUCTO, OFICINA Y FECHA'
    select
      @w_error = 351010,
      @w_msg = 'ERROR OBTENIENDO LOS CLIENTES POR PRODUCTO, OFICINA Y FECHA'
    goto ERRORFIN
  end

  ----------------------------------------------------
  ---------- INGRESANDO DATOS EN TABLA FINAL ---------
  ----------------------------------------------------   
  select
    'FECHA_REPORTE' = ltrim(rtrim(@w_fecha_proc)),
    'NOMBRE_OFICINA' = ltrim(rtrim(of_nombre)),
    'CODIGO_OFICINA' = ltrim(rtrim(a.oficina)),
    'NUM_ID_CLIENTE' = ltrim(rtrim(en_ced_ruc)),
    'NOMBRE_CLIENTE' = ltrim(rtrim(b.nombre)),
    'TIPO_PRODUCTO' = case a.producto
                        when '7' then 'CARTERA'
                        when '14' then 'CDT'
                        when '4' then 'AHORROS'
                        else 'OTRO'
                      end,
    'NUM_ULTIMO_PRODUCTO' = ltrim(rtrim(b.banco)),
    'ESTADO_PRODUCTO' = ltrim(rtrim(b.estado)),
    'FECHA_CANC_INACT' = ltrim(rtrim(a.fecha_can))
  into   #rep_prodcan_tmp
  from   #prodcan a,
         #prod_canc b,
         cobis..cl_oficina ofi,
         cobis..cl_ente cl
  where  a.id_cliente = cl.en_ente
     and a.id_cliente = b.id_cliente
     and a.oficina    = ofi.of_oficina
     and a.oficina    = b.oficina
     and a.producto   = b.producto
     and a.fecha_can  = b.fecha_can

  if @@error <> 0
  begin
    print 'ERROR INSERTANDO OPERACIONES DE CARTERA EN LA TABLA REPORTE'
    select
      @w_error = 701185,
      @w_msg = 'ERROR INSERTANDO OPERACIONES DE CARTERA EN LA TABLA REPORTE'
    goto ERRORFIN
  end

  if exists (select
               1
             from   sysobjects
             where  name = 'rep_prodcan'
                and type = 'U')
  begin
    drop table rep_prodcan
  end

  select
    *
  into   rep_prodcan
  from   #rep_prodcan_tmp
  order  by CODIGO_OFICINA,
            NUM_ID_CLIENTE

  if @@error <> 0
  begin
    print 'ERROR INSERTANDO PRODUCTOS AHORROS EN LA TABLA REPORTE DEFINITIVA'
    select
      @w_error = 701185,
      @w_msg =
    'ERROR INSERTANDO PRODUCTOS AHORROS EN LA TABLA REPORTE DEFINITIVA'
    goto ERRORFIN
  end

  -----------------------------------------------------------------|
  ------------------------- REALIZANDO BCP ------------------------|
  -----------------------------------------------------------------|

  select
    @w_anio = convert(varchar(4), datepart(yyyy,
                                           @w_fecha_proc)),
    @w_mes = convert(varchar(2), datepart(mm,
                                          @w_fecha_proc)),
    @w_dia = convert(varchar(2), datepart(dd,
                                          @w_fecha_proc))

  select
    @w_fecha1 = (right('00' + @w_mes, 2) + right('00'+ @w_dia, 2) + @w_anio)

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  -- GENERACIËN DE LISTADO
  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 2

  ----------------------------------------
  -- Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_nombre = 'rep_prodcan',
    @w_nom_tabla = 'rep_prodcan',
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), ''),
    @w_nombre_cab = @w_nombre

  select
    @w_nombre_plano = @w_path + @w_nombre_cab + '_' + @w_fecha1 + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cobis..sysobjects o,
           cobis..syscolumns c
    where  o.id    = c.id
       and o.name  = @w_nom_tabla
       and c.colid > @w_col_id
    order  by c.colid

    if @@rowcount = 0
    begin
      set rowcount 0
      break
    end
    select
      @w_cabecera = @w_cabecera + @w_columna + '^|'
  end

  select
    @w_cabecera = left(@w_cabecera,
                       datalength(@w_cabecera) - 2)

  -- Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  -- Ejecucion para Generar Archivo Datos
  select
    @w_comando = @w_s_app + 's_app bcp -auto -login cobis..rep_prodcan out '

  select
    @w_destino = @w_path + 'rep_prodcan.txt',
    @w_errores = @w_path + 'rep_prodcan.err'

  select
    @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                 ' -t"|" '
                                                                     +
                 '-config '
                                                                     + @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR GENERANDO REPORTE DE PRODUCTOS CANCELADOS'
    goto ERRORFIN
  end

  ----------------------------------------
  -- Union de archivos (cab) y (dat)
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'rep_prodcan.txt'
                 +
                        ' ' +
                        @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando

  select
    @w_cmd = 'del ' + @w_destino
  exec xp_cmdshell
    @w_cmd

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERRORFIN
  end

  return 0

  ERRORFIN:

  exec sp_errorlog
    @i_fecha       = @w_fecha_proc,
    @i_error       = @w_error,
    @i_tran        = null,
    @i_usuario     = 'op_batch',
    @i_tran_name   = @w_sp_name,
    @i_cuenta      = '',
    @i_rollback    = 'N',
    @i_descripcion = @w_msg
  print @w_msg
  return 1

go

