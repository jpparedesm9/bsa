/************************************************************************/
/*	Archivo:		operador.sp 				*/
/*	Stored procedure:	sp_operador 				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Cristian Navas					*/
/*	Fecha de escritura: 5-Oct-2001					*/
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
/*	Insercion de operadores						*/
/*	Actualizacion de operador					*/
/*	Borrado del operador						*/
/*	Busqueda del operador						*/
/*	Query del operador						*/
/*	Ayuda del operador						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	5/Oct/2001	C. Navas	Emision inicial			*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_operador')
   drop proc sp_operador
go

create proc sp_operador (
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
	@i_modo			smallint = null,
        @i_login                varchar(30) = NULL,
        @i_osuser               varchar(16) = null,
        @i_rol	                tinyint = null,
        @i_estado               varchar(1) = 'V',
        @i_dbuser            	varchar(255) = NULL
)
as
declare
	@w_sp_name		varchar(30),
        @w_today                datetime,
	@w_return		int,
	@w_siguiente		tinyint,
	@w_osuser 		varchar(16),
	@w_dbuser 		varchar(255),
	@w_estado 		varchar(1),
	@w_rol 			tinyint,
	@v_osuser 		varchar(16),
	@v_dbuser 		varchar(255),
	@v_estado 		varchar(1),
	@o_funcionario 		smallint,
	@o_nombre_f 		varchar(64),
	@o_osuser 		varchar(16),
	@o_dbuser 		varchar(255),
	@o_estado 		varchar(1)


select @w_today = @s_date
select @w_sp_name = 'sp_operador'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 15291
begin
 /* chequeo de claves foraneas */
 if (@i_login is NULL 
     OR @i_osuser is NULL OR @i_estado is NULL 
     OR @i_dbuser is NULL)
 begin
 /* 'No se llenaron todos los campos'  */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
        return 1
 end

  /* Se verifica la existencia y vigencia del usuario */
  if not exists (
        select 1
          from ad_usuario
          where us_login = @i_login
	  and us_nodo = 1
	  and us_estado = "V")
  begin
        /* 'No existe usuario o usuario no está vigente' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151160
        return 1
  end

  /* Se verifica la existencia del rol de operador de batch*/
  select @w_rol = pa_tinyint from cl_parametro
  where pa_nemonico = "ROB"
  if @@rowcount= 0
  begin
  /* 'No existe parámetro de rol de operador de batch' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151161
        return 1
  end


  /* Se verifica la asociación al rol */
  if not exists (
  	select 1 from ad_usuario_rol
	where ur_login = @i_login
  	and ur_rol = @w_rol)
  begin
        /* 'No existe rol de operador para ese usuario' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151162
        return 1
  end
  

  /* Verificar que el usuario no sea operador */
  if exists (
  	select 1 from ba_operador
	where op_login = @i_login)
  begin
        /* 'Ya existe este usuario como operador de batch' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151163
        return 1
  end


  begin tran
	insert into ba_operador (op_login, op_rol, op_osuser, op_estado,
			     op_dblogin)
		     values (@i_login, @w_rol, @i_osuser, @i_estado,
			     @i_dbuser)

        if @@error != 0
	begin
         /* 'Error en insercion de operador' */
	     exec sp_cerror
	       @t_debug	    = @t_debug,
	       @t_file	    = @t_file,
	       @t_from	    = @w_sp_name,
	       @i_num	    = 153068
	     return 1
	end

      /* transaccion de servicio */
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
	   /* 'No corresponde codigo de transaccion' */
	return 1
end
end


/* ** Update **/
if @i_operacion = 'U'
begin
if @t_trn = 15292
begin
  if (@i_osuser is NULL OR @i_estado is NULL)
  begin
