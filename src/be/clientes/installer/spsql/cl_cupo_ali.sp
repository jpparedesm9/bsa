/************************************************************************/
/*  Archivo:                         cl_cupo_ali.sp                     */
/*  Stored procedure:                sp_cupo_global                     */
/*  Base de datos:                   cobis                              */
/*  Producto:                        Cobis                              */
/*  Disenado por:                    Luisa Bernal                       */
/*  Fecha de escritura:              20-Jun-2014                        */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*Calcular creditos vigentes y saldos a la fecha de los clientes con    */
/*alianzas comerciales                                                  */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  May/02/2016     DFu             Migracion CEN                       */
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
           where  name = 'sp_cupo_global')
  drop proc sp_cupo_global
go

create proc sp_cupo_global
--(@i_param1            varchar(255)    --Fecha de Proceso)
(
  @t_show_version bit = 0
)
as
  declare
    @i_fecha          datetime,
    @w_sp_name        varchar(20),
    @w_slm            money,
    @w_s_app          varchar(50),
    @w_path           varchar(50),
    @w_nombre_archivo varchar(18),
    @w_cmd            varchar(255),
    @w_destino        varchar(2500),
    @w_errores        varchar(1500),
    @w_error          int,
    @w_comando        varchar(2500),
    @w_nombre_plano   varchar(1500),
    @w_mensaje        varchar(200),
    @w_msg            varchar(200),
    @w_col_id         int,
    @w_columna        varchar(30),
    @w_cabecera       varchar(2500),
    @w_alianza        varchar(100)

  select
    @w_sp_name = 'sp_cupo_global'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_fecha = (select
                  fp_fecha
                from   cobis..ba_fecha_proceso)
  --convert(datetime,   @i_param1)

  -- parametro kernel
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_batch = 2154

  if exists(select
              1
            from   cobis..sysobjects
            where  name = 'cl_cupo_global')
    drop table cl_cupo_global

  --Reporte Diario

  --1. datos de la alianza y armar la tabla en estructura
  select
    rc_fecha = (select top 1
                  fp_fecha
                from   cobis..ba_fecha_proceso),
    rc_alianza = al_alianza,
    rc_nit = en_ced_ruc,
    rc_nombre = al_nom_alianza,
    rc_cupo = al_monto_alianza,
    rc_creditos = convert(int, 0),
    rc_valor = convert(money, 0)
  into   #temp_cl_cupo_global
  from   cobis..cl_ente with (nolock),
         cobis..cl_alianza with (nolock)
  where  en_ente   = al_ente
     and al_estado = 'V'
  group  by al_alianza,
            en_ced_ruc,
            al_nom_alianza,
            al_monto_alianza

  --2. calcular cantidad de creditos y sumatoria de saldos
  select
    alianza=rc_alianza,
    num = (select
             count(distinct tr_tramite)),
    valor = (sum(am_cuota + am_gracia - am_pagado))
  into   #temp_saldos
  from   cob_credito..cr_tramite with (nolock),
         cob_cartera..ca_operacion with (nolock),
         cob_cartera..ca_amortizacion with (nolock),
         cob_cartera..ca_rubro_op with (nolock),
         #temp_cl_cupo_global
  where  tr_alianza    = rc_alianza
     and tr_estado     <> 'Z'
     and tr_tramite    = op_tramite
     and op_estado in (1, 2, 4, 9)
     and op_naturaleza <> 'P'
     and ro_tipo_rubro = 'C'
     and op_operacion  = am_operacion
     and ro_operacion  = am_operacion
     and ro_concepto   = am_concepto
  group  by rc_alianza

  --3. actualizar cantidad de creditos y saldos
  update #temp_cl_cupo_global
  set    rc_creditos = num,
         rc_valor = valor
  from   #temp_saldos
  where  rc_alianza = alianza

  select
    FECHA = rc_fecha,
    NIT = rc_nit,
    NOMBRE_ALIANZA = rc_nombre,
    CREDITOS = rc_creditos,
    CUPO_GLOBAL = rc_cupo,
    SALDOS = rc_valor
  into   cl_cupo_global
  from   #temp_cl_cupo_global

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_col_id = 0,
    @w_columna = '',
    @w_cabecera = convert(varchar(2000), ''),
    @w_nombre_archivo = 'Cupos_Alianzas'

  select
    @w_nombre_plano =
       @w_path + @w_nombre_archivo + '_' + convert(varchar(2),
       datepart(dd, @i_fecha))
       + '_'
                      + convert(varchar(2), datepart(mm, @i_fecha)) + '_'
                      + convert(varchar(4), datepart(yyyy, @i_fecha)) + '.txt'

  while 1 = 1
  begin
    set rowcount 1
    select
      @w_columna = c.name,
      @w_col_id = c.colid
    from   cobis..sysobjects o,
           cobis..syscolumns c
    where  o.id    = c.id
       and o.name  = 'cl_cupo_global'
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

  --Escribir Cabecera

  select
    @w_cabecera = left(@w_cabecera,
                       datalength(@w_cabecera) - 2)

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
    @w_comando = @w_s_app + 's_app bcp -auto -login cobis..cl_cupo_global out '

  select
    @w_destino = @w_path + 'cl_cupo_global.txt',
    @w_errores = @w_path + 'cl_cupo_global.err'

  select
    @w_comando = @w_comando + @w_destino + ' -b5000 -c -e' + @w_errores +
                 ' -t"|" '
                                                                        +
                 '-config '
                                                                        +
                 @w_s_app
                 + 's_app.ini'

  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    if exists(select
                1
              from   cobis..sysobjects
              where  name = 'cl_cupo_global')
      drop table cl_cupo_global

    print 'Error Generando Archivo cl_cupo_global '
    return @w_error
  end

  ----------------------------------------
  --Union de archivo @w_nombre_plano con archivo cl_cupo_global.txt
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                 'cl_cupo_global.txt'
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

  if exists(select
              1
            from   cobis..sysobjects
            where  name = 'cl_cupo_global')
    drop table cl_cupo_global

  return 0

  ERRORFIN:

  select
    @w_mensaje = @w_sp_name + ' --> ' + @w_mensaje
  print @w_mensaje

  return 1

go

