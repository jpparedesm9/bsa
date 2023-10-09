/************************************************************************/
/*      Archivo           :  rptordpa.sp                                */
/*     Stored procedure   :  rptordpa                                   */
/*      Base de datos     :  cob_pfijo                                  */
/*      Producto          :  Plazo Fijo                                 */
/*      Disenado por      :  Jorge Vidal Z.                             */
/*      Fecha de escritura:  26/Sep/16                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*     Este reporte, lista las ordenes de pago que fueron generadas     */
/*     por los depositos en un rango de fechas ingresadas como          */
/*     parametro.                                                       */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR           RAZON                           */
/*      26/Sep/16     J. Vidal Z        Emision Inicial                 */ 
/*      05-Ene-2017   N. Martillo       Ajustes VBatch                  */
/************************************************************************/
use cob_pfijo
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'rptordpa')
  drop procedure rptordpa
go
create procedure  rptordpa
with encryption
as declare
       @w_sp_name            varchar(32),
       @w_retorno            int,
       @w_error_msg          varchar(250),
       @w_retorno_ej         int,
       @w_fecha_proceso      datetime

Select @w_sp_name = 'rptordpa'

select @w_fecha_proceso = fp_fecha
from   cobis..ba_fecha_proceso

truncate table cob_reportes..rep_dpf_ord_pa
insert into cob_reportes..rep_dpf_ord_pa
(op_regional,
 op_zona,
 op_oficina,
 op_num_banco,           op_nom_cli,          op_moneda,
 op_fpago,               op_int_pag,          op_int_pag_mn,
 op_fec_desde,           
 op_fec_hasta,           op_sal_cap,          op_sal_cap_mn,
 op_tasa,                op_base_calculo,
 op_mm_cuenta,           op_mm_beneficiario)
 select
 (select of_nombre from cobis..cl_oficina where of_oficina = o.of_regional),
 (select of_nombre from cobis..cl_oficina where of_oficina = o.of_zona),
 (select of_nombre from cobis..cl_oficina where of_oficina = op_oficina),
 op_num_banco,           op_descripcion,      (select mo_descripcion      from cobis..cl_moneda 
                                                                          where mo_moneda = op_moneda),
 mm_producto,         mm_valor,            (select isnull(ct_valor,1) * mm_valor from  cob_conta..cb_cotizacion 
                                                                          where ct_moneda = op_moneda
                                                                          and   ct_fecha = (select max(ct_fecha) from  cob_conta..cb_cotizacion 
                                                                                                                 where ct_moneda = op_moneda)),
 case when cu_fecha_pago < op_fecha_ult_pg_int then cu_fecha_pago else op_fecha_ult_pg_int end,
 op_fecha_ult_pg_int,    op_monto,            (select isnull(ct_valor,1) * op_monto from  cob_conta..cb_cotizacion 
                                                                          where ct_moneda = op_moneda
                                                                          and   ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion 
                                                                                                                 where ct_moneda = op_moneda)),
 op_tasa,                op_base_calculo,
 mm_cuenta,              (select ce_nombre from pf_cliente_externo where ce_secuencial = mm_beneficiario)
 from  pf_operacion,
       pf_mov_monet,
       cobis..cl_oficina o,
       cobis..cl_ciudad,
       --pf_fpago,
       pf_cuotas
 where mm_tipo              = 'C'
 and   mm_estado            = 'A'
 and   mm_tran              = 14905
 and   op_operacion         = cu_operacion
 and   cu_fecha_pago        < op_fecha_ult_pg_int
 and   op_oficina           = of_oficina
 and   mm_operacion         = op_operacion 
 and   of_ciudad            =  ci_ciudad 
 and   mm_fecha_aplicacion  is not NULL 
 --and   mm_producto          =  fp_mnemonico 
 
 --and   (mm_fecha_aplicacion >= @i_fecha_ini  or @i_fecha_ini  is null)
 --and   (mm_fecha_aplicacion <= @i_fecha_fin  or @i_fecha_fin  is null)
 --and   (op_toperacion       =  @i_toperacion or @i_toperacion is null)
 --and   (ci_ciudad           =  @i_ciudad     or @i_ciudad     is null)
 --and   (op_oficina          =  @i_oficina    or @i_oficina    is null)
 --and   (mm_producto         =  @i_forma_pago or @i_forma_pago is null)
 ORDER BY of_regional, of_zona, op_oficina, op_toperacion, mm_producto, op_moneda, op_num_banco
if @@rowcount = 0
begin
     select @w_retorno_ej = 14000,
            @w_error_msg = '[' + @w_sp_name + '] ' + 'No existen Registros Consultados'
     goto ERROR
end
return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptloger', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej
	
go
