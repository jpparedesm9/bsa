/************************************************************************/
/*   Archivo:       clposi.sp                                           */
/*   Stored procedure:   sp_cli_posicion                                */
/*   Base de datos:      cobis                                          */
/*   Producto: Clientes                                                 */
/*   Disenado por:  Mauricio Bayas/Sandra Ortiz                         */
/*   Fecha de documentacion: 10/Dic/1993                                */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/*   Este store procedure consulta:                                     */
/*      Los promedios de las cuentas que un cliente puede tener en      */
/*      ahorros y cuentas corrientes                                    */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*      10/Dic/93       R. Minga v.     documentacion                   */
/*                                      Habilitacion de consulta de     */
/*                                      ahorros y verificacion          */
/*      27/May/01       J.Anaguano Consulta de Cuentas de los miem      */
/*                       bros del grupo atrav‚s de tabla                */
/*                       cl_cliente_grupo                               */
/*      09/Ago/2004     E. Laguna       Tunning                         */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cli_posicion')
  drop proc sp_cli_posicion
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cli_posicion
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_cliente      int = null,
  @i_cuenta       cuenta = null,
  @i_es_grupo     char(1) = 'N'
)
as
  declare @w_sp_name varchar(32)

  select
    @w_sp_name = 'sp_cli_posicion'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /*  Seleahionar promedios de cuentas corrientes */
  if @i_es_grupo <> 'S'
  begin
    if @i_operacion = 'C'
    begin
      set rowcount 20
      if @i_modo = 0 --     se debe corregir
        select
          'Cuenta' = cc_cta_banco,
          'Producto' = 'CTE',
          'Mes 1' = cc_promedio1,
          'Mes 2' = cc_promedio2,
          'Mes 3' = cc_promedio3,
          'Mes 4' = cc_promedio4,
          'Mes 5' = cc_promedio5,
          'Mes 6' = cc_promedio6,
          'Promedio' = (isnull(cc_promedio1, 0) + isnull(cc_promedio2, 0) +
                        isnull
                        (
                        cc_promedio3, 0)
                        + isnull(cc_promedio4, 0) + isnull(cc_promedio5, 0) +
                        isnull
                        (
                        cc_promedio6, 0)
                       ) / 6
        from   cob_cuentas..cc_ctacte
        where  cc_cliente = @i_cliente
           and cc_estado  <> 'G' /* Cuenta de Gerencia */
      --      order  by cc_cta_banco

      if @i_modo = 1
        select
          'Cuenta' = cc_cta_banco,
          'Producto' = 'CTE',
          'Mes 1' = cc_promedio1,
          'Mes 2' = cc_promedio2,
          'Mes 3' = cc_promedio3,
          'Mes 4' = cc_promedio4,
          'Mes 5' = cc_promedio5,
          'Mes 6' = cc_promedio6,
          'Promedio' = (isnull(cc_promedio1, 0) + isnull(cc_promedio2, 0) +
                        isnull
                        (
                        cc_promedio3, 0)
                        + isnull(cc_promedio4, 0) + isnull(cc_promedio5, 0) +
                        isnull
                        (
                        cc_promedio6, 0)
                       ) / 6
        from   cob_cuentas..cc_ctacte
        where  cc_cliente   = @i_cliente
           and cc_cta_banco > @i_cuenta
           and cc_estado    <> 'G' /* Cuenta de Gerencia */
      --      order  by cc_cta_banco
      set rowcount 0
      return 0
    end

    /*  Seleahionar promedios de cuentas de ahorros  */
    if @i_operacion = 'A'
    begin
      set rowcount 20
      if @i_modo = 0
        select
          'Cuenta' = ah_cta_banco,
          'Producto' = 'AHO    ',
          'Mes 1' = ah_promedio1,
          'Mes 2' = ah_promedio2,
          'Mes 3' = ah_promedio3,
          'Mes 4' = ah_promedio4,
          'Mes 5' = ah_promedio5,
          'Mes 6' = ah_promedio6,
          'Promedio' = (isnull(ah_promedio1, 0) + isnull(ah_promedio2, 0) +
                        isnull
                        (
                        ah_promedio3, 0)
                        + isnull(ah_promedio4, 0) + isnull(ah_promedio5, 0) +
                        isnull
                        (
                        ah_promedio6, 0)
                       ) / 6
        from   cob_ahorros..ah_cuenta
        where  ah_cliente = @i_cliente
      --   order  by ah_cta_banco
      if @i_modo = 1
        select
          'Cuenta' = ah_cta_banco,
          'Producto' = 'AHO    ',
          'Mes 1' = ah_promedio1,
          'Mes 2' = ah_promedio2,
          'Mes 3' = ah_promedio3,
          'Mes 4' = ah_promedio4,
          'Mes 5' = ah_promedio5,
          'Mes 6' = ah_promedio6,
          'Promedio' = (isnull(ah_promedio1, 0) + isnull(ah_promedio2, 0) +
                        isnull
                        (
                        ah_promedio3, 0)
                        + isnull(ah_promedio4, 0) + isnull(ah_promedio5, 0) +
                        isnull
                        (
                        ah_promedio6, 0)
                       ) / 6
        from   cob_ahorros..ah_cuenta
        where  ah_cliente   = @i_cliente
           and ah_cta_banco > @i_cuenta
      --   order  by ah_cta_banco
      set rowcount 0
      return 0
    end
  end
  else
  begin
    if @i_operacion = 'C'
    begin
      set rowcount 20
      if @i_modo = 0
        select distinct
          'Cuenta' = cc_cta_banco,
          'Producto' = 'CTE    ',
          'Mes 1' = cc_promedio1,
          'Mes 2' = cc_promedio2,
          'Mes 3' = cc_promedio3,
          'Mes 4' = cc_promedio4,
          'Mes 5' = cc_promedio5,
          'Mes 6' = cc_promedio6,
          'Promedio' = (isnull(cc_promedio1, 0) + isnull(cc_promedio2, 0) +
                        isnull
                        (
                        cc_promedio3, 0)
                        + isnull(cc_promedio4, 0) + isnull(cc_promedio5, 0) +
                        isnull
                        (
                        cc_promedio6, 0)
                       ) / 6
        from   cob_cuentas..cc_ctacte,
               cobis..cl_cliente_grupo
        where  cc_cliente = cg_ente
           and cc_estado  <> 'G' /* Cuenta de Gerencia */
           and cg_grupo   = @i_cliente
      --         order  by cc_cta_banco
      if @i_modo = 1
        select distinct
          'Cuenta' = cc_cta_banco,
          'Producto' = 'CTE    ',
          'Mes 1' = cc_promedio1,
          'Mes 2' = cc_promedio2,
          'Mes 3' = cc_promedio3,
          'Mes 4' = cc_promedio4,
          'Mes 5' = cc_promedio5,
          'Mes 6' = cc_promedio6,
          'Promedio' = (isnull(cc_promedio1, 0) + isnull(cc_promedio2, 0) +
                        isnull
                        (
                        cc_promedio3, 0)
                        + isnull(cc_promedio4, 0) + isnull(cc_promedio5, 0) +
                        isnull
                        (
                        cc_promedio6, 0)
                       ) / 6
        from   cob_cuentas..cc_ctacte,
               cobis..cl_cliente_grupo
        where  cc_cliente   = cg_ente
           and cc_cta_banco > @i_cuenta
           and cc_estado    <> 'G'
           and cg_grupo     = @i_cliente
      --         order  by cc_cta_banco
      set rowcount 0
      return 0
    end

    /*  Seleccionar promedios de cuentas de ahorros  */
    if @i_operacion = 'A'
    begin
      set rowcount 20
      if @i_modo = 0
        select distinct
          'Cuenta' = ah_cta_banco,
          'Producto' = 'AHO    ',
          'Mes 1' = ah_promedio1,
          'Mes 2' = ah_promedio2,
          'Mes 3' = ah_promedio3,
          'Mes 4' = ah_promedio4,
          'Mes 5' = ah_promedio5,
          'Mes 6' = ah_promedio6,
          'Promedio' = (isnull(ah_promedio1, 0) + isnull(ah_promedio2, 0) +
                        isnull
                        (
                        ah_promedio3, 0)
                        + isnull(ah_promedio4, 0) + isnull(ah_promedio5, 0) +
                        isnull
                        (
                        ah_promedio6, 0)
                       ) / 6
        from   cob_ahorros..ah_cuenta,
               cobis..cl_cliente_grupo
        where  ah_cliente = cg_ente
           and cg_grupo   = @i_cliente
      --      order  by ah_cta_banco
      if @i_modo = 1
        select distinct
          'Cuenta' = ah_cta_banco,
          'Producto' = 'AHO    ',
          'Mes 1' = ah_promedio1,
          'Mes 2' = ah_promedio2,
          'Mes 3' = ah_promedio3,
          'Mes 4' = ah_promedio4,
          'Mes 5' = ah_promedio5,
          'Mes 6' = ah_promedio6,
          'Promedio' = (isnull(ah_promedio1, 0) + isnull(ah_promedio2, 0) +
                        isnull
                        (
                        ah_promedio3, 0)
                        + isnull(ah_promedio4, 0) + isnull(ah_promedio5, 0) +
                        isnull
                        (
                        ah_promedio6, 0)
                       ) / 6
        from   cob_ahorros..ah_cuenta,
               cobis..cl_cliente_grupo
        where  ah_cliente   = cg_ente
           and ah_cta_banco > @i_cuenta
           and cg_grupo     = @i_cliente
      --      order  by ah_cta_banco
      set rowcount 0
      return 0
    end
  end

go

