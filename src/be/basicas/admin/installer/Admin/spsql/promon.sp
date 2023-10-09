/************************************************************************/
/*	Archivo:		promon.sp				*/
/*	Stored procedure:	sp_pro_mon				*/
/*	Base de datos:		cobis					*/
/*	Producto: clientes						*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 27-Nov-1992					*/
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
/*	Insercion de producto - moneda					*/
/*	Actualizacion del producto - moneda				*/
/*	Borrado del producto - moneda					*/
/*	Busqueda del producto - moneda					*/
/*	Query del producto - moneda					*/
/*	Ayuda del producto - moneda					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	27/Nov/92	M. Davila	Emision inicial 		*/
/*	11/Ene/93	L. Carvajal	Debug, error			*/
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	08/May/95	S. Vinces       Admin Distribdo    		*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_pro_mon')
   drop proc sp_pro_mon
go

create proc sp_pro_mon (
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
	@i_operacion	    	varchar(1),
	@i_tipo_s	    	tinyint = null,
	@i_tipo_h	    	varchar(1) = null,
	@i_modo		    	tinyint = null,
	@i_tipo 	    	char(1) = null,
	@i_producto	    	tinyint = null,
	@i_moneda	    	tinyint = null,
	@i_estado               estado = NULL,
	@i_descripcion	    	descripcion = null,
	@i_central_transmit	varchar(1) = null
)
as
declare
	@w_sp_name	    varchar(32),
	@w_today	    datetime,
	@w_aux		    int,
	@w_producto	    tinyint,
	@w_tipo	            char(1),
	@w_estado           estado,   
	@w_moneda           tinyint,
	@w_descripcion	    descripcion,
	@v_producto	    tinyint,
	@v_tipo	            char(1),
	@v_estado           estado,   
	@v_moneda           tinyint,
	@v_descripcion	    descripcion,
	@o_producto	    tinyint,
	@o_prnombre	    descripcion,
	@o_tipo		    char(1),
	@o_moneda	    tinyint,
	@o_monombre	    descripcion,
	@o_descripcion	    descripcion,
	@o_estado     	    estado,
	@o_desc_estado   	descripcion,      
	@w_num_nodos        smallint,    
	@w_contador          smallint,
	@w_cmdtransrv	    varchar(64),
	@w_nt_nombre        varchar(32),
	@w_clave		int,
	@w_return 		int


select @w_today = @s_date
select @w_sp_name = 'sp_pro_mon'

/** Insert **/
if @i_operacion = 'I'
begin
if @t_trn = 1524  
begin
/* Verificacion de claves foraneas */

if not exists (
	select pd_producto
	  from cl_producto
	 where pd_producto = @i_producto
           and pd_tipo = @i_tipo)
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101032
	  /*"Producto no existe"*/
	return 1
end

if not exists (
	select mo_moneda
	  from cl_moneda
	 where mo_moneda = @i_moneda)
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101045
	  /* "Moneda no existe"*/
	return 1
end

if  exists (
	select pm_producto 
	  from cl_pro_moneda
	 where pm_producto = @i_producto
           and pm_tipo     = @i_tipo
           and pm_moneda   = @i_moneda )
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151064
	  /* Producto moneda ya existe */
	return 1
end

begin tran
	insert into cl_pro_moneda (pm_producto, pm_moneda, pm_tipo,
				 pm_descripcion, pm_fecha_aper,pm_estado)
	values
		(@i_producto,@i_moneda, @i_tipo,
		 @i_descripcion, @w_today, @i_estado)
	if @@error != 0
	begin
		exec sp_cerror
		  @t_debug	 = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 103032
		  /*"Error en creacion de producto-moneda"*/
		return 1
	end
	/* Transaccion servicios - cl_pro_moneda */

	insert into ts_pro_moneda (secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    producto, moneda, tipo, descripcion, fecha_aper,
		    estado)
	values (@s_ssn, 1524 , 'N', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@i_producto, @i_moneda, @i_tipo, @i_descripcion, @w_today,
		@i_estado)
	if @@error != 0
	begin
	    exec sp_cerror
	      @t_debug	 = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 103005
	     /* 'Error en creacion de transaccion de servicios'*/
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


