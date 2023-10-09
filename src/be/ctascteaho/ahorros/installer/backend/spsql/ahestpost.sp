/************************************************************************/
/*  Archivo:            ahestpost.sp                                    */
/*  Stored procedure:   sp_ahestpost                                    */
/*  Base de datos:      cob_ahorros                                     */
/*  Producto:           Cuentas de Ahorros                              */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*      Listado de cotejo para cuadre de estados de cuenta de ahorros   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR           RAZON                                   */
/*  10/05/2006  Oliver          Emision Inicial                         */
/*  05/Ago/2006 Pedro Coello    Incluir parametro de programa para que  */
/*                              coincida con estados de cuenta emitidos */
/*  01/Nov/2006 Pedro Coello    PONER DEFALT DE CAMPOS DE LA TABLA      */
/*                              TEMPORAL EN NULO                        */
/*  02/May/2016 Ignacio Yupa    Migración a CEN                         */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   cob_ahorros..sysobjects
           where  name = 'sp_ahestpost')
  drop proc sp_ahestpost
go

if exists (select
             1
           from   tempdb..sysobjects
           where  name = 'tmpcasilla')
  drop table tempdb..tmpcasilla
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

/*****
create table tempdb..tmpcasilla(
cta_banco varchar(12),
nombre varchar(60),
apartado varchar(60),
zona varchar(60),
provincia varchar(60),
saldo_ant   money)
****/
--go

create proc sp_ahestpost
(
  @t_show_version  bit = 0,
  @i_fecha_proceso datetime = null,
  @i_oficina_ini   int = 0,
  @i_oficina_fin   int = 999
)
as
  declare
    @w_sp_name      varchar(30),
    @cuenta         varchar(12),
    @nombre         varchar(60),
    @apartado       varchar(120),
    @zona           varchar(60),
    @provincia      varchar(60),
    @descripcion_ec varchar(120),
    @saldo_ant      money,
    @pos1           int,
    @pos2           int

  /*  Captura nombre de Stored Procedure  */
  select
    @w_sp_name = 'sp_ahestpost'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if exists (select
               1
             from   tempdb..sysobjects
             where  name = 'tmpcasilla')
    drop table tempdb..tmpcasilla

  create table tempdb..tmpcasilla
  (
    cta_banco varchar(12),
    nombre    varchar(60),
    apartado  varchar(120),
    zona      varchar(60) null,
    provincia varchar(60) null,
    saldo_ant money
  )

  declare cr_casilla cursor for
    select
      ah_cta_banco,
      ah_nombre,
      ah_descripcion_ec,
      ah_saldo_ult_corte
    from   cob_ahorros..ah_estado_cta,
           cob_ahorros..ah_cuenta
    where  ec_fecha_prx_corte = @i_fecha_proceso
       and ec_cta_banco       = ah_cta_banco
       and ah_estado_cuenta   = 'S'
       and ah_tipo_dir in ('C', 'D')
       and ec_oficina         >= @i_oficina_ini
       and ec_oficina         <= @i_oficina_fin

  open cr_casilla
  fetch cr_casilla into @cuenta, @nombre, @descripcion_ec, @saldo_ant

  while @@fetch_status <> -2
  begin
    select
      @zona = ''
    select
      @apartado = ''
    select
      @provincia = ''
    select
      @pos1 = 0
    select
      @pos1 = patindex('%|%',
                       @descripcion_ec)

    if @pos1 <> 0
    begin
      select
        @pos2 = @pos1 - 1
      select
        @apartado = substring(@descripcion_ec,
                              1,
                              @pos2)
      select
        @descripcion_ec = substring(@descripcion_ec,
                                    @pos2 + 2,
                                    120 - @pos2)
    end
    else
    begin
      select
        @apartado = @descripcion_ec
      --PCOELLO ESTO POR LAS DIRECCIONES EXTRANJERAS
      goto grabar_blanco
    end

    select
      @descripcion_ec = ltrim(rtrim(@descripcion_ec))

    select
      @pos1 = patindex('%|%',
                       @descripcion_ec)

    if @pos1 <> 0
    begin
      select
        @pos2 = @pos1 - 1
      select
        @zona = substring(@descripcion_ec,
                          1,
                          @pos2)
      select
        @descripcion_ec = substring(@descripcion_ec,
                                    @pos2 + 2,
                                    120 - @pos2)
    end
    else
    begin
      select
        @zona = ''
    end

    select
      @provincia = @descripcion_ec

    grabar_blanco:

    insert into tempdb..tmpcasilla
    values     (@cuenta,@nombre,@apartado,@zona,@provincia,
                @saldo_ant)

    fetch cr_casilla into @cuenta, @nombre, @descripcion_ec, @saldo_ant
  end

  close cr_casilla
  deallocate cr_casilla

  return 0

go

