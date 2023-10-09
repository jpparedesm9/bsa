/************************************************************************/
/*  Archivo:        reset.sp                                            */
/*  Stored procedure:   sp_reset                                        */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 06-Nov-1992                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones inicializacion de los       */
/*  seqnos de la cl_perfil y cl_servicio                                */
/*                            MODIFICACIONES                            */
/*  FECHA       AUTOR       RAZON                                       */
/*  06/Nov/92   M. Davila   Emision Inicial                             */
/*  15/Ene/93   L. Carvajal Tabla de errores, variables                 */
/*                  de debug                                            */
/*  05/May/2016 T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_reset')
           drop proc sp_reset
go

create proc sp_reset
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0
)
as
  declare @w_sp_name varchar(30)

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_reset'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Inicializa la tabla cl_seqnos  */
  begin tran
  update cl_seqnos
  set    siguiente = 0
  where  tabla = 'cl_servicio'
  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101000
    /* 'Error al actualizar seqnos'*/
    return 1
  end
  else
    delete cl_servicio

  update cl_seqnos
  set    siguiente = 0
  where  tabla = 'cl_perfil'
  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101000
    /* 'Error al actualizar seqnos'*/
    return 1
  end
  else
    delete cl_perfil
  update cl_atributo
  set    at_maximo = null,
         at_minimo = null
  if @@error <> 0
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101000
    /* 'Error al actualizar atributos'*/
    return 1
  end

  commit tran

go

