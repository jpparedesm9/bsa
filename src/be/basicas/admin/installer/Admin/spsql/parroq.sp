/************************************************************************/
/*  Archivo:        		parroq.sp               		*/
/*  Stored procedure:   	sp_parroquia                		*/
/*  Base de datos:      	cobis                   		*/
/*  Producto: 			Administracion         	             	*/
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz          		*/
/*  Fecha de escritura: 08-Nov-1992                 			*/
/************************************************************************/
/*              IMPORTANTE              				*/
/*  Este programa es parte de los paquetes bancarios propiedad de   	*/
/*  "MACOSA", representantes exclusivos para el Ecuador de la   	*/
/*  "NCR CORPORATION".                      				*/
/*  Su uso no autorizado queda expresamente prohibido asi como  	*/
/*  cualquier alteracion o agregado hecho por alguno de sus     	*/
/*  usuarios sin el debido consentimiento por escrito de la     	*/
/*  Presidencia Ejecutiva de MACOSA o su representante.     		*/
/*              PROPOSITO               				*/
/*  Este programa procesa las transacciones del stored procedure 	*/
/*  Busqueda de parroquia                       			*/
/*              MODIFICACIONES              				*/
/*  FECHA       AUTOR       RAZON               			*/
/*  12/Nov/92   M. Davila   Emision Inicial         			*/
/*  12/Ene/93   L. Carvajal Tabla de errores, variables 		*/
/*                  de debug            				*/
/*  26/Feb/93   M. Davila   Eliminar la tabla de catalogo   		*/
/*  05/Abr/93   C. Rodriguez V. Considerar la ciudad en el Where        */
/*              de la consulta Help("H") especifica("V")                */
/*  05/May/94	F.Espinosa	Parametros tipo "S"			*/
/*				Transacciones de Servicio		*/
/*  03/May/95	S. Vinces       Cambios de Admin Distribuido 		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_parroquia')
   drop proc sp_parroquia



go
create proc sp_parroquia (
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
	@i_operacion 		varchar(2),
	@i_modo      		tinyint = null,
	@i_tipo_h    		varchar(1) = null,
	@i_parroquia 		smallint = null,
	@i_descripcion   	descripcion = null,
	@i_tipo          	varchar(1) = null,
	@i_ciudad        	int = null, /* PES Version Colombia */
	@i_zona			varchar(3) = null,
	@i_estado    		estado = null,
	@i_ultimo		descripcion=null,
	@i_central_transmit     varchar(1) = null      
)
as
declare @w_today    datetime,
	@w_sp_name  varchar(32),
	@w_cambio   int,
	@w_codigo   int,
	@w_descripcion  descripcion,
	@w_tipo     char(1),
	@w_ciudad   int, /* PES Version Colombia */
	@w_zona     char(3),
	@w_estado   estado,
	@w_return   int,
	@w_contador smallint,
	@w_clave    int,      
	@w_num_nodos    smallint,
	@w_nt_nombre   varchar(30),
	@w_codigo_c	varchar(10), 
	@w_cmdtransrv  varchar(64),
	@v_descripcion  descripcion,
	@v_tipo     char(1),
	@v_ciudad   int, /* PES Version Colombia */
	@v_zona     char(3),
	@v_estado   estado,
	@o_parroquia    smallint

select @w_today=@s_date
select @w_sp_name = 'sp_parroquia'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 1528
begin
  /* Verificacion de claves foraneas */
  select @w_codigo = null
	from cl_ciudad
   where ci_ciudad = @i_ciudad 
  if @@rowcount = 0
  begin
	 exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 101024
	   /*   'No existe ciudad'*/
	 return 1
  end

  select @w_codigo = null
    from cl_parroquia
   where pq_parroquia = @i_parroquia
     and pq_ciudad = @i_ciudad
  if @@rowcount != 0
  begin
	 exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 101151
	   /*   'Parroquia ya existe en esa ciudad'*/ 
	 return 1
  end

  select @w_codigo = null
	from cl_catalogo x, cl_tabla y
   where y.tabla = 'cl_tparroquia'
     and y.codigo = x.tabla
     and x.codigo = @i_tipo
  if @@rowcount = 0
  begin
	 exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 101041
		/*  'No existe tipo de parroquia'*/
	 return 1
  end


  /* verificar que exista la zona */
    exec @w_return = cobis..sp_catalogo
	 @t_debug       = @t_debug,
	 @t_file        = @t_file,
	 @t_from        = @w_sp_name,
	 @i_tabla       = 'cl_zona',
	 @i_operacion   = 'E',
	 @i_codigo      = @i_zona

   /* si no existe la zona, error */
   if @w_return != 0
   begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101132
	     /* 'No existe sector'*/
	return 1
    end

  begin tran
	 /* Insert cl_parroquia */
