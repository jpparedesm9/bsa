/************************************************************************/
/*  Archivo:        		parroq_cr.sp               		*/
/*  Stored procedure:   	sp_parroquia_cr                		*/
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
/*  09/Ago/2012 I. Torres       Actualizado para que funcione como      */
/*                              Interceptor                             */ 
/*  11-04-2016  BBO             Migracion Sybase-Sqlserver FAL          */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_parroquia_cr')
   drop proc sp_parroquia_cr



go
create proc sp_parroquia_cr (
	@s_ssn			    int         = NULL,
	@s_user			    login       = NULL,
	@s_sesn			    int         = NULL,
	@s_term			    varchar(32) = NULL,
	@s_date			    datetime    = NULL,
	@s_srv			    varchar(30) = NULL,
	@s_lsrv			    varchar(30) = NULL, 
	@s_rol			    smallint    = NULL,
	@s_ofi			    smallint    = NULL,
	@s_org_err		    char(1)     = NULL,
	@s_error		    int         = NULL,
	@s_sev			    tinyint     = NULL,
	@s_msg			    descripcion = NULL,
	@s_org			    char(1)     = NULL,
	@t_debug		    char(1)     = 'N',
	@t_file			    varchar(14) = null,
	@t_from			    varchar(32) = null,
	@t_trn			    smallint    = NULL,
	@t_show_version     bit         = 0,
	@i_operacion 		varchar(2),
	@i_modo      		tinyint     = null,
	@i_tipo_h    		varchar(1)  = null,
	@i_parroquia 		int         = null,
	@i_descripcion   	descripcion = null,
	@i_tipo          	varchar(1)  = null,
	@i_ciudad        	int         = null, /* PES Version Colombia */
	@i_zona			    varchar(3)  = null,
	@i_estado    		estado      = null,
	@i_ultimo		    descripcion = null,
	@i_central_transmit varchar(1)  = null,
    @i_distrito 		int 		= null,	--Agregado para Interceptor
	@i_canton           int 		= null, --Agregado para Interceptor
	@i_valor   	        descripcion = null
)
as
declare @w_today        datetime,
	    @w_sp_name      varchar(32),
	    @w_cambio       int,
	    @w_codigo       int,
	    @w_descripcion  descripcion,
	    @w_tipo         char(1),
	    @w_canton       int, /* PES Version Colombia */
	    @w_zona         char(3),
	    @w_estado       estado,
	    @w_return       int,
	    @w_contador     smallint,
	    @w_clave        int,      
	    @w_num_nodos    smallint,
	    @w_nt_nombre    varchar(30),
	    @w_codigo_c	    varchar(10), 
	    @w_cmdtransrv   varchar(64),
	    @v_descripcion  descripcion,
	    @v_tipo         char(1),
	    @v_canton       int, /* PES Version Colombia */
	    @v_zona         char(3),
	    @v_estado       estado,
	    @o_distrito     int

select @w_today   = @s_date
select @w_sp_name = 'sp_parroquia_cr'

if @t_show_version = 1
begin
    print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.2'
    return 0
end

