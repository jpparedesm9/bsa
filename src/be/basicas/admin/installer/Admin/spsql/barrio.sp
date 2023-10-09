/************************************************************************/
/*  Archivo:            barrio.sp                                       */
/*  Stored procedure:   sp_barrio                                       */
/*  Base de datos:      cobis                                           */
/*  Producto:           Admin                                           */
/*  Disenado por:       Isaac Torres                                    */
/*  Fecha de escritura: Junio 22 del 2012                               */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de:                         */
/*  Ayuda de cantones pertenecientes a una misma provincia              */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*                          Emision inicial                             */
/*  13-OCT-15   N.Martillo  CC-CLI-0009 En tabla cl_barrio el campo     */
/*  						Distrito hace referencia a la provincia     */
/*  11-04-2016    BBO       Migracion Sybase-Sqlserver FAL              */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_barrio')
   drop proc sp_barrio
go

create proc sp_barrio (
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
	@i_operacion 		varchar(2)  = NULL,
	@i_modo      		tinyint     = null,
	@i_tipo_h    		varchar(1)  = null,	
	@i_descripcion   	descripcion = null,
	@i_tipo          	varchar(1)  = null,
	@i_barrio        	int         = null, 
	@i_distrito 		int         = null, -- Nota: este campo hace referencia a la provincia en la tabla cl_barrio CC-CLI-0009 NM
	--@i_distrito_o       int         = null,
	@i_canton        	int         = null, 
	@i_canton_o        	int         = null,
	@i_provincia   	    int         = null, --Cambio de smallint a int
	@i_departamento	    catalogo    = null, --CC-CLI-0009 NM
	@i_pais        	    smallint    = null,	
	@i_zona			    varchar(3)  = null,
	@i_estado    		estado      = null,
	@i_ultimo		    descripcion = null,
    @i_valor		    descripcion = null	
)
as
declare @w_today        datetime,
	    @w_sp_name      varchar(32),
	    @w_cambio       int,
	    @w_codigo       int,
	    @w_descripcion  descripcion,
	    @w_distrito     int,
	    @w_canton       int, 
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
	    @v_distrito     int, 
		@v_canton       int, 
	    @v_zona         char(3),
	    @v_estado       estado,
	    @o_barrio       int


		
select @w_today   = @s_date
select @w_sp_name = 'sp_barrio'

