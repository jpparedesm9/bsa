/************************************************************************/
/*   Stored procedure:     sp_valor_otros                               */
/*   Base de datos:        cobis                                        */
/************************************************************************/
/*                                  IMPORTANTE                          */
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
/*                            PROPOSITO                                 */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA       AUTOR             RAZON                                 */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_valor_otros')
  drop proc sp_valor_otros
go

create proc sp_valor_otros
(
  @t_show_version bit = 0,
  @i_ente         int,
  @i_tipo         varchar(10) = null,
  @o_vlr_oi       money = null out,
  @o_vlr_bienes   money = null out
)
as
  declare @w_sp_name varchar(20)

  select
    @w_sp_name = 'sp_valor_otros'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @i_ente = @i_ente
  from   cobis..cl_ente X
  where  en_ente = @i_ente

  if @@rowcount = 0
  begin
    -- No existe el cliente indicado

    exec cobis..sp_cerror
      @t_from = @w_sp_name,
      @i_num  = 101129

    return 101129

  end

  select
    @o_vlr_oi = sum(oi_valor)
  from   cobis..cl_otros_ingresos
  where  oi_ente = @i_ente

  if @o_vlr_oi is null
    select
      @o_vlr_oi = 0

  select
    @o_vlr_bienes = sum(pr_valor)
  from   cobis..cl_propiedad
  where  pr_persona = @i_ente

  if @o_vlr_bienes is null
    select
      @o_vlr_bienes = 0

  return 0

go

