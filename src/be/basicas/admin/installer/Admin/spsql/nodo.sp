/************************************************************************/
/*	Archivo:		nodo.sp 				*/
/*	Stored procedure:	sp_nodo 				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 23-Nov-1992					*/
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
/*	Insercion de nodos						*/
/*	Actualizacion del nodo						*/
/*	Borrado del nodo						*/
/*	Busqueda del nodo						*/
/*	Query del nodo							*/
/*	Ayuda del nodo							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	23/Nov/1992	L. Carvajal	Emision inicial			*/
/*	07/Jun/1993     M. Davila	Search sin errores              */
/*	15/Mar/1994	F. Espinosa	Modo 1 en Help (All)		*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_nodo')
   drop proc sp_nodo
go

create proc sp_nodo (
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
	@i_operacion		char(1),
	@i_tipo_h		char(1) = null,
	@i_modo			smallint = null,
        @i_nodo                 tinyint = null,
        @i_marca                char(20) = null,
        @i_modelo               char(20) = null,
        @i_tipo                 char(5) = NULL,
        @i_num_serie            char(20) = NULL,
        @i_registrador          smallint = NULL,
	@i_habilitante		smallint = NULL,
	@i_fecha_habil		datetime = NULL,
	@i_formato_fecha	int=NULL
)
as
declare
	@w_sp_name		varchar(30),
        @w_today                datetime,
        @w_detecta     		char(1),
	@w_return		int,
        @w_fecha_habil          datetime,
        @w_nodo                 tinyint,
        @w_marca                char(20),
        @w_modelo               char(20),
        @w_tipo                 char(5),
        @w_num_serie            char(20),
        @w_registrador          smallint,
	@w_habilitante		smallint,
	@w_fecha_ult_mod	datetime,
	@w_fecha_reg		datetime,
        @v_fecha_habil          datetime,
        @v_nodo                 tinyint,
        @v_marca                char(20),
        @v_modelo               char(20),
        @v_tipo                 char(5),
        @v_num_serie            char(20),
        @v_registrador          smallint,
	@v_habilitante		smallint,
	@v_fecha_ult_mod	datetime,
	@o_nodo 		tinyint,
	@o_marca		char(20),
	@o_modelo		char(20),
	@o_tipo 		char(5),
	@o_num_serie		char(20),
	@o_registrador		int,
	@o_nombre_reg		descripcion,
	@o_nombre_hab		descripcion,
	@o_habilitante		int,
	@o_fecha_habil		datetime,
	@o_fecha_reg		datetime,
	@w_siguiente		tinyint


select @w_today = @s_date
select @w_sp_name = 'sp_nodo'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 519
begin
 /* chequeo de claves foraneas */
 if (@i_marca is NULL OR @i_modelo is NULL
     OR @i_num_serie is NULL )
 begin
/* 'No se llenaron todos los campos' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
        return 1
 end

  if not exists (
        select fu_funcionario
          from cl_funcionario
          where fu_funcionario = @i_registrador)
  begin
/* 'No existe funcionario' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 101036
        return 1
  end

  if @i_habilitante is not NULL
  begin
    if not exists (
        select fu_funcionario
          from cl_funcionario
          where fu_funcionario = @i_habilitante)
    begin
/* 'No existe funcionario' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 101036
        return 1
    end
  end
/*  else
**    select @i_habilitante = 0*/

  begin tran
	exec @w_return = sp_cseqnos @i_tabla = 'ad_nodo',
				    @o_siguiente = @w_siguiente out
	if @w_return != 0
		return @w_return
	select @w_siguiente
	insert into ad_nodo (no_nodo, no_marca, no_modelo, no_tipo,
                             no_num_serie, no_fecha_reg, no_fecha_habil,
			     no_registrador, no_habilitante, no_estado,
			     no_fecha_ult_mod)
		     values (@w_siguiente, @i_marca, @i_modelo, @i_tipo,
			     @i_num_serie, @w_today, @i_fecha_habil,
			     @i_registrador, @i_habilitante, 'V',
			     @w_today)
        if @@error != 0
	begin
