/************************************************************************/
/*	Archivo:		proloc.sp				*/
/*	Stored procedure:	sp_pro_loc				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 15-Nov-1992					*/
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
/*	Insercion de producto						*/
/*	Actualizacion de producto					*/
/*	Ayuda de producto						*/
/*	Query de producto						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	11/Mar/94	F.Espinosa	Search sin errores para tipos	*/
/*					1 y 2				*/
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	08/May/95	S. Vinces       Admin Distribuido  		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_pro_loc')
   drop proc sp_pro_loc




go
create proc sp_pro_loc (
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
	@i_operacion		varchar(1),
	@i_modo 		tinyint = null,
	@i_tipo			tinyint = null,
	@i_tipo_h		varchar(1) = null,
	@i_producto		tinyint = null,
	@i_tipo_r		varchar(1) = null,
	@i_moneda		tinyint = null,
	@i_monto		money = null,
	@i_filial		tinyint = null,
	@i_oficina		smallint = null,
	@i_secuencial		int = null,
	@o_siguiente		int = null out,
        @i_central_transmit     varchar(1) = null
)
as
declare
	@w_return		int,
	@w_today		datetime,
	@w_sp_name		varchar(32),
	@w_aux			int,
	@w_filial		tinyint,
	@w_oficina		smallint,
	@w_producto		tinyint,
	@w_tipo			char(1),
	@w_moneda		tinyint,
	@w_monto		money,
	@v_monto		money,
	@o_filial		tinyint,
	@o_finombre		descripcion,
	@o_oficina		smallint,
	@o_ofnombre		descripcion,
	@o_producto		tinyint,
	@o_prnombre		descripcion,
	@o_tipo			char(1),
	@o_moneda		tinyint,
	@o_monombre		descripcion,
	@o_descripcion		descripcion,
	@o_monto		money,
        @w_cmdtransrv           varchar(64),
	@w_nt_nombre            varchar(32),
	@w_num_nodos            smallint,    
	@w_contador             smallint,
	@w_clave		int 


select @w_today = @s_date
select @w_sp_name = 'sp_pro_loc'


/** Insert **/
If @i_operacion = 'I'
begin
if @t_trn = 1521
begin
/* Verificacion de claves foraneas */
select @w_filial = of_filial
	from cl_oficina
	where of_oficina = @i_oficina
	  and of_filial = @i_filial
if @@rowcount = 0
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101016
	   /*"Oficina no existe"*/
	return 1
end

select @w_aux=null
  from cl_pro_moneda
 where pm_producto = @i_producto
   and pm_tipo = @i_tipo_r  
   and pm_moneda  = @i_moneda
if @@rowcount = 0 
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101012
	    /*"Producto moneda no existe"*/
	return 1
end


begin tran
       if @i_secuencial is NULL 
       begin
	exec sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'cl_pro_oficina',
		@o_siguiente	= @o_siguiente out
        select @i_secuencial    = @o_siguiente  
        end
        else
               select @o_siguiente = @i_secuencial
	insert into cl_pro_oficina (pl_filial, pl_oficina,
				 pl_producto, pl_tipo, pl_moneda,
				 pl_monto, pl_fecha_aper,
				 pl_secuencial)

	values
		(@i_filial, @i_oficina,
		 @i_producto, @i_tipo_r, @i_moneda,
		 @i_monto, @w_today, @o_siguiente)
	if @@error != 0
	begin
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103032
	     /*"Error en creacion de producto-oficina"*/
	  return 1
	end
	/* Transaccion servicios - pro_oficina */

	insert into ts_pro_oficina(secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    filial, oficina, producto, moneda, tipo,
		    monto, fecha_aper, pro_mon)
	values (@s_ssn, 1521 , 'N', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@w_filial, @i_oficina, @i_producto, @i_moneda, @i_tipo_r,
		@i_monto, @w_today, @o_siguiente)
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
If @i_operacion = 'U'
begin
if @t_trn = 1522
begin
/* Verificacion de claves foraneas */
select @w_filial = of_filial
	from cl_oficina
	where of_oficina = @i_oficina
	  and of_filial = @i_filial
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

select @w_aux=null
	from cl_pro_moneda
	where pm_producto = @i_producto
        and   pm_tipo = @i_tipo_r
	and   pm_moneda   = @i_moneda
if @@rowcount != 1
begin
	exec sp_cerror 
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101012
            /* "Producto moneda no existe" */
	return 1