/** Update **/
if @i_operacion = 'U'
begin
if @t_trn = 15149  
begin
/* Verificacion de claves foraneas */

if not exists (
	select pd_producto
	  from cl_producto
	 where pd_producto = @i_producto
           and pd_tipo = @i_tipo)
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101032
	  /*"Producto no existe"*/
	return 1
end

if not exists (
	select mo_moneda
	  from cl_moneda
	 where mo_moneda = @i_moneda)
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101045
	  /* "Moneda no existe"*/
	return 1
end

  select @w_estado = pm_estado,
	 @w_producto = pm_producto,   
	 @w_tipo     = pm_tipo,      
	 @w_moneda   = pm_moneda,
	 @w_descripcion = pm_descripcion      
  from cl_pro_moneda
 where pm_producto = @i_producto
   and pm_tipo     = @i_tipo
   and pm_moneda   = @i_moneda 
if @@rowcount = 0
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151064
	  /* Producto moneda no  existe */
	return 1
end

select @v_estado = @w_estado,
       @v_producto  = @w_producto,
       @v_tipo      = @w_tipo,    
       @v_moneda    = @w_moneda,  
       @v_descripcion  = @w_descripcion  

if @w_estado = @i_estado
	select @w_estado = null,@v_estado = null
else
	select @w_estado = @i_estado

if @w_producto =  @i_producto 
	select @w_producto = null,@v_producto = null
else
	select @w_producto = @i_producto 

if @w_tipo     =  @i_tipo     
	select @w_tipo     = null,@v_tipo     = null
else
	select @w_tipo     = @i_tipo      

if @w_moneda   =  @i_moneda   
	select @w_moneda   = null,@v_moneda   = null
else
	select @w_moneda   = @i_moneda    

if @w_descripcion =  @i_descripcion
	select @w_descripcion   = null,@v_descripcion   = null
else
	select @w_descripcion = @i_descripcion     

begin tran

        update cl_pro_moneda set  pm_estado   = @i_estado   
	 where pm_producto = @i_producto
           and pm_tipo     = @i_tipo
           and pm_moneda   = @i_moneda 

	if @@error != 0
	begin
		exec sp_cerror
		  @t_debug	 = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 103032
		  /*"Error en actualizacion producto-moneda"*/
		return 1
	end
	/* Transaccion servicios - cl_pro_moneda */

	insert into ts_pro_moneda (secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    producto, moneda, tipo, descripcion,
		    estado)
	values (@s_ssn, 1524 , 'N', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@v_producto, @v_moneda, @v_tipo, @v_descripcion,
		@v_estado)
	if @@error != 0
	begin
	    exec sp_cerror
	      @t_debug	 = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 103005
	     /* 'Error en creacion de transaccion de servicios'*/
	    return 1
	end

	insert into ts_pro_moneda (secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    producto, moneda, tipo, descripcion,
		    estado)
	values (@s_ssn, 1524 , 'N', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@w_producto, @w_moneda, @w_tipo, @w_descripcion,
		@w_estado)
	if @@error != 0
	begin
	    exec sp_cerror
	      @t_debug	 = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 103005
	     /* 'Error en creacion de transaccion de servicios'*/
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

/* ** Delete **/
If @i_operacion = 'D'
begin
if @t_trn = 1525
begin
/* Verificacion de existencia */
select @w_aux=null
	from cl_pro_moneda
	where pm_producto = @i_producto
	and   pm_moneda   = @i_moneda
	and   pm_tipo = @i_tipo
if @@rowcount = 0
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101031
	   /* "Producto moneda no existe"*/
	return 1
end
/* Control de referencias */
/* referencia en producto oficina */
if exists (
	select pl_filial
	  from cl_pro_oficina
	 where pl_producto = @i_producto
           and pl_tipo = @i_tipo
	   and pl_moneda = @i_moneda
	 )
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101070
	    /* Existe referencia en producto oficina */
	return 1
end 
/* referencia en producto - transaccion */
if exists (
	select pt_producto
	  from ad_pro_transaccion
	 where pt_producto = @i_producto
	   and pt_tipo = @i_tipo
	   and pt_moneda = @i_moneda
	 )
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file 	= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101068
	    /* Existe referencia en producto transaccion */
	return 1
