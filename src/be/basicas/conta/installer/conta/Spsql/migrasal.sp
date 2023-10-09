/************************************************************************/
/*	Archivo: 		migrasal.sp  			        */
/*	Stored procedure: 	sp_migrasal				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               Contabilidad                		*/
/*	Disenado por:           Martha Gil Valdes  	        	*/
/*	Fecha de escritura:     07-Enero-1998				*/
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
/*	   Mantenimiento al catalogo de saldos de Presupuesto   	*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	07/Ene/1998	Marta Gil V     Emision Inicial			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_migrasal')
	drop proc sp_migrasal  
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_migrasal (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa              tinyint = null,
	@i_oficina		smallint = null,
        @i_oficina_conta	smallint = null,
	@i_cuenta         	cuenta= null,
	@i_asiento  		smallint = null 	
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint
 
select @w_today = getdate()
select @w_sp_name = 'sp_migrasal'

/************************************************/
/* Valida Tipo de Transaccion 			*/


if (@t_trn <> 6602 and @i_operacion = 'U')
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
		i_empresa 	= @i_empresa,
		i_cuenta   	= @i_cuenta ,
                i_oficina	= @i_oficina,
		i_asiento	= @i_asiento
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

/* Validacion de datos para  actualizacion            */
/******************************************************/

if @i_operacion =  'U'
begin

	/* Validacion de datos */
	/***********************/

	if 	@i_empresa is null or 
		@i_cuenta  is null or
                @i_oficina is null or
		@i_asiento is null
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

  if @i_modo = 1
 
  begin
	/**** Integridad Referencial *****/
	/*********************************/

        if NOT EXISTS (select * from cob_conta..cb_migsaldos
			where  msd_empresa      = @i_empresa
    			  and  msd_oficina_orig = @i_oficina
    			  and  msd_cuenta       = @i_cuenta
    			  and  msd_asiento      = @i_asiento)
	begin
		/* 'No existe registro ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601166
		return 1
	end


	/* Actualizacion de la oficina */
	/*************************/

	begin tran
		update cob_conta..cb_migsaldos
		set    msd_oficina_orig = @i_oficina_conta
  		where  msd_empresa      = @i_empresa
    		  and  msd_oficina_orig = @i_oficina
    		  and  msd_cuenta       = @i_cuenta
    		  and  msd_asiento      = @i_asiento  
		if @@error <> 0 
		begin
		/*'Error en actualizacion de la oficina'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605077
			return 1
		end

	commit tran
	return 0
  end

  if @i_modo = 2
  begin

	/**** Integridad Referencial *****/
	/*********************************/

        if NOT EXISTS (select * from cob_conta..cb_migsaldos
			where  msd_empresa      = @i_empresa
    			  and  msd_oficina_dest = @i_oficina
    			  and  msd_cuenta       = @i_cuenta
    			  and  msd_asiento      = @i_asiento)
	begin
		/* 'No existe registro ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601166
		return 1
	end


	/* Actualizacion de la oficina */
	/*************************/

	begin tran
		update cob_conta..cb_migsaldos
		set    msd_oficina_dest = @i_oficina_conta
  		where  msd_empresa      = @i_empresa
    		  and  msd_oficina_dest = @i_oficina
    		  and  msd_cuenta       = @i_cuenta
    		  and  msd_asiento      = @i_asiento  
		if @@error <> 0 
		begin
		/*'Error en actualizacion de la oficina'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605077
			return 1
		end

	commit tran
	return 0
  end
end
go