/*	 exec sp_cseqnos
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_tabla    = 'cl_parroquia',
		@o_siguiente    = @o_parroquia out
*/
	 insert into cl_parroquia (pq_parroquia, pq_descripcion, pq_tipo,
				   pq_ciudad, pq_zona, pq_estado)
		   values (@i_parroquia, @i_descripcion, @i_tipo,
			   @i_ciudad, @i_zona, 'V')
	 if @@error != 0
	 begin
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 103041
	   /* 'Error en creacion de parroquia'*/
	return 1
	 end

	 insert into ts_parroquia (secuencia, tipo_transaccion, clase, fecha,
		                  oficina_s, usuario, terminal_s, srv, lsrv,
				  parroquia, descripcion, tipo,
				  ciudad, zona, estado)

	 values (@s_ssn, 1528, 'N', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		 @i_parroquia, @i_descripcion, @i_tipo,
		 @i_ciudad, @i_zona,'V')

	 if @@error != 0
	 begin
	  exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 103005
		/* 'Error en creacion de transaccion de servicios'*/
	  return 1
	 end
  commit tran

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_parroquia)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 584,
       		@i_operacion		   = 'I',
       		@i_tabla		   = 'cl_parroquia',
       		@i_codigo		   = @w_codigo_c,
       		@i_descripcion 		   = @i_descripcion,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
		return @w_return


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