end
/* referencia en producto - rol */
if exists (
	select pr_producto
	  from ad_pro_rol
	 where pr_producto = @i_producto
	   and pr_tipo = @i_tipo
	   and pr_moneda = @i_moneda
	 )
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101069
	   /* Existe referencia en producto rol */
	return 1
end
/* Control de campos a actualizarse */
    select @w_producto = pm_producto,
           @w_tipo = pm_tipo,
	   @w_moneda = pm_moneda,
	   @w_estado = pm_estado, 
           @w_descripcion = pm_descripcion
      from cl_pro_moneda
     where pm_producto = @i_producto
       and pm_moneda = @i_moneda
       and pm_tipo = @i_tipo

begin tran
	delete from cl_pro_moneda
		where pm_producto = @i_producto
		and   pm_moneda   = @i_moneda
	        and   pm_tipo = @i_tipo
	if @@error != 0
	begin
		exec sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 107051
		  /*"Error en actualizacion de producto-moneda"*/
		return 1
	end
	/* Transaccion servicios - cl_pro_moneda */
	
        insert into ts_pro_moneda (secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    producto, tipo, moneda, descripcion, fecha_aper,estado)
	values (@s_ssn, 1525, 'D', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@w_producto, @w_tipo, @w_moneda, @w_descripcion, null,
  	        @w_estado)
	if @@error != 0
	begin
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 103005
	  /* 'Error en creacion de transaccion de servicios'*/
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

