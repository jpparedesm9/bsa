/************************************************************************/
/*	Archivo:		tello.sp				*/
/*	Stored procedure:	sp_telefono_loc 			*/
/*	Base de datos:		cobis					*/
/*	Producto: Clientes						*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 06-Nov-1992					*/
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
/*	Query de empleo 						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10/Nov/92	L. Carvajal	Emision Inicial			*/
/*	15/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	07/Sep/94	C.Rodriguez	Tomar el secuencial de trans. de*/
/*					servicio del @s_ssn		*/
/*					Crear la operacion S,H y Q	*/
/*	25/Jul/12			Modificacion en un alias 	*/
/*	08/Sep/12       R.Orejuela      Agrego isnull para of_telefono  */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_telefono_loc')
   drop proc sp_telefono_loc
go

create proc sp_telefono_loc (
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
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
        @t_show_version		bit         	= 0, -- Mostrar la version del programa  --(PRMR STANDAR)
	@i_operacion	     char(1),
	@i_oficina	     smallint= null,
	@i_secuencial	     tinyint= null,
	@i_valor	     varchar(12)= null,
	@i_tipo_tel	     char(2)= null, --jm
	@o_siguiente	     int = null out
 )
as
declare  @w_var 	  int,
	 @w_sp_name	  varchar(32),
	 @w_aux           int,
	 @w_today         datetime,
	 @w_valor         varchar(12),
	 @w_ttelefono char(2),
	 @v_valor         varchar(12),
	 @v_ttelefono char(2),
	 @w_transaccion   int,
	 @o_valor         varchar(12),
	 @o_tipo_tel      char(2)


select @w_today=@s_date
select @w_sp_name = 'sp_telefono_loc'


/***Mostrar versionamiento del sp ***/--(PRMR STANDAR)
	if @t_show_version = 1
	begin
		print 'Stored procedure sp_telefono_loc, Version 4.0.0.0'
		return 0
	end

/* ** Insert ** */
if @i_operacion = 'I'
begin
If @t_trn = 15059
begin
 /* chequeo de claves foraneas */
 if not exists (
     select  of_filial
       from  cl_oficina
      where  of_oficina = @i_oficina)
 begin
     exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101016
	/* 'No existe oficina' */
     return 1
 end

 begin tran
   update cl_oficina
	  set of_telefono = isnull(of_telefono,0) + 1
	  where of_oficina = @i_oficina
   if @@error != 0
   begin
	exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 103038
	  /* 'Error en creacion de telefono'*/
	return 1
   end
   select @o_siguiente = of_telefono
	  from cl_oficina
	  where  of_oficina = @i_oficina

 insert into cl_telefono_of (to_oficina,
			      to_secuencial, to_valor, to_ttelefono)
		      values (@i_oficina,
			      @o_siguiente, @i_valor, @i_tipo_tel)
  if @@error != 0
  begin
       exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 103038
	   /*	'Error en creacion de telefono'*/
       return 1
  end

  /* transaccion de servicio - oficina */
  insert into ts_telefono_of (secuencial, tipo_transaccion, clase, fecha,
			       oficina, secuencia, valor,
			       tipo_telefono)
		       values (@s_ssn,15059, 'N', @w_today,
			       @i_oficina,
			       @o_siguiente, @i_valor, @i_tipo_tel)
  if @@error != 0
  begin
      exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 103005
	     /*	"Error en creacion de transaccion de servicio"*/
      return 1
  end
  commit tran

  select @o_siguiente
 
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
If @t_trn = 15060
begin
 if not exists (
	       select   of_filial
		 from   cl_oficina
		where   of_oficina = @i_oficina
 )
 begin
     exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101016
	     /*	'No existe oficina'*/
     return 1
 end

/* Verificacion de cambio: @w_aux = 0 -> cambio  @w_aux = -1 -> no cambio */
select  @w_valor = to_valor,
	@w_ttelefono = to_ttelefono
  from  cl_telefono_of
 where  to_oficina = @i_oficina
   and  to_secuencial = @i_secuencial

select @v_valor = @w_valor,
       @v_ttelefono = @w_ttelefono

select @w_aux = -1
if @w_valor = @i_valor
   select @w_valor = null, @v_valor = null
else
   select @w_valor = @i_valor, @w_aux = 0
