/************************************************************************/
/*      Archivo:                errorlog.sp                             */
/*      Stored procedure:       sp_errorlog                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Laguna                             */
/*      Fecha de documentacion: 15/05/2001                              */
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
/*      Este script crea los procedimientos para las inserciones        */
/*      de errores generados por los procesos batch                     */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA         AUTOR           RAZON                             */
/*      15-May-2001   E. Laguna       Emision Inicial                   */
/*      04/May/2016   T. Baidal       Migracion a CEN                   */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select * from sysobjects where name = 'sp_errorlog')
    drop proc sp_errorlog
go

create proc sp_errorlog
  @t_show_version bit = 0,
  @i_fecha        datetime,
  @i_error        int,
  @i_usuario      login,
  @i_tran         int,
  @i_tran_name    descripcion,
  @i_rollback     char(1),
  @i_cuenta       cuenta=null,
  @i_descripcion  varchar(255) = null
as
  declare
    @w_aux     int,
    @w_err_msg varchar(255),
    @i_sev     int,
    @w_sp_name varchar(30)

  select
    @w_sp_name = 'sp_se_ente_ofi'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_aux = @@trancount

  if @i_rollback = 'S'
    while @@trancount > 0
      rollback

  select
    @i_descripcion = isnull(@i_descripcion,
                            ''),
    @i_tran_name = isnull(@i_tran_name,
                          ''),
    @w_err_msg = isnull(@w_err_msg,
                        '')

  select
    @w_err_msg = @i_descripcion + ' ' + @i_tran_name + ' ' + @w_err_msg

  insert into cl_error_log
              (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
               er_descripcion)
  values     (@i_fecha,@i_error,@i_usuario,@i_tran,@i_cuenta,
              @w_err_msg)
  if @i_rollback = 'S'
    while @@trancount < @w_aux
      begin tran

  return

go

