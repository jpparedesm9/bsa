/************************************************************************/
/*      Archivo:                rol.sp                                  */
/*      Stored procedure:       sp_ad_rol                               */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 25-Nov-1992                                 */
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
/*      Insercion de rol                                                */
/*      Actualizacion del rol                                           */
/*      Borrado del rol                                                 */
/*      Busqueda del rol                                                */
/*      Query del rol                                                   */
/*      Ayuda del rol                                                   */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      25/Nov/1992     L. Carvajal     Emision inicial                 */
/*      07/Jun/1993     M. Davila       Search sin error                */
/*      22/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      04/May/95       S. Vinces       Admin Distribuido               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_ad_rol')
   drop proc sp_ad_rol
go

create proc sp_ad_rol (
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
	@i_tipo                 varchar(1) = null,
	@i_modo                 smallint = null,
	@i_rol                  tinyint = null,
	@i_filial               tinyint = null,
	@i_descripcion          descripcion = NULL,
	@i_creador              smallint = NULL,
	@i_fecha_crea           datetime = null,
	@i_time_out             smallint = null,
        @i_central_transmit     varchar (1) = NULL,
	@i_estado		estado = NULL,
	@i_formato_fecha	int=NULL
)
as
declare
	@w_today                datetime,
	@w_return               int,
	@w_sp_name              varchar(32),
	@w_fecha_crea           datetime,
	@w_filial               tinyint,
	@w_descripcion          descripcion,
	@w_creador              smallint,
	@w_time_out             smallint,
	@w_estado		estado,
	@v_fecha_crea           datetime,
	@v_filial               tinyint,
	@v_descripcion          descripcion,
	@v_creador              smallint,
	@v_time_out             smallint,
	@v_estado		estado,
	@o_rol                  tinyint,
	@o_fecha_crea           datetime,
	@o_time_out             smallint,
	@o_filial               tinyint,
	@o_nombre_f             descripcion,
	@o_descripcion          descripcion,
	@o_creador              smallint,
	@o_estado		estado,
	@w_siguiente            int,
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_crea          descripcion,
	@w_comando              descripcion,
        @w_cmdtransrv           varchar(64),
	@w_nt_nombre            varchar(32),
	@w_num_nodos            smallint,    
	@w_contador             smallint,
	@w_clave		int 

select @w_today = @s_date
select @w_sp_name = 'sp_ad_rol'


/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1))
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 540
begin
 /* chequeo de claves foraneas */
 if (@i_filial is NULL OR @i_descripcion is NULL
     OR @i_creador is NULL )
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
	select fu_funcionario
	  from cl_funcionario
	  where fu_funcionario = @i_creador)
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
	select fi_filial
	  from cl_filial
	  where fi_filial = @i_filial)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101002
	   /*  'No existe filial'*/
	return 1
  end

  begin tran
        if @i_rol is NULL
        begin
        	exec @w_return = sp_cseqnos @i_tabla = 'ad_rol',
				    @o_siguiente = @w_siguiente out
                select @i_rol  = @w_siguiente 
        end
        else
                select  @w_siguiente = @i_rol        

	if @w_return != 0
		return @w_return

	insert into ad_rol  (ro_rol, ro_filial, ro_descripcion,
			     ro_fecha_crea, ro_creador, ro_estado,
			     ro_fecha_ult_mod,
			     ro_time_out)
		     values (@w_siguiente, @i_filial, @i_descripcion,
			     @i_fecha_crea, @i_creador, @i_estado, @w_today,
			     @i_time_out)
	if @@error != 0
	begin
	    exec sp_cerror
	       @t_debug       = @t_debug,
	       @t_file        = @t_file,
	       @t_from        = @w_sp_name,
	       @i_num         = 153005
	       /*  'Error en insercion de rol' */
	    return 1
	end

   /* transaccion de servicio */
   insert into ts_ad_rol (secuencia, tipo_transaccion, clase, fecha,
			  oficina_s, usuario, terminal_s, srv, lsrv,
			  rol, filial, descripcion, fecha_crea,
			  creador, estado, fecha_ult_mod,time_out)
		  values (@s_ssn, 540, 'N', @s_date,
			  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,    
			  @w_siguiente, @i_filial, @i_descripcion,
			  @i_fecha_crea, @i_creador, @i_estado, @w_today,@i_time_out)
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

  select @w_siguiente
  commit tran

  exec REENTRY...rp_gen_rol
  select @w_cmdtransrv = @s_lsrv +'...rp_load_rol'
        exec @w_cmdtransrv
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
					@i_rol         = @i_rol,
					@i_filial      = @i_filial,
					@i_descripcion = @i_descripcion,
					@i_creador     = @i_creador,
					@i_fecha_crea  = @i_fecha_crea,
					@i_time_out    = @i_time_out,   
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
if @t_trn = 541
begin
 /* chequeo de claves foraneas */
  if (@i_rol is NULL OR @i_filial is NULL 
      OR @i_descripcion is NULL OR @i_creador is NULL )
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

  select @w_filial = ro_filial,
	 @w_descripcion = ro_descripcion,
	 @w_fecha_crea = ro_fecha_crea,
	 @w_creador = ro_creador,
	 @w_fecha_ult_mod = ro_fecha_ult_mod,
	 @w_time_out      = ro_time_out,
	 @w_estado = ro_estado       
  from ad_rol
  where ro_rol = @i_rol
   /* and ro_estado = 'V'*/
  if @@rowcount = 0
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
	  where fu_funcionario = @i_creador)
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
	select fi_filial
	  from cl_filial
	  where fi_filial = @i_filial)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101002
	   /*  'No existe filial'*/
	return 1
  end

