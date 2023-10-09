/************************************************************************/
/*      Archivo:                aplica_impuestos.sp                     */
/*      Stored procedure:       sp_aplica_impuestos                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Yecid Martinez                          */
/*      Fecha de documentacion: 11/Jul/2009                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea los procedimientos para las transacciones de   */
/*      adicion, modificacion, eliminacion, search y query de las       */
/*      operaciones temporales de plazos fijos.                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR              RAZON                            */
/*     11/Jul/2009  Yecid Martinez     Creacion                         */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if object_id('sp_aplica_impuestos') is not null
   drop proc sp_aplica_impuestos
go

create proc sp_aplica_impuestos (
   @s_ofi                  smallint        = null,
   @t_debug                char(1)         = 'N',
   @i_ente                 int             = null,
   @i_plazo                int             = null,
   @i_capital              money           = null,
   @i_interes              money           = null,
   @i_base_calculo         smallint        = null,
   @o_retienimp            char(1)         = null output,
   @o_tasa_retencion       decimal(30,6)   = null output,
   @o_valor_retencion      money           = null output
)
with encryption
as
declare
   @w_sp_name           varchar(32),
   @w_retienimp         char(1),
   @w_ret_capital       char(1),
   @w_ret_interes       char(1),
   @w_porc_capital      float,
   @w_porc_interes      float,
   @w_numdeci           int,
   @w_abr_pais          varchar(10)

    select @w_retienimp = 'S'
   
    select @w_abr_pais = pa_char
    from cobis..cl_parametro
    where pa_nemonico = 'ABPAIS'

    if @w_abr_pais <> 'CO'
    begin
        select  @o_retienimp     = 'N',
                @o_tasa_retencion = 0,
                @o_valor_retencion = 0

        return 0
    end

    select @w_numdeci = isnull(pa_tinyint,0)
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
    and    pa_producto = 'PFI'

    -- COBRO IMPUESTO SOBRE CAPITAL
    select @w_ret_capital = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'ISCAP'
    and    pa_producto = 'PFI'

    -- COBRO IMPUESTO SOBRE INTERES
    select @w_ret_interes = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'ISINT'
    and    pa_producto = 'PFI'

    -- PORCENTAJE IMPUESTO A LA RENTA
    select @o_tasa_retencion = pa_float
    from   cobis..cl_parametro
    where  pa_nemonico = 'IMPREN'
    and    pa_producto = 'PFI'
    
    if @@rowcount = 0 
        select @o_tasa_retencion = 0

    if @w_retienimp = 'S'
    begin

        select @o_retienimp = @w_retienimp
        --print 'C ' + cast(@i_capital as varchar) +  '-T ' + cast(@o_tasa_retencion as varchar)+ '-B ' + cast(@i_base_calculo as varchar)+ '-T ' + cast(@i_plazo as varchar)
        if @w_ret_capital = 'S'
            select @o_valor_retencion = isnull(round(@i_capital * (@o_tasa_retencion/100)/@i_base_calculo * @i_plazo, @w_numdeci), 0)
        else
            if @w_ret_interes = 'S'
                select @o_valor_retencion = isnull(round(@i_interes * @o_tasa_retencion/100, @w_numdeci), 0)
            else
                select @o_valor_retencion = 0, @o_tasa_retencion = 0
    end
    else
        select  @o_retienimp       = 'N',
                @o_tasa_retencion  = 0,
                @o_valor_retencion = 0

if @t_debug = 'S' print '@o_retienimp  ' + cast(@o_retienimp  as varchar)
if @t_debug = 'S' print '@o_tasa_retencion  ' + cast(@o_tasa_retencion  as varchar)
if @t_debug = 'S' print '@o_valor_retencion  ' + cast(@o_valor_retencion  as varchar)

return 0
go
