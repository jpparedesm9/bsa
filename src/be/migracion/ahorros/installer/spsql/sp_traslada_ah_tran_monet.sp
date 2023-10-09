/************************************************************************/
/*  Archivo:                sp_traslada_ah_tran_monet.sp                */
/*  Stored procedure:       sp_traslada_ah_tran_monet                   */
/*  Base de datos:          cob_remesas                                 */
/*  Producto:               Pasivas                                     */
/*  Disenado por:           Roxana Sánchez.                             */
/*  Fecha de escritura:     31-08-2016                                  */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*      Este programa realiza la migracion de la tabla re_detalle_cheque*/
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA             AUTOR                   RAZON                 */
/*      31-Ago-2016       Roxana Sánchez         Emisión Inicial        */
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_ah_tran_monet')
   drop proc sp_traslada_ah_tran_monet
go

create proc sp_traslada_ah_tran_monet(
   @i_clave_i            int          = null,
   @i_clave_f            int          = null
)
as
declare
  @w_conteo             int,
  @w_det_producto       int,
  @w_comentario         descripcion,
  @w_autorizante        smallint

select @i_clave_i = @i_clave_i + 1,
       @w_comentario = 'TRANSACCIONES MONETARIAS'
       
select @w_autorizante = fu_funcionario
from cobis..cl_funcionario
where fu_login = 'sa'
 
select @w_conteo = count(*)
from    ah_tran_monet_mig
where tm_codigo between @i_clave_i and @i_clave_f
and     tm_estado_mig = 'VE'
if @w_conteo = 0
   return 0

     -- ------------------------------------------------------------------
     -- - Cargo tabla definitiva
     -- ------------------------------------------------------------------

     insert cob_ahorros..ah_tran_monet
     (
      tm_fecha,              tm_secuencial,        tm_ssn_branch,          tm_cod_alterno,       
      tm_tipo_tran,          tm_filial,            tm_oficina,             tm_usuario,      
      tm_terminal,           tm_correccion,        tm_sec_correccion,      tm_origen,        
      tm_nodo,               tm_reentry,           tm_signo,               tm_fecha_ult_mov,        
      tm_cta_banco,          tm_valor,             tm_chq_propios,         tm_chq_locales,          
      tm_chq_ot_plazas,      tm_remoto_ssn,        tm_moneda,              tm_efectivo,            
      tm_indicador,          tm_causa,             tm_departamento,        tm_saldo_lib,
      tm_saldo_contable,     tm_saldo_disponible,  tm_saldo_interes,       tm_fecha_efec, 
      tm_interes,            tm_control,           tm_ctadestino,          tm_tipo_xfer,
      tm_estado,             tm_concepto,          tm_oficina_cta,         tm_hora,
      tm_banco,              tm_valor_comision,    tm_prod_banc,           tm_categoria,
      tm_monto_imp,          tm_tipo_exonerado_imp,tm_serial,              tm_tipocta_super,
      tm_turno,              tm_cheque,            tm_forma_pg,            tm_canal,
      tm_stand_in,           tm_oficial,           tm_clase_clte,          tm_cliente,
      tm_base_gmf
     )
     select
      tm_fecha,              tm_secuencial,        tm_ssn_branch,          tm_cod_alterno,       
      tm_tipo_tran,          tm_filial,            tm_oficina,             tm_usuario,      
      tm_terminal,           tm_correccion,        tm_sec_correccion,      tm_origen,        
      tm_nodo,               tm_reentry,           tm_signo,               tm_fecha_ult_mov,        
      nc_cta_banco,          tm_valor,             tm_chq_propios,         tm_chq_locales,          
      tm_chq_ot_plazas,      tm_remoto_ssn,        tm_moneda,              tm_efectivo,            
      tm_indicador,          tm_causa,             tm_departamento,        tm_saldo_lib,
      tm_saldo_contable,     tm_saldo_disponible,  tm_saldo_interes,       tm_fecha_efec,
      tm_interes,            tm_control,           tm_ctadestino,          tm_tipo_xfer,
      tm_estado,             tm_concepto,          tm_oficina_cta,         tm_hora,
      tm_banco,              tm_valor_comision,    tm_prod_banc,           tm_categoria,
      tm_monto_imp,          tm_tipo_exonerado_imp,tm_serial,              tm_tipocta_super,
      tm_turno,              tm_cheque,            tm_forma_pg,            tm_canal,
      tm_stand_in,           tm_oficial,           tm_clase_clte,          tm_cliente,
      tm_base_gmf
         from  cob_externos..ah_tran_monet_mig, ah_numero_cuenta	
		 where tm_codigo between @i_clave_i and @i_clave_f     
           and nc_cta_banco_mig = tm_cta_banco	            
		 and tm_estado_mig = 'VE'
	
         
        
         if @@error <> 0
		 begin
			insert into ah_log_mig
			select top 1 convert(varchar, tm_codigo),
       		'INS',
       		convert(varchar, @i_clave_i),
       		convert(varchar, @i_clave_f),
       		convert(varchar, tm_codigo),
       		282,
       		tm_codigo,
               tm_cta_banco
			from ah_tran_monet_mig
		 end   
                                                   
return  0
go 

