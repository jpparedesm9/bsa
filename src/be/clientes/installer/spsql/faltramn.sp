/************************************************************************/
/*  Archivo:        faltramn.sp                                         */
/*  Stored procedure:   sp_falso_tran_menu                              */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:       Jenniffer Anaguano                              */
/*  Fecha de escritura:     10-Abr-2001                                 */
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
/*  Un stored procedure que no realiza nada                             */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  10/Abr/01   J.Anaguano  Emision Inicial                             */
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
           where  name = 'sp_falso_tran_menu') 
    drop proc sp_falso_tran_menu
go

create proc sp_falso_tran_menu
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
    @w_sp_name = 'sp_falso_tran_menu'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn = 1472
      or @t_trn = 1473
      or @t_trn = 1474
      or @t_trn = 1475
  begin
    return 0

  end
  if @t_trn = 1476
      or @t_trn = 1477
      or @t_trn = 1478
      or @t_trn = 1479
  begin
    return 0

  end
  if @t_trn = 1480
      or @t_trn = 1481
      or @t_trn = 1484
      or @t_trn = 1485
  begin
    return 0

  end
  if @t_trn = 1486
      or @t_trn = 1487
      or @t_trn = 1488
      or @t_trn = 1489
  begin
    return 0

  end
  if @t_trn = 1490
      or @t_trn = 1491
      or @t_trn = 1483
  begin
    return 0
  end

  /* ELA MAYO/2001 MENUS */

  if @t_trn = 1000
      or @t_trn = 1001
      or @t_trn = 1002
  begin
    return 0
  end

  if @t_trn = 1003
      or @t_trn = 1004
      or @t_trn = 1005
  begin
    return 0
  end

  if @t_trn = 1006
      or @t_trn = 1007
      or @t_trn = 198
      or @t_trn = 199 /* fuera de linea */
  begin
    return 0
  end

go