/** Search **/
If @i_operacion = 'S'
begin
If @t_trn = 15035
begin
if @i_tipo_s = 0
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Producto' = pm_producto,
			'Tipo'     = pm_tipo,
		        'Moneda'   = pm_moneda,
			'Producto - Moneda' = pm_descripcion,
			'Estado' = pm_estado     
		  from	cl_pro_moneda
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
	if @i_modo = 1
	begin
		select 	'Producto' = pm_producto,
			'Tipo'     = pm_tipo,
		        'Moneda'   = pm_moneda,
			'Producto - Moneda' = pm_descripcion,
			'Estado' = pm_estado     
		  from	cl_pro_moneda
		 where	(
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
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
end
if @i_tipo_s = 1
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Producto' = pm_producto,
			'Tipo'    = pm_tipo,
	 		'Descripcion' = pd_descripcion
		  from	cl_pro_moneda, cl_producto
		 where	pd_producto = pm_producto
		   and	pd_tipo = pm_tipo
		   and 	pm_moneda = @i_moneda
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
	if @i_modo = 1
	begin
		select 'Producto' = pm_producto,
			'Tipo'    = pm_tipo,
	 		'Descripcion' = pd_descripcion
		  from	cl_pro_moneda, cl_producto
		 where	pd_producto = pm_producto
		   and	pd_tipo = pm_tipo
		   and 	pm_moneda = @i_moneda
		   and	(
			(pm_producto > @i_producto)
		    or	((pm_producto = @i_producto) and (pm_tipo > @i_tipo))
			) 
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
set rowcount 0
return 0
end
if @i_tipo_s = 2
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Moneda' = pm_moneda,
		       'Descripcion' = mo_descripcion
		  from cl_pro_moneda, cl_moneda
		 where mo_moneda = pm_moneda
		   and pm_producto = @i_producto
		   and pm_tipo = @i_tipo
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
	if @i_modo = 1
	begin
		select 'Moneda' = pm_moneda,
		       'Descripcion' = mo_descripcion
		  from cl_pro_moneda, cl_moneda
		 where mo_moneda = pm_moneda
		   and pm_producto = @i_producto
		   and pm_tipo = @i_tipo
		   and pm_moneda > @i_moneda
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
end
set rowcount 0

if @i_tipo_s = 3
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Producto' = pm_producto,
		        'Moneda'   = pm_moneda,
			'Tipo'     = pm_tipo,
			'Producto - Moneda' = pm_descripcion,
			'Estado' = pm_estado      
		  from	cl_pro_moneda, cl_producto, ad_pro_instalado
		 where  pd_abreviatura = pi_producto
		   and	pm_producto = pd_producto
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
	if @i_modo = 1
	begin
		select 	'Producto' = pm_producto,
		        'Moneda'   = pm_moneda,
			'Tipo'     = pm_tipo,
			'Producto - Moneda' = pm_descripcion,
			'Estado' = pm_estado      
		  from	cl_pro_moneda, cl_producto, ad_pro_instalado
		 where	(
			(pm_producto > @i_producto)
		    or  ((pm_producto = @i_producto) and (pm_tipo > @i_tipo))
		    or  ((pm_producto = @i_producto) and (pm_tipo = @i_tipo)
			 and (pm_moneda > @i_moneda))
			)
		   and  pd_abreviatura = pi_producto
		   and	pm_producto = pd_producto
		if @@rowcount = 0
  		begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
	  		 /*'No existe producto moneda'*/
		set rowcount 0
   		return 1
 		end

	end
end
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

/** Query **/
If @i_operacion = 'Q'
begin
If @t_trn = 15036
begin
     select @o_producto = pm_producto,
	    @o_prnombre = pd_descripcion,
	    @o_tipo	= pm_tipo,
	    @o_moneda = pm_moneda,
	    @o_monombre = mo_descripcion,
	    @o_descripcion = pm_descripcion,
	    @o_estado      = pm_estado      
      from  cl_pro_moneda, cl_producto, cl_moneda
     where  pm_producto = @i_producto
     and    pm_moneda = @i_moneda
     and    pm_tipo = @i_tipo
     and    pd_producto = pm_producto
     and    mo_moneda = pm_moneda

    if @@rowcount = 0
     begin
       exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101031
	   /* 'No existe producto moneda'*/
	return 1
      end

    /*B-28/jun/1999 No se devolvia la descripcion del estado del registro*/
    select @o_desc_estado = b.valor
    from cl_tabla a, cl_catalogo b
    where a.tabla = 'cl_estado_ser'
    and   a.codigo = b.tabla
    and   b.codigo = @o_estado

    select @o_producto, @o_prnombre, @o_tipo, @o_moneda, @o_monombre,
           @o_descripcion, @o_estado, @o_desc_estado
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

/* ** help ** */
if @i_operacion = 'H'
begin
If @t_trn = 15037
begin
 if @i_tipo_h = 'A'
 begin
	set rowcount 20
	if @i_modo = 0
	 select   'Producto' = pm_producto, 
		  'Tipo' = pm_tipo, 
		  'Cod. Moneda' = pm_moneda,
		  'Nombre del Producto ' = substring(pm_descripcion,1,30)
	   from   cl_pro_moneda
	   where  pm_estado = 'V'
        else
	if @i_modo = 1
	 select   'Producto' = pm_producto, 
		  'Tip' = pm_tipo, 
		  'Cod. Moneda' = pm_moneda,
		  'Nombre del Producto' = substring(pm_descripcion,1,30)
	   from   cl_pro_moneda
          where	  (
		   (pm_producto > @i_producto)
	     or	  ((pm_producto = @i_producto) and (pm_tipo > @i_tipo))
	     or   ((pm_producto = @i_producto) and (pm_tipo = @i_tipo)
		   and (pm_moneda > @i_moneda))
		  )
	   and    pm_estado = 'V'
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101031
	   /*  'No existe producto moneda' */
	  return 1
	 end
 end
 if @i_tipo_h = 'V'
 begin
	set rowcount 20
	if @i_modo = 0
	 select	  'Cod. Moneda' = pm_moneda,
		  'Cod. Tipo' =  pm_tipo,
		  'Descripcion' = substring(pm_descripcion,1,30)
	   from   cl_pro_moneda
	  where   pm_producto = @i_producto
	   and    pm_estado = 'V'
	else
	if @i_modo = 1
	 select	  'Cod. Moneda' = pm_moneda,
		  'Cod. Tipo' =  pm_tipo,
		  'Descripcion' = substring(pm_descripcion,1,30)
	   from   cl_pro_moneda
	  where   pm_producto = @i_producto
	    and   (
	           (pm_tipo > @i_tipo)
  	     or	  ((pm_tipo = @i_tipo) and (pm_moneda > @i_moneda))
	          )
	   and    pm_estado = 'V'
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101031
	   /*  'No existe producto moneda' */
	  return 1
	 end
 end
 return  0
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

