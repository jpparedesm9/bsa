/************************************************************************/
/*      Archivo:                prodproc.sp                             */
/*      Stored procedure:       sp_producto_procesado                   */
/*      Base de datos:          cob_conta                               */
/*      Producto:               Interface Contable                      */
/*      Disenado por:           L. Tandazo                              */
/*      Fecha de escritura:     11/Julio/1996                           */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa la consulta de productos procecesados     */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      11/07/96	L. Tandazo	Emision inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_producto_procesado')
	drop proc sp_producto_procesado

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_producto_procesado   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 602,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null,
	@t_from         varchar(30) = null,
	@i_operacion    char(1) = null,
	@i_empresa      tinyint = null,
	@i_producto     tinyint = null,
	@i_fecha	datetime = null,
	@i_fecha1	datetime = null,
	@i_formato_fecha smallint = null,
	@i_estado	char(1) = null,
	@i_modo         smallint = null
)
as 
declare @w_hoy		datetime,
	@w_return       int,
	@w_sp_name      varchar(32),
	@w_existe       int,
	@w_producto 	tinyint,
	@w_fecha	datetime,
	@w_estado	char(1)
	

select @w_hoy = getdate()
select @w_sp_name = 'sp_producto_procesado'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6798 or @i_operacion <> 'S')
   and (@t_trn <> 6799 or @i_operacion <> 'I')
   and (@t_trn <> 6800 or @i_operacion <> 'U')
   and (@t_trn <> 6809 or @i_operacion <> 'D')
   and (@t_trn <> 6810 or @i_operacion <> 'Q')
   
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_producto      = @i_producto,
		i_fecha		= @i_fecha
	exec cobis..sp_end_debug
end

if @i_operacion = 'S'
begin
	set rowcount 5
 	if @i_modo = 0
		select  'Codigo'      = pe_producto,
			'Producto'    = substring(pd_descripcion,1,32),
			'Fecha'       = convert(char(10), pe_fecha, @i_formato_fecha),
                        'Estado '     = pe_procesado
		from cobis..cl_producto, cb_producto_procesado
		where ((pd_producto = @i_producto and @i_producto is not null)
		   or @i_producto is null)
		   and pe_empresa = @i_empresa
		   and pd_producto = pe_producto
		   and ((pe_fecha = @i_fecha and @i_fecha is not null)
		   or @i_fecha is null)


 	if @i_modo = 2
		select  'Codigo'      = pe_producto,
			'Producto'    = substring(pd_descripcion,1,32),
			'Fecha'       = convert(char(10), pe_fecha, @i_formato_fecha),
                        'Estado '     = pe_procesado
		from cobis..cl_producto, cb_producto_procesado
		where pe_empresa = @i_empresa
		   and pd_producto = pe_producto
		   and (pd_producto = @i_producto and pe_fecha > @i_fecha1)

 	if @i_modo = 1
		select  'Codigo'      = pe_producto,
			'Producto'    = substring(pd_descripcion,1,32),
			'Fecha'       = convert(char(10), pe_fecha, @i_formato_fecha),
                        'Estado '     = pe_procesado
		from cobis..cl_producto, cb_producto_procesado
		where pd_producto > @i_producto
		   and pe_empresa = @i_empresa
		   and pd_producto = pe_producto
		   and pe_fecha = @i_fecha

 	if @i_modo = 3
		select  'Codigo'      = pe_producto,
			'Producto'    = substring(pd_descripcion,1,32),
			'Fecha'       = convert(char(10), pe_fecha, @i_formato_fecha),
                        'Estado '     = pe_procesado
		from cobis..cl_producto, cb_producto_procesado
		where pe_empresa = @i_empresa
		   and pd_producto = pe_producto
		   and (pd_producto > @i_producto
		   or (pd_producto = @i_producto and pe_fecha > @i_fecha1))

	set rowcount 0
end

if @i_operacion = 'I' or @i_operacion = 'U' 
   or @i_operacion = 'Q' or @i_operacion = 'D'
begin
	select *
	from cb_producto_procesado
	where pe_empresa = @i_empresa
	   and pe_producto = @i_producto
	   and pe_fecha = @i_fecha
	if @@rowcount = 0
		select @w_existe = 0
	else
		select @w_existe = 1
end

if @i_operacion = 'I'
Begin
	if @w_existe = 1
	begin
		/* 'Codigo ya existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601160
		return 1
	end
	if not exists (select *
			from cobis..cl_producto
			where pd_producto = @i_producto)
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end

	
	/* Insercion del registro */
	/**************************/
	begin tran
		insert into cb_producto_procesado
		       (pe_empresa, pe_producto, pe_fecha, pe_procesado)
		values (@i_empresa, @i_producto, @i_fecha, @i_estado)
		if @@error <> 0 
		begin
			/* 'Error en insercion de registro ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601161
			return 1
		end

	commit tran
	return 0
end

/* Actualizacion (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	begin tran
		update cb_producto_procesado
		set pe_procesado = @i_estado
		from cb_producto_procesado
		where pe_empresa = @i_empresa
	   	   and pe_producto = @i_producto
	   	   and pe_fecha = @i_fecha

		if @@error <> 0
		begin
			/* 'Error en actualizacion de registro	*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601162
			return 1
		end
		
	commit tran
	return 0
end

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	begin tran
		delete
		from cb_producto_procesado
		where pe_empresa = @i_empresa
	   	and pe_producto = @i_producto
	   	and pe_fecha = @i_fecha
	commit tran
	return 0
end
	
if @i_operacion = 'Q'
begin
	if @w_existe = 0 
	begin
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	begin tran
	select @w_producto = pe_producto,
		@w_fecha = pe_fecha,
		@w_estado = pe_procesado
	from cb_producto_procesado
	where pe_empresa = @i_empresa
	   and pe_producto = @i_producto
	   and pe_fecha = @i_fecha
	commit tran
	return 0
end
	
return 0
go
