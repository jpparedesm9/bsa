/************************************************************************/
/*    Archivo:                cl_registro_dll.sp                        */
/*    Stored Procedure:       sp_registro_dll                           */
/*    Base de datos:          cobis                                     */
/*    Disenado por:           Jose Julian Cortes                        */
/*    Fecha de escritura:     01/10/2013                                */
/*    Producto:               Clientes                                  */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                            PROPOSITO                                 */
/*   Generar reporte de procesos masivos para los errores encontrados   */
/*   en la creacion de Clientes, Tramites y Desembolsos                 */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA                    AUTOR               RAZON                */
/*  01/10/2013                 Jose Cortes       Emision Inicial        */
/*  02//016                    DFu               Migracion CEN          */
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
           where  name = 'sp_registro_dll')
  drop proc sp_registro_dll
go

create proc sp_registro_dll
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name varchar(32),/* NOMBRE STORED PROC*/
    @w_msg     varchar(124),
    @w_error   int,
    @w_comando varchar(1000)

  select
    @w_sp_name = 'sp_registro_dll'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* QUITA EL REGISTRO  SysWow64 */
  select
    @w_comando = 'regsvr32 -u C:\WINDOWS\SysWOW64\BClientes.dll -s'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /* QUITA EL REGISTRO  System32 */
  select
    @w_comando = 'regsvr32 -u C:\WINDOWS\system32\BClientes.dll -s'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /* RENOMBRA ARCHIVO DDL  SysWow64 */
  select
    @w_comando = 'rename C:\WINDOWS\SysWOW64\BClientes.dll BClientes_old.dll'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /*    RENOMBRA ARCHIVO DDL  System32 */
  select
    @w_comando = 'rename C:\WINDOWS\system32\BClientes.dll BClientes_old.dll'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /* Copia Archivo DLL desde F:\Bancamia  SysWow64 */
  select
    @w_comando =
           'copy F:\Bancamia\BClientes.dll C:\WINDOWS\SysWOW64\BClientes.dll /Y'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /* Copia Archivo DLL desde F:\Bancamia System32 */
  select
    @w_comando =
           'copy F:\Bancamia\BClientes.dll C:\WINDOWS\system32\BClientes.dll /Y'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /* COLOCA DE NUEVO EL REGISTRO SysWow64 */
  select
    @w_comando = 'regsvr32 -v C:\WINDOWS\SysWOW64\BClientes.dll -s'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  /* COLOCA DE NUEVO EL REGISTRO System32 */
  select
    @w_comando = 'regsvr32 -v C:\WINDOWS\system32\BClientes.dll -s'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'Error Generando Ejecucion' + @w_comando
    goto ERRORFIN
  end

  return 0

  ERRORFIN:
  exec cobis..sp_error_proc_masivos
    @i_referencia     = 'No_Id',
    @i_tipo_proceso   = 'C',
    @i_procedimiento  = @w_sp_name,
    @i_codigo_interno = 0,
    @i_codigo_err     = @w_error,
    @i_descripcion    = @w_msg

  return 1

go

