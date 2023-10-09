/************************************************************************/
/*  Archivo:                sp_traslada_re_accion_nd.sp                 */
/*  Stored procedure:       sp_traslada_re_accion_nd                    */
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

if exists(select * from sysobjects where name = 'sp_traslada_re_accion_nd')
   drop proc sp_traslada_re_accion_nd
go

create proc sp_traslada_re_accion_nd(
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
       @w_comentario = 'ACCION ND'
       
select @w_autorizante = fu_funcionario
from cobis..cl_funcionario
where fu_login = 'sa'
 
select @w_conteo = count(*)
from    re_accion_nd_mig
where an_causa between @i_clave_i and @i_clave_f
and   an_estado_mig = 'VE'
if @w_conteo = 0
   return 0

     -- ------------------------------------------------------------------
     -- - Cargo tabla definitiva
     -- ------------------------------------------------------------------

     insert cob_remesas..re_accion_nd
     (
      an_producto,             an_causa,            an_accion,              an_comision,       
      an_impuesto,             an_modo,             an_saldomin                             
     )
     select
      an_producto,             an_causa,            an_accion,              an_comision,       
      an_impuesto,             an_modo,             an_saldomin 
         from  cob_externos..re_accion_nd_mig	
		 where an_causa between @i_clave_i and @i_clave_f         
		 and an_estado_mig = 'VE'
		 
         if @@error <> 0
		 begin
			insert into ah_log_mig(lm_id_reg,lm_tabla,lm_fuente,lm_columna,lm_dato,lm_error,lm_operacion)
			select top 1 convert(varchar, an_causa),
       		'INS',
       		convert(varchar, @i_clave_i),
       		convert(varchar, @i_clave_f),
       		convert(varchar, an_causa),
       		280,
       		an_causa
			from re_accion_nd_mig
		 end   
   
go 