/* Search */
if @i_operacion = 'S'
begin
if @t_trn = 1558
begin
	set rowcount 20
	if @i_modo = 0
	Select	'Cod.Canton'        = pq_ciudad,
		    'Nombre de Canton'  = substring( ci_descripcion,1,30),		    
			'Cod.Distrito.'     = pq_parroquia,
		    'Nombre Distrito'   = substring( pq_descripcion,1,30),	    
		    'Tipo'              = pq_tipo,
		    'Descr. del Tipo'   = substring( x.valor,1,30),
		    'Cod.Zona'          = pq_zona,
		    'Nombre de la Zona' = substring( a.valor,1,30),
		    'Estado'            = pq_estado
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
	Select	'Cod.Canton'        = pq_ciudad,
		    'Nombre de Canton'  = substring( ci_descripcion,1,30),		    
			'Cod.Distrito.'     = pq_parroquia,
		    'Nombre Distrito'   = substring( pq_descripcion,1,30),			
		    'Tipo'              = pq_tipo,
		    'Descr. del Tipo'   = substring( x.valor,1,30),
		    'Cod.Zona'          = pq_zona,
		    'Nombre de la Zona' = substring( a.valor,1,30),
		    'Estado'            = pq_estado
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
	Select	'Cod.Canton'        = pq_ciudad,
		    'Nombre de Canton'  = substring( ci_descripcion,1,30),
		    'Cod.Distrito.'     = pq_parroquia,
		    'Nombre Distrito'   = substring( pq_descripcion,1,30),
		    'Tipo'              = pq_tipo,
		    'Descr. del Tipo'   = substring( x.valor,1,30),
		    'Cod.Zona'          = pq_zona,
		    'Nombre de la Zona' = substring( a.valor,1,30),
		    'Estado'            = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
           cl_catalogo a, cl_tabla b
     where y.tabla   = 'cl_tparroquia'
       and y.codigo  = x.tabla
	   and x.codigo  = pq_tipo
	   and ci_ciudad = pq_ciudad
       and a.codigo  = pq_zona
       and a.tabla   = b.codigo
       and b.tabla   = 'cl_zona'
	   and pq_estado = 'V'
	order by pq_ciudad, pq_parroquia

	if @i_modo = 1
	Select	'Cod.Canton'        = pq_ciudad,
		    'Nombre de Canton'  = substring( ci_descripcion,1,30),
		    'Cod.Distrito.'     = pq_parroquia,
		    'Nombre Distrito'   = substring( pq_descripcion,1,30),
		    'Tipo'              = pq_tipo,
		    'Descr. del Tipo'   = substring( x.valor,1,30),
		    'Cod.Zona'          = pq_zona,
		    'Nombre de la Zona' = substring( a.valor,1,30),
		    'Estado'            = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
           cl_catalogo a, cl_tabla b
     where y.tabla   = 'cl_tparroquia'
       and y.codigo  = x.tabla
	   and x.codigo  = pq_tipo
	   and ci_ciudad = pq_ciudad
       and a.codigo  = pq_zona
       and a.tabla   = b.codigo
       and b.tabla   = 'cl_zona'
	   and (( pq_ciudad = @i_canton and  pq_parroquia > @i_distrito)
            or ( pq_ciudad > @i_canton ))
	  and pq_estado = 'V'
	order by pq_ciudad, pq_parroquia,pq_descripcion

	if @i_modo = 2
	Select	'Cod.Canton'        = pq_ciudad,
		    'Nombre de Canton'  = substring( ci_descripcion,1,30),
		    'Cod.Distrito.'     = pq_parroquia,
		    'Nombre Distrito'   = substring( pq_descripcion,1,30),
		    'Tipo'              = pq_tipo,
		    'Descr. del Tipo'   = substring( x.valor,1,30),
		    'Cod.Zona'          = pq_zona,
		    'Nombre de la Zona' = substring( a.valor,1,30),
		    'Estado'            = pq_estado
	from   cl_ciudad, cl_parroquia, cl_catalogo x, cl_tabla y,
           cl_catalogo a, cl_tabla b
    where  y.tabla      = 'cl_tparroquia'
      and  y.codigo     = x.tabla
	  and  x.codigo     = pq_tipo
	  and  ci_ciudad    = pq_ciudad
      and  a.codigo     = pq_zona
      and  a.tabla      = b.codigo
      and  b.tabla      = 'cl_zona'
	  and  pq_parroquia = @i_distrito
	  and  pq_ciudad    = @i_canton
	  and  pq_estado    = 'V'
		

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
     if @i_tipo_h = "B"
		   begin /* nueva validacion de F5 general del distrito */
		   
		    
				set rowcount 20
				if @i_modo = 0
					select 'Cod.Distrito' = pq_parroquia,
					       'Distrito'     = substring(pq_descripcion,1,30),
					       'Cod.Cantón'   = pq_ciudad,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)					      
					  from cl_parroquia, cl_ciudad					  
					where pq_ciudad = @i_ciudad
					and ci_ciudad = pq_ciudad					
					and pq_estado = 'V'
					and pq_descripcion like isnull(@i_valor,pq_descripcion)
                   order by pq_descripcion	
				else
				if @i_modo = 1
					select 'Cod.Distrito' = pq_parroquia,
					       'Distrito'     = substring(pq_descripcion,1,30),
					       'Cod.Cantón'   = pq_ciudad,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)
					 from cl_parroquia, cl_ciudad
					where pq_ciudad = @i_ciudad
					and ci_ciudad = pq_ciudad
					   and  pq_descripcion > @i_ultimo
					   and pq_estado = 'V'
                       and pq_descripcion like isnull(@i_valor,pq_descripcion)					   
					 order by pq_descripcion	
				set rowcount 0
				return 0
		   end       
      
   
	if @i_tipo_h = "A"
	begin
	
	  
		set rowcount 20
		if @i_modo = 0
			select "Cod.Distrito." = pq_parroquia,
			       "Distrito"      = substring(pq_descripcion,1,30),
			       "Cod. Zona"     = pq_zona,
			       "Zona"          = substring(valor,1,30)
			  from cl_parroquia, cl_catalogo x, cl_tabla y
			 where pq_ciudad = @i_ciudad
			   and x.tabla = y.codigo
			   and y.tabla = 'cl_zona'
			   and x.codigo = pq_zona 
			   and pq_estado = 'V'
			 order by pq_descripcion	
		else
		if @i_modo = 1
			select "Cod.Distrito." = pq_parroquia,
			       "Distrito"      = substring(pq_descripcion,1,30),
			       "Cod. Zona"     = pq_zona,
			       "Zona"          = substring(valor,1,30)
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
	end  /* operacion A */
	else
	begin
	     if @i_tipo_h = "V"
	     begin
		 
		
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

              end  /* operacion V */   
	      else
	      begin
		  /* nueva validacion de F5 general del distrito */
		   
		   if @i_tipo_h = "P"
		   begin /* nueva validacion de F5 general del distrito */
		   
		     
				set rowcount 20
				if @i_modo = 0
					select 'Cod.Distrito' = pq_parroquia,
					       'Distrito'     = substring(pq_descripcion,1,30),
					       'Cod.Cantón'   = pq_ciudad,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)					      
					  from cl_parroquia, cl_ciudad					  
					where pq_ciudad = @i_ciudad
					and ci_ciudad = pq_ciudad					
					and pq_estado = 'V'
					 order by pq_descripcion	
				else
				if @i_modo = 1
					select 'Cod.Distrito' = pq_parroquia,
					       'Distrito'     = substring(pq_descripcion,1,30),
					       'Cod.Cantón'   = pq_ciudad,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)
					 from cl_parroquia, cl_ciudad
					where pq_ciudad = @i_ciudad
					and ci_ciudad = pq_ciudad
					   and  pq_descripcion > @i_ultimo
					   and pq_estado = 'V'		 
					 order by pq_descripcion	
				set rowcount 0
				return 0
		   end
            
            if @i_tipo_h = "L"
		    begin
		
			select pq_descripcion
				from cl_parroquia, cl_ciudad
				where ci_ciudad = pq_ciudad
				and pq_parroquia = @i_parroquia
				and pq_estado = 'V'

				if @@rowcount = 0
			   exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101000,
				@i_msg          = 'No existe dato en catalogo'
		       	/*' No existe dato en catalogo'*/
			return 0
			end
			
			
			end /* else operacion V */
         end /* else operacion A */
   end /* Fin de transaccion */
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

