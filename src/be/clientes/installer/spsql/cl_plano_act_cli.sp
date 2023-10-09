/************************************************************************/
/*   Archivo:             cl_plano_act_cli.sp                           */
/*   Stored procedure:    cl_plano_act_cli                              */
/*   Base de datos:       cobis                                         */
/*   Producto:            clientes                                      */
/*   Disenado por:        Luis Carlos Moreno C.                         */
/*   Fecha de escritura:  Noviembre/2011                                */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
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
/*  Generar un Archivo Plano de los clientes modificados en el sistema  */
/*  con la siguiente estructura:                                        */
/*  - Nombre Cliente                                                    */
/*  - Cédula Cliente                                                    */
/*  - Dirección                                                         */
/*  - Teléfono                                                          */
/*  - Código Oficina                                                    */
/*  - Nombre Oficina                                                    */
/*  - Fecha Modificación                                                */
/*  - Hora Modificación                                                 */
/*  - Usuario Modificación                                              */
/*  - Estación                                                          */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA     AUTOR             RAZON                                   */
/*  15-11-11  L.Moreno          Emisión Inicial - Req: 254              */
/*  0205-16   DFu               Migracion CEN                           */
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
           where  name = 'cl_plano_act_cli')
  drop proc cl_plano_act_cli
go

create procedure cl_plano_act_cli
(
  @t_show_version bit = 0,
  @i_param1       datetime,
  @i_param2       datetime,
  @i_param3       char(1) = 'T',
  @i_param4       int = 0
)
as
  declare
    @w_fecha_ini        datetime,
    @w_fecha_fin        datetime,
    @w_por_ofi          char(1),
    @w_oficina          int,
    @w_sp_name          varchar(32),
    @w_servidor         varchar(10),
    @w_comando_sql      varchar(1200),
    @w_cont_reg         int,
    @w_fecha_proceso    varchar(10),
    @w_msg              varchar(30),
    @w_fecha_arch       varchar(8),
    @w_hora_arch        varchar(4),
    @w_sp_name_batch    varchar(30),
    @w_s_app            varchar(30),
    @w_path             varchar(255),
    @w_error            int,
    @w_nombre_plano     varchar(200),
    @w_plano_errores    varchar(200),
    @w_nombre_plano_det varchar(200),
    @w_nombre_plano_tot varchar(200),
    @w_col_id           int,
    @w_columna          varchar(50),
    @w_cabecera         varchar(400),
    @w_comando          varchar(1000),
    @w_cmd              varchar(300),
    @w_totales_linea    varchar(100),
    @w_totales_fechas1  varchar(100),
    @w_totales_fechas2  varchar(100),
    @w_totales_fechas3  varchar(100),
    @w_totales_num_reg  varchar(100)

  select
    @w_sp_name = 'cl_plano_act_cli'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set nocount on

  -- INICIALIZACION DE VARIABLES
  select
    @w_fecha_ini = @i_param1
  select
    @w_fecha_fin = dateadd(second,
                           86399,
                           @i_param2)
  select
    @w_por_ofi = @i_param3
  select
    @w_oficina = @i_param4
  select
    @w_cont_reg = 0

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

/************************************************************************/
/*                    VALIDACION PARAMETROS DE ENTRADA                  */
  /************************************************************************/

  if @w_fecha_ini is null
  begin
    select
      @w_msg = 'ERROR, NO SE ENCUENTRA LA FECHA INICIAL'
    goto ERROR_INF
  end

  if @w_fecha_fin is null
  begin
    select
      @w_msg = 'ERROR, NO SE ENCUENTRA LA FECHA FINAL'
    goto ERROR_INF
  end

  if @w_por_ofi is null
  begin
    select
      @w_msg = 'ERROR, NO SE ENCUENTRA EL TIPO DE OFICINA PARA CONSULTA'
    goto ERROR_INF
  end

  if @w_por_ofi = 'T'
  begin
    select
      @w_oficina = null
  end

  if @w_por_ofi = 'O'
  begin
    if @w_oficina is null
    begin
      select
        @w_msg = 'ERROR, NO SE ENCUENTRA LA OFICINA PARA CONSULTA'
      goto ERROR_INF
    end
  end

