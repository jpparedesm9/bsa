/************************************************************************/
/*	Archivo: 		asoest.sp				*/
/*	Stored procedure: 	sp_asoest				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     16-Febrero-95 				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	   Relaciona asientos contables con detalles de estado de cta	*/
/*         para conciliacion bancaria					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	16/Feb/1995	G Jaramillo     Emision Inicial			*/
/*	09/Abr/1999	O. Escandon	Agregar el parametro @i_cuenta	*/
/*					Hacer uso de cob_conta_tercero  */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_asoest')
    drop proc sp_asoest
go
create proc sp_asoest (
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
   @i_empresa            tinyint  = null,
   @i_cuenta             cuenta = null,
   @i_fecha_tran         datetime  = null,
   @i_comprobante        int  = null,
   @i_asiento 		 smallint = null,
   @i_banco		 varchar(16) = null, 
   @i_fecha_est		 datetime = null,	
   @i_detalle		 smallint = null,
   @i_fecha1		 datetime = '01/01/90',
   @i_fecha2             datetime = '12/31/2018',
   @i_fecha3             datetime = null,
   @i_detalle1           smallint = null,
   @i_formato_fecha	 smallint = null,
   @i_relacionado        char(1)  = null,
   @i_refinterna	 int = null
  -- @i_cuenta		 varchar(20) = null
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_moneda		 tinyint,      /* moneda de la cuenta */
   @w_moneda_base        tinyint,      /* moneda base de la empresa*/
   @w_extranjera	 tinyint,      /* flag */
   @w_existe             tinyint       /* existe el registro*/

select @w_today = getdate()
select @w_sp_name = 'sp_asoest'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6832 and @i_operacion = 'U') or
   (@t_trn <> 6833 and @i_operacion = 'D') or
   (@t_trn <> 6838 and @i_operacion = 'T') 

begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 601077
    return 1 
end


/* Actualizacion de relacion*/
/****************************/

if @i_operacion = 'U'
begin
   begin tran 
      if @i_modo = 0
      begin
	update cob_conta_tercero..ct_conciliacion
	set cl_banco     = @i_banco,
	    cl_fecha_est = @i_fecha_est,
	    cl_detalle   = @i_detalle,
	    cl_relacionado = @i_relacionado,
	    cl_refinterna = @i_refinterna,
            cl_cuenta_cte = @i_cuenta,
            cl_fecha_conc = @s_date
	where   cl_empresa = @i_empresa and
		cl_fecha_tran = @i_fecha_tran and
		cl_comprobante = @i_comprobante and
		cl_asiento = @i_asiento 


	if @@error <> 0
	begin
           /*Error en relacion de conciliacion */
           	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 605083
        	return 1 
     	end
   end else
   begin
	update cob_conta_tercero..ct_detest
	set     de_comprobante = @i_comprobante, 
                de_fecha_asiento = @i_fecha_tran,
		de_asiento = @i_asiento,
		de_relacionado = @i_relacionado,
	        de_refinterna = @i_refinterna,
                de_fecha_conc = @s_date
	where de_empresa = @i_empresa and
		de_banco = @i_banco and
		de_fecha_tran = @i_fecha_est and
		de_detalle = @i_detalle
   	        and   de_cuenta = @i_cuenta



	if @@error <> 0
	begin
           /*Error en relacion de conciliacion */
           	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 605083      
        	return 1 
     	end
     end
   commit  tran
   return 0
end

/* Eliminacion de relacion*/
/**************************/

if @i_operacion = 'D'
begin
   begin tran
	update cob_conta_tercero..ct_conciliacion
	set --cl_banco = NULL,
	    cl_fecha_est = NULL,
	    cl_detalle = NULL,
	    cl_relacionado = 'N',
	    cl_refinterna = NULL
	where cl_empresa = @i_empresa
	and   cl_refinterna = @i_refinterna
   	and   cl_cuenta_cte = @i_cuenta		--OJE 

	if @@error <> 0
	begin
           /*Error en relacion de conciliacion */
           	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 605083
        	return 1 
     	end

	update cob_conta_tercero..ct_detest
	set de_fecha_asiento = NULL,
	    de_fecha_conc = NULL,
	    de_comprobante = NULL,
	    de_asiento = NULL,
	    de_relacionado = NULL,
	    de_refinterna = NULL
	where de_empresa = @i_empresa
	and   de_refinterna = @i_refinterna
	
	if @@error <> 0
	begin
           /*Error en relacion de conciliacion */
           	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 605083
        	return 1 
     	end
   commit  tran
