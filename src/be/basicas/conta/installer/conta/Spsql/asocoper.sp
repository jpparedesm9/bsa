/************************************************************************/
/*      Archivo:                asocoper.sp                             */
/*      Stored procedure:       sp_asociacion_operaciones               */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           O. Escand¢n                             */
/*      Fecha de escritura:     15-MAR-1999                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Maneja la asociaci¢n de las operaciones bancarias con las 	*/
/*	operaciones contables. 						*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA        	AUTOR           RAZON                           */
/*      15/MAR/1999  	O. Escand¢n     Emision Inicial                 */
/*	06/ABR/1999	O. Escandon	Modificacion del tamano del	*/
/*					campo para operacion del banco  */
/*									*/
/*                                                                      */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_asociacion_operaciones')
	drop proc sp_asociacion_operaciones
go

create proc sp_asociacion_operaciones   (
	@s_ssn			int 		= null,
	@s_date			datetime 	= null,
	@s_user			login 		= null,
	@s_term			descripcion 	= null,
	@s_corr			char(1) 	= null,
	@s_ssn_corr		int 		= null,
        @s_ofi			smallint 	= null,
	@t_rty			char(1) 	= null,
        @t_trn			smallint 	= 602,
	@t_debug        	char(1) 	= 'N',
	@t_file         	varchar(14) 	= null,
	@t_from         	varchar(30) 	= null,
	@i_modo			int		= null,
	@i_operacion    	char(1) 	= null,
	@i_empresa  		tinyint 	= null,
	@i_banco 		char(3) 	= null,
	@i_operacion_entidad	char(10) 	= null,
	@i_operacion_banco	char(10) 	= null,
	@i_descripcion 		descripcion 	= null,
	@i_opera_extrac		char(1)		= 'D'
)
as
declare
	@w_return       	int,
	@w_sp_name      	varchar(32),
	@w_existe		smallint,
	@w_empresa  		tinyint,
	@w_banco 		char(3),
	@w_operacion_entidad	char(10),
	@w_operacion_banco	char(10),
	@w_descripcion 		descripcion,
	@w_opera_extrac		char(1)

select @w_sp_name = 'sp_asociacion_operaciones'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6244 or @i_operacion <> 'I') and
   (@t_trn <> 6245 or @i_operacion <> 'D') and
   (@t_trn <> 6247 or @i_operacion <> 'U') and
   (@t_trn <> 6246 or @i_operacion <> 'Q') 
   
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror 
	@t_debug = @t_debug,
	@t_file  = @t_file, 
	@t_from  = @w_sp_name,
	@i_num   = 601077
	return 1 
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_empresa	= @i_empresa,
		i_banco		= @i_banco,
		i_operacion_entidad 	= @i_operacion_entidad,
		i_operacion_banco 	= @i_operacion_banco,
		i_descripcion		= @i_descripcion

	exec cobis..sp_end_debug
end

if @i_operacion <> 'Q'
begin
	select	@w_empresa= ao_empresa,
		@w_banco= ao_banco,
		@w_operacion_entidad=ao_operacion_entidad,
		@w_operacion_banco=ao_operacion_banco,
		@w_descripcion=ao_descripcion,
		@w_opera_extrac=ao_operacion
	from cob_conta..cb_asociacion_operaciones
	where ao_empresa = @i_empresa
		and ao_banco = @i_banco
		and ao_operacion_entidad = @i_operacion_entidad
		and ao_operacion_banco  = @i_operacion_banco

	if @@rowcount > 0
	begin
		select @w_existe = 1
	end
	else
	begin
		select @w_existe = 0
	end
end

	
if @i_operacion = 'I'
begin
	if @w_existe = 1
	begin
		/* Registro a insertar ya existe */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file, 
		@t_from  = @w_sp_name,
		@i_num   = 601177
		return 1
	end

	insert into cb_asociacion_operaciones
	values (@i_empresa,@i_banco,@i_operacion_entidad,
	@i_operacion_banco,@i_descripcion,@i_opera_extrac)
	return 0
end


if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select  ao_empresa, ao_operacion_entidad, ao_operacion_banco,
			ao_descripcion, ao_operacion
		from 	cb_asociacion_operaciones
		where ao_empresa = @i_empresa
		and   ao_banco	 = @i_banco
		order by convert(int,ao_operacion_entidad), convert(int,ao_operacion_banco)
	end
	else
	begin
		select  ao_empresa, ao_operacion_entidad, ao_operacion_banco,
			ao_descripcion, ao_operacion
		from 	cb_asociacion_operaciones
		where ao_empresa = @i_empresa
		and   ao_banco	 = @i_banco
		and (
		(convert(int,ao_operacion_entidad) > convert(int,@i_operacion_entidad))
		or 
		((convert(int,ao_operacion_entidad) >= convert(int,@i_operacion_entidad))
		and (convert(int,ao_operacion_banco) > convert(int,@i_operacion_banco)))
		)
		order by convert(int,ao_operacion_entidad), convert(int,ao_operacion_banco)
	end
	set rowcount 0
	return 0
end


if @i_operacion = 'U'
begin
	if @w_existe = 0
	begin
		/* Registro a insertar no existe */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file, 
		@t_from  = @w_sp_name,
		@i_num   = 601178
		return 1 
	end

	update cb_asociacion_operaciones 
		set ao_descripcion = @i_descripcion, ao_operacion = @i_opera_extrac
	where	ao_empresa = @i_empresa
		and ao_banco = @i_banco
		and ao_operacion_entidad = @i_operacion_entidad
		and ao_operacion_banco  = @i_operacion_banco
	return 0
end


if @i_operacion = 'D'
begin
	if @w_existe = 0
	begin
		/* Registro a insertar no existe */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file, 
		@t_from  = @w_sp_name,
		@i_num   = 601178
		return 1
	end

	delete from cb_asociacion_operaciones
	where ao_empresa = @i_empresa
	and ao_banco = @i_banco
	and ao_operacion_entidad = @i_operacion_entidad
	and ao_operacion_banco  = @i_operacion_banco
	return 0
end
return 0

go
