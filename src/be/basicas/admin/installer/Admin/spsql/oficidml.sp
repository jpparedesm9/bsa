/************************************************************************/
/*	Archivo:		oficidml.sp				*/
/*	Stored procedure:	sp_oficina_dml				*/
/*	Base de datos:		cobis					*/
/*	Producto: Clientes						*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 12-Nov-1992					*/
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
/*	Este programa procesa las transacciones del stored procedure	*/
/*      Insercion de oficina                                            */
/*      Modificacion de oficina                                         */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	12/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	11/Jun/93	S. Ortiz	Mantenimiento de datos redun-	*/
/*					dantes en ad_ruta.		*/
/*      23/Nov/93       R. Minga V.     Documentacion, param @s_        */
/*                                      Verificacion y validacion       */
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	02/May/95	S. Vinces  	Cambios para Admin Distribuido  */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_oficina_dml')
   drop proc sp_oficina_dml
go
create proc sp_oficina_dml (
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
        @i_operacion           	varchar(1),
        @i_modo                	tinyint=NULL,
        @i_tipo                	varchar(2)=NULL,
        @i_oficina	      	smallint=NULL,
        @i_filial              	tinyint=NULL,
        @i_nombre              	descripcion=NULL,
        @i_direccion           	direccion=NULL,
        @i_ciudad              	int=NULL, /* PES version Colombia */
        @i_subtipo             	varchar (1)=NULL,
        @i_sucursal	      	smallint=null, /*CNA versión Colombia*/
	@i_central_transmit	varchar(1) = null
       )
as
declare @w_sp_name	  varchar(32),
	@w_aux            int,
	@w_filial         tinyint,
	@w_nombre         descripcion,
	@w_direccion      direccion,
	@w_ciudad         int, /* PES version Colombia */
	@w_subtipo        char(1),
	@w_sucursal       smallint, /*CNA versión Colombia*/
        @w_siguiente      int,
        @w_return         int,
	@v_filial         tinyint,
	@v_nombre         descripcion,
	@v_direccion      direccion,
	@v_ciudad         int, /* PES version Colombia */
	@v_subtipo        char(1),
	@v_sucursal       smallint, /*CNA versión Colombia*/
	@w_codigo	  catalogo,  
	@w_bandera	   char(1) ,
	@w_cmdtransrv	  varchar(60),
	@w_nt_nombre    varchar(30),
	@w_server_logico    varchar(10),
	@w_num_nodos        smallint,    
	@w_contador          smallint,
	@w_clave	     int 

select @w_sp_name = 'sp_oficina_dml'
select @w_bandera = 'N'


/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U') and (@i_central_transmit is NULL)  
begin
 create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char (1) )
end

/* ** insercion ** */
if @i_operacion='I'
begin
if @t_trn = 1513
begin

  /* verificar que la oficina no exista anteriormente */
  select @w_aux=null
       from cl_oficina
       where of_oficina = @i_oficina

  if @@rowcount != 0
  begin

    /* "Oficina fue registrada anteriormente"*/
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151053
    return 1
  end 

  /* verificar si existe la filial */
  select @w_aux=null
       from cl_filial
       where fi_filial = @i_filial

  if @@rowcount != 1
  begin

    /* "Filial no existe"*/
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101002
    return 1
  end

  /* verificar si existe la ciudad */
  select @w_aux=null
  from cl_ciudad
  where ci_ciudad = @i_ciudad
  if @@rowcount != 1
  begin
    /*"No existe Ciudad"*/
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101024
    return 1
  end

  /* verificar que se trate de agencia o sucursal */
  if (@i_subtipo != 'A') and (@i_subtipo != 'S')
  begin
    /*"Subtipo no valido"*/
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101046
    return 1
  end

  /*si se trata de una agencia, verificar que exista la sucursal propietaria*/
  if @i_subtipo = 'A'
  begin
    select @w_aux=null
    from cl_oficina
    where of_oficina = @i_sucursal
      and of_subtipo = 'S'

    if @@rowcount != 1
    begin
	 /* "Sucursal no existe"*/
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101028
	 return 1
    end
  end

  /* si se trata de una sucursal, no tiene sucursal propietaria */
  else
	select @i_sucursal = null

  begin tran
