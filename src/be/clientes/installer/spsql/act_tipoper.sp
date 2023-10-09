/************************************************************************/
/*   Stored procedure:     sp_act_tipoper                               */
/*   Base de datos:        cobis                                        */
/************************************************************************/
/*                                  IMPORTANTE                          */
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
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA                    AUTOR                       RAZON           */
/* 02/may/2016              DFu                  Migracion CEN          */
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
           where  name = 'sp_act_tipoper')
  drop proc sp_act_tipoper
go

create proc sp_act_tipoper
(
  @t_show_version bit = 0
)
as
  declare @w_sp_name char(30)

  select
    @w_sp_name = 'sp_act_tipoper'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  print ' Datos de el campo tipo de persona '
  select
    p_tipo_persona,
    count(*)
  from   cobis..cl_ente
  group  by p_tipo_persona

  print ' Actualizacion de tipo_persona = 1'

  update cobis..cl_ente
  set    p_tipo_persona = '001'
  where  p_tipo_persona = '1'

  if @@error <> 0
  begin
    print 'Error en Actualizacion de p_tipo_persona'
  end

  print 'Registros procesados ' + cast(@@rowcount as varchar)

  return 0

go