end

/* Control de campos a actualizar */
    select  @w_monto = pl_monto
      from  cl_pro_oficina
     where  pl_filial = @i_filial 
       and  pl_oficina = @i_oficina
       and  pl_producto = @i_producto
       and  pl_moneda = @i_moneda
       and  pl_tipo = @i_tipo_r

    select @v_monto = @w_monto

    if @w_monto = @i_monto
	select @w_monto = null, @v_monto = null
    else
	select @w_monto = @i_monto

begin tran
	update cl_pro_oficina 
	set	pl_monto = @i_monto
	where  pl_filial = @i_filial	 
          and  pl_oficina = @i_oficina
	and	pl_producto = @i_producto
	and	pl_tipo = @i_tipo_r
	and	pl_moneda = @i_moneda
	if @@error != 0
	begin
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103011
		/*"Error en actualizacion de producto-oficina"*/
	  return 1
	end
	/* Transaccion servicios - pro_oficina */
	insert into ts_pro_oficina(secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    filial, oficina, producto, moneda, tipo,
		    monto, fecha_aper, pro_mon)
	values (@s_ssn, 1522, 'P', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@i_filial, @i_oficina, @i_producto, @i_moneda, @i_tipo_r,
		@v_monto, null, null)
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

	insert into ts_pro_oficina(secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    filial, oficina, producto, moneda, tipo,
		    monto, fecha_aper, pro_mon)
	values (@s_ssn, 1522 , 'A', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@i_filial, @i_oficina, @i_producto, @i_moneda, @i_tipo_r,
		@w_monto, null, null)
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
if @t_trn = 1523
begin
/* chequeo de claves foraneas */
select @w_filial = of_filial
	from cl_oficina
	where of_oficina = @i_oficina
	  and of_filial = @i_filial
if @@rowcount = 0 
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101016
	    /*"Localidad no existe"*/
	return 1
end

select @w_aux=null
	from cl_pro_moneda
	where pm_producto = @i_producto
        and   pm_tipo = @i_tipo_r
	and   pm_moneda   = @i_moneda
if @@rowcount != 1
begin
	exec sp_cerror 
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101012
            /* "Producto moneda no existe" */
	return 1
end

/* chequeo de referencias */
if exists (
	select sg_filial_p
          from ad_server_logico
 	 where sg_filial_p = @i_filial 
	   and sg_oficina_p = @i_oficina
	   and sg_producto = @i_producto
	   and sg_tipo = @i_tipo_r
	   and sg_moneda = @i_moneda
	 )
begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file 	= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101067
	     /* Existe referencia en server logico */
	return 1
end

/* campos para transaccion de servicios */
	select @w_filial = pl_filial,
	       @w_oficina = pl_oficina,
	       @w_producto = pl_producto,
	       @w_tipo = pl_tipo,
	       @w_moneda = pl_moneda,
	       @w_monto = pl_monto
	  from cl_pro_oficina
	 where pl_filial = @i_filial
	   and pl_oficina = @i_oficina
           and pl_producto = @i_producto
           and pl_tipo = @i_tipo_r
           and pl_moneda = @i_moneda 
