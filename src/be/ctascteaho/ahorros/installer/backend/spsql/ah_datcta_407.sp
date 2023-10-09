/************************************************************************/
/*      Archivo:                ah_datcta_407.sp                        */
/*      Stored procedure:       sp_datcta_407                           */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Ahorros                                 */
/*      Disenado por:           Doris Lozano                            */
/*      Fecha de escritura:     08-mayo-2012                            */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Extraer datos diarios de saldos de cuentas de ahorro por        */
/*      oficina   del '12/06/2010' al  '04/30/2012'                     */
/*                              MODIFICACIONES                          */
/************************************************************************/
/*      FECHA            AUTOR             RAZON                        */
/*      08/05/2012       D. Lozano         Emision inicial              */
/*      03/May/2016      J. Salazar        Migracion COBIS CLOUD MEXICO */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_datcta_407')
  drop proc sp_datcta_407
go

/****** Object:  StoredProcedure [dbo].[sp_datcta_407]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_datcta_407
  @t_show_version bit = 0
as
  declare
    --variables para bcp   
    @w_path_destino   varchar(100),
    @w_s_app          varchar(50),
    @w_cmd            varchar(255),
    @w_comando        varchar(255),
    @w_nombre_archivo varchar(255),
    @w_anio           varchar(4),
    @w_mes            varchar(2),
    @w_dia            varchar(2),
    @w_error          int,
    @w_path           varchar(50),
    @w_col_id         int,
    @w_nombre_plano   varchar(1500),
    @w_columna        varchar(30),
    @w_msg            varchar(200),
    @w_nombre_cab     varchar(18),
    @w_fecha          datetime,
    @w_destino        varchar(2500),
    @w_sp_name        varchar(20),
    @w_cabecera       varchar(2500),
    @w_errores        varchar(1500),
    @w_mensaje        varchar(200)

  select
    @w_sp_name = 'sp_datcta_407',
    @w_fecha = getdate()

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  if exists(select
              1
            from   sysobjects
            where  name = 'tmp_datos_aho_407')
    drop table tmp_datos_aho_407

  create table tmp_datos_aho_407
  (
    fecha          datetime null,
    oficina        smallint null,
    nro_cuentas    int null,
    tipo_cta       varchar(30) null,
    estado         varchar(20) null,
    saldo_contable money null,
    egresos        money null,
    ingresos       money null
  )

  select
    'fecha' = co_fecha,
    'oficina' = co_oficina,
    'nro_cuentas' = co_numcuentas,
    'tipo_cta' = (select
                    pb_descripcion
                  from   cob_remesas..pe_pro_bancario
                  where  pb_pro_bancario = co_prod_banc),
    'estado' = (select
                  b.valor
                from   cobis..cl_tabla a,
                       cobis..cl_catalogo b
                where  a.tabla  = 'ah_estado_cta'
                   and a.codigo = b.tabla
                   and b.codigo = co_estado
                   and b.estado = 'V'),
    'saldo_contable' = co_saldo_neto,
    'egresos' = co_debitos_hoy,
    'ingresos' = co_creditos_hoy
  into   #datos
  from   cob_ahorros..ah_consolidado with (nolock)
  where  co_fecha between '12/06/2010' and '04/30/2012'

  if @@error <> 0
  begin
    select
      @w_error = 2805004,
      @w_msg = 'Error en Insercion en cob_ahorros..tmp_datos_aho_407'
    goto ERROR
  end

  insert into cob_ahorros..tmp_datos_aho_407
    select
      fecha,oficina,sum(nro_cuentas),tipo_cta,estado,
      sum(saldo_contable),sum(egresos),sum(ingresos)
    from   #datos
    group  by fecha,
              oficina,
              tipo_cta,
              estado

  select
    @w_path_destino = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 4188

  if @@rowcount = 0
  begin
    select
      @w_error = 201165,
      @w_msg = 'No Existe path_destino para el proceso : '
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
      @w_msg = 'NO EXISTE RUTA DEL S_APP'
    goto ERROR
  end

  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), ''),
    @w_nombre_cab = 'movaho_ors_407'

  select
    @w_nombre_plano = @w_path_destino + @w_nombre_cab + '_' + convert(varchar(2)
                      ,
                                                                  datepart(dd,
                                                                  @w_fecha)) +
                      '_'
                      + convert(varchar(2), datepart(mm, @w_fecha)) + '_'
                      + convert(varchar(4), datepart(yyyy, @w_fecha))

  select
       @w_nombre_plano = @w_nombre_plano + '_' + convert(varchar(2), datepart(hh
                         ,
                         @w_fecha)) + '_'
                      + convert(varchar(2), datepart(mi, @w_fecha)) + + '_'
                      + convert(varchar(2), datepart(ss, @w_fecha)) + '.txt'

  while 1 = 1
  begin
    set rowcount 1

    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cob_ahorros..sysobjects o,
           cob_ahorros..syscolumns c
    where  o.id    = c.id
       and o.name  = 'tmp_datos_aho_407'
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

  --Escribir Cabecera

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
    goto ERROR
  end

  --Ejecucion para Generar Archivo Datos

  select
    @w_comando =
           @w_s_app +
           's_app bcp -auto -login cob_ahorros..tmp_datos_aho_407 out '

  select
    @w_destino = @w_path_destino + 'tmp_datos_aho_407.txt',
    @w_errores = @w_path_destino + 'tmp_datos_aho_407.err'

  select
       @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                    ' -t"|" ' + '-config '
                    + @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'Error Generando Archivo tmp_datos_aho_407 '
    return @w_error
  end

  ----------------------------------------
  --Union de archivo @w_nombre_plano con archivo tmp_datos_aho_407.txt
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path_destino +
                        'tmp_datos_aho_407.txt' +
                        ' '
                 + @w_nombre_plano

  select
    @w_comando

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg =
    'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
    goto ERROR
  end

  return 0

  ERROR:
  exec sp_errorlog
    @i_cuenta      = '0',
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 264,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

go