/************************************************************************/
/*                  LECTURA DE VARIABLES DE TRABAJO                     */
/************************************************************************/
  /*Calcula fecha de proceso*/
  select
    @w_fecha_proceso = convert(varchar(10), fp_fecha, 103)
  from   ba_fecha_proceso

  /* PARAMETRO GENERAL SERVIDOR HISTORICOS*/
  select
    @w_servidor = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'CCA'
     and pa_nemonico = 'SRVHIS'

/************************************************************************/
/*         CARGA TABLA TEMPORAL CON LOS DATOS DE LA CONSULTA            */
  /************************************************************************/
  truncate table cl_actcli_tmp

  /* Inserta clientes actualizados por datos basicos */
  insert into cl_actcli_tmp
    select
      en_nomlar,en_ced_ruc,'','',en_oficina,
      '',convert(varchar(10), en_fecha_mod, 103),
      convert(varchar(10), en_fecha_mod
      ,
      108),'','',
      'DATOS PERSONALES'
    from   cl_ente with (nolock)
    where  en_subtipo = 'P'
       and en_fecha_mod between @w_fecha_ini and @w_fecha_fin
       and en_oficina = isnull(@w_oficina,
                               en_oficina)

  set @w_cont_reg = @w_cont_reg + @@rowcount

  /* Inserta clientes actualizados por direccion */
  insert into cl_actcli_tmp
    select
      en_nomlar,en_ced_ruc,'','',cl_ente.en_oficina,
      '',convert(varchar(10), di_fecha_modificacion, 103),
      convert(varchar(10), di_fecha_modificacion, 108),'','',
      'DIRECCION'
    from   cl_direccion with (nolock),
           cl_ente with (nolock)
    where  en_subtipo = 'P'
       and di_ente    = en_ente
       and di_fecha_modificacion between @w_fecha_ini and @w_fecha_fin
       and en_oficina = isnull(@w_oficina,
                               en_oficina)

  set @w_cont_reg = @w_cont_reg + @@rowcount

  /* Inserta clientes actualizados por telefono */

  insert into cl_actcli_tmp
    select
      cl_ente.en_nomlar,cl_ente.en_ced_ruc,'','',cl_ente.en_oficina,
      '',convert(varchar(10), te_fecha_mod, 103),
      convert(varchar(10), te_fecha_mod
      ,
      108),'','',
      'TELEFONO'
    from   cl_telefono with (nolock),
           cl_ente with (nolock)
    where  en_subtipo = 'P'
       and te_ente    = en_ente
       and te_fecha_mod between @w_fecha_ini and @w_fecha_fin
       and en_oficina = isnull(@w_oficina,
                               en_oficina)

  set @w_cont_reg = @w_cont_reg + @@rowcount

  /* Actualiza con direccion principal */
  update cl_actcli_tmp
  set    ct_direccion = cl_direccion.di_descripcion
  from   cl_direccion,
         cl_ente
  where  en_ced_ruc   = ct_cedula
     and di_ente      = en_ente
     and di_principal = 'S'

  /* Actualiza con telefono asociado a direccion principal */
  update cl_actcli_tmp
  set    ct_telefono = isnull('(' + te_tipo_telefono + ')', '')
                       + isnull('(' + cl_telefono.te_prefijo + ') ', '') +
                       isnull(
                              cl_telefono.te_valor, '')
  from   cl_ente,
         cl_direccion,
         cl_telefono
  where  en_ced_ruc   = ct_cedula
     and di_ente      = en_ente
     and te_ente      = di_ente
     and te_direccion = di_direccion
     and di_principal = 'S'

  /* Actualiza nombre de la oficina */
  update cl_actcli_tmp
  set    ct_nom_oficina = of_nombre
  from   cl_oficina
  where  of_oficina = ct_cod_oficina

