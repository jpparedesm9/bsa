/************************************************************************/
/*	Archivo:		catalpro.sp				*/
/*	Stored procedure:	sp_catalogo_pro				*/
/*	Base de datos:		cobis   			 	*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  		Sandra Ortiz	    			*/
/*	Fecha de escritura: 	24-Ago-1993				*/
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
/*	Este programa procesa las transacciones del stored procedure    */
/*	Insercion de catalogo_pro					*/
/*	Actualizacion de catalogo_pro					*/
/*	Borrado de catalogo_pro						*/
/*	Busqueda de catalogo_pro					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      24/Ago/93	S. Estevez      Actualizacion tabla-catalogo_pro*/
/*      13/Dic/93       R. Minga V.     Verificaciones de datos         */
/*	25/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_catalogo_pro')
	drop proc sp_catalogo_pro
go

create proc sp_catalogo_pro (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
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
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
        @i_operacion		varchar(2),
        @i_modo        		tinyint = null,
        @i_producto	        varchar(3) = null,
        @i_tabla		varchar(30) = null,
	@i_central_transmit     varchar(1) = null
)
as
declare @w_sp_name	    varchar(30),
       	@w_producto         char(3),
        @w_tabla	    smallint,
        @w_cmdtransrv       descripcion,
	@w_server_logico    varchar(10),
	@w_num_nodos        smallint,    
	@w_contador         smallint,
	@w_clave	    int,
	@w_return           smallint,
	@w_nt_nombre        varchar(40)


/*  Inicializa variables  */
select	@w_sp_name = 'sp_catalogo_pro'

/*  Modo de debug  */

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 586
begin
  /* Verificar si existe el producto */
  if not exists (select *
	    from cl_producto 
	   where pd_abreviatura = @i_producto)
  begin
	exec cobis..sp_cerror 
		/* No existe el producto */
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 101032
	return 1
  end

  /* Verificar que exista la tabla */
  select @w_tabla = codigo
    from cl_tabla
   where tabla = @i_tabla
    if @@rowcount != 1
     begin
	exec cobis..sp_cerror 
		/* No existe tabla */
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 101003
		return 1
     end

	/* verificar que no exista la tabla previamente */
	if exists (select *
		     from cl_catalogo_pro
		   where cp_tabla = @w_tabla
		     and cp_producto = @i_producto)
	begin
		exec cobis..sp_cerror 
			/* tabla ya existe */
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 101104
		return 1
	end

	begin tran
	     insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
			      values (@i_producto, @w_tabla)
	     if @@error != 0
	     begin
		exec cobis..sp_cerror 
			/* Error en la creacion de catalogo-producto */
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 103060 
		return 1
	     end

	/* transaccion de servicio */
	   insert into ts_cat_prod (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       producto, tabla)
		       values (@s_ssn, 586, 'N', @s_date,
			       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       	       @i_producto, @w_tabla)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	return 1
   end
  commit tran


  	return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end



/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 587
begin
  select @w_producto  = cp_producto,
	 @w_tabla     = cp_tabla
    from cl_catalogo_pro,
	 cl_tabla
   where tabla = @i_tabla
     and cp_producto = @i_producto
     and cp_tabla    = codigo
   if @@rowcount != 1
     begin
	exec cobis..sp_cerror 
		/* No existe tablas para este producto */
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 101097
	return 1
     end

  begin tran
     delete cl_catalogo_pro
     where  cp_producto  = @i_producto 
     and    cp_tabla 	 = @w_tabla

     if @@error != 0
     begin
	exec cobis..sp_cerror 
		/* Error en la eliminacion de catalogo_pro */
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 107053
	return 1
     end
/* transaccion de servicio */
   insert into ts_cat_prod (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       producto, tabla)
	       values (@s_ssn, 587, 'B', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_producto, @w_tabla)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	return 1
   end
  commit tran

  	return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end

/* Search */
if @i_operacion = 'S'
begin
if @t_trn = 1578
begin
   set rowcount 20
   if @i_modo = 0  
     select  'Descripcion' = substring(descripcion, 1, 30),  
 	     'Tabla'       = substring(tabla, 1, 30)
       from  cobis..cl_catalogo_pro,
	     cobis..cl_tabla
      where  cp_producto = @i_producto 
	and  codigo = cp_tabla
      order by tabla
   if @i_modo = 1
     select  'Descripcion' = substring(descripcion, 1, 30),  
 	     'Tabla'       = substring(tabla, 1, 30)
       from  cobis..cl_catalogo_pro,
	     cobis..cl_tabla
      where  cp_producto = @i_producto 
	and  codigo = cp_tabla
        and  convert(char(30),tabla) > @i_tabla
      order by tabla
     set rowcount 0
     return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end
go