return 0
end

/* Consulta de asientos contables relacionados a estados de cuentas */
/********************************************************************/

if @i_operacion = 'T'
begin
	if @i_modo = 0
	begin
/*
	   	select convert(char(10),cl_fecha_tran,@i_formato_fecha),
		  cl_comprobante,
                  cl_asiento,
		  cl_debcred,
		  cl_valor           
		from cob_conta_tercero..ct_conciliacion,cob_conta_tercero..ct_detest,cb_banco
	   	where    de_empresa      = @i_empresa and
			 de_banco        = ba_banco and
			 ba_cuenta       = @i_cuenta and
			 de_fecha        = @i_fecha_est and
			 de_detalle	 = @i_detalle and
			 de_comprobante  =  cl_comprobante and
			 de_asiento      =  cl_asiento and 
			 de_fecha_tran   =  cl_fecha_tran
	   		 and   de_cuenta = @i_cuenta	--OJE 
	   		 and   cl_cuenta_cte = @i_cuenta --OJE 

	   	order by cl_fecha_tran,cl_comprobante,cl_asiento
*/
	   	select 'Fecha' = convert(char(10),cl_fecha_tran,@i_formato_fecha),
		       'Comp'  = cl_comprobante, 
		       'As'    = cl_asiento, 
		       'DC'    = cl_debcred, 
		       'Valor' = cl_valor           
		from cob_conta_tercero..ct_conciliacion
		where cl_empresa = @i_empresa
		and   cl_refinterna = @i_refinterna
	   	and   cl_cuenta = @i_cuenta		--OJE 


	   	if @@rowcount = 0
       	   	begin
           	/*Registro no existe */
            		exec cobis..sp_cerror
        		@t_debug = @t_debug,
        		@t_file  = @t_file, 
        		@t_from  = @w_sp_name,
        		@i_num   = 601159
        		return 1 
    	   	end
	end
	if @i_modo = 1
	begin
/*
	   select 'Fecha'= convert(char(10),de_fecha,@i_formato_fecha),
		substring(de_referencia,1,10),de_detalle,
		de_debcred,de_valor,de_operacion
	   from cob_conta_tercero..ct_detest,cob_conta_tercero..ct_conciliacion,cb_banco 
	   where cl_empresa = @i_empresa and
		 cl_fecha_tran = @i_fecha_tran and
		 cl_comprobante = @i_comprobante and
		 cl_asiento = @i_asiento and
		 ba_banco = @i_banco  and
		 cl_cuenta_cte = ba_cuenta and 
                 cl_banco = de_banco and 
		 cl_fecha_tran = de_fecha and
		 cl_detalle = de_detalle
	   	and   de_cuenta = @i_cuenta	--OJE 
	   	and   cl_cuenta_cte = @i_cuenta	--OJE 


	   order by de_fecha,de_detalle
*/

	   select 'Fecha' = convert(char(10),de_fecha,@i_formato_fecha),
		  'Ref'   = substring(de_referencia,1,10),
		  'As'    = de_detalle,
		  'DC'    = de_debcred,
		  'Valor' = de_valor,
		  'Operacion' = de_operacion
	   from cob_conta_tercero..ct_detest
	   where de_empresa = @i_empresa
	   and   de_banco = @i_banco
	   and   de_refinterna = @i_refinterna
	   and   de_cuenta = @i_cuenta		--OJE 

	   if @@rowcount = 0
           begin
    	 /* No existen registros */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 601150
                return 1 
           end
	end
return 0
end
go