/* Actualiza con los campos usuario y terminal para actualizacion de datos basicos*/
  /* Primero actualiza con la tabla ts_persona si la informacion no ha pasado al historico */
  update cl_actcli_tmp
  set    ct_usuario = t.ts_usuario,
         ct_terminal = t.ts_terminal
  from   (select
            max(t.ts_secuencial) secuencial,
            t.ts_tipo_transaccion,
            a.ct_cedula          cedula
          from   cl_actcli_tmp a with (nolock)
                 inner join cl_ente c with (nolock)
                         on a.ct_cedula = c.en_ced_ruc
                 inner join cl_tran_servicio t with (nolock)
                         on t.ts_ente = c.en_ente
          where  a.ct_usuario  = ''
             and a.ct_terminal = ''
             and t.ts_fecha    >= convert(datetime, a.ct_fecha_mod, 103)
             and t.ts_tipo_transaccion in (103, 104, 186, 192,
                                           1288, 109, 110, 1226,
                                           111, 112, 148)
             and t.ts_usuario is not null
          group  by t.ts_ente,
                    a.ct_cedula,
                    t.ts_tipo_transaccion) s,
         cl_tran_servicio t with (nolock)
  where  ct_cedula    = s.cedula
     and (ct_tipo_mod  = 'DATOS PERSONALES'
          and t.ts_tipo_transaccion in (103, 104, 186, 192, 1288)
           or ct_tipo_mod  = 'DIRECCION'
              and t.ts_tipo_transaccion in (109, 110, 1226)
           or ct_tipo_mod  = 'TELEFONO'
              and t.ts_tipo_transaccion in (111, 112, 148))
     and s.secuencial = t.ts_secuencial
     and t.ts_usuario is not null

  /* Si existe servidor historico actualiza campos usuario y terminal */
  if @w_servidor <> 'NOHIST'
  begin
    select
      @w_comando_sql = 'update cl_actcli_tmp'
    select
      @w_comando_sql = @w_comando_sql + ' set ct_usuario = t.ts_usuario,'
    select
      @w_comando_sql = @w_comando_sql + ' ct_terminal = t.ts_terminal'
    select
      @w_comando_sql = @w_comando_sql + ' from'
    select
      @w_comando_sql = @w_comando_sql
                       +
' (select max(t.ts_secuencial) secuencial, t.ts_tipo_transaccion, a.ct_cedula cedula'
  select
    @w_comando_sql = @w_comando_sql + ' from cl_actcli_tmp a with (nolock)'
  select
    @w_comando_sql = @w_comando_sql + ' inner join cl_ente c with (nolock) on'
  select
    @w_comando_sql = @w_comando_sql + ' a.ct_cedula = c.en_ced_ruc'
  select
    @w_comando_sql = @w_comando_sql + ' inner join  ' + @w_servidor
                     + '.cobis_his.dbo.cl_tran_servicio t with (nolock) on'
  select
    @w_comando_sql = @w_comando_sql + ' t.ts_ente = c.en_ente'
  select
    @w_comando_sql = @w_comando_sql +
                     ' where a.ct_usuario = '''' and a.ct_terminal = '''' and'
  select
    @w_comando_sql = @w_comando_sql +
                     ' t.ts_fecha >= convert(datetime,a.ct_fecha_mod,103)  and'
  select
    @w_comando_sql = @w_comando_sql
                     +
' t.ts_tipo_transaccion in (103,104,186,192,1288,109,110,1226,111,112,148) and'
  select
    @w_comando_sql = @w_comando_sql + ' t.ts_usuario is not null'
  select
    @w_comando_sql = @w_comando_sql +
    ' group by t.ts_ente, a.ct_cedula, t.ts_tipo_transaccion) s, '
    + @w_servidor +
    '.cobis_his.dbo.cl_tran_servicio t with (nolock)'
  select
    @w_comando_sql = @w_comando_sql + ' where ct_cedula = s.cedula and'
  select
    @w_comando_sql = @w_comando_sql
                     +