if @w_ttelefono = @i_tipo_tel
   select @w_ttelefono = null, @v_ttelefono = null
else
   select @w_ttelefono = @i_tipo_tel, @w_aux = 0

if @w_aux = 0
begin
  begin tran
    update cl_telefono_of
       set to_valor = @i_valor,
	   to_ttelefono = @i_tipo_tel
     where      to_oficina = @i_oficina
       and      to_secuencial = @i_secuencial
    if @@error != 0
    begin
	exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 105035
	   /* 'Error en actualizacion de telefono'*/
	return 1
    end
    /* Transaccion servicios - cl_telefono_of */
	insert into ts_telefono_of (secuencial, tipo_transaccion, clase, fecha,
		    oficina , secuencia,
		    valor, tipo_telefono)

	values(@s_ssn, 15060, 'P', @w_today,
	       @i_oficina, @i_secuencial, @v_valor,
	       @v_ttelefono)
	if @@error != 0
	begin
	    exec sp_cerror
	      @t_debug	 = @t_debug,
	      @t_file	 = @t_file,
	      @t_from	 = @w_sp_name,
	      @i_num	 = 103005
	    /* 'Error en creacion de transaccion de servicio'*/
	    return  1
	end
	insert into ts_telefono_of (secuencial, tipo_transaccion, clase, fecha,
		    oficina, secuencia, valor, tipo_telefono)
	values(@s_ssn, 88, 'A', @w_today,
	       @i_oficina, @i_secuencial, @v_valor,
	       @v_ttelefono)
	if @@error != 0
	begin
	    exec sp_cerror
	       @t_debug	 = @t_debug,
	       @t_file	 = @t_file,
	       @t_from	 = @w_sp_name,
	       @i_num	 = 103005
	      /* 'Error en creacion de transaccion de servicio'*/
	    return  1
	end
  commit tran
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


/* ** Delete ** */
if @i_operacion = 'D'
begin
If @t_trn = 15061
begin
 /* chequeo de claves foraneas */
 if not exists (
     select  of_filial
       from  cl_oficina
      where  of_oficina = @i_oficina)
 begin
     exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 101016
	   /*	'No existe oficina'*/
     return 1
 end

 select @o_valor = to_valor,
	@o_tipo_tel = to_ttelefono
   from  cl_telefono_of
  where  to_oficina = @i_oficina
    and  to_secuencial = @i_secuencial

 begin tran
  delete cl_telefono_of 
   where to_oficina = @i_oficina
     and to_secuencial = @i_secuencial
  if @@error != 0
  begin
       exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 107038
	    /*	'Error en borrado de telefono'*/
       return 1
  end
  update cl_oficina
	  set of_telefono = of_telefono - 1
	  where of_oficina = @i_oficina
   if @@error != 0
   begin
	exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 107038
	  /* 'Error en eliminacion de telefono'*/
	return 1
   end
  update cl_telefono_of
     set to_secuencial = to_secuencial - 1
   where to_oficina = @i_oficina
     and to_secuencial > @i_secuencial
  if @@error != 0
  begin
	exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 107038
	  /* 'Error en eliminacion de telefono'*/
	return 1
  end
  /* transaccion de servicio - telefono_loc */
  insert into ts_telefono_of (secuencial, tipo_transaccion, clase, fecha,
			       oficina, secuencia, valor,
			       tipo_telefono)
		       values (@s_ssn, 15061, 'B', @w_today,
			       @i_oficina,
			       @i_secuencial, @o_valor, @o_tipo_tel)
  if @@error != 0
  begin
      exec sp_cerror
	     @t_debug	 = @t_debug,
	     @t_file	 = @t_file,
	     @t_from	 = @w_sp_name,
	     @i_num	 = 103005
	    /*	"Error en creacion de transaccion de servicio"*/
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

if @t_trn = 15104
begin
	select 'Sec.'=to_secuencial,
	       'Teléfono'=ltrim(rtrim(to_valor)),
	       'Tipo'=ltrim(rtrim(to_ttelefono)),
	       'Descr.Tipo'=substring(a.valor, 1, 10)
	from   cl_telefono_of, cl_catalogo a, cl_tabla m
	where  to_oficina = @i_oficina
	and    a.codigo = to_ttelefono
	and    a.tabla  = m.codigo
	and    m.tabla = 'cl_ttelefono'
	return 0

end
else
begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end

end

go
