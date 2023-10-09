/************************************************************************/
/*  Archivo:            ahestadistica.sp                                */
/*  Stored procedure:   sp_estadisticas_for444                          */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas Corrientes                              */
/*  Fecha de escritura: 02-Mayo-2011                                    */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno  de sus            */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp.     */
/*  Este programa esta protegido por la ley de derechos de autor        */
/*  y por las convenciones  internacionales de propiedad inte-          */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para       */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier infraccion.                   */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Este programa genera un archivo  con el detalle de transacciones    */
/*  monetarias de y de consulta para el formato 444                     */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  04/May/2016     J. Salazar        Migracion COBIS CLOUD MEXICO      */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_estadisticas_for444')
  drop proc sp_estadisticas_for444
go

/****** Object:  StoredProcedure [dbo].[sp_estadisticas_for444]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_estadisticas_for444
(
  @s_user         varchar(30) = null,
  @t_show_version bit = 0,
  @i_param1       datetime -- Fecha de Proceso
)
as
  declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_fecha_aux      datetime,
    @w_fecha_ini      datetime,
    @w_fecha          datetime,
    @w_procesadas     int,
    @w_error          int,
    @w_msj            varchar(255),
    @w_proceso        int,
    @w_fecha_fin      varchar(10),
    --variables para bcp   
    @w_path_destino   varchar(100),
    @w_s_app          varchar(50),
    @w_cmd            varchar(255),
    @w_comando        varchar(255),
    @w_nombre_archivo varchar(255),
    @w_anio           varchar(4),
    @w_mes            varchar(2),
    @w_dia            varchar(2)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_estadisticas_for444',
    @w_fecha = @i_param1,
    @w_proceso = 4028

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_procesadas = 0

  /* Lectura para login operador batch*/
  select
    @s_user = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'LOB'
     and pa_producto = 'ADM'

  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @w_fecha,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'N',
    @w_dias_ret  = 1,
    @o_fecha_sig = @w_fecha_aux out

  print ' Empieza el sp: ' + @w_sp_name

  if convert(tinyint, datepart(mm,
                               @w_fecha_aux)) =
     convert(tinyint, datepart(mm,
                               @w_fecha
                      ))
    return 0

  --ELIMINAR TABLAS TEMPORALES
  if exists(select
              1
            from   sysobjects
            where  name = 'tmp_transacciones')
    drop table tmp_transacciones

  if exists(select
              1
            from   sysobjects
            where  name = 'tmp_plano_aho')
    drop table tmp_plano_aho

  create table tmp_plano_aho
  (
    orden  int not null,
    cadena varchar(2000) not null
  )

  select
    @w_fecha_ini = convert(datetime, convert(varchar(2), datepart(mm, @w_fecha))
                                     +
                                                '/01/'
                                     + convert(varchar(5), datepart(yy, @w_fecha
                                     )
                                     )
                              )

  print 'fecha inicio :' + cast(@w_fecha_ini as varchar)

  /***INSERTANDO TRANSACCIONES MONETARIAS***/
  select
    'Mes' = datename (month,
                      @w_fecha),
    'Producto' = '4',
    'Trans' = tc_tipo_tran,
    'Des_tran' = tn_descripcion,
    'Cod_forma_pag' = tc_concepto,
    'Des_forma_pag' = (select
                         valor
                       from   cobis..cl_catalogo c,
                              cobis..cl_tabla t
                       where  t.tabla  = 're_concepto_contable'
                          and t.codigo = c.tabla
                          and c.codigo = tt.tc_concepto),
    'Num_registro' = sum(tc_numtran),
    'Valor' = sum(tc_valor),
    'Estado' = case
                 when tc_estado in ('CON', 'ING') then 'A'
                 else 'R'
               end
  into   tmp_transacciones
  from   cob_remesas..re_trn_contable tt,
         cobis..cl_ttransaccion
  where  tc_tipo_tran = tn_trn_code
     and tc_fecha between @w_fecha_ini and @w_fecha
     and tc_tipo_tran not in (271, 379, 221)
  group  by tc_tipo_tran,
            tn_descripcion,
            tn_descripcion,
            tc_concepto,
            tc_estado
  if @@rowcount = 0
  begin
    select
      @w_error = 201163,
      @w_msj = 'NO EXISTEN DATOS PARA LA FECHA :' + cast(@w_fecha as varchar)
    print @w_msj
  end

  /***INSERTANDO TRANSACCIONES DE SERVICIO***/
  insert into tmp_transacciones
              (Mes,Producto,Trans,Des_tran,Cod_forma_pag,
               Des_forma_pag,Num_registro,Valor,Estado)
    select
      datename (month,
                @w_fecha),4,ts_tipo_transaccion,tn_descripcion,tn_nemonico,
      tn_descripcion,count(1),0,'A'
    from   cob_ahorros..ah_tran_servicio t,
           cobis..cl_ttransaccion
    where  ts_tipo_transaccion = tn_trn_code
       and ts_tipo_transaccion in (230)
       and ts_estado is null
       and ts_tsfecha between @w_fecha_ini and @w_fecha
    group  by ts_tipo_transaccion,
              tn_descripcion,
              tn_nemonico

  select
    @w_anio = convert(varchar(4), datepart(yyyy,
                                           @w_fecha)),
    @w_mes = convert(varchar(2), datepart(mm,
                                          @w_fecha)),
    @w_dia = convert(varchar(2), datepart(dd,
                                          @w_fecha))

  select
    @w_fecha_fin = (@w_anio + right('00' + @w_mes, 2) + right('00'+ @w_dia, 2))

  /* GENERACION ARCHIVO PLANO */
  print '--> Path Archivo Resultante'

  select
    @w_path_destino = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = @w_proceso
  if @@rowcount = 0
  begin
    select
      @w_error = 201165,
      @w_msj = 'No Existe path_destino para el proceso : ' + cast(@w_proceso as
               varchar)
    goto ERROR
  end

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'
  if @@rowcount = 0
  begin
    select
      @w_error = 201164,
      @w_msj = 'NO EXISTE RUTA DEL S_APP'
    goto ERROR
  end

  -- Arma Nombre del Archivo
  print 'Generar el archivo plano TRANS_AHORROS_AAAAMMDD.txt !!!!! '
  insert into cob_ahorros..tmp_plano_aho
              (orden,cadena)
  values      (0,
'Mes | Producto | Tipo_Tran | Cod_Tran | Descrip_Tran | Num_registros | Valor |Estado'
  )

  insert into cob_ahorros..tmp_plano_aho
              (orden,cadena)
    select
      row_number()
        over (
          order by Trans),Mes + '|' + Producto + '|' + convert(varchar, Trans )
      +
      '|' + Cod_forma_pag +
      '|' + Des_forma_pag + '|'
      + convert(varchar, Num_registro) + '|' + convert(varchar, Valor) + '|' +
      Estado
    --select *
    from   tmp_transacciones
    order  by Trans
  print 'Registros Procesados : ' + cast(@@rowcount as varchar)

  select
    @w_nombre_archivo = @w_path_destino + 'TRANS_AHORROS_' + @w_fecha_fin +
                        '.txt'
  print @w_nombre_archivo

  select
    @w_cmd =
'bcp "select cadena from cob_ahorros..tmp_plano_aho order by orden " queryout '
  select
       @w_comando = @w_cmd + @w_nombre_archivo + ' -b5000 -c -t"|" -T -S' +
                    @@servername
    +
                    ' -eFNG.err'
  print @w_comando
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msj = 'Error Generando BCP' + @w_comando
    goto ERROR
  end

  ERROR:
  exec sp_errorlog
    @i_cuenta      = '0',
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 264,
    @i_descripcion = @w_msj,
    @i_programa    = @w_sp_name

  return 0

go