if @t_show_version = 1
begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.1'
    return 0
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 15296
begin
  /*-- Verificacion de claves foraneas 
  select @w_codigo = null
	from cl_parroquia
   where pq_parroquia = @i_distrito 
  if @@rowcount = 0
  begin
	 exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 157092
	    --  'No existe Parroquia'
	 return 1
  end
	*/
  select @w_codigo = null
    from cl_barrio
   where ba_barrio    = @i_barrio
     and ba_canton  = @i_canton
  if @@rowcount != 0
  begin
	 exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 157095
	   --   'Barrio ya existe en esta Ciudad'
	 return 1
  end

  begin tran
	 insert into cl_barrio (ba_barrio, ba_descripcion,
							ba_distrito, ba_canton, ba_estado)				  
		   values (@i_barrio,   @i_descripcion,
			       @i_distrito, @i_canton,   'V')
	 if @@error != 0
	 begin
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 157094
	   -- 'Error en creacion de Barrio'
	return 1
	 end

	 insert into ts_barrio (secuencia, tipo_transaccion, clase, fecha,
							oficina_s, usuario, terminal_s, srv, lsrv,
							barrio, descripcion,
							distrito, canton, estado)
	 values (@s_ssn, 1528, 'N', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		 @i_barrio, @i_descripcion, 
		 @i_distrito, @i_canton, 'V')

	 if @@error != 0
	 begin
	  exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 103005
		 --'Error en creacion de transaccion de servicios'
	  return 1
	 end
  commit tran

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_barrio)
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
		@t_from		       = @w_sp_name,
		@t_trn			   = 584,
       	@i_operacion	   = 'I',
       	@i_tabla		   = 'cl_barrio',
       	@i_codigo		   = @w_codigo_c,
       	@i_descripcion 	   = @i_descripcion,
       	@i_estado	       = 'V'	
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
if @t_trn = 15303
begin  
   select @w_descripcion = ba_descripcion,
          @w_canton      = ba_canton,
		  @w_distrito 	 = ba_distrito,
          @w_estado      = ba_estado
    from cl_barrio
   where ba_barrio   = @i_barrio
		and ba_canton = @i_canton_o
     --and ba_distrito = @i_distrito_o

  select @v_descripcion = @w_descripcion  
  select @v_estado      = @w_estado
  select @v_distrito	= @w_distrito
  select @v_canton      = @w_canton

  if @w_descripcion = @i_descripcion
	 select @w_descripcion = null, @v_descripcion = null
  else
	 select @w_descripcion = @i_descripcion
  
  if @w_canton  = @i_canton
	 select @w_canton = null, @v_canton = null
  else
	 select @w_canton = @i_canton

  if @w_distrito  = @i_distrito
	 select @w_distrito = null, @v_distrito = null
  else
	 select @w_distrito = @i_distrito
  
  if @w_estado = @i_estado
 	select @w_estado = null, @v_estado = null
  else
	select @w_estado = @i_estado

  begin tran
	 /* Update barrio */	 
	 update cl_barrio
	 set    ba_descripcion = @i_descripcion,		   
		    ba_canton	   = @i_canton,
		    ba_estado      = @i_estado,
			ba_distrito    = @i_distrito
	 where  ba_barrio   = @i_barrio
		and ba_canton = @i_canton_o
       --and  ba_distrito = @i_distrito_o
	 if @@error != 0
	 begin
	exec sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 157096
		/* 'Error en actualizacion de Barrio'*/
	return 1
	 end
	 /* transaccion servicios - barrio */

	 insert into ts_barrio (secuencia, tipo_transaccion, clase, fecha,
		                   oficina_s, usuario, terminal_s, srv, lsrv,
				   barrio, descripcion,
				   distrito, canton, estado)
	 values (@s_ssn, 1529, 'P', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		 @i_barrio, @v_descripcion, 
		 @v_distrito, @v_canton, @v_estado)
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

	 insert into ts_barrio (secuencia, tipo_transaccion, clase, fecha,
		                   oficina_s, usuario, terminal_s, srv, lsrv,
				   barrio, descripcion,
				   distrito, canton, estado)
	 values (@s_ssn, 1529, 'A', @s_date,
		 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		 @i_barrio, @w_descripcion,
		 @w_distrito, @w_canton, @w_estado)
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
       	select @w_codigo_c = convert(varchar(10), @i_barrio)
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
		@t_from		       = @w_sp_name,
		@t_trn			   = 585,
       	@i_operacion	   = 'U',
       	@i_tabla		   = 'cl_barrio',
       	@i_codigo		   = @w_codigo_c,
       	@i_descripcion 	   = @i_descripcion,
       	@i_estado	       = @i_estado	
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
if @t_trn = 15299
begin
	set rowcount 20
	if @i_modo = 0	
	begin
		Select	'Cod.Barrio'        = ba_barrio,
				'Nombre de Barrio'  = substring(ba_descripcion,1,30),	    		    
				'Cod.Ciudad'        = ci_ciudad,
				'Ciudad'            = substring(ci_descripcion,1,30),
				'Cod.Provincia'     = pv_provincia,
				'Provincia'	        = substring(pv_descripcion,1,30),
				--'Cod.Dpto.'     	= dp_departamento,
				--'Nombre Dpto.'   	= substring(dp_descripcion,1,30),	
				'Cod.Pais'          = pa_pais,
				'País'	            = substring(pa_descripcion,1,30),
				'Estado'            = ba_estado
		from   cl_barrio, cl_ciudad, cl_provincia, cl_pais --cl_depart_pais,
			where ba_canton = ci_ciudad
			and ci_provincia   = pv_provincia