/* 'Error en insercion de nodo'*/
	     exec sp_cerror
	       @t_debug	    = @t_debug,
	       @t_file	    = @t_file,
	       @t_from	    = @w_sp_name,
	       @i_num	    = 153001
	     return 1
	end

     /* transaccion de servicio */
	insert into ts_nodo (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     nodo, marca, modelo, tipo,
			     num_serie, fecha_reg, fecha_habil,
			     registrador, habilitante, estado, fecha_ult_mod)
		     values (@s_ssn, 519, 'N', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @w_siguiente, @i_marca, @i_modelo, @i_tipo,
			     @i_num_serie, @w_today, @i_fecha_habil,
			     @i_registrador, @i_habilitante, 'V', @w_today)
        if @@error != 0
	begin
/* 'Error en creacion de transaccion de servicio' */
	     exec sp_cerror
	       @t_debug	    = @t_debug,
	       @t_file	    = @t_file,
	       @t_from	    = @w_sp_name,
	       @i_num	    = 153023
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


/* ** Update **/
if @i_operacion = 'U'
begin
if @t_trn = 520
begin
  if (@i_nodo is NULL OR @i_registrador is NULL)
  begin
/* 'No se llenaron todos los campos' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file  	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
	return 1
  end

  select @w_registrador = no_registrador,
         @w_marca =  no_marca,
         @w_modelo = no_modelo,
         @w_tipo =  no_tipo,
         @w_num_serie = no_num_serie,
         @w_fecha_habil = no_fecha_habil,
	 @w_habilitante = no_habilitante,
	 @w_fecha_ult_mod = no_fecha_ult_mod
    from ad_nodo
   where no_nodo = @i_nodo
     and no_estado = 'V'
  if @@rowcount= 0
  begin
/* 'No existe nodo' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151002
        return 1
  end

  if @i_habilitante is not NULL

  begin
    if not exists (
	select fu_funcionario
	  from cl_funcionario
	  where fu_funcionario = @i_habilitante)
    begin
/*  'No existe funcionario' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 101036
        return 1
    end
  end
  /*else
   ** select @i_habilitante = 0, @w_habilitante = 0*/

  /* verificacion de campos a actualizar */
  select @v_marca = @w_marca,
         @v_modelo= @w_modelo,
         @v_tipo = @w_tipo,
         @v_num_serie = @w_num_serie,
         @v_fecha_habil = @w_fecha_habil,
	 @v_habilitante = @w_habilitante,
	 @v_fecha_ult_mod = @w_fecha_ult_mod

  select @w_detecta = 'N'
  if @w_marca = @i_marca
   select @w_marca= null, @v_marca = null
  else
    select @w_marca = @i_marca

  if @w_modelo = @i_modelo
   select @w_modelo = null, @v_modelo = null
  else
   select @w_modelo = @i_modelo

  if @w_tipo = @i_tipo
   select @w_tipo = null, @v_tipo = null
  else
   select @w_tipo = @i_tipo

  if @w_num_serie = @i_num_serie 
   select @w_num_serie  = null, @v_num_serie  = null
  else
   select @w_num_serie  = @i_num_serie 

  if @w_habilitante = @i_habilitante
   select @w_habilitante = null, @v_habilitante = null
  else
   select @w_habilitante = @i_habilitante

  if @w_fecha_habil = @i_fecha_habil
   select @w_fecha_habil = null, @v_fecha_habil = null
  else
   select @w_fecha_habil = @i_fecha_habil

  begin tran
   Update ad_nodo
      set no_marca = @i_marca,
          no_tipo = @i_tipo,
          no_modelo = @i_modelo,
          no_num_serie = @i_num_serie,
          no_habilitante = @i_habilitante,
	  no_fecha_habil = @i_fecha_habil,
	  no_fecha_ult_mod = @w_today,
	  no_registrador = @i_registrador
    where no_nodo = @i_nodo
   if @@error != 0
   begin
