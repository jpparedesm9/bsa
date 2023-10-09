/************************************************************************/
/*	Archivo: 		temctip.sp			        */
/*	Stored procedure: 	sp_temctip 				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Grava la cabecera de los comprobantes tipo  a la tabla       */
/*	   temporal							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_temctip')
	drop proc sp_temctip  
go
create proc sp_temctip    (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_comp_tipo	int = null,
	@i_empresa	tinyint = null,
	@i_modificable	char(1) = null,
        @i_referencia   varchar(10) = null,
	@i_concepto   	char(255) = null,
	@i_oficina_orig smallint = null,
	@i_area_orig	smallint = null,
	@i_porcentual   char(1) = null,
	@i_detalles	int = null
	
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/

	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */
	@w_empresa	tinyint ,
	@w_siguiente	int

select @w_today = getdate()
select @w_sp_name = 'sp_temctip'




/************************************************/
/*  Tipo de Transaccion = 612X 			*/

if (@t_trn <> 6338 and @i_operacion = 'I') or
   (@t_trn <> 6339 and @i_operacion = 'U') 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa  	= @i_empresa,      
		i_comp_tipo	= @i_comp_tipo,
		i_modificable	= @i_modificable,
		i_concepto   	= @i_concepto,
		i_oficina_orig	= @i_oficina_orig,
		i_area_orig	= @i_area_orig,
		i_porcentual	= @i_porcentual,
		i_detalles	= @i_detalles
	exec cobis..sp_end_debug
end

if NOT EXISTS (select * from cb_empresa
		where em_empresa = @i_empresa)

begin
	/* 'Empresa especificada no existe' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601018
	return 1
end



if @i_operacion = 'I'
begin
	begin tran
	    
            exec @w_return = cob_conta..sp_cseqcomp
                                        @i_empresa = @i_empresa,
                                        @i_fecha   = @w_today,
                                        @i_tabla   = 'cb_comp_tipo',
                                        @i_modulo  = 6,
                                        @i_modo    = 1,
                                        @o_siguiente = @w_siguiente out

            if @w_return <> 0
		return @w_return
	    else 
		select @w_siguiente

	
	    insert into cb_tcomp_tipo (tt_comp_tipo,tt_empresa,tt_modificable,
		tt_concepto,tt_oficina_orig,tt_area_orig,tt_porcentual,
	        tt_referencia,tt_detalles) /* SYR 31/10/1997 */
	    values (@w_siguiente,@i_empresa,@i_modificable,
		    @i_concepto,@i_oficina_orig,@i_area_orig,
		    @i_porcentual, @i_referencia, @i_detalles)

	    if @@error <> 0
	    begin
	    /* 'Error en insercion de cabecera de comprobante tipo en tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603045

		return 1
	    end
	commit tran
return 0
end


if @i_operacion = 'U'
begin

        if exists (select * from cb_tcomp_tipo
                   where  tt_comp_tipo = @i_comp_tipo)
        begin
              delete cb_tcomp_tipo
                   where  tt_comp_tipo = @i_comp_tipo
        end 

        
	begin tran
	
            

	    insert into cb_tcomp_tipo (tt_comp_tipo,tt_empresa,tt_modificable,
			tt_concepto,tt_oficina_orig,tt_area_orig,
			tt_porcentual,tt_referencia,tt_detalles)
	    values     (@i_comp_tipo,@i_empresa,@i_modificable,
			@i_concepto,@i_oficina_orig,@i_area_orig,
			@i_porcentual,@i_referencia,@i_detalles)

	    if @@error <> 0
	    begin
	    /* 'Error en insercion comprobante tipo en tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603045
		return 1
	    end
	commit tran
return 0
end
go