/* 'No se llenaron todos los campos' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file  	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
	return 1
  end

  /* Se verifica la existencia y vigencia del usuario */
  if not exists (
        select 1
          from ad_usuario
          where us_login = @i_login
	  and us_nodo = 1
	  and us_estado = "V")
  begin
        /* 'No existe usuario o usuario no está vigente' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151160
        return 1
  end

  /* Se verifica la existencia del rol de operador de batch*/
  select @w_rol = pa_tinyint from cl_parametro
  where pa_nemonico = "ROB"
  if @@rowcount= 0
  begin
  /* 'No existe parámetro de rol de operador de batch' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151161
        return 1
  end


  /* Se verifica la asociación al rol */
  if not exists (
  	select 1 from ad_usuario_rol
	where ur_login = @i_login
  	and ur_rol = @w_rol)
  begin
        /* 'No existe rol de operador para ese usuario' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151162
        return 1
  end
  

  select @w_osuser = op_osuser,
	 @w_dbuser = op_dblogin,
         @w_estado =  op_estado
    from ba_operador
   where op_login = @i_login
  if @@rowcount= 0
  begin
  /* 'No existe operador de batch' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151164
        return 1
  end


  /* verificacion de campos a actualizar */
  select @v_osuser = @w_osuser,
  	 @v_dbuser = @w_dbuser,
         @v_estado = @w_estado

  if @w_osuser = @i_osuser
   select @w_osuser= null, @v_osuser = null
  else
    select @w_osuser = @i_osuser

  if @w_estado = @i_estado
   select @w_estado = null, @v_estado = null
  else
   select @w_estado = @i_estado


  if @i_dbuser is NULL
	select @i_dbuser = @w_dbuser

  if @w_dbuser = @i_dbuser
   select @w_dbuser= null, @v_dbuser = null
  else
    select @w_dbuser = @i_dbuser

  begin tran
   Update ba_operador
      set op_osuser = @i_osuser,
	  op_dblogin = @i_dbuser,
          op_estado = @i_estado
    where op_login = @i_login
   if @@error != 0
   begin
   /*  'Error en actualizacion de operador' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 155070
        return 1
   end

   /* doble transaccion de servicio */

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
if @t_trn = 15293 
begin
 /* chequeo de claves foraneas */
  if (@i_login is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151001
        return 1
  end

  select @w_osuser = op_osuser,
         @w_estado =  op_estado,
         @w_rol = op_rol
    from ba_operador
   where op_login = @i_login

  if @@rowcount= 0
  begin
/*  'No existe operador' */
	exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151164
        return 1
  end


/* borrado del operador */
  begin tran
    Delete ba_operador
     where op_login = @i_login

   if @@error != 0
   begin
/*  'Error en eliminacion de login' */
     exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 157091
     return 1
   end

  /* transaccion de servicio */
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
If @t_trn = 15289
begin
 set rowcount 20
     if @i_modo = 0
     begin
	select	'Login' = op_login,
		'Rol' = substring(ro_descripcion,1,40),
	        'Usuario S.O.' = op_osuser,
		'Estado' = op_estado
	 from	ba_operador, ad_rol
	 where  op_rol = ro_rol
        order   by op_login
       set rowcount 0
       return 0
     end


     if @i_modo = 1
     begin
	select	'Login' = op_login,
		'Rol' = substring(ro_descripcion,1,40),
	        'Usuario S.O.' = op_osuser,
		'Estado' = op_estado
	 from	ba_operador, ad_rol
	 where  op_rol = ro_rol
	 and	op_login > @i_login
        order   by op_login
	if @@rowcount = 0
	begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 151121
		   /*  'No existe operador' */
		return 1
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



/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15290
begin
	select  @o_funcionario = fu_funcionario,
		@o_nombre_f = fu_nombre,
		@o_osuser = op_osuser,
		@o_estado = op_estado
	 from   cl_funcionario, ba_operador
	where   fu_login = op_login
	  and   op_login = @i_login

	if @@rowcount = 0
	begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151164
	   /*  'No existe Operador' */
	 return 1
       end


       select @o_funcionario, @o_nombre_f, @i_login, @o_osuser, @o_estado

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
