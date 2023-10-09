/************************************************************************/
/*	Archivo: 	        credito3.sp                             */ 
/*	Stored procedure:       sp_credito3                             */ 
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           Rodrigo Garces                   	*/
/*			        Luis Alfredo Castellanos              	*/
/*	Fecha de escritura:     Junio-1995  				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Consulta todos los tramites de una garantia.                    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	Jun/1995		     Emision Inicial			*/
/*	Oct/20160		     Migracion Cobis Cloud			*/
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_credito3')
    drop proc sp_credito3
go
create proc sp_credito3       (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_corr               char(1)  = null,
   @s_ssn_corr           int      = null,
   @s_ofi                smallint  = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_garantia           descripcion = null,
   @i_tramite            int = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_scu                varchar(64),
   @w_fecha			 datetime

select @w_today = @s_date
select @w_sp_name = 'sp_credito3'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 19444 and @i_operacion = 'S') 
     
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end

if @i_operacion = 'S'
begin
   set rowcount 20
   select 
	tr_tramite,
	tr_numero_op,
	((1-floor(power(cos(gp_monto_exceso),2))) * gp_monto_exceso 
	  + floor(power(cos(gp_monto_exceso),2)) * tr_monto * isnull(cv_valor,1)),
	tr_monto * isnull(cv_valor,1)
   from cob_credito..cr_gar_propuesta,
        cob_conta..cb_vcotizacion right outer join cob_credito..cr_tramite on cv_moneda = tr_moneda
   where gp_garantia  =  @i_garantia
     and gp_tramite   =  tr_tramite
     and cv_fecha     =  dateadd(dd,-1,@s_date)
     and (tr_tramite  >  @i_tramite or @i_tramite is null)
 
   if @@rowcount = 0
      if @i_tramite is null
         print 'No existen tramites para esta garantia'
      else
         print 'No existen mas tramites para esta garantia'
end
go

