/************************************************************************/
/*	Archivo: 		campoarch.sp 			        */
/*	Stored procedure: 	sp_campo_archivo			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Claudia M. De Orcajo                  	*/
/*	Fecha de escritura:     24-Mar-1999 				*/
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
/*	Este programa trae los datos de la tabla cb_campo_archivo       */
/*	   Mantenimiento al catalogo de areas	                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*    24/Mar/99	        C. De Orcajo    Emision Inicial                 */
/*                                      Especificacion COR060    	*/
/*							                */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_campo_archivo')
	drop proc sp_campo_archivo

go
create proc sp_campo_archivo   (
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
	@i_codigo               char(3) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_existe	int,
        @w_codigo       char,        		/* codigo existe = 1 */	
        @w_nombre       varchar(40)             /*  no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_campo_archivo'

/* Chequeo de Existencias */
/**************************/


if  @i_operacion <> 'A'
begin
        select  @w_nombre = cb_nombre
        from    cob_conta..cb_campos_banco
        where   cb_codigo = @i_codigo 
             
            

        if @@rowcount > 0                       
        begin
             select @w_existe = 1
        end
        else
        begin
             select  @w_existe = 0
                        
        end

end                                            

/************************************************/
/*  Tipo de Transaccion  			*/

if (@t_trn <> 6760 and @i_operacion = 'A') 
   
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
		i_empresa	= @i_codigo
	exec cobis..sp_end_debug
end


/*  All */
/********/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'CODIGO' = cb_codigo, 'NOMBRE' = cb_nombre
		from cob_conta..cb_campos_banco
		order by cb_codigo

		if @@rowcount = 0
		begin
			/* 'No existen campos banco '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601129
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'CODIGO' = cb_codigo, 'NOMBRE' = cb_nombre
		from cob_conta..cb_campos_banco
		where 	cb_codigo > @i_codigo 
		order by cb_codigo

		if @@rowcount = 0
		begin
			/* 'No existen campos banco'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601130
			return 1
		end
		set rowcount 0
		return 0
	end
end

/****************************/
/* Query de Areas           */
/****************************/

if @i_operacion = 'Q'
begin
        
         
         if @w_existe = 1
            select @w_nombre 
	    
	 else       
              

        /* 'Area consultada no existe ' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
        return 1
end                            

go
