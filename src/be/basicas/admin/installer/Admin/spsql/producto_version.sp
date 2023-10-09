/************************************************************************/
/*      Archivo:                producto.sp                             */
/*      Stored procedure:       sp_producto_version                     */
/*      Base de datos:          cobis	                                */
/*      Producto:               Control de Version                      */
/*      Disenado por:           M.E.Segura                              */
/*      Fecha de escritura:     24-julio-2001                           */
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
/*      Este programa procesa las transacciones de:                     */
/*    Mantenimiento a la tabla de productos para control de version     */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_producto_version')
	drop proc sp_producto_version

go
create proc sp_producto_version   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		varchar(32) = null,
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
	@i_submodulo    char(10) = null,
	@i_estado       char(1) = null,
	@i_modo         smallint = null
)
as 
declare
	@w_hoy          datetime,
	@w_return       int,
	@w_sp_name      varchar(32),
	@w_existe       int,
	@w_parametro    varchar(10)

select @w_hoy = getdate()
select @w_sp_name = 'sp_producto_version'


/*  Tipo de Transaccion = 			*/

if (@t_trn <> 28745 or @i_operacion <> 'I') and
   (@t_trn <> 28746 or @i_operacion <> 'S') 
   
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 3250000
	return 1
end


if @i_operacion = 'S'
begin
 	if @i_modo = 0
		select  'Producto'    = substring(pd_descripcion,1,32),
                        'Estado '     = pr_version,
                        'Empresa'     = pr_empresa,
			'Codigo'      = pr_producto 
		from cl_producto, ve_producto
		where pd_producto = pr_producto

	else
		select  'Producto'    = substring(pd_descripcion,1,32),
                        'Estado '     = pr_version,
                        'Empresa'     = pr_empresa,
			'Codigo'      = pr_producto
		from cl_producto, ve_producto
	        where pd_producto > @i_producto
end

/* Insercion */
/*************************/

if @i_operacion = 'I'
begin
	if exists (select * from ve_producto 
			where pr_empresa = @i_empresa
                          and pr_producto = @i_producto)
	begin
		delete from ve_producto 
			where pr_empresa = @i_empresa
                          and pr_producto = @i_producto
	end
	
	/* Insercion del registro */
	/**************************/
	begin tran
		insert into ve_producto
		       (pr_producto,pr_version,pr_fecha_mod,pr_empresa)
		values (@i_producto,@i_estado,@w_hoy,@i_empresa)
		if @@error <> 0 
		begin
			/* 'Error en insercion de registro ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 3255010
			return 1
		end

	commit tran
	return 0
end

go