' (ct_tipo_mod = ''DATOS PERSONALES'' and t.ts_tipo_transaccion in (103,104,186,192,1288) or'
  select
    @w_comando_sql = @w_comando_sql
                     +
' ct_tipo_mod = ''DIRECCION'' and t.ts_tipo_transaccion in (109,110,1226) or'
  select
    @w_comando_sql = @w_comando_sql
                     +
' ct_tipo_mod = ''TELEFONO'' and t.ts_tipo_transaccion in (111,112,148)) and'
  select
    @w_comando_sql = @w_comando_sql +
    ' s.secuencial = t.ts_secuencial and t.ts_usuario is not null'

  exec @w_error = sp_sqlexec
    @w_comando_sql
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR, AL ACTUALIZAR TABLA DE CLIENTES ACTUALIZADOS'
    goto ERROR_INF
  end

  select
    @w_comando_sql = ''
end

/************************************************************************/
/*          GENERA ARCHIVO PLANO CON EL REPORTE DE CLIENTES             */
/************************************************************************/
  /* Asigna variables para el nombre del archivo */
  select
    @w_fecha_arch = substring(convert(varchar(10), @w_fecha_proceso), 1, 2)
                    + substring(convert(varchar(10), @w_fecha_proceso), 4, 2)
                    + substring(convert(varchar(10), @w_fecha_proceso), 7, 4),
    @w_hora_arch = substring(convert(varchar, getdate(), 108), 1, 2)
                   + substring(convert(varchar, getdate(), 108), 4, 2)
                   + substring(convert(varchar(10), @w_fecha_proceso), 7, 4),
    @w_sp_name_batch = 'cobis..cl_plano_act_cli'

  /* Obtiene el path donde se va a generar el informe : VBatch\Clientes\Listados */
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    goto ERROR_INF
  end

  /* Obtiene el parametro de la ubicacion del kernel\bin en el servidor */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR AL OBTENER EL PARAMETRO GENERAL S_APP DE ADM'
    goto ERROR_INF
  end

  /* Obtiene los nombres de los informes */
  select
    @w_nombre_plano = @w_path + 'PLANO_ACT_CLI_' + @w_fecha_arch + '_' +
                             @w_hora_arch + '.txt',
    @w_plano_errores = @w_path + 'PLANO_ACT_CLI_' + @w_fecha_arch + '_' +
                       @w_hora_arch + '.err',
    @w_nombre_plano_det = @w_path + 'PLANO_ACT_CLI_det.txt',
    @w_nombre_plano_tot = @w_path + 'PLANO_ACT_CLI_tot.txt'

/*-------------------------------------------------------------------------------------*/
/*             GENERA ENCABEZADO INFORME - ARCHIVO: PLANO_ACT_CLI_enc.txt       */
/*-------------------------------------------------------------------------------------*/
  /* Obtiene texto para el encabezado de las columnas */
  select
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = ''
  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   sysobjects o,
           syscolumns c
    where  o.id    = c.id
       and o.name  = 'cl_actcli_tmp'
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

  /*Escribir encabezado de las columnas */
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ESCRIBIR ENCABEZADO DEL INFORME.'
    goto ERROR_INF
  end

/*-------------------------------------------------------------------------------------*/
/*             GENERA DETALLE INFORME - ARCHIVO: PLANO_ACT_CLI_det.txt          */
/*-------------------------------------------------------------------------------------*/
  /* Genera detalle del informe en el archivo */
  select
    @w_cmd = @w_s_app + 's_app bcp -auto -login cobis..cl_actcli_tmp out '
  select
       @w_comando = @w_cmd + @w_nombre_plano_det + ' -c -e' + @w_plano_errores +
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
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVIZAR ARCHIVOS DE LOG GENERADOS.'
    print @w_comando
    goto ERROR_INF
  end
  else
  begin
    select
      @w_comando = 'del ' + @w_plano_errores
    exec @w_error = xp_cmdshell
      @w_comando
    if @w_error <> 0
    begin
      select
        @w_error = 808022,
        @w_msg = 'ERROR AL BORRAR EL ARCHIVO DE ERRORES BCP.'
      print @w_comando
      goto ERROR_INF
    end
  end