/*   /* obtener un nuevo secuencial para la oficina */
    exec sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'cl_oficina',
		@o_siguiente	= @w_siguiente out
*/
     /* insertar los datos de entrada */
     insert into cl_oficina (of_filial, of_oficina,of_nombre,
			       of_direccion,of_ciudad, of_telefono,
			       of_subtipo, a_sucursal)
		      values  (@i_filial, @i_oficina, @i_nombre,
			       @i_direccion, @i_ciudad, 0,
			       @i_subtipo, @i_sucursal)

     /* si no se puede insertar, error */
     if @@error != 0
     begin
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103049
	  /*	"Error en creacion de oficina"*/
      return 1
   end

   /* transaccion de servicio - oficina */
   insert into ts_oficina (secuencia,tipo_transaccion,clase,fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   filial,oficina,nombre,direccion,
			   ciudad,telefono,subtipo,sucursal)
		     values (@s_ssn, 1513,'N',@s_date,
	                     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_filial, @i_oficina, @i_nombre,@i_direccion,
			     @i_ciudad, 0,@i_subtipo, @i_sucursal)

    /* si no se puede insertar, error */
    if @@error != 0
    begin
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	  /*	"Error en creacion de transaccion de servicio"*/
      return 1
   end
  select @w_bandera = 'S'
  commit tran
/*  
  /* retornar el siguiente secuencial para la oficina */
  select @w_siguiente
*/ 
  if @w_bandera = 'S'
     begin
	
	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo = convert(varchar(10), @i_oficina)
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
       		@i_tabla		   = 'cl_oficina',
       		@i_codigo		   = @w_codigo,
       		@i_descripcion 		   = @i_nombre,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
		return @w_return
     end

/********************   Para   Unix     ***************************/

	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
	  from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             

	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	select @w_contador = 1
	while @w_contador <= @w_num_nodos
	 begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'
		
		set rowcount 0

		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre = @w_nt_nombre

		exec @w_return = @w_cmdtransrv  
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_oficina     = @i_oficina,
					@i_filial      = @i_filial,
					@i_nombre      = @i_nombre,
					@i_direccion   = @i_direccion,
					@i_ciudad      = @i_ciudad,
					@i_subtipo     = @i_subtipo,
					@i_sucursal    = @i_sucursal,
					@i_central_transmit = 'S',
					@o_clave        = @w_clave out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave,
				@i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