/*** verificacion de campos a actualizar ****/
  select @v_filial = @w_filial,
	 @v_descripcion = @w_descripcion,
	 @v_fecha_crea = @w_fecha_crea,
	 @v_creador = @w_creador,
	 @v_fecha_ult_mod = @w_fecha_ult_mod,
	 @v_time_out      = @w_time_out,
	 @v_estado = @w_estado      

  if @w_filial = @i_filial
   select @w_filial = null, @v_filial = null
  else
   select @w_filial = @i_filial

  if @w_descripcion = @i_descripcion
   select @w_descripcion = null, @v_descripcion = null
  else
   select @w_descripcion = @i_descripcion

  if @w_fecha_crea = @i_fecha_crea
   select @w_fecha_crea = null, @v_fecha_crea = null
  else
   select @w_fecha_crea = @i_fecha_crea

  if @w_creador = @i_creador
   select @w_creador = null, @v_creador = null
  else
   select @w_creador = @i_creador

  if @w_time_out = @i_time_out
   select @w_time_out = null, @v_time_out = null
  else
   select @w_time_out = @i_time_out 

  if @w_estado = @i_estado
   select @w_estado = null, @v_estado = null
  else
   select @w_estado = @i_estado 

  begin tran
   Update ad_rol
      set ro_filial = @i_filial,
	  ro_descripcion = @i_descripcion,
	  ro_fecha_crea = @i_fecha_crea,
	  ro_creador = @i_creador,
	  ro_fecha_ult_mod = @w_today,
	  ro_time_out      = @i_time_out,
	  ro_estado = @i_estado
   where ro_rol = @i_rol
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155006
	   /*  'Error en actualizacion de rol' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_ad_rol (secuencia, tipo_transaccion, clase, fecha,
			  oficina_s, usuario, terminal_s, srv, lsrv,
			  rol, filial, descripcion, fecha_crea,
			  creador, estado, fecha_ult_mod,time_out)
		  values (@s_ssn, 541, 'P', @s_date,
			  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,    
			  @i_rol, @v_filial, @v_descripcion,
			  @v_fecha_crea, @v_creador,@v_estado, @v_fecha_ult_mod,
			  @v_time_out)
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

   insert into ts_ad_rol (secuencia, tipo_transaccion, clase, fecha,
			  oficina_s, usuario, terminal_s, srv, lsrv,
			  rol, filial, descripcion, fecha_crea,
			  creador, estado, fecha_ult_mod,time_out)
		  values (@s_ssn, 41, 'A', @w_today,
			  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,    
			  @i_rol, @w_filial, @w_descripcion,
			  @w_fecha_crea, @w_creador, @w_estado, @w_today,
			  @i_time_out)
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
            
  exec REENTRY...rp_gen_rol
  select @w_cmdtransrv = @s_lsrv +'...rp_load_rol'
        exec @w_cmdtransrv
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
					@i_rol         = @i_rol,
					@i_filial      = @i_filial,
					@i_descripcion = @i_descripcion,
					@i_creador     = @i_creador,
					@i_fecha_crea  = @i_fecha_crea,
					@i_time_out    = @i_time_out,
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
if @t_trn = 542
begin
 /* chequeo de claves foraneas */
  if (@i_rol is NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

  select @w_filial = ro_filial,
	 @w_descripcion = ro_descripcion,
	 @w_fecha_crea = ro_fecha_crea,
	 @w_creador = ro_creador,
	 @w_fecha_ult_mod = ro_fecha_ult_mod,
	 @w_time_out      = ro_time_out,
	 @w_estado = ro_estado      
  from ad_rol
  where ro_rol = @i_rol
    /*and ro_estado = 'V'*/
  if @@rowcount = 0
  begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151026
	   /*  'No existe rol' */
	return 1
  end

 /* Verificacion de referencias */
  if exists (
	select ur_rol

	  from ad_usuario_rol
	 where ur_rol = @i_rol
	   and ur_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157012
	   /*  'Existe referencia en usuario rol' */
	return 1
  end

  if exists (
	select pr_rol
	  from ad_pro_rol
	 where pr_rol = @i_rol
	   and pr_estado = 'V')
  begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157014
	   /*  'Existe referencia en producto rol' */
	return 1
  end

 /* borrado de rol */ 
 begin tran
  Delete ad_rol
   where ro_rol = @i_rol
  if @@error != 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157015
	   /*  'Error en eliminacion de rol' */
	return 1
  end

  /* transaccion de servicio */
   insert into ts_ad_rol (secuencia, tipo_transaccion, clase, fecha,
			  oficina_s, usuario, terminal_s, srv, lsrv,
			  rol, filial, descripcion, fecha_crea,
			  creador, estado, fecha_ult_mod,time_out)
		  values (@s_ssn, 542, 'B', @s_date,
			  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,    
			  @i_rol, @w_filial, @w_descripcion,
			  @w_fecha_crea, @w_creador,@w_estado, @w_fecha_ult_mod,
			  @w_time_out)
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
   
  /* Cambios para Admin Distribuido */
  /* Actualizar la informacion en el transrv */
  exec REENTRY...rp_gen_rol
  select @w_cmdtransrv = @s_lsrv +'...rp_load_rol'
        exec @w_cmdtransrv
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
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
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
If @t_trn = 15041
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select  'Cod. Rol' = ro_rol,
		'Estado  ' = ro_estado,
		'Descripcion' = substring(ro_descripcion, 1, 20),
		'Cod. Filial' = ro_filial,
		'Filial' = fi_abreviatura,
		'Creador' = ro_creador,
		'Nombre Creador' = fu_nombre,
		'Protector Pantalla' = ro_time_out
	 from   ad_rol, cl_filial, cl_funcionario
	where   ro_filial = fi_filial
	  and   ro_creador = fu_funcionario
	  /*and   ro_estado = 'V'*/
	order   by ro_rol, ro_filial
       set rowcount 0
     end
     if @i_modo = 1
     begin
	select  'Cod. Rol' = ro_rol,
		'Estado  ' = ro_estado,
		'Descripcion' = substring(ro_descripcion, 1, 20),
		'Cod. Filial' = ro_filial,
		'Filial' = fi_abreviatura,
		'Creador' = ro_creador,
		'Nombre Creador' = fu_nombre,
		'Protector Pantalla' = ro_time_out
	 from   ad_rol, cl_filial, cl_funcionario
	where   ro_filial = fi_filial
	  and   ro_creador = fu_funcionario
	  and   ro_rol > @i_rol
	  /*and   ro_estado = 'V'*/
	order   by ro_rol, ro_filial
       set rowcount 0
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

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15042
begin
	select  @o_rol = @i_rol,        
		@o_nombre_f = fi_nombre,
		@o_descripcion = ro_descripcion,
		@o_filial = ro_filial,
		@o_creador = ro_creador,
		@o_nombre_crea = fu_nombre,
		@o_fecha_crea = ro_fecha_crea,
		@o_time_out   = ro_time_out,
		@o_estado = ro_estado
	 from   ad_rol, cl_filial, cl_funcionario
	where   ro_filial = fi_filial
	  and   ro_creador = fu_funcionario
	  and   ro_rol = @i_rol
       /* and   ro_estado = 'V'*/
	if @@rowcount = 0
	begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151026
	   /*  'No existe Rol' */
	  return 1
	end
	select @i_rol, @o_descripcion, @o_filial, @o_nombre_f, @o_creador,
	       @o_nombre_crea, convert(char(10), @o_fecha_crea, @i_formato_fecha),
	       @o_time_out, @o_estado
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
If @t_trn = 15043
begin
 if @i_tipo = 'A'
 begin
    set rowcount 20
    if @i_modo = 0
	 select   'Codigo' = ro_rol,
		  'Rol'    = substring(ro_descripcion, 1, 20),
		  'Filial' = substring(fi_nombre, 1, 20),
		  'Protector Pantalla' = ro_time_out,
		  'Estado' = ro_estado
	   from   ad_rol, cl_filial
	  where   ro_filial = fi_filial
	   order  by ro_rol
    else
	 select   'Codigo' = ro_rol,
		  'Rol'    = substring(ro_descripcion, 1, 20),
		  'Filial' = substring(fi_nombre, 1, 20),
		  'Protector Pantalla' = ro_time_out,
		  'Estado' = ro_estado
	   from   ad_rol, cl_filial
	 where   ro_filial = fi_filial
           and   ro_rol    > @i_rol
	   order  by ro_rol
         set rowcount 0  
 end
 if @i_tipo = 'V'
 begin
	 select   substring(ro_descripcion, 1, 20),
		  substring(fi_nombre, 1, 20),
		  ro_time_out
	   from   ad_rol, cl_filial
	  where   ro_rol = @i_rol
	    and   ro_filial = fi_filial
	/*  and   ro_estado = 'V'*/
	 if @@rowcount = 0
	 begin
		 exec sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 151026
			/*  'No existe Rol' */
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

