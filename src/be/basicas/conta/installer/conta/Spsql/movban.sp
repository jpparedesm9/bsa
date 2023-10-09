/************************************************************************/
/*	Archivo: 		movban.sp  				*/
/*	Stored procedure: 	sp_mov_banco				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Juan C. G¢mez                          	*/
/*	Fecha de escritura:     18/Mayo/1999 				*/
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
/*	Este programa es el encargado de realizar las transacciones 	*/
/*	sobre la tabla cb_mov_banco					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	18/05/1999	Juan C. G¢mez	Emisi¢n Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_mov_banco')
    drop proc sp_mov_banco
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_mov_banco (
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
   @i_empresa            tinyint  = null,
   @i_banco		 varchar(3) = null,
   @i_tipo_reg		 tinyint = null	
)
as

declare
   	@w_return	int,          /* valor que retorna */
   	@w_sp_name      varchar(32),  /* nombre stored proc*/
	@w_existe	tinyint,
	@w_empresa	tinyint,
	@w_banco	varchar(3),
	@w_tipo_reg	tinyint	

select @w_sp_name = 'sp_mov_banco'

/***********************************************************/
/* Codigos de Transacciones                                */

if (@t_trn <> 6765 and @i_operacion = 'I') or
   (@t_trn <> 6766 and @i_operacion = 'U') or
   (@t_trn <> 6767 and @i_operacion = 'S') 
begin
	/* tipo de transaccion no corresponde */
    	exec cobis..sp_cerror
    	@t_debug = @t_debug,
    	@t_file  = @t_file, 
    	@t_from  = @w_sp_name,
    	@i_num   = 601077
    	return 1 
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' or @i_operacion <> 'I' or @i_operacion <> 'U'
begin
	select 	@w_empresa  = mb_empresa,
		@w_banco    = mb_banco,
		@w_tipo_reg = mb_tipo_registro
	from 	cb_mov_banco
	where	mb_empresa = @i_empresa and
		mb_banco   = @i_banco
		
	if @@rowcount > 0
        	select @w_existe = 1
    	else
            	select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
	if @i_empresa is NULL or @i_banco is NULL or @i_tipo_reg is NULL
    	begin
    		/* Campos NOT NULL con valores nulos */
        	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 601001
        	return 1 
    	end
end

/* INSERCION */
/*************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1
	begin
		/* Registro ya existe */
        	exec cobis..sp_cerror
        	@t_debug = @t_debug,
	        @t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 601160
        	return 1 
    	end
	
	begin tran

	insert into cb_mov_banco values (@i_empresa, @i_banco, @i_tipo_reg, @i_tipo_reg, @i_tipo_reg)

	if @@error <> 0 
        	begin
         	/* Error en insercion de registro */
             	exec cobis..sp_cerror
             	@t_debug = @t_debug,
             	@t_file  = @t_file, 
             	@t_from  = @w_sp_name,
             	@i_num   = 601161

		rollback tran
		
             	return 1 
        end
	
	commit tran
end

/* MODIFICAR */
/*************************/

if @i_operacion = 'U'
begin
    	if @w_existe = 0
    	begin
    		/* Registro a actualizar no existe */
        	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 605082
        	return 1 
    	end
	
	begin tran

	update cb_mov_banco set mb_tipo_registro = @i_tipo_reg
	where mb_empresa = @i_empresa and mb_banco = @i_banco

	if @@error <> 0 
        	begin
         	/* Error en la actualizaci¢n de registro */
             	exec cobis..sp_cerror
             	@t_debug = @t_debug,
             	@t_file  = @t_file, 
             	@t_from  = @w_sp_name,
             	@i_num   = 601162

		rollback tran
		
             	return 1 
        end
	
	commit tran
end


/* Consulta opcion SEARCH */
/*************************/

if @i_operacion = 'S'
begin
	if @w_existe = 1
		select @w_tipo_reg
	else
	begin
    		/*Registro no existe */
        	exec cobis..sp_cerror
        	@t_debug = @t_debug,
        	@t_file  = @t_file, 
        	@t_from  = @w_sp_name,
        	@i_num   = 605082
        	return 1 
    	end
end

return 0
go
