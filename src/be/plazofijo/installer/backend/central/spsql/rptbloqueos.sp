/************************************************************************/
/*      Archivo               :  rptbloqueos.sp                         */
/*      Stored procedure      :  sp_rptbloqueos                         */
/*      Base de datos         :  cob_pfijo                              */
/*      Diseñado Por          :  Nancy Martillo                         */
/*      Producto              :  Plazo_fijo                             */
/*      Fecha de Documentación:  Nancy Martillo                         */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este reporte lista los depósitos bloqueados                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA        AUTOR                RAZON                             */
/*  05-Oct-2016  N.Martillo           Emisión Inicial                   */
/************************************************************************/


use cob_pfijo
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_rptbloqueos')
  drop procedure sp_rptbloqueos
go
create procedure sp_rptbloqueos
with encryption
as declare @w_sp_name            varchar(32), 
           @w_retorno            int,
           @w_retorno_ej         int,
           @w_error_msg          varchar(250),
           @w_tabla              varchar (250),
           @w_fecha_proceso      datetime
           
   
select @w_sp_name = 'sp_rptbloqueos'

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

truncate table cob_reportes..rep_dpf_bloqueos

insert into cob_reportes..rep_dpf_bloqueos (
bl_regional,                              bl_des_regional, 
bl_zona,                                  bl_des_zona, 
bl_oficina,                               bl_des_oficina, 
bl_toperacion,                            bl_fecha_valor, 
bl_num_banco,                             bl_descripcion, 
bl_oficial_principal,                     
bl_monto,                                 bl_monto_mn,
bl_motivo_ret,                            
bl_valor_bloq,                            bl_valor_bloq_mn,
bl_funcionario,                           bl_fecha_crea, 
bl_moneda,                                bl_desc_moneda)
select
o.of_regional,                            (select of_nombre from cobis..cl_oficina where of_oficina = o.of_regional),
o.of_zona,                                (select of_nombre from cobis..cl_oficina where of_oficina = o.of_zona),
op_oficina,                               (select of_nombre from cobis..cl_oficina where of_oficina = op_oficina),
op_toperacion,                            op_fecha_valor,
op_num_banco,                             op_descripcion,
op_oficial_principal + ' - ' + fu_nombre,
op_monto,                                 (select isnull(ct_valor,1) * op_monto from cob_conta..cb_cotizacion where ct_moneda = op_moneda and ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = op_moneda)),                                 
a.valor,                                  
rt_valor,                                 (select isnull(ct_valor,1) * rt_valor from cob_conta..cb_cotizacion where ct_moneda = op_moneda and ct_fecha = (select max(ct_fecha) from cob_conta..cb_cotizacion where ct_moneda = op_moneda)),                                
rt_funcionario,                           rt_fecha_crea,
op_moneda,                                (select mo_descripcion from cobis..cl_moneda where mo_moneda = op_moneda)
FROM  pf_operacion, 
      pf_retencion, 
      cobis..cl_funcionario,
      cobis..cl_oficina o,
      cobis..cl_catalogo a,
      cobis..cl_tabla b
WHERE op_oficial_principal = fu_login
  and op_operacion = rt_operacion
  and op_oficina   = o.of_oficina
  and a.tabla      = b.codigo
  and b.tabla      = 'pf_motivo_ret' 
  and a.codigo     = rt_motivo
  and a.estado     = 'V'

if @@error <> 0 
    begin 
        select @w_tabla = 'rep_dpf_bloqueos', @w_retorno_ej = 14000,
        @w_error_msg = 'error al insertar en'  + '-' + @w_tabla
        goto ERROR  
        End   

return 0

ERROR:

exec @w_retorno     = cob_pfijo..sp_errorlog
     @i_fecha       = @w_fecha_proceso, 
     @i_error       = @w_retorno_ej, 
     @i_usuario     = 'OPERADOR',
     @i_tran        = 14000, 
     @i_tran_name   = @w_sp_name, 
     @i_rollback    = 'N',
     @i_cuenta      = 'sp_rptbloqueos', 
     @i_descripcion = @w_error_msg

if @w_retorno > 0
    return @w_retorno
else
    return @w_retorno_ej
    
go
