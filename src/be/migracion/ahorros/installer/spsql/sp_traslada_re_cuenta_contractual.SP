/************************************************************************/
/*  Archivo:                sp_traslada_re_cuenta_contractual.sp        */
/*  Stored procedure:       sp_traslada_re_cuenta_contractual           */
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
/*      Este programa realiza la migracion de la tabla re_accion_nd     */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*      FECHA             AUTOR                   RAZON                 */
/*      31-Ago-2016       Roxana Sánchez         Emisión Inicial        */
/************************************************************************/
use cob_externos
go

if exists(select * from sysobjects where name = 'sp_traslada_re_cuenta_contractual')
   drop proc sp_traslada_re_cuenta_contractual
go

create proc sp_traslada_re_cuenta_contractual(
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
       @w_comentario = 'CUENTA CONTRACTUAL'
       
select @w_autorizante = fu_funcionario
from cobis..cl_funcionario
where fu_login = 'sa'
 
select @w_conteo = count(*)
from    re_cuenta_contractual_mig
where cc_profinal between @i_clave_i and @i_clave_f
and   cc_estado_mig = 'VE'
if @w_conteo = 0
   return 0

     -- ------------------------------------------------------------------
     -- - Cargo tabla definitiva
     -- ------------------------------------------------------------------

     insert cob_remesas..re_cuenta_contractual
     (
      cc_modulo,             cc_profinal,            cc_cta_banco,            cc_plazo,       
      cc_cuota,              cc_periodicidad,        cc_monto_final,          cc_intereses, 
      cc_ptos_premio,        cc_estado,              cc_categoria,            cc_fecha_crea, 
      cc_periodos_incump,    cc_prodbanc
     )
     select
      cc_modulo,             cc_profinal,            nc_cta_banco,          cc_plazo,       
      cc_cuota,              cc_periodicidad,        cc_monto_final,        cc_intereses, 
      cc_ptos_premio,        cc_estado,              cc_categoria,          cc_fecha_crea, 
      cc_periodos_incump,    cc_prodbanc
         from  cob_externos..re_cuenta_contractual_mig, ah_numero_cuenta	
		 where cc_profinal between @i_clave_i and @i_clave_f     
           and  nc_cta_banco_mig =  cc_cta_banco          
		 and cc_estado_mig = 'VE'
		 
         if @@error <> 0
		 begin
			insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
			select top 1 convert(varchar, cc_profinal),
       		'INS',
       		convert(varchar, @i_clave_i),
       		convert(varchar, @i_clave_f),
       		convert(varchar, cc_profinal),
       		281,
       		cc_profinal
			from re_cuenta_contractual_mig
		 end   
   
go 

