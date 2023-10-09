/*cl_reptr.sp************************************************************/
/*  Archivo:                         cl_reptr.sp                        */
/*  Stored procedure:                sp_reporte_trn                     */
/*  Base de datos:                   cobis                              */
/*  Producto:                        Clientes                           */
/*  Disenado por:                    Alfredo Zuluaga                    */
/*  Fecha de escritura:              10-Dic-2010                        */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Generar Reporte para mostrar la informacion de los clientes que se  */
/*  actualizan por ruta critica                                         */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR                    RAZON                          */
/*  10/12/2010  Alfredo Zuluaga          Emision Inicial                */
/*   02/Mayo/2016     Roxana Sánchez       Migración a CEN              */
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
           where  name = 'sp_reporte_trn')
  drop proc sp_reporte_trn
go

create proc sp_reporte_trn
(
  @t_show_version bit = 0,
  @i_param1       varchar(255) = null,--Fecha de Proceso
  @i_param2       varchar(255) = null,--Nombre Archivo de Salida
  @i_usuario      varchar(10) = null,--Login de Usuario
  @i_fecha_ini    datetime = null,--Fecha Inicial Consulta
  @i_fecha_fin    datetime = null,--Fecha Final Consulta
  @i_id           int = null --Codigo de secuencial

)
as
  declare
    @i_fecha        datetime,
    @i_nombre_arch  varchar(100),
    @w_sp_name      varchar(255),
    @w_msg          varchar(255),
    @w_path         varchar(255),
    @w_s_app        varchar(255),
    @w_col_id       int,
    @w_columna      varchar(30),
    @w_cabecera     varchar(255),
    @w_destino      varchar(255),
    @w_errores      varchar(255),
    @w_comando      varchar(2000),
    @w_nombre_plano varchar(1000),
    @w_error        int,
    @w_des_usuario  varchar(50)

  select
    @i_fecha = convert(datetime, @i_param1),
    @i_nombre_arch = ltrim(rtrim(@i_param2)),
    @w_sp_name = 'sp_reporte_trn'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  --Si la oficina tiene valor diferente a null, el SP es disparado desde el FE para consultar la tabla generada por el Batch
  if @i_usuario is not null
  begin
    select
      @i_id = isnull(@i_id,
                     0)

    select
      @w_des_usuario = fu_nombre
    from   cobis..cl_funcionario(nolock)
    where  fu_login = @i_usuario

    select
      @w_des_usuario

    set rowcount 10

    select
      'SECUENCIAL' = id,
      'OFICINA   ' = oficina,
      'NOMBRE OFICINA    ' = des_oficina,
      'CLIENTE   ' = cliente,
      'CLASE     ' = clase,
      'USUARIO   ' = usuario,
      'FECHA MODIF.' = convert(varchar(10), fecha_mod, 103),
      'NOMBRES            ' = convert(varchar(30), nombre),
      'PRIMER APELLIDO    ' = convert(varchar(30), p_apellido),
      'SEGUNDO APELLIDO   ' = convert(varchar(30), s_apellido),
      'TIPO ID.   ' = tipo_ced,
      'IDENTIFICACION     ' = ced_ruc,
      'FECHA EMISION ' = convert(varchar(10), fecha_emision, 103),
      'FECHA NACIM.' = convert(varchar(10), fecha_nac, 103)
    from   cl_temporal_datos_trn
    where  usuario = @i_usuario
       and fecha_mod between @i_fecha_ini and @i_fecha_fin
       and id      > @i_id
    order  by id

    set rowcount 0

    return 0
  end

  --Si la oficina tiene null, el SP es disparado desde el FE para consultar la tabla generada por el Batch

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 2000

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = '',
    @w_nombre_plano = @w_path + @i_nombre_arch + '_' + convert(varchar(2),
                      datepart(
                      dd, @i_fecha)) +
                      '_'
                      + convert(varchar(2), datepart(mm, @i_fecha)) + '_'
                      + convert(varchar(4), datepart(yyyy, @i_fecha)) + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   sysobjects o,
           syscolumns c
    where  o.id    = c.id
       and o.name  = 'cl_temporal_datos_trn'
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

  --exec @w_error = xp_cmdshell @w_comando
  --if @w_error <> 0 begin
  --    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
  --    goto ERROR_FIN
  --end

  ----------------------------------------
  --Generar Archivo de Datos
  ----------------------------------------

  delete cl_temporal_datos_trn
  where  fecha_mod = @i_fecha

  if @@error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg = 'ERROR ELIMINANDO DATOS EN cl_temporal_datos_trn '
    goto ERROR_FIN
  end

  insert into cl_temporal_datos_trn
              (oficina,des_oficina,cliente,clase,usuario,
               fecha_mod,nombre,p_apellido,s_apellido,tipo_ced,
               ced_ruc,fecha_emision,fecha_nac)
    select
      en_oficina,of_nombre,ts_ente,ts_clase,ts_usuario,
      ts_fecha,ts_nombre,ts_p_apellido,ts_s_apellido,ts_tipo_ced,
      ts_cedruc,ts_fecha_emision,ts_fecha_nac
    from   cobis..cl_tran_servicio (nolock),
           cobis..cl_ente (nolock),
           cobis..cl_oficina
    where  ts_fecha   = @i_fecha
       and ts_tipo_transaccion in(186, 187)
       -- transacciones de query para actualizacion critica  y actualizacion critica respectivamente
       and ts_ente    = en_ente
       and en_oficina = of_oficina

  if @@error <> 0
  begin
    select
      @w_error = 2902797,
      @w_msg = 'ERROR EN INSERCION DE DATOS EN cl_temporal_datos_trn '
    goto ERROR_FIN
  end

  select
    @w_comando =
                 @w_s_app +
                 's_app bcp -auto -login cobis..cl_temporal_datos_trn out '

  select
    @w_destino = @w_path + 'cl_temporal.txt',
    @w_errores = @w_path + 'cl_temporal.err'

  select
    @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                 ' -t"|" '
                                                                     +
                 '-config '
                                                                     + @w_s_app
                 + 's_app.ini'

  --exec @w_error = xp_cmdshell @w_comando
  --if @w_error <> 0 begin
  --   print 'Error Generando Archivo cl_temporal_datos_trn '
  --   return @w_error
  --end

  --------------------------------------------------------------
  --Uni¢n de archivo @w_nombre_plano con archivo cl_temporal.txt
  --------------------------------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path + 'cl_temporal.txt'
                 +
                        ' ' +
                        @w_nombre_plano

  --exec @w_error = xp_cmdshell @w_comando
  --if @w_error <> 0 begin
  --    select @w_error = 2902797, @w_msg = 'EJECUCION comando bcp FALLIDA. REVISAR ARCHIVOS DE LOG GENERADOS.'
  --    goto ERROR_FIN
  --end

  return 0

  ERROR_FIN:

  select
    @w_msg = @w_sp_name + ' --> ' + @w_msg
  print @w_msg

  return 1

go