/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 1529
begin
  /* Verificacion de claves foraneas */
  select @w_codigo = null
    from cl_catalogo x, cl_tabla y
   where y.tabla = 'cl_tparroquia'
     and y.codigo = x.tabla
     and x.codigo = @i_tipo
  if @@rowcount = 0
    begin
	 exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 101041
	   /*   'No existe tipo de parroquia'*/
	 return 1
    end

  /* verificar que exista la zona */
    exec @w_return = cobis..sp_catalogo
	 @t_debug       = @t_debug,
	 @t_file        = @t_file,
	 @t_from        = @w_sp_name,
	 @i_tabla       = 'cl_zona',
	 @i_operacion   = 'E',
	 @i_codigo      = @i_zona

   /* si no existe la zona, error */
   if @w_return != 0
   begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 101132
	     /* 'No existe sector'*/
	return 1
    end

  select @w_descripcion = pq_descripcion,
	 @w_tipo    = pq_tipo,
         @w_zona    = pq_zona,
	 @w_estado  = pq_estado
    from cl_parroquia
   where pq_parroquia = @i_parroquia
     and pq_ciudad = @i_ciudad

  select @v_descripcion = @w_descripcion
  select @v_tipo    = @w_tipo
  select @v_estado      = @w_estado
  select @v_zona    = @w_zona

  if @w_descripcion = @i_descripcion
	 select @w_descripcion = null, @v_descripcion = null
  else
	 select @w_descripcion = @i_descripcion
  if @w_tipo = @i_tipo
	 select @w_tipo = null, @v_tipo = null
  else
	 select @w_tipo = @i_tipo
  if @w_zona = @i_zona
	 select @w_zona = null, @v_zona = null
  else
	 select @w_zona = @i_zona
  if @w_estado = @i_estado
 	select @w_estado = null, @v_estado = null
  else
	select @w_estado = @i_estado

  begin tran
	 /* Update parroquia */
	 update cl_parroquia
	 set    pq_descripcion = @i_descripcion,
		pq_tipo    = @i_tipo,
		pq_zona	       = @i_zona,
		pq_estado      = @i_estado
	 where  pq_parroquia  = @i_parroquia
	   and	pq_ciudad     = @i_ciudad
	 if @@error != 0
	 begin
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 105039
		/* 'Error en actualizacion de parroquia'*/
	return 1
	 end
	 /* transaccion servicios - parroquia */

	 insert into ts_parroquia (secuencia, tipo_transaccion, clase, fecha,
		                   oficina_s, usuario, terminal_s, srv, lsrv,
				   parroquia, descripcion, tipo,
				   ciudad, zona, estado)
	 values (@s_ssn, 1529, 'P', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		 @i_parroquia, @v_descripcion, @v_tipo,
		 @i_ciudad, @v_zona, null)
	 if @@error != 0
	 begin
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 103005
		  /* 'Error en creacion de transaccion de servicios'*/
	return 1
	 end

	 insert into ts_parroquia (secuencia, tipo_transaccion, clase, fecha,
		                   oficina_s, usuario, terminal_s, srv, lsrv,
				   parroquia, descripcion, tipo,
				   ciudad, zona, estado)
	 values (@s_ssn, 1529, 'A', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		 @i_parroquia, @w_descripcion, @w_tipo,
		 @i_ciudad, @w_zona, null)
	 if @@error != 0
	 begin
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 103005
		/* 'Error en creacion de transaccion de servicios'*/
	return 1
	 end
  commit tran

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_parroquia)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 585,
       		@i_operacion		   = 'U',
       		@i_tabla		   = 'cl_parroquia',
       		@i_codigo		   = @w_codigo_c,
       		@i_descripcion 		   = @i_descripcion,
       		@i_estado	     	   = @i_estado	
	if @w_return != 0
		return @w_return


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
if @t_trn = 1558
begin
	set rowcount 20
	if @i_modo = 0
	Select	'Cod.Ciudad' = pq_ciudad,
		'Nombre de Ciudad' =substring( ci_descripcion,1,30),
		'Cod.Parroq.' = pq_parroquia,
		'Nombre Parroquia' = substring( pq_descripcion,1,30),
		'Tipo' = pq_tipo,
		'Descr. del Tipo' =substring( x.valor,1,30),
		'Cod.Zona' = pq_zona,
		'Nombre de la Zona' =substring( a.valor,1,30),
		'Estado' = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
               cl_catalogo a, cl_tabla b
        where y.tabla = 'cl_tparroquia'
          and y.codigo = x.tabla
	  and x.codigo = pq_tipo
	  and  ci_ciudad = pq_ciudad
          and a.codigo = pq_zona
          and a.tabla = b.codigo
          and b.tabla = 'cl_zona'
	  order by pq_ciudad, pq_parroquia
	 else
	if @i_modo = 1
	Select	'Cod.Ciudad' = pq_ciudad,
		'Nombre de Ciudad' =substring( ci_descripcion,1,30),
		'Cod.Parroq.' = pq_parroquia,
		'Nombre Parroquia' = substring( pq_descripcion,1,30),
		'Tipo' = pq_tipo,
		'Descr. del Tipo' =substring( x.valor,1,30),
		'Cod.Zona' = pq_zona,
		'Nombre de la Zona' =substring( a.valor,1,30),
		'Estado' = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
               cl_catalogo a, cl_tabla b
        where y.tabla = 'cl_tparroquia'
          and y.codigo = x.tabla
	  and x.codigo = pq_tipo
	  and  ci_ciudad = pq_ciudad
          and a.codigo = pq_zona
          and a.tabla = b.codigo
          and b.tabla = 'cl_zona'
	  and (( pq_ciudad = @i_ciudad and  pq_parroquia > @i_parroquia)
               or ( pq_ciudad > @i_ciudad ))
	  order by pq_ciudad, pq_parroquia
          if @@rowcount = 0
          exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101000
          /*    'No existe dato en catalogo'*/
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

