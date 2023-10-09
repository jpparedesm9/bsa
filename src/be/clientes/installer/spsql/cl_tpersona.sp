/* ***********************************************************************/
/*      Archivo:                cl_aplica_tpersona.sp                    */
/*      Stored procedure:       sp_aplica_tpersona                       */
/*      Base de datos:          cobis                                    */
/*      Producto:               Clientes                                 */
/*      Disenado por:           Erika Alvarez                            */
/*      Fecha de escritura:     04-Feb-2009                              */
/* ***********************************************************************/
/*                       IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad         */
/*  de 'COBISCorp'.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como     */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus     */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.    */
/*  Este programa esta protegido por la ley de   derechos de autor       */
/*  y por las    convenciones  internacionales   de  propiedad inte-     */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir         */
/*  penalmente a los autores de cualquier   infraccion.                  */
/*************************************************************************/
/*                       PROPOSITO                                       */
/*  Permite seleccionar los objetos que son obligatorios de acuerdo al   */
/*  tipo de persona                                                      */
/*************************************************************************/
/*                 MODIFICACIONES                                        */
/*       FECHA          AUTOR            RAZON                           */
/*     14-Abr-2008    A. Correa        Emision inicial                   */
/*     02/Mayo/2016     Roxana Sánchez       Migración a CEN             */
/* ***********************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_aplica_tpersona')
  drop proc sp_aplica_tpersona
go

create proc sp_aplica_tpersona
(
  @s_ofi          smallint,
  @t_debug        char(1) = null,
  @t_file         varchar(10)= null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_tipo         char(1),
  @i_tpersona     char(3)
)
as
  declare
    @w_sp_name    descripcion,
    @w_cargo      smallint,
    @w_debug      char(1),
    @w_t_objeto   char(1),
    @w_nom_objeto char(30),
    @w_aplica     char(1)

  select
    @w_sp_name = 'sp_aplica_tpersona'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'C'
  begin
    set rowcount 0
    select
      '@w_t_objeto' = atp_t_objeto,
      '@w_nom_objeto' = atp_nom_objeto
    from   cl_aplica_tipo_persona
    where  atp_tipo     = @i_tipo
       and atp_tpersona = @i_tpersona
       and atp_t_objeto = 'C'
       and atp_aplica   = 'S'
    order  by atp_secuencia

  end

  if @i_operacion = 'P'
  begin
    set rowcount 0

    select
      '@w_nom_objeto' = atp_nom_objeto,
      'Aplica' = atp_aplica
    from   cl_aplica_tipo_persona
    where  atp_tipo     = @i_tipo
       and atp_tpersona = @i_tpersona
       and atp_t_objeto = 'P'
    order  by atp_secuencia

  end

  return 0

go

