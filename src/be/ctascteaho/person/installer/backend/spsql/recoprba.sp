/****************************************************************************/
/*  Archivo:            recpprba.sp                                         */
/*  Stored procedure:   sp_cons_productoban                                 */
/*  Base de datos:      cob_cuentas                                         */
/*  Producto:           Cuentas Corrientes                                  */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz                         */
/*  Fecha de escritura: 13-Jul-1994                                         */
/****************************************************************************/
/*                              IMPORTANTE                                  */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                              PROPOSITO                                   */
/*  Este programa procesa las transacciones de consulta                     */
/*  de productos bancarios                                                  */
/****************************************************************************/
/*                              MODIFICACIONES                              */
/*  FECHA           AUTOR           RAZON                                   */
/*  13/Jul/1994     J. Bucheli V.   Emision Inicial para Banco de           */
/*                                  la Produccion                           */
/*  07/Jul/2000     K.Verdesoto     Version Colombia                        */
/*  30/Mar/2010     E.Alvarez       Se incluye el estado en la consulta     */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cons_productoban')
  drop proc sp_cons_productoban

set QUOTED_IDENTIFIER off
go
create proc sp_cons_productoban
(
  @t_debug        char(1) = 'N',
  @t_file         char(1) = null,
  @t_trn          smallint,
  @t_show_version bit = 0,
  @i_help         char(1),
  @i_prodfin      smallint = 0,
  @i_prodban      smallint = null,
  @i_mon          tinyint = null,
  @i_filial       tinyint = null,
  @i_oficina      smallint = null,
  @i_tipo_ente    catalogo = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_sucursal smallint,
    @w_subtipo  char(1),
    @w_fecha    datetime

  select
    @w_sp_name = 'sp_cons_productoban'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Obtencion de la sucusal */

  select
    @w_subtipo = of_subtipo
  from   cobis..cl_oficina
  where  of_oficina = @i_oficina

  if @w_subtipo = 'O'
    select
      @w_sucursal = of_regional
    from   cobis..cl_oficina
    where  of_oficina = @i_oficina
  else
    select
      @w_sucursal = @i_oficina

  if @i_help = 'S'
  begin
    if @i_prodban is null
    begin
      select
        'CODIGO' = pb_pro_bancario,
        'DESCRIPCION' = pb_descripcion
      from   cob_remesas..pe_pro_bancario
      where  pb_estado = 'V'
    end
    else
    begin
      select
        'DESCRIPCION' = pb_descripcion
      from   cob_remesas..pe_pro_bancario
      where  pb_pro_bancario = @i_prodban
         and pb_estado       = 'V'
      if @@rowcount = 0
      begin
        /* No existe producto bancario */
        exec cobis..sp_cerror
          @t_from = 'sp_cons_productoban',
          @i_num  = 351015
        return 351015
      end
    end
    return 0
  end

  if @i_help = 'A'
  begin
    if @i_tipo_ente is null
      select distinct
        'CODIGO' = pb_pro_bancario,
        'DESCRIPCION' = pb_descripcion
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado,
             cob_remesas..pe_pro_bancario
      where  pf_filial       = @i_filial
         and pf_sucursal     = @w_sucursal
         and pf_producto     = @i_prodban
         and pf_moneda       = @i_mon
         and pf_tipo         = 'R'
         and me_mercado      = pf_mercado
         and me_pro_bancario = pb_pro_bancario
         and pb_estado       = 'V'
    else
    begin
      select
        @w_fecha = fp_fecha
      from   cobis..ba_fecha_proceso

      select distinct
        'CODIGO' = pb_pro_bancario,
        'DESCRIPCION' = pb_descripcion
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado,
             cob_remesas..pe_pro_bancario,
             cob_remesas..pe_oficina_autorizada
      where  pf_filial       = @i_filial
         and pf_sucursal     = @w_sucursal
         and pf_producto     = @i_prodban
         and pf_moneda       = @i_mon
         and pf_tipo         = 'R'
         and me_mercado      = pf_mercado
         and me_pro_bancario = pb_pro_bancario
         and me_tipo_ente    = @i_tipo_ente
         and pb_estado       = 'V'
         and pf_producto     = oa_producto
         and me_pro_bancario = oa_prod_banc
         and oa_oficina      = @i_oficina
         and oa_estado       = 'V'
         and oa_fecha_inicio <= @w_fecha
    end
  end
  else
  begin
    if @i_tipo_ente is null
      select distinct
        'DESCRIPCION' = pb_descripcion
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado,
             cob_remesas..pe_pro_bancario
      where  pf_filial       = @i_filial
         and pf_sucursal     = @w_sucursal
         and pf_producto     = @i_prodban
         and pf_moneda       = @i_mon
         and pf_tipo         = 'R'
         and me_mercado      = pf_mercado
         and me_pro_bancario = pb_pro_bancario
         and pb_pro_bancario = @i_prodfin
         and pb_estado       = 'V'
    else
    begin
      select
        @w_fecha = fp_fecha
      from   cobis..ba_fecha_proceso

      select distinct
        'DESCRIPCION' = pb_descripcion
      from   cob_remesas..pe_pro_final,
             cob_remesas..pe_mercado,
             cob_remesas..pe_pro_bancario,
             cob_remesas..pe_oficina_autorizada
      where  pf_filial       = @i_filial
         and pf_sucursal     = @w_sucursal
         and pf_producto     = @i_prodban
         and pf_moneda       = @i_mon
         and pf_tipo         = 'R'
         and me_mercado      = pf_mercado
         and me_pro_bancario = pb_pro_bancario
         and pb_pro_bancario = @i_prodfin
         and me_tipo_ente    = @i_tipo_ente
         and pb_estado       = 'V'
         and pf_producto     = oa_producto
         and me_pro_bancario = oa_prod_banc
         and oa_oficina      = @i_oficina
         and oa_estado       = 'V'
         and oa_fecha_inicio <= @w_fecha
    end
  end

  if @@rowcount = 0
  begin
    /* No existe producto bancario */
    exec cobis..sp_cerror
      @t_from = 'sp_cons_productoban',
      @i_num  = 351015
    return 351015
  end
  return 0

GO 
