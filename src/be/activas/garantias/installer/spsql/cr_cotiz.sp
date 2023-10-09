/***********************************************************************/
/*	Archivo:			cr_cotiz.sp                    */
/*	Stored procedure:		sp_cotizacion                  */
/*	Base de Datos:			cob_credito                    */
/*	Producto:			Credito	                       */
/*	Disenado por:			Myriam Davila                  */
/*	Fecha de Documentacion: 	27/Jul/95                      */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T							       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/*			PROPOSITO				       */
/*	Este store procedure dada una monto y la moneda  	       */ 
/*	retorna el monto traducido a la moneda local		       */
/*								       */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	27/Jul/95	Myriam Davila		Emision Inicial	       */
/***********************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_cotizacion')
    drop proc sp_cotizacion
go
create proc sp_cotizacion (
   @s_ssn                int      = null,
   @s_date               datetime = null,
   @s_user               login    = null,
   @s_term               descripcion = null,
   @s_ofi                smallint  = null,
   @s_srv		 varchar(30) = null,
   @s_lsrv	  	 varchar(30) = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_moneda 		 money,
   @i_monto		 money    = null,
   @i_fecha              datetime = null,
   @i_operacion          char(1)  = null,
   @o_cotiz 		 money out
)
as
declare
   @w_today		datetime,     /* fecha del dia */ 
   @w_return            int,          /* valor que retorna */
   @w_sp_name           varchar(32),  /* nombre stored proc*/
   @w_mon_loc		tinyint,
   @w_cotizacion	money,
   @w_decimales         tinyint


--select @w_today = getdate()
select @w_today = @s_date
select @w_sp_name = 'sp_cotizacion'

/* Debug */
/*********/

if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file = @t_file
        select '/** Stored Procedure **/ ' = @w_sp_name,
                s_ssn                      = @s_ssn,
                s_user                     = @s_user,
                s_term                     = @s_term,
                s_date                     = @s_date,
                s_srv                      = @s_srv,
                s_lsrv                     = @s_lsrv,
                s_ofi                      = @s_ofi,
		t_trn			   = @t_trn,
		t_file			   = @t_file,
		t_from			   = @t_from,
		i_moneda		   = @i_moneda,
   		i_monto			   = @i_monto,
		o_cotiz			   = @o_cotiz
    exec cobis..sp_end_debug
end

exec sp_decimales
     @i_moneda    = @i_moneda,
     @o_decimales = @w_decimales out 


if 1 = 1
begin
/**** ENCONTRAR LA COTIZACION DE LA MONEDA */


     if @i_operacion = 'I' or @i_operacion = 'C'   
     begin
	select @w_cotizacion = cv_valor 	from   cob_conta..cb_vcotizacion
        where  cv_moneda = convert(tinyint,@i_moneda)
	and    cv_fecha in (select max(cv_fecha)
			    from cob_conta..cb_vcotizacion
			    where cv_fecha <= @i_fecha
                              and cv_moneda = convert(tinyint,@i_moneda))
        select @o_cotiz = isnull(@w_cotizacion,1)
      return 0
     end
     else 
     begin
	select @w_cotizacion = cv_valor
	from   cob_conta..cb_vcotizacion
        where  cv_moneda = @i_moneda
	and    cv_fecha in (select max(cv_fecha)
			    from cob_conta..cb_vcotizacion
			    where cv_fecha <= @i_fecha
                              and cv_moneda = convert(tinyint,@i_moneda))
        select @o_cotiz = isnull(@w_cotizacion,1)
	return 0
     end   
   select @o_cotiz = isnull(@w_cotizacion,1)
   return 0


end
go