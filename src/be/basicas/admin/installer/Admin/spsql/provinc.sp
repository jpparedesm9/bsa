/************************************************************************/
/*	Archivo:		provonc.sp				*/
/*	Stored procedure:	sp_provincia				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 08-Nov-1992					*/
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
/*	Busqueda de provincia						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	08/Nov/92	M. Davila	Emision Inicial			*/
/*	12/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	25/Feb/93	M. Davila	Eliminacion de la tabla de cata */
/*  					logo				*/
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	03/May/95	S. Vinces 	Cambios por Admin Distribuido   */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_provincia')
   drop proc sp_provincia


go
create proc sp_provincia (
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
       	@i_modo			tinyint = null,
       	@i_tipo			varchar(1) = null,
       	@i_provincia		smallint = null,
       	@i_descripcion   	descripcion = null,
       	@i_region_nat    	varchar(2) = null,
       	@i_region_ope    	varchar(3) = null,
       	@i_pais			smallint = null,
       	@i_estado		estado = null,
	@i_central_transmit	varchar(1) = null,
       	@i_valor   		descripcion 	= null,		/** JL  **/
        @i_provinc_alf  	varchar(64)  	= null,	/*REC*/
       	@o_filas		tinyint = null out
)
as
declare @w_today	datetime,
	@w_sp_name	varchar(32),
	@w_cambio	int,
	@w_codigo	int,
	@w_ciudad	int,
	@w_descripcion	descripcion,
	@w_region_nat	varchar(2),
	@w_region_ope	varchar(3),
	@w_pais 	smallint,
	@w_estado	estado,
	@w_transaccion	int,
	@v_descripcion	descripcion,
	@v_region_nat	varchar(2),
	@v_region_ope	varchar(3),
	@v_pais 	smallint,
	@v_estado	estado,
	@o_provincia	smallint,
	@w_server_logico    varchar(10),
	@w_num_nodos        smallint,    
	@w_contador          smallint,
	@w_cmdtransrv	varchar(60),
	@w_nt_nombre    varchar(30),
	@w_clave	int,
	@w_return       int,
	@w_codigo_c	varchar(10)

select	@w_today=@s_date,
	@w_sp_name = 'sp_provincia',
	@o_filas = 13

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 1526 
begin
  /* Verificacion de claves foraneas */
  select @w_codigo = null
    from cl_catalogo x, cl_tabla y
   where x.codigo = @i_region_nat
     and y.tabla = 'cl_region_nat'
     and y.codigo = x.tabla
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101039
	    /*'No existe region natural'*/
     return 1
  end
  select @w_codigo = null
    from cl_catalogo x, cl_tabla y
   where x.codigo = @i_region_ope
     and y.tabla = 'cl_region_ope'
     and y.codigo = x.tabla
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101040
	  /*	'No existe region operativa'*/
     return 1
  end
  select @w_codigo = null
    from cl_pais
   where pa_pais = @i_pais 
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101018
	   /*	'No existe pais'*/
     return 1
  end

  if exists (select pv_provincia  from cl_provincia
   	      where pv_provincia = @i_provincia )
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 151073
	   /*	'Ya existe provincia ' */
     return 1
  end

  begin tran
