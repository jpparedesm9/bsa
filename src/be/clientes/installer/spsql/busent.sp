/************************************************************************/
/*    Archivo:              busent.sp                                   */
/*    Stored procedure:     sp_busqueda_entidades_externas              */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Jaime Loyo Holguin                          */
/*    Fecha de escritura:   21-Jul-1998                                 */
/************************************************************************/
/*                IMPORTANTE                                            */
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
/*                PROPOSITO                                             */
/*    Este programa procesa las transacciones del stored procedure      */
/*    Un stored procedure que no realiza nada, se utiliza para la       */
/*    activacion de botones ede busqueda en otras entidades externas    */
/*    como cifin, datacredito                                           */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA         AUTOR        RAZON                                  */
/*    21/Jul/98     J. Loyo        Emision Inicial                      */
/*    May/02/2016   DFu            Migracion CEN                        */
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
           where  name = 'sp_busqueda_entidades_externas')
  drop proc sp_busqueda_entidades_externas
go

create proc sp_busqueda_entidades_externas
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1) = null,
  @i_ente         int = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_codigo  int,
    @w_return  int

  select
    @w_sp_name = 'sp_busqueda_entidades_externas'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1298
  begin
    return 0
  end

go