/* Query */
if @i_operacion = 'Q'
begin
if @t_trn = 1557
begin
	 set rowcount 20
	 if @i_modo = 0
	Select	'Cod.Ciudad' = pq_ciudad,
		'Nombre de Ciudad' =substring( ci_descripcion,1,30),
		'Cod.Parroq.' = pq_parroquia,
		'Nombre Parroquia' = substring( pq_descripcion,1,30),
		'Tipo' = pq_tipo,
		'Descr. del Tipo' =substring( x.valor,1,30),
		'Cod.Zona' = pq_zona,
		'Nombre de la Zona' =substring( a.valor,1,30),
		'Estado' = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
               cl_catalogo a, cl_tabla b
        where y.tabla = 'cl_tparroquia'
          and y.codigo = x.tabla
	  and x.codigo = pq_tipo
	  and ci_ciudad = pq_ciudad
          and a.codigo = pq_zona
          and a.tabla = b.codigo
          and b.tabla = 'cl_zona'
	  and  pq_estado = 'V'
	order by pq_ciudad, pq_parroquia

	if @i_modo = 1
	Select	'Cod.Ciudad' = pq_ciudad,
		'Nombre de Ciudad' =substring( ci_descripcion,1,30),
		'Cod.Parroq.' = pq_parroquia,
		'Nombre Parroquia' = substring( pq_descripcion,1,30),
		'Tipo' = pq_tipo,
		'Descr. del Tipo' =substring( x.valor,1,30),
		'Cod.Zona' = pq_zona,
		'Nombre de la Zona' =substring( a.valor,1,30),
		'Estado' = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
               cl_catalogo a, cl_tabla b
        where y.tabla = 'cl_tparroquia'
          and y.codigo = x.tabla
	  and x.codigo = pq_tipo
	  and ci_ciudad = pq_ciudad
          and a.codigo = pq_zona
          and a.tabla = b.codigo
          and b.tabla = 'cl_zona'
	  and ( ( pq_ciudad = @i_ciudad and  pq_parroquia > @i_parroquia )
                or ( pq_ciudad > @i_ciudad ))
	  and pq_estado = 'V'
	order by pq_ciudad, pq_parroquia,pq_descripcion

	if @i_modo = 2
	Select	'Cod.Ciudad' = pq_ciudad,
		'Nombre de Ciudad' = substring( ci_descripcion,1,30),
		'Cod.Parroq.' = pq_parroquia,
		'Nombre Parroquia' = substring( pq_descripcion,1,30),
		'Tipo' = pq_tipo,
		'Descr. del Tipo' =substring( x.valor,1,30),
		'Cod.Zona' = pq_zona,
		'Nombre de la Zona' =substring( a.valor,1,30),
		'Estado' = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
               cl_catalogo a, cl_tabla b
        where  y.tabla = 'cl_tparroquia'
          and  y.codigo = x.tabla
	  and  x.codigo = pq_tipo
	  and  ci_ciudad = pq_ciudad
          and  a.codigo = pq_zona
          and  a.tabla = b.codigo
          and  b.tabla = 'cl_zona'
	  and  pq_parroquia = @i_parroquia
	  and  pq_ciudad = @i_ciudad
	  and  pq_estado = 'V'
		

	 if @@rowcount = 0
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 101000
	 /* 'No existe dato en catalogo'*/
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

/* ** Help ** */
if @i_operacion = 'H'
begin
if @t_trn = 1559
begin
	if @i_tipo_h = "A"
	begin
		set rowcount 20
		if @i_modo = 0
			select "Cod.Parroq." = pq_parroquia,
			       "Parroquia" = substring(pq_descripcion,1,30),
			       "Cod. Zona" = pq_zona,
			       "Zona" = substring(valor,1,30)
			  from cl_parroquia, cl_catalogo x, cl_tabla y
			 where pq_ciudad = @i_ciudad
			   and x.tabla = y.codigo
			   and y.tabla = 'cl_zona'
			   and x.codigo = pq_zona 
			   and pq_estado = 'V'
			 order by pq_descripcion	
		else
		if @i_modo = 1
			select "Cod.Parroq." = pq_parroquia,
			       "Parroquia" = substring(pq_descripcion,1,30),
			       "Cod. Zona" = pq_zona,
			       "Zona" = substring(valor,1,30)
			  from cl_parroquia, cl_catalogo x, cl_tabla y
			 where pq_ciudad = @i_ciudad
			   and x.tabla = y.codigo
			   and y.tabla = 'cl_zona'
			   and x.codigo = pq_zona 
	                   and  pq_descripcion > @i_ultimo
			   and pq_estado = 'V'		 
			 order by pq_descripcion	
		set rowcount 0
		return 0
	end
	else
	begin
	if @i_tipo_h = "V"
		select pq_descripcion, pq_zona, valor
		  from cl_parroquia, cl_catalogo x, cl_tabla y
		 where pq_parroquia = @i_parroquia
		   and pq_ciudad = @i_ciudad
		   and pq_estado = 'V'
                   and x.codigo = pq_zona
                   and x.tabla = y.codigo
                   and y.tabla ='cl_zona'
		if @@rowcount = 0
			exec sp_cerror
				@t_debug    = @t_debug,
				@t_file     = @t_file,
				@t_from     = @w_sp_name,
				@i_num      = 101000
			/* No existe parroquia */
		return 0
	end
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

