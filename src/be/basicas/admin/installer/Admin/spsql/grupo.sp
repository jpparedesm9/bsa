/************************************************************************/
/*	Archivo: 		grupo.sp 			        */
/*	Stored procedure: 	sp_grupo				*/
/*	Base de datos:  	cobis    				*/
/*	Producto:               Referencias               		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     14-Ago-2006 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	'MACOSA', representantes exclusivos para el Ecuador de la 	*/
/*	'NCR CORPORATION'.						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa consulta los grupos de tasas creados		*/
/*	                                                                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	14/Ago/2006	N.Nieto     Emision Inicial			*/
/*                                                                      */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_grupo')
	drop proc sp_grupo
go



create proc sp_grupo   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 615,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_filial       tinyint = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_grupo   	catalogo = null,
	@i_area 	smallint = null,
	@i_estado       char(1) = null ,
	@i_codigo	descripcion = null,
	@i_tabla        varchar(30) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_filial       tinyint,
	@w_area		smallint,
	@w_grupo	catalogo,
	@w_descripcion	descripcion,
	@w_estado	char(1),
	@w_estado_ant	char(1),
	@w_codigo	descripcion,
        @w_nombre_exc   char(20),
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_grupo'


/************************************************/
/*  Tipo de Transaccion =     			*/
if (@t_trn <> 15986 and @i_operacion = 'L') or
   (@t_trn <> 15987 and @i_operacion = 'S') or
   (@t_trn <> 15988 and @i_operacion = 'V') or
   (@t_trn <> 15986 and @i_operacion = 'M') 
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
		i_grupo 	= @i_grupo,
		i_estado 	= @i_estado
	exec cobis..sp_end_debug
end

/********/


/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select @w_filial = de_filial,
	       @w_area   = de_departamento,
	       @w_descripcion = de_descripcion
	  from cobis..cl_departamento
	 where de_filial        = @i_filial
	   and de_departamento = @i_area 
	   
	if @@rowcount > 0
	begin
		select @w_existe = 1
	end
	else
	begin
		select @w_existe = 0
        end

end

if @i_operacion = 'L'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Grupo'       = codigo,
                       'Descripcion' = valor
		from cobis..cl_catalogo
		where tabla in (select codigo 
		                 from cl_tabla 
                                where tabla = 'te_grupos_tasas')
		order by codigo

 		if @@rowcount = 0
		begin
			/* 'No existen Oficinas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		
		select 'Grupo'       = codigo,
                       'Descripcion' = valor
		 from cobis..cl_catalogo
		where tabla in (select codigo 
		                 from cl_tabla 
                                where tabla = 'te_grupos_tasas')
                  and codigo > @i_grupo
		order by codigo
		

		if @@rowcount = 0
		begin
			/* 'No existen Oficinas'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
end

/**** Value  ****/
/****************/

if @i_operacion = 'V'
begin
	if @w_existe = 1
		select @w_descripcion
	else
	begin
		/* 'Area consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601128
		return 1
	end
	return 0
end


if @i_operacion = 'M'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Area' = de_departamento,
                       'Descripcion' = de_descripcion
		from cobis..cl_departamento
		where de_filial = @i_filial
		order by de_departamento

		if @@rowcount = 0
		begin
			/* 'No existen Areas '*/
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
		select 'Area' = de_departamento,
                       'Descripcion' = de_descripcion
		from cobis..cl_departamento
		where 	de_departamento > @i_area
		order by de_departamento

		if @@rowcount = 0
		begin
			/* 'No existen mas Areas'*/
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



go