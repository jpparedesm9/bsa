/************************************************************************/
/*   Archivo:              aherrlog.sp                                  */
/*   Stored procedure:     sp_errorlog                                  */
/*   Base de datos:        cob_ahorros                                  */
/*   Producto:             Ahorros                                      */
/*   Fecha de escritura:                                                */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCorp'                                                        */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCorp o su representante.             */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA            AUTOR           RAZON                             */
/*   04/May/2016      J. Salazar      Migracion COBIS CLOUD MEXICO      */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_errorlog')
  drop proc sp_errorlog
go

/****** Object:  StoredProcedure [dbo].[sp_errorlog]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_errorlog
(
  @t_show_version bit = 0,
  @i_fecha        datetime = null,
  @i_error        int,
  @i_usuario      login,
  @i_tran         int,
  @i_cuenta       varchar(24) = null,
  @i_descripcion  mensaje = null,
  @i_cta_pagrec   varchar(24) = null,
  @i_programa     varchar(24) = null,
  @i_rollback     char(1) = 'N'
)
as
  declare
    @w_aux     int,
    @w_err_msg varchar(255),
    @w_sp_name varchar(30)

  /* Captura nombre de stored procedure */
  select
    @w_sp_name = 'sp_errorlog'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  select
    @w_aux = @@trancount

  if @i_rollback = 'S'
    while @@trancount > 0
      rollback

  if @i_descripcion is null
    select
      @i_descripcion = mensaje
    from   cobis..cl_errores with (nolock)
    where  numero = @i_error
  set transaction isolation level read uncommitted

  insert ah_errorlog
         (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
          er_descripcion,er_cta_pagrec,er_programa)
  values (@i_fecha,@i_error,@i_usuario,@i_tran,@i_cuenta,
          @i_descripcion,@i_cta_pagrec,@i_programa)

  if @i_rollback = 'S'
    while @@trancount < @w_aux
      begin tran

  return 0

go

