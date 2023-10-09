/************************************************************************/
/*	Archivo:		promon.sp				*/
/*	Stored procedure:	sp_pro_mon_con 				*/
/*	Base de datos:		cobis					*/
/*	Producto: controlador						*/
/*	Disenado por:  Patricio Martinez/Diego Hidalgo 			*/
/*	Fecha de escritura: 03/03/95 					*/
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
/*      Busqueda de todos los producto-moneda                           */
/*      Actualizacion del estado de un producto-moneda                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      03/03/95        Diego Hidalgo 	Emision inicial 		*/
/*  21/04/2016  BBO         Migracion SYB-SQL FAL                       */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_pro_mon_con')
   drop proc sp_pro_mon_con
go

create proc sp_pro_mon_con (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = NULL,
	@t_from			varchar(32) = NULL,
	@t_trn			smallint = NULL,
	@i_operacion	    	char(1) = NULL,
	@i_modo                 smallint = NULL,
	@i_producto	    	tinyint = NULL,
	@i_moneda	    	tinyint = NULL,
	@i_tipo 	    	char(1) = NULL,
	@i_descripcion	    	descripcion = NULL,
	@i_estado               char(1) = NULL
)
as
declare
	@w_sp_name	    varchar(32),
	@w_today	    datetime,
	@o_producto	    tinyint,
	@o_moneda	    tinyint,
	@o_tipo		    char(1),
	@o_descripcion	    descripcion,
	@o_estado           char(1)


select @w_today = @s_date
select @w_sp_name = 'sp_pro_mon_con'


/** Search **/
If @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	   begin
		select 	'DESCRIPCION' = substring(pm_descripcion,1,32),
			'ESTADO '      = pm_estado,
			'PRODUCTO '    = pm_producto,
		        'MONEDA '      = pm_moneda,
			'TIPO'        = pm_tipo
		  from	cl_pro_moneda
		if @@rowcount = 0
  		   begin
   		        exec sp_cerror
	   		    @t_debug    	= @t_debug,
	   		    @t_file		= @t_file,
	   		    @t_from		= @w_sp_name,
	   		    @i_num	       	= 101031
	  		    /*'No existe producto moneda'*/
		        set rowcount 0
   		        return 1
 		   end
	   end

	if @i_modo = 1
 	  begin
		select 	'DESCRIPCION' = substring(pm_descripcion,1,32),
			'ESTADO '      = pm_estado,
			'PRODUCTO '    = pm_producto,
		        'MONEDA '      = pm_moneda,
			'TIPO'        = pm_tipo
		  from	cl_pro_moneda
		where (
			(pm_producto > @i_producto)
		    or  ((pm_producto = @i_producto) and (pm_tipo > @i_tipo))
		    or  ((pm_producto = @i_producto) and (pm_tipo = @i_tipo)
			 and (pm_moneda > @i_moneda))
			)
		if @@rowcount = 0
  		  begin
   			exec sp_cerror
	   		    @t_debug	= @t_debug,
	   		    @t_file		= @t_file,
	   		    @t_from		= @w_sp_name,
	   		    @i_num	       	= 101031
	  		    /*'No existe producto moneda'*/
		            set rowcount 0
   		            return 1
 		  end
	  end
end

/** Update **/ 
If @i_operacion = 'U'
begin
	/* chequeo de claves */
	if (@i_producto is NULL OR @i_moneda is NULL OR @i_tipo is NULL)
	  begin
		/* No se llenaron todos los campos */
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 20500
		return 1
	  end

	if not exists(	
		select pm_producto
		from cl_pro_moneda
		where pm_producto = @i_producto
		and   pm_moneda = @i_moneda
		and   pm_tipo = @i_tipo
		)
	  begin
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 20500 
			/* 'Producto-Moneda no existe' */
		return 1
	  end

	begin tran
	  Update cl_pro_moneda
	     set pm_estado = @i_estado
	  where  pm_producto = @i_producto
	    and  pm_moneda = @i_moneda
	    and  pm_tipo = @i_tipo
	  if @@error != 0
	    begin
		/*Error en la actualizacion de pro_moneda*/
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 20500 
		return 1
	    end
	  /* transaccion de servicio */

	  commit tran
	  return 0
	end



go  

