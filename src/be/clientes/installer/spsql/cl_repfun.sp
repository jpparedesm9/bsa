/************************************************************************/
/*  Archivo:                         cl_repfun.sp                       */
/*  Stored procedure:                sp_reporte_func                    */
/*  Base de datos:                   cobis                              */
/*  Producto:                        Clientes                           */
/*  Disenado por:                    Myriam Davila                      */
/*  Fecha de escritura:              27-Jul-1998                        */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*  Generar BCPS de tablas consultas de funcionarios                    */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*  FECHA       AUTOR                    RAZON                          */
/*  10/04/2012  Alfredo Zuluaga          Emision Inicial                */
/*  May/02/2016 DFu                      Migracion CEN                  */
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
           where  name = 'sp_reporte_func')
  drop proc sp_reporte_func
go

create proc sp_reporte_func
(
  @t_show_version bit = 0,
  @i_param1       varchar(255) --Fecha de Proceso
)
as
  declare
    @i_fecha        datetime,
    @w_periodicidad varchar(1),
    @w_sp_name      varchar(20),
    @w_fecha_ant    datetime,
    @w_slm          money,
    @w_s_app        varchar(50),
    @w_path         varchar(50),
    @w_nombre       varchar(14),
    @w_nombre_cab   varchar(18),
    @w_cmd          varchar(255),
    @w_destino      varchar(2500),
    @w_errores      varchar(1500),
    @w_error        int,
    @w_comando      varchar(2500),
    @w_nombre_plano varchar(1500),
    @w_mensaje      varchar(200),
    @w_msg          varchar(200),
    @w_col_id       int,
    @w_columna      varchar(30),
    @w_cabecera     varchar(2500),
    @w_pagare       varchar(14),
    @w_cod_gar_fag  varchar(10),--LCM
    @w_cod_gar_usad varchar(10),--LCM
    @w_cod_gar_fng  varchar(10) --LCM

  select
    @w_sp_name = 'sp_reporte_func'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha = convert(datetime, @i_param1)

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 2022

  select
    @w_nombre = 'FUNCIONARIOS'

  truncate table cl_reporte_func

  select
    fecha_proceso = @i_param1,
    nombre_funcionario = fu_nombre,
    cedula_funcionario = fu_nomina,
    codigo_oficina = fu_oficina,
    nombre_oficina = (select top 1
                        of_nombre
                      from   cobis..cl_oficina
                      where  of_oficina = x.fu_oficina),
    estado_login = fu_estado,
    nodo_asignado = convert(varchar, nl_oficina) + ' '
                    + (select
                         of_nombre
                       from   cobis..cl_oficina
                       where  of_oficina = y.nl_oficina)
                    + ' --> ' + convert(varchar, nl_nodo) + ' -- ' + nl_nombre,
    cargo = convert(varchar(255), (select top 1
                                     b.codigo + ' - ' + b.valor
                                   from   cobis..cl_tabla a,
                                          cobis..cl_catalogo b
                                   where  a.tabla  = 'cl_cargo'
                                      and a.codigo = b.tabla
                                      and b.codigo = x.fu_cargo))
  into   #temporal
  from   cobis..cl_funcionario x,
         cobis..ad_usuario,
         cobis..ad_nodo_oficina y
  where  fu_login = us_login
     and us_nodo  = nl_nodo
  order  by fu_oficina,
            fu_nombre

  insert into cl_reporte_func
    select
      *
    from   #temporal

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), ''),
    @w_nombre_cab = @w_nombre + '_CAB'

  select
    @w_nombre_plano =
       @w_path + @w_nombre_cab + '_' + convert(varchar(2), datepart (
       dd, @i_fecha )) +
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
       and o.name  = 'cl_reporte_func'
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
    goto ERRORFIN
  end

  --Ejecucion para Generar Archivo Datos

  select
    @w_comando = @w_s_app + 's_app bcp -auto -login cobis..cl_reporte_func out '

  select
    @w_destino = @w_path + 'cl_reporte_func.txt',
    @w_errores = @w_path + 'cl_reporte_func.err'

  select
       @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                    ' -t"|" '
                    + '-config '
                    + @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    print 'Error Generando Archivo cl_reporte_func '
    return @w_error
  end

  ----------------------------------------
  --Uni�n de archivo @w_nombre_plano con archivo cl_reporte_func.txt
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                 'cl_reporte_func.txt'
                        + ' ' +
                        @w_nombre_plano

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
    goto ERRORFIN
  end

  return 0

  ERRORFIN:

  select
    @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje
  print @w_mensaje

  return 1

go