--			and pv_depart_pais = dp_departamento
			and ci_pais 	   = pa_pais 
			and ba_estado 	   = 'V'
		  order by ba_barrio, ba_canton, ci_ciudad, pv_provincia, pa_pais --dp_departamento, 
	 end	  
	 else
	if @i_modo = 1
	Select	'Cod.Barrio'        = ba_barrio,
		    'Nombre de Barrio'  = substring(ba_descripcion,1,30),	    		    
			'Cod.Ciudad'        = ci_ciudad,
		    'Ciudad'            = substring(ci_descripcion,1,30),
			'Cod.Provincia'     = pv_provincia,
			'Provincia'	        = substring(pv_descripcion,1,30),
			--'Cod.Dpto.'     	= dp_departamento,
		    --'Nombre Dpto.'   	= substring(dp_descripcion,1,30),	
			'Cod.Pais'          = pa_pais,
			'País'	            = substring(pa_descripcion,1,30),
		    'Estado'            = ba_estado
	from   cl_barrio, cl_ciudad, cl_provincia, cl_depart_pais, cl_pais
        where ba_canton    = ci_ciudad
		and ba_distrito    = pv_provincia
		and ci_provincia   = pv_provincia
--		and pv_depart_pais = dp_departamento
--		and dp_pais 	   = pa_pais 
--		and ba_estado 	   = 'V'
	    and (
			(ba_barrio > @i_barrio) or
			(ba_barrio = @i_barrio and ba_canton > @i_canton) or
			(ba_barrio = @i_barrio and ba_canton = @i_canton and ba_distrito > @i_provincia) or
			(ba_barrio = @i_barrio and ba_canton = @i_canton and ba_distrito = @i_provincia) or --and dp_departamento > @i_departamento) or
			(ba_barrio = @i_barrio and ba_canton = @i_canton and ba_distrito = @i_provincia and pa_pais > @i_pais)) --and dp_departamento = @i_departamento
        order by ba_barrio, ba_canton, ci_ciudad, ba_distrito, pv_provincia, pa_pais  --dp_departamento,
		
         /* if @@rowcount = 0
          exec sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101000*/
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
if @t_trn = 15304
begin
	 set rowcount 20
	 if @i_modo = 0
	Select	'Cod.Barrio'        = ba_barrio,
		    'Nombre de Barrio'  = substring( ba_descripcion,1,30),
			'Cod.Prov.'     	= ba_distrito,
		    'Nombre Provincia'  = substring( pv_descripcion,1,30),
		    'Estado'            = ba_estado
	from   cl_barrio, cl_provincia
		where ba_distrito = pv_provincia
	  order by ba_barrio, ba_distrito

	if @i_modo = 1
	Select	'Cod.Barrio'        = ba_barrio,
		    'Nombre de Barrio'  = substring( ba_descripcion,1,30),
		    'Cod.Prov.'     	= ba_distrito,
		    'Nombre Provincia'  = substring( pv_descripcion,1,30),
		    'Estado'            = ba_estado
	from   cl_barrio, cl_provincia
        where ba_distrito = pv_provincia
	    and (( ba_distrito = @i_distrito and  ba_barrio > @i_barrio)
        or ( ba_distrito > @i_distrito ))
	    order by ba_distrito, ba_barrio

	if @i_modo = 2
	Select	'Cod.Barrio'        = ba_barrio,
		    'Nombre de Barrio'  = substring( ba_descripcion,1,30),
		    'Cod.Prov.'     	= ba_distrito,
		    'Nombre Provincia'  = substring( pv_descripcion,1,30),
		    'Estado'            = ba_estado
	from   cl_barrio, cl_provincia
        where ba_distrito = pv_provincia         
	      and  ba_barrio    = @i_barrio
	      and  ba_distrito  = @i_distrito
	      and  ba_estado    = 'V'		

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
   if @t_trn = 15309
   begin
   			/* nueva validacion de F5 general del barrio */
			if @i_tipo_h = 'B'
			begin
			
				set rowcount 20
				if @i_modo = 0		
				
					select 'Cod.Barrio'   = ba_barrio,
					       'Barrio'       = substring(ba_descripcion,1,30),
					       'Cod.Prov.'     	= ba_distrito,
		    				'Nombre Provincia'  = substring( pv_descripcion,1,30),
					       'Cod.Cantón'   = ba_canton,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)
					 from cl_barrio, cl_provincia, cl_ciudad
					 where ba_distrito = pv_provincia
					and ba_distrito = @i_distrito
					and ba_canton   = @i_canton
                    and ba_canton   = ci_ciudad		   
					and ba_estado   = 'V'
					and ba_descripcion like isnull(@i_valor,ba_descripcion)
					order by ba_descripcion							
					
				else
				if @i_modo = 1
					select 'Cod.Barrio'   = ba_barrio,
					       'Barrio'       = substring(ba_descripcion,1,30),
					       'Cod.Prov.'     	= ba_distrito,
		    				'Nombre Provincia'  = substring( pv_descripcion,1,30),
					       'Cod.Cantón'   = ba_canton,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)
					 from cl_barrio, cl_provincia, cl_ciudad
					  where ba_distrito = pv_provincia
					and ba_distrito = @i_distrito
					and ba_canton   = @i_canton
		                        and ba_canton   = ci_ciudad		   
				    	and ba_estado   = 'V'
					and ba_descripcion > @i_ultimo
					and ba_descripcion like isnull(@i_valor,ba_descripcion)
					order by ba_descripcion						
				set rowcount 0
				return 0
			end	/* nueva validacion de F5 general del barrio */
			
	if @i_tipo_h = 'A'
	begin
		set rowcount 20
		if @i_modo = 0
			select "Cod.Barrio." = ba_barrio,
			       "Barrio"      = substring(ba_descripcion,1,30)
			  from cl_barrio
			 where ba_distrito = @i_distrito			   
			   and ba_estado   = 'V'
			 order by ba_descripcion	
		else
		if @i_modo = 1
			select "Cod.Barrio." = ba_barrio,
			       "Barrio"      = substring(ba_descripcion,1,30)
			  from cl_barrio
			 where ba_distrito = @i_distrito
	                  and ba_descripcion > @i_ultimo
			  and ba_estado      = 'V'		 
			 order by ba_descripcion	
		set rowcount 0
		return 0
	end /* operacion A */
	else 
	begin
	      if @i_tipo_h = 'V'
	      begin
			select ba_descripcion
		  from cl_barrio
		 where ba_barrio    = @i_barrio
		   and ba_distrito  = @i_distrito
		   and ba_estado    = 'V'
          
		if @@rowcount = 0
			exec sp_cerror
				@t_debug    = @t_debug,
				@t_file     = @t_file,
				@t_from     = @w_sp_name,
				@i_num      = 157097
			/* No existe Barrio */
		return 0

		end  /* operacion V */ 
		else 
		begin	
			/* nueva validacion de F5 general del barrio */
			if @i_tipo_h = 'P'
			begin
			
				set rowcount 20
				if @i_modo = 0		
					select 'Cod.Barrio'   = ba_barrio,
					       'Barrio'       = substring(ba_descripcion,1,30),
					       'Cod.Prov.'     	= ba_distrito,
			   		       'Nombre Provincia'  = substring( pv_descripcion,1,30),
					       'Cod.Cantón'   = ba_canton,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)
					 from cl_barrio, cl_provincia, cl_ciudad
					 where ba_distrito = pv_provincia
					and ba_distrito = @i_distrito
					and ba_canton   = @i_canton
		            and ba_canton   = ci_ciudad                        						
					and ba_estado   = 'V'
					order by ba_descripcion									
				else
				if @i_modo = 1
					select 'Cod.Barrio'   = ba_barrio,
					       'Barrio'       = substring(ba_descripcion,1,30),
					       'Cod.Prov.'     	= ba_distrito,
			   		    	'Nombre Provincia'  = substring( pv_descripcion,1,30),
					       'Cod.Cantón'   = ba_canton,
					       'Nombre Cantón'= substring(ci_descripcion,1,30)
					 from cl_barrio, cl_provincia, cl_ciudad
					  where ba_distrito = pv_provincia
					and ba_distrito = @i_distrito
					and ba_canton   = @i_canton
		                        and ba_canton   = ci_ciudad		   
					and ba_estado   = 'V'
					and ba_descripcion > @i_ultimo
					order by ba_descripcion
					
				set rowcount 0
				return 0
			end	/* nueva validacion de F5 general del barrio */
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

