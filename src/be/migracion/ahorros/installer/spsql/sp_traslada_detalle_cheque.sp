/************************************************************************/
/*  Archivo:                sp_traslada_detalle_cheque.sp               */
/*  Stored procedure:       sp_traslada_detalle_cheque                  */
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

if exists(select * from sysobjects where name = 'sp_traslada_detalle_cheque')
   drop proc sp_traslada_detalle_cheque
go

create proc sp_traslada_detalle_cheque(
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
       @w_comentario = 'DETALLE CHEQUE'
       
select @w_autorizante = fu_funcionario
from cobis..cl_funcionario
where fu_login = 'sa'
 
select @w_conteo = count(*)
from    re_detalle_cheque_mig
where dc_codigo between @i_clave_i and @i_clave_f
and     dc_estado_mig = 'VE'
if @w_conteo = 0
   return 0

     -- ------------------------------------------------------------------
     -- - Cargo tabla definitiva
     -- ------------------------------------------------------------------

     insert cob_remesas..re_detalle_cheque
     (
      dc_filial,             dc_oficina,            dc_fecha,              dc_fecha_efe,       
      dc_id,                 dc_trn,                dc_numctrl,            dc_secuencial,      
      dc_ssn,                dc_ssn_branch,         dc_cta_banco,          dc_producto,        
      dc_tipo,               dc_tipo_chq,           dc_co_banco,           dc_no_banco,        
      dc_cta_cheque,         dc_num_cheque,         dc_valor,              dc_moneda,          
      dc_fechaemision,       dc_estado,             dc_user,               dc_hora,            
      dc_detalle,            dc_factor,             dc_cotizacion,         dc_valor_convertido,
      dc_mon_destino                             
     )
     select
      dc_filial,             dc_oficina,            dc_fecha,              dc_fecha_efe,       
      dc_id,                 dc_trn,                dc_numctrl,            dc_secuencial,      
      dc_ssn,                dc_ssn_branch,         nc_cta_banco,          dc_producto,        
      dc_tipo,               dc_tipo_chq,           dc_co_banco,           dc_no_banco,        
      dc_cta_cheque,         dc_num_cheque,         dc_valor,              dc_moneda,          
      dc_fechaemision,       dc_estado,             dc_user,               dc_hora,            
      dc_detalle,            dc_factor,             dc_cotizacion,         dc_valor_convertido,
      dc_mon_destino  
         from  cob_externos..re_detalle_cheque_mig, ah_numero_cuenta	
		 where dc_codigo between @i_clave_i and @i_clave_f  
           and nc_cta_banco_mig = dc_cta_banco           
		 and dc_estado_mig = 'VE'
		 
         if @@error <> 0
		 begin
			insert into ah_log_mig
			select top 1 convert(varchar, dc_codigo),
       		'INS',
       		convert(varchar, @i_clave_i),
       		convert(varchar, @i_clave_f),
       		convert(varchar, dc_codigo),
       		250,
       		dc_codigo,
               dc_cta_banco
			from re_detalle_cheque_mig
		 end   
   
go 

