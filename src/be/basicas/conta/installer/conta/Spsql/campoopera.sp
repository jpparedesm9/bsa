/************************************************************************/
/*	Archivo: 		campoopera.sp 			        */
/*	Stored procedure: 	sp_campos_operacion			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Claudia M. De Orcajo                   	*/
/*	Fecha de escritura:     23-Marzo-1999 				*/
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
/*	Este programa realiza la conciliacion con los campos de los     */
/*	registros contables seg£n el tipo de movimiento por realizarse. */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	23/Mar/1999	C. De orcajo    Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_campos_operacion')
	drop proc sp_campos_operacion  

go
create proc sp_campos_operacion   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 605,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_empresa	tinyint = null,
	@i_opera_entid 	char(4),
	@i_campo        char(4) 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_empresa	tinyint,
        @w_opera_entid  char(4),
	@w_campo	char(4),
        @w_existe       int             /*Codigo existe = 1
                                          no existe = 0*/ 
	

select @w_today = getdate()
select @w_sp_name = 'sp_campos_operacion'




/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6757 and @i_operacion = 'I') or
   (@t_trn <> 6758 and @i_operacion = 'D') or
   (@t_trn <> 6759 and @i_operacion = 'Q') 
    
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
		i_empresa	= @i_empresa,
		i_opera_entid 	= @i_opera_entid,
		i_campo	        = @i_campo 
	exec cobis..sp_end_debug
end


/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'Q' 
begin
        select  @w_empresa = co_empresa,
                @w_opera_entid = co_operacion_banco,
                @w_campo = co_campo
        from cob_conta..cb_conciliacion_operaciones
        where   co_empresa = @i_empresa
            and co_operacion_banco = @i_opera_entid
            and co_campo = @i_campo

        if @@rowcount > 0
                select @w_existe = 1
        else
                select @w_existe = 0
end                                     


/* Insercion de Operaciones de Conciliacion*/
/*************************/

if @i_operacion = 'I'
begin
	begin tran
		if @w_existe = 1 
		begin
			/* 'Codigo de organizacion ya existe           ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603066
			return 1
		end
	
	/* Insercion del registro */
	/**************************/
		insert into cb_conciliacion_operaciones
		values (@i_empresa,@i_opera_entid,@i_campo)
		if @@error <> 0 
		begin
			/* 'Error en insercion de Operaciones de Conciliacion ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603060
			return 1
		end

		commit tran
	return 0
end


/* Eliminacion de Operaciones de Conciliacion  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Operacion de Conciliacion a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603067
		return 1
	end

    delete cob_conta..cb_conciliacion_operaciones
	where co_empresa = @i_empresa 
	and	co_operacion_banco = @i_opera_entid 
	and co_campo = @i_campo

	if @@error <> 0
	begin
		/* 'Error en Eliminacion de Operaciones de Conciliacion' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607126
		return 1
	end

--	      commit tran
	return 0
end


/*  Query de Operaciones de Conciliacion */
/********/

if @i_operacion = 'Q'
begin
    select 
    "EMPRESA" = co_empresa,
    "CODIGO DE OPERACION" =  co_operacion_banco,
    "CAMPO" = co_campo
    from cob_conta..cb_conciliacion_operaciones
    where co_empresa = @i_empresa
      and co_operacion_banco = @i_opera_entid
    order by co_operacion_banco
      
      if @@rowcount = 0 
   
   /* 'No existen Operaciones de Conciliacion'*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 609135
	return 1
end

return 0
go
