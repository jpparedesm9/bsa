/************************************************************************/
/*  Archivo:        falprese.sp                                         */
/*  Stored procedure:   sp_falso_upd_presentado_por                     */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Sara Meza                                       */
/*              Jaime Loyo Holguin                                      */
/*  Fecha de escritura: 25-Oct-1996                                     */
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
/*  Este programa procesa las transacciones del stored procedure        */
/*  Un stored procedure que no realiza nada, se utiliza para la         */
/*  transaccion especial en actualizacion de cliente                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  25/Oct/96   S. Meza.    Emision Inicial                             */
/*              J. Loyo                                                 */
/*  04/May/2016 T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_falso_upd_presentado_por') 
    drop proc sp_falso_upd_presentado_por
go

create proc sp_falso_upd_presentado_por
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
    @w_sp_name = 'sp_falso_upd_presentado_por'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1306
  begin
    return 0

  end

  if @t_trn = 1100
  begin
    return 0

  end

  if @t_trn = 1101
  begin
    return 0

  end

go