/********************   Para   Unix     ****************************/

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
if @i_operacion ='U'
begin
if @t_trn = 1514
begin
  /* verificar que exista la oficina */
  select  @w_nombre = of_nombre,
	  @w_direccion = of_direccion,
	  @w_ciudad = of_ciudad,
	  @w_sucursal = a_sucursal,
          @w_subtipo=of_subtipo
  from cl_oficina
  where of_oficina = @i_oficina

  if @@rowcount != 1
  begin
   exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101016
	 /*"Localidad no existe"*/
   return 1
  end

  /* verificar que exista la ciudad */
  select @w_aux=null
  from cl_ciudad
    where ci_ciudad = @i_ciudad


  if @@rowcount != 1
  begin
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101024
	  /*"Ciudad no existe"*/
    return 1
  end
 
  /* verificar que exista la sucursal propietaria de la agencia
     si se trata de una agencia */
  if @i_subtipo = 'A'
  begin
   select @w_aux=null
    from cl_oficina
    where of_oficina = @i_sucursal
      and of_subtipo = 'S'

   if @@rowcount != 1
   begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101028
	 /*	"Sucursal no existe"*/
     return 1
   end

  end
  /* si no es agencia, se trata de sucursal que no tiene sucursal 
     propietaria  */
  else
    select @i_sucursal = null

 
  /* verificar que si era sucursal y se va a convertir en agencia
     no debe tener agencias dependiendo de ella */
  if @i_subtipo = 'A' and @w_subtipo='S'
  begin
   if exists (select of_oficina
    		from cl_oficina
    		where a_sucursal = @i_oficina
      		and of_subtipo = 'A')

   	begin
	     exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 151062
		 /*	"Existen Oficinas dependientes de esta sucursal"*/
	     return 1
	end
  end

  /* guardar los datos anteriores */
  select @v_nombre = @w_nombre,
	 @v_direccion = @w_direccion,
	 @v_ciudad = @w_ciudad,
	 @v_sucursal = @w_sucursal

  if @w_nombre = @i_nombre
   select @w_nombre = null, @v_nombre = null
  else
   select @w_nombre = @i_nombre

  if @w_direccion = @i_direccion
   select @w_direccion= null, @v_direccion= null
  else
   select @w_direccion= @i_direccion

  if @w_ciudad = @i_ciudad
   select @w_ciudad= null, @v_ciudad= null
  else
   select @w_ciudad= @i_ciudad

  if @w_sucursal = @i_sucursal
   select @w_sucursal= null, @v_sucursal= null
  else
   select @w_sucursal= @i_sucursal

  begin tran

   /* modificar los datos */
   update cl_oficina 
      set of_nombre = @i_nombre,
	  of_direccion = @i_direccion,
	  of_ciudad = @i_ciudad,
	  a_sucursal = @i_sucursal,
	  of_subtipo = @i_subtipo
   where of_oficina= @i_oficina

   /* si no se puede modificar, error */
   if @@error != 0
   begin
   /*"Error en actualizacion de oficina"*/
    exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105049
    return 1
   end

      /*  Mantiente actualizados los datos redundates de ad_ruta  */
      if @w_nombre is not null
      begin
	      update	ad_ruta
	      set	ru_nombre_o_d = @i_nombre
	      where	ru_oficina_d = @i_oficina

	      if @@error != 0
	      begin
		 /* 'Error en actualizacion de ruta'*/
		 exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 155018
		 return 1
	      end

	      update	ad_ruta
	      set	ru_nombre_o_h = @i_nombre
	      where	ru_oficina_h = @i_oficina

	      if @@error != 0
	      begin
		 /* 'Error en actualizacion de ruta'*/
		 exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 155018
		 return 1
	       end
	end

  /* transaccion de servicio - oficina */
   insert into ts_oficina (secuencia,tipo_transaccion,clase,fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
		           oficina,nombre,direccion,
			   ciudad,sucursal)
		     values (@s_ssn, 1514,'P',@s_date,
	                     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_oficina,@v_nombre,@v_direccion,
			     @v_ciudad,  @v_sucursal)

    /* si no se puede insertar, error */
    if @@error != 0
    begin
      /* "Error en creacion de transaccion de servicio"*/
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
      return 1
   end

   /* transaccion de servicio - oficina */
   insert into ts_oficina (secuencia,tipo_transaccion,clase,fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   oficina,nombre,direccion,
			   ciudad,sucursal)
		     values (@s_ssn, 1514,'A',@s_date,
	                     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_oficina,@w_nombre,@w_direccion,
			     @w_ciudad,  @w_sucursal)

    /* si no se puede insertar, error */
    if @@error != 0
    begin
      /* "Error en creacion de transaccion de servicio"*/
      exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
      return 1
   end

  select @w_bandera = 'S'
  commit tran
  if @w_bandera = 'S'
     begin

	/* Actualizacion de la los datos en el catalogo */
       	
	select @w_codigo = convert(varchar(10), @i_oficina)
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
       		@i_tabla		   = 'cl_oficina',
       		@i_codigo		   = @w_codigo,
       		@i_descripcion 		   = @i_nombre,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
		return @w_return
     end

/********************   Para   Unix     ***************************/

	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
	  from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             

	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	select @w_contador = 1
	while @w_contador <= @w_num_nodos
	 begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'
		
		set rowcount 0

		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre = @w_nt_nombre

		exec @w_return = @w_cmdtransrv  
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_oficina     = @i_oficina,
					@i_filial      = @i_filial,
					@i_nombre      = @i_nombre,
					@i_direccion   = @i_direccion,
					@i_ciudad      = @i_ciudad,
					@i_subtipo     = @i_subtipo,
					@i_sucursal    = @i_sucursal,
					@i_central_transmit = 'S',
					@o_clave        = @w_clave out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave,
				@i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
/*******************   Para   Unix     ****************************/


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