/*  'Error en actualizacion de nodo' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 155001
        return 1
   end

   /* transaccion de servicio */
	insert into ts_nodo (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     nodo, marca, modelo, tipo,
			     num_serie, fecha_habil,
			     habilitante, estado, fecha_ult_mod)
		     values (@s_ssn, 520, 'P', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_nodo, @v_marca, @v_modelo, @v_tipo,
			     @v_num_serie,  @v_fecha_habil,
			     @v_habilitante, null, @v_fecha_ult_mod)
        if @@error != 0
	begin
/* 'Error en creacion de transaccion de servicio' */
	     exec sp_cerror
	       @t_debug	    = @t_debug,
	       @t_file	    = @t_file,
	       @t_from	    = @w_sp_name,
	       @i_num	    = 153023
	     return 1
	end

	insert into ts_nodo (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     nodo, marca, modelo, tipo,
			     num_serie, fecha_habil,
			     habilitante, estado, fecha_ult_mod)
		     values (@s_ssn, 520, 'A', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_nodo, @w_marca, @w_modelo, @w_tipo,
			     @w_num_serie,  @w_fecha_habil,
			     @w_habilitante, null, @w_today)
        if @@error != 0
	begin
/*  'Error en creacion de transaccion de servicio' */
	     exec sp_cerror
	       @t_debug	    = @t_debug,
	       @t_file	    = @t_file,
	       @t_from	    = @w_sp_name,
	       @i_num	    = 153023
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
if @i_operacion = 'D'
begin
if @t_trn = 521 
begin
 /* chequeo de claves foraneas */
  if (@i_nodo is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
        return 1
  end

  select @w_registrador = no_registrador,
         @w_marca =  no_marca,
         @w_modelo = no_modelo,
         @w_tipo =  no_tipo,
	 @w_num_serie = no_num_serie,
	 @w_fecha_reg = no_fecha_reg,
         @w_fecha_habil = no_fecha_habil,
         @w_habilitante = no_habilitante
    from ad_nodo
   where no_nodo = @i_nodo
     and no_estado = 'V'
  if @@rowcount= 0
  begin
/*  'No existe nodo' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151002
        return 1
  end

 if exists (
	select nl_nodo
          from ad_nodo_oficina
	 where nl_nodo = @i_nodo
	   and nl_estado = 'V')
 begin
/* 'Existe referencia en Nodo Oficina' */
  exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 157000
  return 1
 end

/* borrado del nodo */
  begin tran
    Delete ad_nodo
     where no_nodo = @i_nodo
   if @@error != 0
   begin
/*  'Error en eliminacion de nodo' */
     exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 157001
     return 1
   end

  /* transaccion de servicio */
	insert into ts_nodo (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     nodo, marca, modelo, tipo,
			     num_serie, fecha_reg, registrador, fecha_habil,
			     habilitante, estado, fecha_ult_mod)
		     values (@s_ssn, 521, 'B', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_nodo, @w_marca, @w_modelo, @w_tipo,
			     @w_num_serie,  @w_fecha_reg, @w_registrador,
			     @w_fecha_habil, @w_habilitante, 'V',
			     @w_today)
        if @@error != 0
	begin
/* 'Error en creacion de transaccion de servicio' */
	     exec sp_cerror
	       @t_debug	    = @t_debug,
	       @t_file	    = @t_file,
	       @t_from	    = @w_sp_name,
	       @i_num	    = 153023
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


/* ** Search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15010
begin
 set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Nodo' = no_nodo,
		'Marca' = no_marca,
	        'Modelo' = no_modelo,
		'Tipo' = no_tipo,
		'Numero de serie' = no_num_serie,
		'Registrador' = no_registrador,
		'Nombre Reg' = X.fu_nombre,
		'Habilitante' = no_habilitante,
		'Nombre Hab' = Y.fu_nombre
	 from	ad_nodo, cl_funcionario X, cl_funcionario Y
	where	no_estado = 'V'
	  and	no_registrador = X.fu_funcionario
	  /*and isnull(no_habilitante, 0) = Y.fu_funcionario*/
	  and	no_habilitante = Y.fu_funcionario
        order   by no_nodo
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
	select	'Cod. Nodo' = no_nodo,
		'Marca' = no_marca,
	        'Modelo' = no_modelo,
		'Tipo' = no_tipo,
		'Numero de serie' = no_num_serie,
		'Registrador' = no_registrador,
		'Nombre Reg' = X.fu_nombre,
		'Habilitante' = no_habilitante,
		'Nombre Hab' = Y.fu_nombre
	 from	ad_nodo, cl_funcionario X, cl_funcionario Y
	where	no_estado = 'V'
	  and	no_registrador =  X.fu_funcionario
	  /*and	isnull(no_habilitante, 0) = Y.fu_funcionario*/
	  and	no_habilitante = Y.fu_funcionario
	  and	no_nodo > @i_nodo
	  and   no_estado = 'V'
        order   by no_nodo
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

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15011
begin
	select	@o_marca = no_marca,
		@o_modelo = no_modelo,
		@o_tipo = no_tipo,
		@o_num_serie = no_num_serie,
		@o_registrador = no_registrador,
		@o_nombre_reg = x.fu_nombre,
		@o_habilitante = no_habilitante,
		@o_nombre_hab = y.fu_nombre,
		@o_fecha_reg = no_fecha_reg,
		@o_fecha_habil = no_fecha_habil
         from   ad_nodo, cl_funcionario x, cl_funcionario y
	where	no_nodo = @i_nodo
	  and	no_estado = 'V'
	  and   x.fu_funcionario = no_registrador
	  and	no_habilitante = y.fu_funcionario
       if @@rowcount = 0
       begin
/* 'No existe nodo' */
	 exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151002
	 return 1
       end


	select @i_nodo, @o_marca, @o_modelo, @o_tipo, @o_num_serie,
	       @o_registrador, @o_nombre_reg, convert(char(10), @o_fecha_reg, @i_formato_fecha),
	       @o_habilitante, @o_nombre_hab, convert(char(10), @o_fecha_habil, @i_formato_fecha)
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
If @t_trn = 15012
begin
 if @i_tipo_h = 'A'
 begin
    if @i_modo = 0
    begin
	 select   'Nodo' = no_nodo,
                  'Marca / Modelo' =  no_marca + ' '+ no_modelo
	   from	  ad_nodo
	  where   no_estado = 'V'
	    and   no_nodo not in (select no_nodo
				    from ad_nodo, ad_nodo_oficina
				   where no_nodo = nl_nodo)
	   order  by no_nodo
    end

    if @i_modo = 1
    begin
	 select   'Nodo' = no_nodo,
                  'Marca / Modelo' =  no_marca + ' '+ no_modelo
	   from	  ad_nodo
	  where   no_estado = 'V'
            and   no_nodo > @i_nodo
	    and   no_nodo not in (select no_nodo
				    from ad_nodo, ad_nodo_oficina
				   where no_nodo = nl_nodo)
	   order  by no_nodo
    end
 end

 if @i_tipo_h = 'V'
 begin
	 select  no_marca+' '+ no_modelo
	   from	 ad_nodo
	  where  no_nodo = @i_nodo
	    and  no_estado = 'V'
	    and  no_nodo not in ( select no_nodo
				    from ad_nodo, ad_nodo_oficina
				   where no_nodo = nl_nodo)
	 if @@rowcount = 0
	 begin
/* 'No existe nodo' */
	    exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151002
	    return 1
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
go