begin tran
	delete from cl_pro_oficina
	 where pl_filial = @i_filial
	   and pl_oficina = @i_oficina
           and pl_producto = @i_producto
           and pl_tipo = @i_tipo_r
           and pl_moneda = @i_moneda 
	if @@error != 0
	begin
		exec sp_cerror
			@t_debug 	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num	 	= 107050
		    /* Error al borrar producto - oficina */
		return 1
	end
	/* Transaccion servicios - pro_oficina */
	insert into ts_pro_oficina(secuencia, tipo_transaccion, clase, fecha,
		    oficina_s, usuario, terminal_s, srv, lsrv,
		    filial, oficina, producto, moneda, tipo,
		    monto, fecha_aper, pro_mon)
	values (@s_ssn, 1523, 'D', @s_date,
		@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		@w_filial, @w_oficina, @w_producto, @w_moneda, @w_tipo,
		@w_monto, null, null)
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
if @i_operacion = 'S'
begin
If @t_trn = 15032
begin
if @i_tipo = 0
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Cod. F' = pl_filial, 
		       'Filial' = fi_abreviatura,
		       'Cod. O' = pl_oficina,
		       'Oficina' = substring(of_nombre, 1, 20),
		       'Producto' = pl_producto,
   		       'Tipo' = pl_tipo,
		       'Moneda' = pl_moneda,
		       'Producto - Moneda' = pm_descripcion
		  from cl_filial, cl_oficina, cl_pro_oficina, cl_pro_moneda
                 where fi_filial = pl_filial
     		   and of_oficina = pl_oficina
		   and pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
	end
	if @i_modo = 1
	begin
		select 'Cod. F' = pl_filial, 
		       'Filial' = fi_abreviatura,
		       'Cod. O' = pl_oficina,
		       'Oficina' = substring(of_nombre, 1, 20),
		       'Producto' = pl_producto,
   		       'Tipo' = pl_tipo,
		       'Moneda' = pl_moneda,
		       'Producto - Moneda' = pm_descripcion
		  from cl_filial, cl_oficina, cl_pro_oficina, cl_pro_moneda
                 where fi_filial = pl_filial
     		   and of_oficina = pl_oficina
		   and pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and (
			(pl_filial > @i_filial) or
                        ((pl_filial = @i_filial) and (pl_oficina > @i_oficina))
                    or  ((pl_filial = @i_filial) and (pl_oficina = @i_oficina)
  			 and (pl_producto > @i_producto) )
                    or  ((pl_filial = @i_filial) and (pl_oficina = @i_oficina)
  		         and (pl_producto = @i_producto) 
                         and (pl_tipo > @i_tipo_r))
                    or  ((pl_filial = @i_filial) and (pl_oficina = @i_oficina)
  		         and (pl_producto = @i_producto) 
                         and (pl_tipo = @i_tipo_r) and (pl_moneda > @i_moneda))
			)
	end
end
if @i_tipo = 1
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Cod. F' = pl_filial,
                       'Filial' = fi_abreviatura,
		       'Cod. O' = pl_oficina,
               	       'Oficina' = substring(of_nombre, 1, 20)
          	  from cl_filial, cl_oficina, cl_pro_oficina
                 where fi_filial = pl_filial
                   and of_oficina = pl_oficina
                   and pl_producto = @i_producto
                   and pl_tipo = @i_tipo_r
                   and pl_moneda = @i_moneda
	end

	if @i_modo = 1
	begin
		select 'Cod. F' = pl_filial, 
		       'Filial' = fi_abreviatura,
		       'Cod. O' = pl_oficina,
               	       'Oficina' = substring(of_nombre, 1, 20)
          	  from cl_filial, cl_oficina, cl_pro_oficina
                 where fi_filial = pl_filial
                   and of_oficina = pl_oficina
                   and pl_producto = @i_producto
                   and pl_tipo = @i_tipo_r
                   and pl_moneda = @i_moneda
		   and (
                       (pl_filial > @i_filial) or
                       ((pl_filial = @i_filial) and (pl_oficina > @i_oficina))
		       )
	end
end
if @i_tipo = 2
begin
	if @i_modo = 0
	begin
		select 'Cod. Producto' = pl_producto,
		       'Tipo' = pl_tipo,
		       'Moneda' = pl_moneda,
		       'Producto - Moneda' = pm_descripcion
		  from cl_pro_oficina, cl_pro_moneda
		 where pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and pl_filial = @i_filial
		   and pl_oficina = @i_oficina
	end
	if @i_modo = 1
	begin
		select 'Cod. Producto' = pl_producto,
		       'Tipo' = pl_tipo,
		       'Moneda' = pl_moneda,
		       'Producto - Moneda' = pm_descripcion
		  from cl_pro_oficina, cl_pro_moneda
		 where pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and pl_filial = @i_filial
		   and pl_oficina = @i_oficina
		   and (
			(pl_producto > @i_producto) or
                        ((pl_producto = @i_producto) and 
                         (pl_tipo > @i_tipo_r))
                    or  ((pl_producto = @i_producto) and
			 (pl_tipo = @i_tipo_r) and
			 (pl_moneda > @i_moneda))
			)
	end
