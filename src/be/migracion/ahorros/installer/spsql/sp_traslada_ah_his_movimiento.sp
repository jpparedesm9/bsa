/************************************************************************/
/*  Archivo:                 sp_traslada_ah_his_movimiento.sp           */
/*  Stored procedure:        sp_traslada_ah_his_movimiento              */
/*  Base de Datos:           cob_externos                               */
/*  Producto:                AHORROS                                    */
/************************************************************************/
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
/*                           PROPOSITO                                  */
/* Realiza el traspaso de las tablas MIGs a las tablas definitivas      */
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_ah_his_movimiento')
    drop proc sp_traslada_ah_his_movimiento
go

create proc sp_traslada_ah_his_movimiento
(
    @i_clave_i            int          = null,
    @i_clave_f            int          = null
)
as 
declare @w_conteo int

select @i_clave_i = @i_clave_i + 1
 
select @w_conteo = count(1)
from   ah_his_movimiento_mig
where  hm_codigo between @i_clave_i and @i_clave_f
and    hm_estado_mig = 'VE'

if @w_conteo = 0   return 0
   
-- ------------------------------------------------------------------
-- - Cargo tabla definitiva
-- ------------------------------------------------------------------
insert into cob_ahorros_his..ah_his_movimiento
      (hm_fecha            ,hm_secuencial       ,hm_ssn_branch       ,hm_cod_alterno        ,hm_tipo_tran        ,hm_filial           ,
       hm_oficina          ,hm_usuario          ,hm_terminal         ,hm_correccion         ,hm_sec_correccion   ,hm_origen           ,
       hm_nodo             ,hm_reentry          ,hm_signo            ,hm_fecha_ult_mov      ,hm_cta_banco        ,hm_valor            ,
       hm_chq_propios      ,hm_chq_locales      ,hm_chq_ot_plazas    ,hm_remoto_ssn         ,hm_moneda           ,hm_efectivo         ,
       hm_indicador        ,hm_causa            ,hm_departamento     ,hm_saldo_lib          ,hm_saldo_contable   ,hm_saldo_disponible ,
       hm_saldo_interes    ,hm_fecha_efec       ,hm_interes          ,hm_control            ,hm_ctadestino       ,hm_tipo_xfer        ,
       hm_estado           ,hm_concepto         ,hm_oficina_cta      ,hm_hora               ,hm_banco            ,hm_valor_comision   ,
       hm_prod_banc        ,hm_categoria        ,hm_monto_imp        ,hm_tipo_exonerado_imp ,hm_serial           ,hm_tipocta_super    ,
       hm_turno            ,hm_cheque           ,hm_canal            ,hm_stand_in           ,hm_oficial          ,hm_clase_clte       ,
       hm_cliente          ,hm_base_gmf)   
select hm_fecha            ,hm_secuencial       ,hm_ssn_branch       ,hm_cod_alterno        ,hm_tipo_tran        ,hm_filial           ,
       hm_oficina          ,hm_usuario          ,hm_terminal         ,hm_correccion         ,hm_sec_correccion   ,hm_origen           ,
       hm_nodo             ,hm_reentry          ,hm_signo            ,hm_fecha_ult_mov      ,nc_cta_banco        ,hm_valor            ,
       hm_chq_propios      ,hm_chq_locales      ,hm_chq_ot_plazas    ,hm_remoto_ssn         ,hm_moneda           ,hm_efectivo         ,
       hm_indicador        ,hm_causa            ,hm_departamento     ,hm_saldo_lib          ,hm_saldo_contable   ,hm_saldo_disponible ,
       hm_saldo_interes    ,hm_fecha_efec       ,hm_interes          ,hm_control            ,hm_ctadestino       ,hm_tipo_xfer        ,
       hm_estado           ,hm_concepto         ,hm_oficina_cta      ,hm_hora               ,hm_banco            ,hm_valor_comision   ,
       hm_prod_banc        ,hm_categoria        ,hm_monto_imp        ,hm_tipo_exonerado_imp ,hm_serial           ,hm_tipocta_super    ,
       hm_turno            ,hm_cheque           ,hm_canal            ,hm_stand_in           ,hm_oficial          ,hm_clase_clte       ,
       hm_cliente          ,hm_base_gmf
from   ah_his_movimiento_mig, ah_numero_cuenta
where  hm_codigo between @i_clave_i and @i_clave_f
and    hm_cta_banco = nc_cta_banco_mig
and    hm_estado_mig = 'VE'

if @@error <> 0
begin                                                
    insert into ah_log_mig
    select top 1 convert(varchar, hm_cta_banco),
           'ah_his_movimiento_mig',
           'sp_traslada_ah_his_movimiento',
           'INS',
           convert(varchar, hm_cta_banco),
           285,
           null,
           hm_cta_banco
    from   ah_his_movimiento_mig
end

return  0
go
