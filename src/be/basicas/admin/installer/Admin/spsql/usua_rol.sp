/************************************************************************/
/*      Archivo:                usua_rol.sp                             */
/*      Stored procedure:       sp_usuario_rol                          */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 26-Nov-1992                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Insercion de usuario rol                                        */
/*      Actualizacion del usuario rol                                   */
/*      Borrado del usuario rol                                         */
/*      Busqueda del usuario rol                                        */
/*      Query del usuario rol                                           */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      26/Nov/1992     L. Carvajal     Emision inicial                 */
/*      07/Jun/1993     M. Davila       Search sin error                */
/*      22/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      05/May/95       S. Vinces       Admin Distribuido               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_usuario_rol')
   drop proc sp_usuario_rol
go

create proc sp_usuario_rol (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint =NULL,
	@i_operacion            varchar(1),
	@i_modo                 smallint = null,
	@i_login                varchar(30) = null,
	@i_rol                  tinyint = NULL,
	@i_autorizante          smallint = NULL,
	@i_fecha_aut            datetime = null,
	@i_tipoh                tinyint = null,
        @i_central_transmit     varchar(1) = null,
	@i_formato_fecha	int=null
)
as
declare
	@w_today                datetime,
	@w_sp_name              varchar(32),
	@w_fecha_aut            datetime,
	@w_login                varchar(30),
	@w_rol                  tinyint,
	@w_autorizante          smallint,
	@w_tipo_horario         tinyint,
	@v_fecha_aut            datetime,
	@v_login                varchar(30),
	@v_rol                  tinyint,
	@v_autorizante          smallint,
	@v_tipo_horario         tinyint,
	@o_fecha_aut            datetime,
	@o_nombre_r             descripcion,
	@o_nombre_h             descripcion,
	@o_login                varchar(30),
	@o_rol                  tinyint,
	@o_autorizante          smallint,
	@o_tipo_horario         tinyint,
	@o_descripcion_tipo     varchar(30),    
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_aut           descripcion,
	@w_comando              descripcion,
	@w_num_nodos            smallint,    
	@w_contador             smallint,
	@w_cmdtransrv		varchar(60),
	@w_clave		int,
	@w_nt_nombre		varchar(32),
	@w_return		int
       

select @w_today = @s_date
select @w_sp_name = 'sp_usuario_rol'


/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char(1))
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 570
begin
 /* chequeo de claves foraneas */
   if (@i_login is NULL OR @i_rol is NULL or @i_autorizante is NULL or
       @i_tipoh is NULL )
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
   end

  if not exists (
	select fu_login
	  from cl_funcionario
	  where fu_login = @i_login)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101036
	   /*  'No existe funcionario' */
	return 1
  end

  if not exists (
	select ro_rol
	  from ad_rol
	  where ro_rol = @i_rol
	    and ro_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151026
	   /*  'No existe rol' */
	return 1
  end

   if not exists (
	select fu_funcionario
	  from cl_funcionario
	  where fu_funcionario = @i_autorizante)
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101036
	   /*  'No existe funcionario' */
	return 1
   end
 
  if not exists (
	select th_tipo
	  from ad_tipo_horario
	  where th_tipo = @i_tipoh
	    and th_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151047
	   /*  'No tipo de horario' */
	return 1
  end

  if exists (
	select ur_login 
	  from ad_usuario_rol  
	  where ur_login   = @i_login 
	    and ur_rol     = @i_rol )
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151060
	   /*  Ya existe login para ese rol */
	return 1
  end

  begin tran
    insert into ad_usuario_rol (ur_login, ur_rol, ur_fecha_aut,
				ur_autorizante, ur_estado, ur_fecha_ult_mod,
				ur_tipo_horario)
		     values    (@i_login, @i_rol, @i_fecha_aut,
				@i_autorizante, 'V', @w_today,
				@i_tipoh)
    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153006
	   /*  'Error en insercion de usuario rol' */
	return 1
    end

   /* transaccion de servicio */
   insert into ts_usuario_rol  (secuencia, tipo_transaccion, clase, fecha,
				oficina_s, usuario, terminal_s, srv, lsrv,
				login, rol, fecha_aut, autorizante,
				estado, fecha_ult_mod,tipo_horario)
		     values    (@s_ssn, 570, 'N', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
				@i_login, @i_rol,  @i_fecha_aut,
				@i_autorizante, 'V', @w_today, @i_tipoh)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end
  commit tran

  exec REENTRY...rp_gen_loghorol
  select  @w_comando = @s_lsrv +'...rp_load_loghorol'
   exec @w_comando  
  /******************************* Para   Unix  **************************/

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
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv	
					@s_lsrv        = @w_nt_nombre,     
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_login       = @i_login,
					@i_rol         = @i_rol,
					@i_autorizante = @i_autorizante,
					@i_tipoh       = @i_tipoh,       
					@i_fecha_aut   = @i_fecha_aut,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out

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
  /******************************* Para   Unix  **************************/
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


/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 571
begin
 /* chequeo de claves foraneas */
  if (@i_login is NULL OR @i_rol is NULL or @i_tipoh is NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
   end

  select @w_fecha_aut = ur_fecha_aut,
	 @w_autorizante = ur_autorizante,
	 @w_fecha_ult_mod = ur_fecha_ult_mod,
	 @w_tipo_horario = ur_tipo_horario
  from ad_usuario_rol
  where ur_login = @i_login
    and ur_rol = @i_rol
    and ur_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151016
	   /*  'No existe usuario rol' */
	return 1
  end

  if not exists (
	select fu_funcionario
	  from cl_funcionario
	  where fu_funcionario = @i_autorizante)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101036
	   /*  'No existe funcionario' */
	return 1
  end
 
 
  if not exists (
	select th_tipo
	  from ad_tipo_horario
	  where th_tipo = @i_tipoh
	    and th_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151047
	   /*  'No tipo de horario' */
	return 1
  end

/*** verificacion de campos a actualizar ***/
  select @v_fecha_aut = @w_fecha_aut,
	 @v_autorizante = @w_autorizante,
	 @v_fecha_ult_mod = @w_fecha_ult_mod,
	 @v_tipo_horario = @w_tipo_horario

  if @w_fecha_aut = @i_fecha_aut
   select @w_fecha_aut = null, @v_fecha_aut = null
  else
   select @w_fecha_aut = @i_fecha_aut

  if @w_autorizante = @i_autorizante
   select @w_autorizante = null, @v_autorizante = null
  else
   select @w_autorizante = @i_autorizante

  if @w_tipo_horario = @i_tipoh
   select @w_tipo_horario = null, @v_tipo_horario = null
  else
   select @w_tipo_horario = @i_tipoh
  

  begin tran
   Update ad_usuario_rol
      set ur_fecha_aut = @i_fecha_aut,
	  ur_autorizante = @i_autorizante,
	  ur_fecha_ult_mod = @w_today,
	  ur_tipo_horario = @i_tipoh
    where ur_login = @i_login
      and ur_rol = @i_rol
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155007
	   /*  'Error en actualizacion de usuario rol' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_usuario_rol (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       login, rol, fecha_aut, autorizante, estado,
			       fecha_ult_mod, tipo_horario)
		     values    (@s_ssn, 571, 'P', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
				@i_login, @i_rol,  @v_fecha_aut,
				@v_autorizante, null, @v_fecha_ult_mod,
				@v_tipo_horario)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end

   insert into ts_usuario_rol (secuencia, tipo_transaccion, clase, fecha,
			       oficina_s, usuario, terminal_s, srv, lsrv,
			       login, rol, fecha_aut, autorizante,
			       estado, fecha_ult_mod, tipo_horario)
		     values    (@s_ssn, 571, 'A', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
				@i_login, @i_rol, @w_fecha_aut,
				@w_autorizante, null, @w_today, @w_tipo_horario)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end
  commit tran

  exec REENTRY...rp_gen_loghorol
  select  @w_comando = @s_lsrv +'...rp_load_loghorol'
   exec @w_comando  

  /******************************* Para   Unix  **************************/

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
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv	
					@s_lsrv        = @w_nt_nombre,     
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_login       = @i_login,
					@i_rol         = @i_rol,
					@i_autorizante = @i_autorizante,
					@i_tipoh       = @i_tipoh,       
					@i_fecha_aut   = @i_fecha_aut,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out

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
  /******************************* Para   Unix  **************************/
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


/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 572
begin
 /* chequeo de claves foraneas */
  if (@i_login is NULL OR @i_rol is NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
   end

  select @w_fecha_aut = ur_fecha_aut,
	 @w_autorizante = ur_autorizante,
	 @w_fecha_ult_mod = ur_fecha_ult_mod,
	 @w_tipo_horario = ur_tipo_horario
  from ad_usuario_rol
  where ur_login = @i_login
    and ur_rol = @i_rol
    and ur_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151016
	   /*  'No existe usuario rol' */
	return 1
  end

  /* borrado de usuario rol */
  begin tran
   Delete ad_usuario_rol
    where ur_login = @i_login
      and ur_rol = @i_rol
  if @@error != 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157016
	   /*  'Error en eliminacion de usuario rol' */
	return 1
  end

  /* transaccion de servicio */
   insert into ts_usuario_rol  (secuencia, tipo_transaccion, clase, fecha,
				oficina_s, usuario, terminal_s, srv, lsrv,
				login, rol, fecha_aut, autorizante,
				estado, fecha_ult_mod, tipo_horario)
		     values    (@s_ssn, 572, 'B', @s_date,
				@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
				@i_login, @i_rol, @w_fecha_aut,
				@w_autorizante, 'V', @w_fecha_ult_mod, 
				@w_tipo_horario)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end
  commit tran

  exec REENTRY...rp_gen_loghorol
  select  @w_comando = @s_lsrv +'...rp_load_loghorol'
   exec @w_comando  

  /******************************* Para   Unix  **************************/

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
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv	
					@s_lsrv        = @w_nt_nombre,     
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_login       = @i_login,
					@i_rol         = @i_rol,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out

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
  /******************************* Para   Unix  **************************/
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


/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15075
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select  'Login' = ur_login,
		'Cod. Rol' = ur_rol,
		'Rol' =  substring(ro_descripcion, 1, 20),
		'Autorizante' = ur_autorizante,
		'Nombre Aut.' = fu_nombre,
		'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha)
	from    ad_usuario_rol, ad_rol, cl_funcionario
	where   /*isnull(ur_autorizante, 0) = fu_funcionario*/
		ur_autorizante = fu_funcionario
	  and   ur_rol = ro_rol
	 and    ur_estado = 'V'
	order   by ur_login, ur_rol
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
	select  'Login' = ur_login,
		'Cod. Rol' = ur_rol,
		'Rol' =  substring(ro_descripcion, 1, 20),
		'Autorizante' = ur_autorizante,
		'Nombre Aut.' = fu_nombre,
		'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha)
	from    ad_usuario_rol, ad_rol, cl_funcionario
	where   /*isnull(ur_autorizante, 0) = fu_funcionario*/
		ur_autorizante = fu_funcionario
	  and   ur_rol = ro_rol
	  and  ( 
		(ur_login > @i_login)
	  or    ((ur_login = @i_login) and (ur_rol > @i_rol))
	       )        
	  and   ur_estado = 'V'
	order   by ur_login, ur_rol
       set rowcount 0
       return 0
     end
     if @i_modo = 2
     begin
	select  'Cod. Rol' = ur_rol,
		'Rol' =  substring(ro_descripcion, 1, 20),
		'Cod. Horario' = ur_tipo_horario,
		'Horario' = th_descripcion,
		'Filial' = fi_abreviatura,
		'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
		'Autorizante' = ur_autorizante,
		'Nombre Aut.' = fu_nombre               
	 from   ad_usuario_rol, cl_filial, ad_rol, cl_funcionario, 
		ad_tipo_horario
	where   ur_autorizante = fu_funcionario
	  and   ur_rol = ro_rol
	  and   ro_filial = fi_filial              
	  and   ur_login = @i_login
	  and   ur_tipo_horario = th_tipo
	  and   ur_estado = 'V'
	order   by ur_login, ur_rol
       set rowcount 0
       return 0
     end
     if @i_modo = 3
     begin
	select  'Cod. Rol' = ur_rol,
		'Rol' =  substring(ro_descripcion, 1, 20),
		'Cod. Horario' = ur_tipo_horario,
		'Horario' = th_descripcion,
		'Filial' = fi_abreviatura,
		'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
		'Autorizante' = ur_autorizante,
		'Nombre Aut.' = fu_nombre               
	 from   ad_usuario_rol, cl_filial, ad_rol, cl_funcionario,
		ad_tipo_horario
	where   ur_autorizante = fu_funcionario
	  and   ur_rol = ro_rol
	  and   ro_filial = fi_filial              
	  and   ur_login = @i_login
	  and   ur_tipo_horario = th_tipo
	  and   ur_rol > @i_rol
	  and   ur_estado = 'V'
	order   by ur_login, ur_rol
	 --CNA 04-07-2001 Control de Siguientes
	 if @@rowcount = 0
	 begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 151121
		   /*  'No existe usuario' */
		return 1
	 end
       set rowcount 0
       return 0
     end
     if @i_modo = 4
     begin
	select  'Codigo' = X.fu_funcionario,
		'Login' = ur_login,
		'Nombre Funcionario' = X.fu_nombre,
		'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
		'Autorizante' = ur_autorizante,
		'Nombre Aut.' = Y.fu_nombre
	from    ad_usuario_rol, cl_funcionario X, cl_funcionario Y
	where   /*isnull(ur_autorizante, 0)= Y.fu_funcionario*/
		ur_autorizante = Y.fu_funcionario
	  and   ur_login = X.fu_login
	  and   ur_rol = @i_rol
	 and    ur_estado = 'V'
	order   by ur_login
       set rowcount 0
       return 0
     end
     if @i_modo = 5
     begin
	select  'Codigo' = X.fu_funcionario,
		'Login' = ur_login,
		'Nombre Funcionario' = X.fu_nombre,
		'Fecha_aut' = convert(varchar(10),ur_fecha_aut,@i_formato_fecha),
		'Autorizante' = ur_autorizante,
		'Nombre Aut.' = Y.fu_nombre
	from    ad_usuario_rol, cl_funcionario X, cl_funcionario Y
	where   /*isnull(ur_autorizante, 0) = Y.fu_funcionario*/
		ur_autorizante = Y.fu_funcionario
	  and   ur_login = X.fu_login
	  and   ur_rol = @i_rol
	  and   ur_login > @i_login
	  and   ur_estado = 'V'
	order   by ur_login
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
If @t_trn = 15076
begin
	select  distinct @o_nombre_r = substring(ro_descripcion, 1, 20),
		@o_autorizante = ur_autorizante,
		@o_fecha_aut = ur_fecha_aut,
		@o_tipo_horario = ur_tipo_horario,
		@o_descripcion_tipo = substring(th_descripcion, 1, 30)
	 from   ad_usuario_rol, ad_rol, ad_tipo_horario, cl_funcionario
	 where  ur_rol = ro_rol
	  and   ur_login = @i_login
	  and   ur_tipo_horario = th_tipo
	  and   ur_rol = @i_rol
	  and   ur_estado = 'V'
	if @@rowcount = 0
	begin
	  exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151016
	   /*  'No existe Usuario Rol' */
	  return 1
	end

	select @o_nombre_aut = fu_nombre
	  from cl_funcionario
	 where fu_funcionario = @o_autorizante
	 if @@rowcount = 0
	 begin
	   exec sp_cerror
	     @t_debug     = @t_debug,
	     @t_file  = @t_file,
	     @t_from      = @w_sp_name,
	     @i_num       = 101036
	     /* 'No existe funcionario' */
	 end
	select @i_login, @i_rol, @o_nombre_r, @o_tipo_horario,
		 @o_descripcion_tipo, @o_autorizante,
	       @o_nombre_aut, convert(char(10), @o_fecha_aut, @i_formato_fecha)
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


/** Help **/
if @i_operacion = "H"
begin
If @t_trn = 15077
begin
	select ur_rol,
	       ro_descripcion
	  from ad_usuario_rol, ad_rol
	 where ur_rol = ro_rol
	   and ur_login = @i_login
	if @@rowcount = 0
	begin
	  exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151016
	   /*  'No existe Usuario Rol' */
	  return 1
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

