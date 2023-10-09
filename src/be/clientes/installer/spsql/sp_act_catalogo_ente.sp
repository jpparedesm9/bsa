/************************************************************************/
/*      Archivo:                sp_act_catalogo_ente.sp                 */
/*      Stored procedure:       sp_act_catalogo_ente                    */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Mario Algarin                           */
/*      Fecha de escritura:     16-ene-2013                             */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa actualiza con valores por default, informacion    */
/*      del cliente que no nos llega desde los dispositivos DMO.        */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
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
           where  name = 'sp_act_catalogo_ente')
           drop proc sp_act_catalogo_ente
go

create proc sp_act_catalogo_ente
(
  @t_show_version bit = 0,
  @i_param1       datetime -- Fecha Proceso
)
as
  declare
    @w_sector            varchar(10),
    @w_actividad         varchar(10),
    @w_situacion_cliente varchar(10),
    @w_fecha             datetime,
    @w_error             int,
    @w_msg               varchar(255),
    @w_sp_name           varchar(30)

  select
    @w_sp_name = 'sp_act_catalogo_ente'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_param1 is null
  begin
    --Falta parametro obligatorio
    exec cobis..sp_cerror
      @i_num = 101114

    select
      @w_error = 101114,
      @w_msg = 'Falta parametro obligatorio'
    goto ERROR
  end

  select
    @w_fecha = @i_param1

  /* DATOS DE CATALOGO DEFAULT */
  select
    @w_sector = '000010',
    @w_actividad = '001000',
    @w_situacion_cliente = 'NOR'

  /* GENERACION DE UNIVERSO DE CLIENTES SIN DATOS EN CATALOGOS */
  select
    en_ente,
    en_sector,
    en_actividad,
    en_situacion_cliente,
    en_oficial,
    en_fecha_mod = convert(varchar(10), getdate(), 101)
  into   #tmp_ente
  from   cobis..cl_ente
  where  en_sector is null
      or en_actividad is null
      or en_situacion_cliente is null
  order  by en_ente

  if @@error <> 0
  begin
    select
      @w_error = 703105,
      @w_msg =
'Error Al Crear el Tabla Temporal de Clientes con Datos Incompletos en Catalogo'
  goto ERROR
end

  /* INGRESO DE DATOS AL LOG CON EL UNIVERSO DE CLIENTES ANTES DE ACTUALIZAR */
  insert into cl_act_catalogo_ente_log
              (en_ente,en_sector,en_actividad,en_situacion_cliente,en_oficial,
               en_fecha_mod)
    select
      en_ente,en_sector,en_actividad,en_situacion_cliente,en_oficial,
      en_fecha_mod
    from   #tmp_ente

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'Error Al Insertar Datos de Clientes sin datos en catalogo antes de Actualizar'
  goto ERROR
end

/* ACTUALIZACION DE UNIVERSO CON DATOS DE CATALOGO EN NULL POR LOS DATOS DEFAULT*/
  /* update en_sector / en_actividad / en_situacion_cliente */
  update #tmp_ente
  set    en_sector = case
                       when en_sector is null then @w_sector
                       else en_sector
                     end,
         en_actividad = case
                          when en_actividad is null then @w_actividad
                          else en_actividad
                        end,
         en_situacion_cliente = case
                                  when en_situacion_cliente is null then
                                  @w_situacion_cliente
                                  else en_situacion_cliente
                                end

  if @@error <> 0
  begin
    select
      @w_error = 105051,
      @w_msg =
    'Error Al Actualizar Informacion del Cliente del Universo seleccionado'
    goto ERROR
  end

  /* ACTUALIZACION MAESTRO CLIENTES A PARTIR DEL UNIVERSO DE DATOS DE CLIENTES SIN DATOS EN CATALOGOS */
  update cobis..cl_ente
  set    en_sector = C.en_sector,
         en_actividad = C.en_actividad,
         en_situacion_cliente = C.en_situacion_cliente
  from   #tmp_ente C,
         cobis..cl_ente E
  where  C.en_ente = E.en_ente

  if @@error <> 0
  begin
    select
      @w_error = 105051,
      @w_msg = 'Error Al Actualizar Informacion Mestro de Clientes'
    goto ERROR
  end

  /* INGRESO DE DATOS AL LOG CON EL UNIVERSO DESPUES DE ACTUALIZADO */
  insert into cl_act_catalogo_ente_log
              (en_ente,en_sector,en_actividad,en_situacion_cliente,en_oficial,
               en_fecha_mod)
    select
      en_ente,en_sector,en_actividad,en_situacion_cliente,en_oficial,
      en_fecha_mod
    from   #tmp_ente

  if @@error <> 0
  begin
    select
      @w_error = 201242,
      @w_msg =
'Error Al Insertar Datos de Clientes sin datos en catalogo Despues de Actualizar'
  goto ERROR
end

  fin:
  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'Operador',
    @i_tran        = 19041,
    @i_tran_name   = 'Actualizacion de clientes',
    @i_rollback    = 'S',
    @i_descripcion = @w_msg

  return @w_error

go

