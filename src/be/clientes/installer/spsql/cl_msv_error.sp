/************************************************************************/
/*  Archivo           :   cl_msv_error.sp                               */
/*  Stored procedure  :   sp_error_proc_masivos                         */
/*  Base de datos     :   cobis                                         */
/*  Producto          :   Clientes                                      */
/*  Disenado por      :   Luis Ponce                                    */
/*  Fecha de escritura:   24/May/2013                                   */
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
/*  Este programa registra los errores de los procesos masivos: creacion*/
/*  de clientes, tramites C,O,T,U , Novedades, Desembolsos automaticos  */
/*  etc del proceso de Alianzas Comerciales.                            */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR      RAZON                                      */
/*  May/02/2016   DFu        Migracion CEN                              */
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
           where  name = 'sp_error_proc_masivos')
  drop proc sp_error_proc_masivos
go

create proc sp_error_proc_masivos
  @t_show_version   bit = 0,
  @i_id_carga       int = null,
  @i_id_alianza     int = null,
  @i_referencia     varchar (30) = null,
  @i_tipo_proceso   char(1) = null,
  @i_procedimiento  varchar(30) = null,
  @i_codigo_interno int = null,
  @i_codigo_err     int = null,
  @i_descripcion    varchar(255) = null
as
  declare @w_sp_name char(30)

  select
    @w_sp_name = 'sp_error_proc_masivos'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  insert into ca_msv_error
              (me_fecha,me_id_carga,me_id_alianza,me_referencia,me_tipo_proceso,
               me_procedimiento,me_codigo_interno,me_codigo_err,me_descripcion)
  values      (getdate(),@i_id_carga,@i_id_alianza,@i_referencia,@i_tipo_proceso
               ,
               @i_procedimiento,@i_codigo_interno,@i_codigo_err,
               @i_descripcion )

  return 0

go