/*-------------------------------------------------------------------------------------*/
/*           GENERA TOTALES INFORME - ARCHIVO: PLANO_ACT_CLI_tot.txt            */
/*-------------------------------------------------------------------------------------*/
  /* Generar archivo con los totales del proceso */
  select
    @w_totales_linea = '^|'
  select
    @w_totales_fechas1 = 'Fecha Proceso (DD/MM/AAAA)' + '^|' + @w_fecha_proceso
                         +
                                                            '^|'
  select
       @w_totales_fechas2 = 'Fecha Inicio  (DD/MM/AAAA)' + '^|' + convert(
                            varchar
                            (
                            10 ), @w_fecha_ini, 103)
                            + '^|'
  select
    @w_totales_fechas3 =
       'Fecha Fin     (DD/MM/AAAA)' + '^|' + convert(varchar(10),
       @w_fecha_fin, 103) +
       '^|'
  select
    @w_totales_num_reg = 'Numero de registros' + '^|' + convert(varchar(20),
                                            @w_cont_reg) + '^|'

  /*Escribir totales del informe en el archivo */
  select
    @w_comando = 'echo ' + @w_totales_linea + ' > ' + @w_nombre_plano_tot
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA ESCRITURA DE TOTALES.'
    goto ERROR_INF
  end

  select
    @w_comando = 'echo ' + @w_totales_fechas1 + ' >> ' + @w_nombre_plano_tot
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA ESCRITURA DE TOTALES.'
    goto ERROR_INF
  end

  select
    @w_comando = 'echo ' + @w_totales_fechas2 + ' >> ' + @w_nombre_plano_tot
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA ESCRITURA DE TOTALES.'
    goto ERROR_INF
  end

  select
    @w_comando = 'echo ' + @w_totales_fechas3 + ' >> ' + @w_nombre_plano_tot
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA ESCRITURA DE TOTALES.'
    goto ERROR_INF
  end

  select
    @w_comando = 'echo ' + @w_totales_num_reg + ' >> ' + @w_nombre_plano_tot
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA ESCRITURA DE TOTALES.'
    goto ERROR_INF
  end

/*-------------------------------------------------------------------------------------*/
/*           GENERA INFORME FINAL - ARCHIVO: PLANO_ACT_CLI.AAAAMMDD_HHMMSS.txt  */
/*-------------------------------------------------------------------------------------*/
  /* Une los archivos encabezado, detalle y totales */
  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_nombre_plano_det + ' + '
                 +
                        @w_nombre_plano_tot + ' '
                 + @w_nombre_plano
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR EN LA GENERACION DEL INFORME FINAL.'
    goto ERROR_INF
  end

  /* Solamente deja el archivo definitivo, se eliminan los archivos temporales */
  select
    @w_comando = 'del ' + @w_nombre_plano_det
  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
    print @w_comando
    goto ERROR_INF
  end

  select
    @w_comando = 'del ' + @w_nombre_plano_tot
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 808022,
      @w_msg = 'ERROR AL ELIMINAR ARCHIVOS TEMPORALES DE TRABAJO.'
    print @w_comando
    goto ERROR_INF
  end

  return 0

  ERROR_INF:

  exec sp_errorlog
    @i_fecha       = @w_fecha_proceso,
    @i_error       = @w_error,
    @i_usuario     = 'OPERADOR',
    @i_tran        = null,
    @i_tran_name   = 'cl_plano_act_cli',
    @i_cuenta      = '',
    @i_rollback    = 'N',
    @i_descripcion = @w_msg
  print @w_msg

  return 1

go