end
if @i_tipo = 3
begin
	if @i_modo = 0
	begin
		select 'Cod. F' = pl_filial, 
		       'Filial' = fi_abreviatura,
		       'Cod. O' = pl_oficina,
		       'Oficina' = substring(of_nombre, 1, 20),
		       'Producto' = pl_producto,
   		       'Tipo' = pl_tipo,
		       'Producto - Moneda' = pm_descripcion
		  from cl_filial, cl_oficina, cl_pro_oficina, cl_pro_moneda
                 where fi_filial = pl_filial
     		   and of_oficina = pl_oficina
		   and pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and pl_moneda = @i_moneda
	end
	if @i_modo = 1
	begin
		select 'Cod. F' = pl_filial, 
		       'Filial' = fi_abreviatura,
		       'Cod. O' = pl_oficina,
		       'Oficina' = substring(of_nombre, 1, 20),
		       'Producto' = pl_producto,
   		       'Tipo' = pl_tipo,
		       'Producto - Moneda' = pm_descripcion
		  from cl_filial, cl_oficina, cl_pro_oficina, cl_pro_moneda
                 where fi_filial = pl_filial
     		   and of_oficina = pl_oficina
		   and pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and pl_moneda = @i_moneda
		   and (
			(pl_filial > @i_filial) or
                        ((pl_filial = @i_filial) and (pl_oficina > @i_oficina))
                    or  ((pl_filial = @i_filial) and (pl_oficina = @i_oficina)
  			 and (pl_producto > @i_producto) )
                    or  ((pl_filial = @i_filial) and (pl_oficina = @i_oficina)
  		         and (pl_producto = @i_producto) 
                         and (pl_tipo > @i_tipo_r))
			)
	end
end
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

/** Query **/
if @i_operacion = 'Q'
begin
If @t_trn = 15033
begin
    select  @o_filial = pl_filial,
            @o_finombre = fi_nombre,
            @o_oficina = pl_oficina,
	    @o_ofnombre = of_nombre,
	    @o_producto = pl_producto,
            @o_tipo = pl_tipo,
	    @o_moneda = pl_moneda,
	    @o_descripcion = pd_descripcion + " " + mo_descripcion,
	    @o_monto	= pl_monto
      from  cl_pro_oficina, cl_filial, cl_oficina, cl_producto, cl_moneda
     where  fi_filial = pl_filial
       and  of_oficina = pl_oficina
       and  pd_producto = pl_producto
       and  mo_moneda = pl_moneda
       and  pl_filial = @i_filial
       and  pl_oficina = @i_oficina
       and  pl_producto = @i_producto
       and  pl_tipo = @i_tipo_r
       and  pl_moneda = @i_moneda

    if @@rowcount = 0
    begin
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101033
	    /*	'No existe producto oficina'*/
       return 1
    end

    select @o_filial, @o_finombre, @o_oficina, @o_ofnombre,
	   @o_producto, @o_tipo, @o_moneda, @o_descripcion, @o_monto
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
If @t_trn = 15034
begin
 if @i_tipo_h = 'A'
 begin
	if @i_modo = 0
	begin
		select 'Cod. Producto' = pl_producto,
		       'Tipo' = pl_tipo,
		       'Moneda' = pl_moneda,
		       'Producto - Moneda' = pm_descripcion
		  from cl_pro_oficina, cl_pro_moneda
		 where pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and pl_filial = @i_filial
		   and pl_oficina = @i_oficina
	end
	if @i_modo = 1
	begin
		select 'Cod. Producto' = pl_producto,
		       'Tipo' = pl_tipo,
		       'Moneda' = pl_moneda,
		       'Producto - Moneda' = pm_descripcion
		  from cl_pro_oficina, cl_pro_moneda
		 where pm_producto = pl_producto
		   and pm_tipo = pl_tipo
		   and pm_moneda = pl_moneda
		   and pl_filial = @i_filial
		   and pl_oficina = @i_oficina
		   and (
			(pl_producto > @i_producto) or
                        ((pl_producto = @i_producto) and 
                         (pl_tipo > @i_tipo_r))
                    or  ((pl_producto = @i_producto) and
			 (pl_tipo = @i_tipo_r) and
			 (pl_moneda > @i_moneda))
			)
	end
 end
 if @i_tipo_h = 'V'
 begin
	 select	  'Tipo' = pl_tipo,
		  'Moneda' = pl_moneda,
		  'Producto - Moneda' = substring(pm_descripcion,1,30)
	   from   cl_pro_oficina, cl_pro_moneda
	 where	  pl_producto = pm_producto
	 and	  pl_tipo = pm_tipo
	 and	  pl_moneda = pm_moneda
	 and	  pl_filial = @i_filial
	 and	  pl_oficina = @i_oficina
	 and	  pl_producto = @i_producto
/*	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101033
	   /*  'No existe producto oficina' */
	  return 1
	 end
*/
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

