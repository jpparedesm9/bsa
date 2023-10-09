/************************************************************************/
/*   Archivo:                 qrrenope.sp                               */
/*   Stored procedure:        sp_qr_renova_opera                        */
/*   Base de Datos:           cob_cartera                               */
/*   Producto:                Cartera                                   */
/*   Disenado por:            DFu                                       */
/*   Fecha de Documentacion:  Ene. 2017                                 */
/************************************************************************/
/*                               IMPORTANTE                             */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'.                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                                PROPOSITO                             */
/*   Consultar los prestamos candidatos a ser renovados dado un cliente */
/*   y una moneda específica                                            */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA        AUTOR             RAZON                                */
/*  11/ene/2017  DFu               Emision inicial                      */
/************************************************************************/
use cob_cartera
go

if exists(select * from sysobjects where name = 'sp_qr_renova_opera')
   drop proc sp_qr_renova_opera
go

create proc sp_qr_renova_opera (
    @s_user                  varchar(14),
    @s_term                  varchar(30),
    @s_date                  datetime,
    @s_ofi                   smallint,
    @i_ente                  int,
    @i_moneda                smallint,
    @i_formato_fecha         smallint = 101,
    @i_operacion             char(1) = null
)
as

declare 
@w_operacionca    int,
@w_error          int,
@w_msg            varchar(255),
@w_return         int, 
@w_est_novigente  smallint,
@w_est_vigente    smallint,
@w_est_vencido    smallint,
@w_est_cancelado  smallint,
@w_est_castigado  smallint,
@w_est_diferido   smallint,
@w_est_anulado    smallint,
@w_est_condonado  smallint,
@w_est_suspenso   smallint,
@w_est_credito    smallint


exec @w_error = sp_estados_cca
@o_est_vigente    = @w_est_vigente   out,
@o_est_vencido    = @w_est_vencido   out,
@o_est_novigente  = @w_est_novigente  out


if @w_error <> 0 goto ERROR

select 'op_toperacion'    = op_toperacion,
       'op_operacion'     = op_operacion,
       'op_banco'         = op_banco,
       'linea'            = (select c.valor 
                             from   cobis..cl_tabla t, cobis..cl_catalogo c 
                             where  t.codigo = c.tabla 
                             and    t.tabla  = 'ca_toperacion' 
                             and    c.codigo = o.op_toperacion),
       'op_monto'         = op_monto,
       'op_plazo'         = op_plazo,
       'saldo_capital'    = (select isnull(sum((am_acumulado + am_gracia) - am_pagado),0)
                             from   ca_amortizacion, ca_concepto
                             where  am_concepto  = co_concepto 
                             and    am_operacion = o.op_operacion
                             and    co_categoria = 'C'),
       'saldo_interes'    = (select isnull(sum((am_acumulado + am_gracia) - am_pagado),0)
                             from   ca_amortizacion, ca_concepto
                             where  am_concepto  = co_concepto 
                             and    am_operacion = o.op_operacion
                             and    co_categoria = 'I'),
       'saldo_mora'       = (select isnull(sum((am_acumulado + am_gracia) - am_pagado),0)
                             from   ca_amortizacion, ca_concepto
                             where  am_concepto  = co_concepto 
                             and    am_operacion = o.op_operacion
                             and    co_categoria = 'M'),
       'saldo_otros'      = (select isnull(sum((am_acumulado + am_gracia) - am_pagado),0)
                             from   ca_amortizacion, ca_concepto
                             where  am_concepto  = co_concepto 
                             and    am_operacion = o.op_operacion
                             and    co_categoria not in ('C','I','M')),
       'plazo_residual'   = (select count(1) 
                             from   ca_dividendo 
                             where  di_estado in (@w_est_vigente,@w_est_novigente) 
                             and    di_operacion = o.op_operacion),
       'op_estado'        = op_estado,
       'moneda'           = (select mo_nemonico from cobis..cl_moneda where mo_moneda = convert(char(10),o.op_moneda)),
       'cuotas_vencidas'  = (select count(1) from ca_dividendo where di_estado = @w_est_vencido and di_operacion = o.op_operacion),
       'op_cliente'       = op_cliente,
       'op_nombre'        = op_nombre
from   ca_operacion o, ca_default_toperacion 
where  op_toperacion = dt_toperacion 
and    op_moneda     = dt_moneda 
and    op_cliente    = @i_ente 
and    op_moneda     = @i_moneda 
and    op_estado    in (@w_est_vigente, @w_est_vencido) 
and    dt_renovacion = 'S'


if @@rowcount = 0  
begin
    select @w_error = 710201
    goto ERROR
end

return 0

ERROR:
exec cobis..sp_cerror 
@t_debug = 'N', 
@t_file = null,
@t_from = 'sp_qr_renova_opera',
@i_num  = @w_error
return @w_error 



GO

