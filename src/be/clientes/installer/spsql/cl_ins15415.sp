/************************************************************************/
/*    Archivo:             cl_ins15415.sp                               */
/*    Stored procedure:    sp_sincroniza_bal                            */
/*    Base de datos:       cobis                                        */
/*    Producto:            MIS                                          */
/*    Disenado por:        Patricia Garzon Rojas                        */
/*    Fecha de escritura:  Nov 1999                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_sincroniza_bal')
  drop proc sp_sincroniza_bal
go

create proc sp_sincroniza_bal
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name  char(30),
    @w_ente     int,
    @w_cabecera int,
    @w_detalle  int,
    @w_total    int

  select
    @w_sp_name = 'sp_sincroniza_bal'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_ente = 0
  select
    @w_cabecera = 0
  select
    @w_detalle = 0
  select
    @w_total = 0

  select
    ba_cliente,
    'ba_balance'=max(ba_balance)
  into   #tmp_balance_ela
  from   cobis..cl_balance
  group  by ba_cliente

  select
    pl_cliente,
    'pl_balance'=max(pl_balance)
  into   #tmp_plan_ela
  from   cobis..cl_plan
  group  by pl_cliente

  select
    ba_cliente,
    'cabecera'=ba_balance,
    'detalle'=pl_balance
  into   #tmp_unifica_ela
  from   #tmp_balance_ela,
         #tmp_plan_ela
  where  ba_cliente = pl_cliente
     and ba_balance <> pl_balance
  order  by ba_cliente

  select
    @w_total = count(0)
  from   #tmp_unifica_ela
  select
    'Registros a procesar   ' + cast(@w_total as varchar)

  while 1 = 1
  begin
    set rowcount 1

    select
      @w_ente = ba_cliente,
      @w_cabecera = cabecera,
      @w_detalle = detalle
    from   #tmp_unifica_ela
    where  ba_cliente > @w_ente

    if @@rowcount = 0
      break

    print 'DATOS A BORRAR (PLANES SIN BALANCE):'
    set rowcount 0

    delete cl_plan
    where  pl_cliente = @w_ente
       and pl_balance > @w_cabecera

    print 'En el borrado ente ' + cast(@w_ente as varchar)
    print 'En el borrado cabecera ' + cast(@w_cabecera as varchar)

    update cobis..cl_ente
    set    en_balance = @w_cabecera
    where  en_ente = @w_ente

    print 'actualizando ente ' + cast(@w_ente as varchar)
    print 'balances ' + cast(@w_cabecera as varchar)

    SIGUIENTE:
  end

go

