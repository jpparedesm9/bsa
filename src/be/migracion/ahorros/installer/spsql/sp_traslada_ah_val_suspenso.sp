/************************************************************************/
/*  Archivo:                sp_traslada_ah_val_suspenso.sp              */
/*  Stored procedure:       sp_traslada_ah_val_suspenso                 */
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

if exists(select * from sysobjects where name = 'sp_traslada_ah_val_suspenso')
   drop proc sp_traslada_ah_val_suspenso
go

create proc sp_traslada_ah_val_suspenso(
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
       @w_comentario = 'VALORES DE SUSPENSO'
       
select @w_autorizante = fu_funcionario
from cobis..cl_funcionario
where fu_login = 'sa'
 
select @w_conteo = count(*)
from    ah_val_suspenso_mig
where vs_cuenta between @i_clave_i and @i_clave_f
and     vs_estado_mig = 'VE'
if @w_conteo = 0
   return 0

     -- ------------------------------------------------------------------
     -- - Cargo tabla definitiva
     -- ------------------------------------------------------------------

     insert cob_ahorros..ah_val_suspenso
     (
      vs_cuenta,             vs_secuencial,        vs_servicio,            vs_valor,       
      vs_oficina,            vs_fecha,             vs_hora,                vs_ssn,      
      vs_estado,             vs_procesada,         vs_clave,               vs_impuesto        
     )
     select
      vs_cuenta,             vs_secuencial,        vs_servicio,            vs_valor,       
      vs_oficina,            vs_fecha,             vs_hora,                vs_ssn,      
      vs_estado,             vs_procesada,         vs_clave,               vs_impuesto        
      from  cob_externos..ah_val_suspenso_mig, ah_numero_cuenta	
		 where vs_cuenta between @i_clave_i and @i_clave_f    
           and nc_cuenta_mig = vs_cuenta           
		 and vs_estado_mig = 'VE'
		 
         if @@error <> 0
		 begin
			insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
			select top 1 convert(varchar, vs_cuenta),
       		'INS',
       		convert(varchar, @i_clave_i),
       		convert(varchar, @i_clave_f),
       		convert(varchar, vs_cuenta),
       		284,
       		vs_cuenta
			from ah_val_suspenso_mig
		 end   
           
   update cobis..cl_seqnos set siguiente = (select isnull(max(vs_secuencial),0) + 1 from cob_ahorros..ah_val_suspenso)
		 							where bdatos = 'cob_ahorros'
         							and tabla  = 'ah_val_suspenso' 
                                        
return  0
go 