/*     exec sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'cl_provincia',
		@o_siguiente	= @o_provincia out
*/
     /* Insert cl_provincia */
     insert into cl_provincia (pv_provincia, pv_descripcion, pv_region_nat,
			       pv_region_ope, pv_pais, pv_estado)
		   values (@i_provincia, @i_descripcion, @i_region_nat,
			   @i_region_ope, @i_pais, 'V')
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103043
	      /* 'Error en creacion de provincia'*/
	return 1
     end
     /* transaccion servicio - provincia */

     insert into ts_provincia (secuencia, tipo_transaccion, clase, fecha,
			      provincia, descripcion, region_nat,
			      region_ope, pais, estado)
     values (@s_ssn, 1526, 'N', @s_date,
	     @i_provincia, @i_descripcion, @i_region_nat,
	     @i_region_ope, @i_pais, 'V')
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	     /* 'Error en creacion de transaccion de servicios'*/
	  return 1
     end
  commit tran

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_provincia)
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
       		@i_tabla		   = 'cl_provincia',
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
if @t_trn = 1527
begin
  /* Verificacion de claves foraneas */

  select @w_codigo = null
    from cl_catalogo x, cl_tabla y
   where x.codigo = @i_region_nat
     and y.tabla = 'cl_region_nat'
     and y.codigo = x.tabla
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101039
	    /*'No existe region natural'*/
     return 1
  end
  select @w_codigo = null
    from cl_catalogo x, cl_tabla y
   where x.codigo = @i_region_ope
     and y.tabla = 'cl_region_ope'
     and y.codigo = x.tabla
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101040
	  /*	'No existe region operativa'*/
     return 1
  end
  select @w_codigo = null
    from cl_pais
   where pa_pais = @i_pais 
  if @@rowcount = 0
  begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101018
	   /*	'No existe pais'*/
     return 1
  end

  select @w_descripcion    = pv_descripcion,
	 @w_region_nat	   = pv_region_nat,
	 @w_region_ope	   = pv_region_ope,
	 @w_pais	   = pv_pais,
	 @w_estado	   = pv_estado
    from cl_provincia
   where pv_provincia = @i_provincia

  select @v_descripcion    = @w_descripcion
  select @v_region_nat	   = @w_region_nat
  select @v_region_ope	   = @w_region_ope
  select @v_pais	   = @w_pais
  select @v_estado	   = @w_estado

  if @w_descripcion = @i_descripcion
     select @w_descripcion = null, @v_descripcion = null
  else
     select @w_descripcion = @i_descripcion
  if @w_region_nat = @i_region_nat
     select @w_region_nat = null, @v_region_nat = null
  else
     select @w_region_nat = @i_region_nat
  if @w_region_ope = @i_region_ope
     select @w_region_ope = null, @v_region_ope = null
  else
     select @w_region_ope =  @i_region_ope
  if @w_pais = @i_pais
     select @w_pais = null, @v_pais = null
  else
     select @w_pais = @i_pais
  if @w_estado = @i_estado
     select @w_estado = null, @v_estado = null
  else
  begin
	if @i_estado = "C"
	begin
		if exists (
			select *
			  from cl_ciudad
			 where ci_provincia = @i_provincia
			  )
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101072
		  	/* Existe referencia en ciudad */
			return 1
		end
	end
	else
	begin
		if exists (
			select * 
			  from cl_pais
			 where pa_pais = @i_pais
                           and pa_estado = 'C'
			  )
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101074
		  	/* Pais no vigente */
			return 1
		end
	end
	select @w_estado = @i_estado
  end

  begin tran
     /* Update provincia */
     update cl_provincia
     set    pv_descripcion = @i_descripcion,
	    pv_region_nat  = @i_region_nat,
	    pv_region_ope  = @i_region_ope,
	    pv_pais	   = @i_pais,
	    pv_estado	   = @i_estado 

     where  pv_provincia = @i_provincia 
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105038
	    /* 'Error en actualizacion de provincia'*/
	return 1
     end
     /* transaccion servicios - provincia */

     insert into ts_provincia (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       provincia, descripcion, region_nat,
			       region_ope, pais, estado)
     values (@s_ssn, 1527, 'P', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	     @i_provincia, @v_descripcion, @v_region_nat,
	     @v_region_ope, @v_pais, @v_estado)
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	     /* 'Error en creacion de transaccion de servicios'*/
	return 1
     end

     insert into ts_provincia (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       provincia, descripcion,region_nat,
			       region_ope, pais, estado)
     values (@s_ssn, 1527, 'A', @s_date,
             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	     @i_provincia, @w_descripcion, @w_region_nat,
	     @w_region_ope, @w_pais, @w_estado)
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	   /* 'Error en creacion de transaccion de servicios'*/
	return 1
     end
  commit tran

       	select @w_codigo_c = convert(varchar(10), @i_provincia)
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
       		@i_tabla		   = 'cl_provincia',
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
if @t_trn = 1549
begin
     set rowcount 20 -- PES
     if @i_modo = 0
	select 'Codigo' = pv_provincia,
	       'Provincia' = substring(pv_descripcion,1,20),
	       'Cod. Reg. Op.' = pv_region_ope,
	       'Region Opererativa' = substring(x.valor,1,20),
	       'Cod. Reg. Nat.' = pv_region_nat,
	       'Region Natural' = substring(y.valor,1,20),
	       'Cod. Pais' = pv_pais,
	       'Pais' = substring(pa_descripcion,1,20),
               'Estado' = pv_estado
	from   cl_catalogo x, cl_provincia, cl_catalogo y,
	       cl_pais, cl_tabla z, cl_tabla w
	where  z.tabla = 'cl_region_ope'
        and    z.codigo = x.tabla
        and    x.codigo = pv_region_ope
        and    w.tabla = 'cl_region_nat'
        and    w.codigo = y.tabla
        and    y.codigo = pv_region_nat
	and    pa_pais = pv_pais
	order  by pv_provincia
     else
	if @i_modo = 1
	select 'Codigo' = pv_provincia,
	       'Provincia' = substring(pv_descripcion,1,20),
	       'Cod. Reg. Op.' = pv_region_ope,
	       'Region Opererativa' = substring(x.valor,1,20),
	       'Cod. Reg. Nat.' = pv_region_nat,
	       'Region Natural' = substring(y.valor,1,20),
	       'Cod. Pais' = pv_pais,
	       'Pais' = substring(pa_descripcion,1,20),
               'Estado' = pv_estado
	from   cl_catalogo x, cl_provincia, cl_catalogo y,
	       cl_pais, cl_tabla z, cl_tabla w
	where  z.tabla = 'cl_region_ope'
        and    z.codigo = x.tabla
        and    x.codigo = pv_region_ope
        and    w.tabla = 'cl_region_nat'
        and    w.codigo = y.tabla
        and    y.codigo = pv_region_nat
	and    pa_pais = pv_pais
        and    pv_provincia > @i_provincia
	order  by pv_provincia
     if @@rowcount = 0
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101000
	  /*	'No existe dato en catalogo'*/
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
if @t_trn = 1548
begin
     set rowcount 13
     if @i_modo = 0
	select 'Codigo' = pv_provincia,
	       'Provincia' = pv_descripcion,
	       'Cod. Reg. Op.' = pv_region_ope,
	       'Region Opererativa' = x.valor,
	       'Cod. Reg. Nat.' = pv_region_nat,
	       'Region Natural' = y.valor,
	       'Cod. Pais' = pv_pais,
	       'Pais' = pa_descripcion
	from   cl_catalogo x, cl_provincia, cl_catalogo y,
	       cl_pais
	where  x.tabla = 20
        and    x.codigo = convert(char(10), pv_region_ope)
        and    y.tabla = 23
        and    y.codigo = pv_region_nat
	and    pa_pais = pv_pais
        and    pv_estado = 'V'
	order  by pv_provincia
     else
	if @i_modo = 1
	select 'Codigo' = pv_provincia,
	       'Provincia' = pv_descripcion,
	       'Cod. Reg. Op.' = pv_region_ope,
	       'Region Opererativa' = x.valor,
	       'Cod. Reg. Nat.' = pv_region_nat,
	       'Region Natural' = y.valor,
	       'Cod. Pais' = pv_pais,
	       'Pais' = pa_descripcion
	from   cl_catalogo x, cl_provincia, cl_catalogo y,
	       cl_pais
	where  x.tabla = 20
        and    x.codigo = convert(char(10), pv_region_ope)
        and    y.tabla = 23
        and    y.codigo = pv_region_nat
	and    pa_pais = pv_pais
        and    pv_provincia > @i_provincia
        and    pv_estado = 'V'
	order  by pv_provincia
     if @@rowcount = 0
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101000
	  /*	'No existe dato en catalogo'*/
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
/* ** Help **/
if @i_operacion = "H"
begin
if @t_trn = 1550
begin
	if @i_tipo = "A"
	begin
		set rowcount 20
		if @i_modo = 0
		begin
			select	'Cod.'=pv_provincia,
				'Provincia'=pv_descripcion,
				'Cod.Pais'=pa_pais,
				'Pais '=pa_descripcion
			  from  cl_provincia, cl_pais
			 where  pa_pais = pv_pais
			   and  pv_pais = @i_pais
		           and  pv_estado = 'V'
		end
		if @i_modo = 1
		begin
			select	'Cod.'=pv_provincia,
				'Provincia'=pv_descripcion,
				'Cod.Pais'=pa_pais,
				'Pais '=pa_descripcion
			  from  cl_provincia, cl_pais
			 where  pa_pais = pv_pais
			   and  pv_pais = @i_pais
			   and  pv_provincia > @i_provincia
			   and  pv_estado = 'V'
		end
		set rowcount 0
		return 0
	end
	if @i_tipo = "V"
	begin
		select pv_descripcion 
		  from cl_provincia
		 where pv_provincia = @i_provincia
		   and pv_estado = 'V'
     		if @@rowcount = 0
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101000
	  		/*	'No existe dato en catalogo'*/
		return 0
	end
        if @i_tipo = "B"    /** JL: Busqueda Alfabetica  **/
	begin
		set rowcount 20
		if @i_modo = 0
		begin
			select	'Cod.'		= pv_provincia,
				'Provincia'	= pv_descripcion,
				'Cod.Pais'	= pa_pais,
				'Pais '		= pa_descripcion
			  from  cl_provincia, cl_pais
			 where  pa_pais 	= pv_pais
			   and  pv_pais 	= @i_pais
		           and  pv_estado 	= 'V'
			   and  pv_descripcion like @i_valor
                         order by pv_descripcion --REC
		end
		if @i_modo = 1
		begin
			select	'Cod.'		= pv_provincia,
				'Provincia'	= pv_descripcion,
				'Cod.Pais'	= pa_pais,
				'Pais '		= pa_descripcion
			  from  cl_provincia, cl_pais
			 where  pa_pais 	= pv_pais
			   and  pv_pais 	= @i_pais
			   and  pv_estado 	= 'V'
			   and  pv_descripcion > @i_provinc_alf --REC
			   and  pv_descripcion like @i_valor
                         order by pv_descripcion  --REC
                         
		end
		set rowcount 0
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
