/************************************************************************/
/*      Archivo:                tipohora.sp                             */
/*      Stored procedure:       sp_tipo_horario                         */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura:     09/Feb/94                               */
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
/*      Insercion de tipos de horario                                   */
/*      Actualizacion del tipo de horario                               */
/*      Borrado del tipo de horario                                     */
/*      Busqueda de tipos de horario                                    */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      10/Feb/1994     F.Espinosa      Emision inicial                 */
/*      25/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      04/May/95       S. Vinces       Admin Distribuido               */
/*      18-04-2016      BBO             Migracion Sybase-Sqlserver FAL  */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tipo_horario')
   drop proc sp_tipo_horario







go
create proc sp_tipo_horario (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(32) = NULL,
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
	@i_modo                 smallint = NULL,
	@i_tipo                 varchar(1) = NULL,
	@i_tipoh                tinyint = NULL,
	@i_descripcion          descripcion = NULL,     
	@i_fecha_ult_mod        datetime = NULL,        
	@i_creador              smallint = NULL,
	@i_ult_secuencial       tinyint = NULL,
	@i_conexion             smallint = NULL,
	@i_central_transmit	varchar(1) = NULL
)
as
declare
	@w_today                datetime,
	@w_return               int,
	@w_sp_name              varchar(32),
	@w_tipo                 tinyint,
	@w_descripcion          descripcion,
	@v_descripcion          descripcion,
	@w_ult_secuencial       tinyint,
	@w_creador              smallint,
	@v_creador              smallint,
	@w_siguiente            int,
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_crea          descripcion,
	@w_contador             tinyint,
	@w_detalles             tinyint,
	@w_secuencial           tinyint,
	@w_comando              descripcion,
	@w_num_nodos		smallint,
	@w_nt_nombre		varchar(30),
	@w_cmdtransrv		varchar(60),
	@w_clave		int

select @w_today = @s_date
select @w_sp_name = 'sp_tipo_horario'



if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char(1))
end

/* ** Insert ** */

/* Esta operacion realiza la insercion tanto del Tipo de Horario
   como de su composicion en las repectivas tablas reales, tomando
   los datos de las tablas temporales  */
 
if @i_operacion = 'I'
begin
if @t_trn = 578
begin

  begin tran
  if @i_tipoh  is NULL
   begin
   exec @w_return = sp_cseqnos @i_tabla = 'ad_tipo_horario',
			       @o_siguiente = @w_siguiente out
   
        if @w_return != 0
            return @w_return

	select @i_tipoh     = @w_siguiente   
   end
   else
	select @w_siguiente = @i_tipoh       


    insert into ad_tipo_horario (th_tipo, th_descripcion,
			    th_ult_secuencial, th_fecha_ult_mod,
			    th_creador, th_estado)
	 select @w_siguiente, tht_descripcion, @i_ult_secuencial,
		tht_fecha_ult_mod, tht_creador, tht_estado
	 from   ad_tipo_horario_tmp
	 where tht_conexion = @i_conexion
    
    if @@error != 0
    begin
/*  'Error en insercion de tipo de horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153028
	return 1
    end

/* transaccion de servicio */
   insert into ts_tipo_horario (secuencia, tipo_transaccion, clase, fecha,
			oficina_s, usuario, terminal_s, srv, lsrv,
			tipo, descripcion, ult_secuencial,
			creador, estado, fecha_ult_mod)
		select  @s_ssn, 578, 'N', @s_date,
			@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
			@w_siguiente,tht_descripcion, @i_ult_secuencial,
			tht_creador, 'V', @w_today
		  from  ad_tipo_horario_tmp
		  where tht_conexion = @i_conexion

   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */

	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	return 1
   end
 

/* ** Insercion de la composicion de los Horarios ** */

    insert into ad_horario (ho_tipo_horario, ho_secuencial, ho_dia,
			    ho_hr_inicio, ho_hr_fin,
			    ho_fecha_crea, ho_creador, ho_estado,
			    ho_fecha_ult_mod)
		select  @w_siguiente, hot_secuencial, hot_dia,
			hot_hr_inicio, hot_hr_fin,
			hot_fecha_crea, hot_creador, hot_estado,
			hot_fecha_ult_mod
		  from  ad_horario_tmp
		  where hot_conexion = @i_conexion

    if @@error != 0
    begin
/*  'Error en insercion de horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153007
	return 1
    end

/* transaccion de servicio */
   insert into ts_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo_horario, secuencial, dia, 
			   hr_inicio, hr_fin, fecha_crea, creador,
			   estado, fecha_ult_mod)
		select  @s_ssn, 507, 'N', @s_date,
			@s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,      
			@w_siguiente, hot_secuencial, hot_dia,
			hot_hr_inicio, hot_hr_fin, hot_fecha_crea, hot_creador,
			hot_estado, hot_fecha_ult_mod
		  from  ad_horario_tmp
		  where hot_conexion = @i_conexion

   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */

	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	return 1
   end
 

/* Borrar de las tablas temporales los datos */
 
 delete from ad_tipo_horario_tmp
	where tht_conexion = @i_conexion

 delete from ad_horario_tmp
	where hot_conexion = @i_conexion
  
 commit tran
 select @w_siguiente

   exec REENTRY...rp_gen_loghorol 
   select @w_comando = @s_lsrv +'...rp_load_loghorol'
   exec @w_return = @w_comando
   
 if @i_creador is null
	select @i_creador = 0

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
				@s_lsrv                 = @w_nt_nombre,
				@t_trn                  = @t_trn,
				@i_operacion            = @i_operacion,
				@i_tipoh                = @i_tipoh,      
				@i_descripcion          = @i_descripcion,     
				@i_creador              = @i_creador,
				@i_ult_secuencial       = @i_ult_secuencial, 
				@i_conexion		= @i_conexion, 
				@i_central_transmit	= 'S',
				@o_clave		= @w_clave out

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


/* ** Borrar los datos de las tablas temporales  ** */
if @i_operacion = 'B'
begin
if @t_trn = 15095
begin

/* Borrar de las tablas temporales los datos */
 
 delete from ad_tipo_horario_tmp
	where tht_conexion = @i_conexion

 delete from ad_horario_tmp
	where hot_conexion = @i_conexion

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
if @t_trn = 579
begin
 /* chequeo de claves foraneas */
  if (@i_tipoh is NULL OR @i_descripcion is NULL OR
  @i_creador is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
  end

  select  @w_descripcion = th_descripcion,
	  @w_creador = th_creador,
	  @w_fecha_ult_mod = th_fecha_ult_mod
     from ad_tipo_horario
    where th_tipo = @i_tipoh
      and th_estado = 'V'
  if @@rowcount = 0
  begin
/*  'No existe tipo horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151047
	return 1
  end
  
  if not exists (
     select fu_funcionario
       from cl_funcionario
      where fu_funcionario = @i_creador)
  begin
/*  'No existe funcionario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101036
	return 1
  end

/*** verificacion de campos a actualizar ***/
  select @v_descripcion = @w_descripcion,
	 @v_creador = @w_creador,
	 @v_fecha_ult_mod = @w_fecha_ult_mod


  if @w_descripcion = @i_descripcion
   select @w_descripcion = null, @v_descripcion= null
  else
   select @w_descripcion = @i_descripcion

  if @w_creador = @i_creador
   select @w_creador = null, @v_creador = null
  else
   select @w_creador = @i_creador

  begin tran
   Update ad_tipo_horario
      set th_descripcion = @i_descripcion,
	  th_creador = @i_creador,
	  th_fecha_ult_mod = @w_today
   where th_tipo = @i_tipoh
   if @@error != 0
   begin
/* 'Error en actualizacion de tipo de horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155026
	return 1
    end

/* transaccion de servicio */
   insert into ts_tipo_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo, descripcion, ult_secuencial,
			   creador, estado, fecha_ult_mod)
		   values (@s_ssn, 579, 'P', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   null , @v_descripcion, null,
			   @v_creador, null, @v_fecha_ult_mod)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	return 1
   end

   insert into ts_tipo_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo, descripcion, ult_secuencial,
			   creador, estado, fecha_ult_mod)
		   values (@s_ssn, 579, 'A', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   null, @w_descripcion, null,
			   @w_creador, null, @w_today)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	return 1
   end
  commit tran

   exec REENTRY...rp_gen_loghorol 
   select @w_comando = @s_lsrv +'...rp_load_loghorol'
   exec @w_return = @w_comando
         
   if @i_creador is null
        select @i_creador = 0

 

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
				@s_lsrv                 = @w_nt_nombre,
				@t_trn                  = @t_trn,
				@i_operacion            = @i_operacion,
				@i_tipoh                = @i_tipoh,
				@i_descripcion          = @i_descripcion,     
				@i_creador              = @i_creador,
				@i_central_transmit	= 'S',
				@o_clave		= @w_clave out

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
if @t_trn = 580
begin
 /* chequeo de claves foraneas */
  if (@i_tipoh is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
  end

  select  @w_tipo = th_tipo,  
	  @w_descripcion = th_descripcion,
	  @w_ult_secuencial = th_ult_secuencial,
	  @w_creador = th_creador,
	  @w_fecha_ult_mod = th_fecha_ult_mod
     from ad_tipo_horario
    where th_tipo = @i_tipoh
      and th_estado = 'V'
  if @@rowcount = 0
  begin
/*  'No existe horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151006
	return 1
  end

  /* verficacion de referencias  en ad_usuario_rol*/
   if exists (
	select ur_tipo_horario
	  from ad_usuario_rol
	 where ur_tipo_horario = @i_tipoh)
   begin
/*  'Existe referencia en Ususrio Rol ' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157040
	return 1
   end
   
     /* verficacion de referencias cl_oficina*/
   if exists (
	select of_horario
	  from cl_oficina
	 where of_horario = @i_tipoh)
   begin
/*  'Existe referencia en Oficina ' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157229
	return 1
   end

  /* borrado de tipo de horario */
   begin tran
    Delete ad_tipo_horario
     where th_tipo = @i_tipoh
    if @@error != 0
    begin
/*  'Error en eliminacion de tipo de horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157046
	return 1
    end

   insert into ts_tipo_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo, descripcion, ult_secuencial,
			   creador, estado, fecha_ult_mod)
		   values (@s_ssn, 580, 'B', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   @w_tipo, @w_descripcion, @w_ult_secuencial,
			   @w_creador, 'V', @w_fecha_ult_mod)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153023
	return 1
   end

  commit tran

/* Eliminacion de los componentes del Tipo de Horario */

    select @w_detalles = count(*)
	from ad_horario
	where ho_tipo_horario = @i_tipoh
    
    if @w_detalles != 0
    begin
       select @w_contador = 1
 
       set rowcount 1
       while @w_contador <= @w_detalles
       begin
	   select @w_secuencial = ho_secuencial
	      from ad_horario
	      where ho_tipo_horario = @i_tipoh

	   exec @w_return = sp_horario_c
		@s_ssn          = @s_ssn,
		@s_user         = @s_user,      
		@s_sesn         = @s_sesn,              
		@s_term         = @s_term,      
		@s_date         = @s_date,      
		@s_srv          = @s_srv,
		@s_lsrv         = @s_lsrv,
		@s_rol          = @s_rol,
		@s_ofi          = @s_ofi,
		@s_org_err      = @s_org_err,
		@s_error        = @s_error,
		@s_sev          = @s_sev,
		@s_msg          = @s_msg,
		@s_org          = @s_org,       
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_operacion    = "D",
		@i_tipoh        = @i_tipoh,
		@i_secuencial   = @w_secuencial,
		@i_modo         = 1,
		@i_borrar       = "N",
		@t_trn = 509
	
	   if @w_return != 0
	       return @w_return 
	   select @w_contador = @w_contador + 1         
       end
       set rowcount 0
    end


   exec REENTRY...rp_gen_loghorol 
   select @w_comando = @s_lsrv +'...rp_load_loghorol'
   exec @w_return = @w_comando

	if @w_return <> 0
		return @w_return
 if @i_creador is null
        select @i_creador = 0

   
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
		update #ad_nodo_reentry_tmp   set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv	
				@s_lsrv                 = @w_nt_nombre,
				@t_trn                  = @t_trn,
				@i_operacion            = @i_operacion,
				@i_tipoh                = @i_tipoh,
				@i_descripcion          = @i_descripcion,     
				@i_creador              = @i_creador,
				@i_central_transmit	= 'S',
				@o_clave		= @w_clave out

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
If @t_trn = 15064
begin
     set rowcount 20
     if @i_modo = 0
     begin
        select  'Tipo'   = th_tipo,
                'Descripcion' = th_descripcion,
                'Ult_Secuencial' = th_ult_secuencial, 
                'Creador' = th_creador,
                'Nombre Creador' = fu_nombre
        --inicio mig syb-sql 18042016          
          from   ad_tipo_horario
                left outer join cl_funcionario on th_creador = fu_funcionario
         where  th_estado = 'V'
        order   by th_tipo
        --FIN mig syb-sql 18042016    
        
        /****** MIGRACION SYB-SQL 
         from   ad_tipo_horario, cl_funcionario
        where   th_creador *= fu_funcionario
           and  th_estado = 'V'
        order   by th_tipo
        *******/

       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
        select  'Tipo'   = th_tipo,
                'Descripcion' = th_descripcion,
                'Ult_Secuencial' = th_ult_secuencial, 
                'Creador' = th_creador,
                'Nombre Creador' = fu_nombre
        --inicio mig syb-sql 18042016          
          from   ad_tipo_horario
                left outer join cl_funcionario on th_creador = fu_funcionario
         where  th_estado = 'V'
           and  th_tipo > @i_tipoh    
         order  by th_tipo
        --FIN mig syb-sql 18042016    
        
        /****** MIGRACION SYB-SQL 
         from   ad_tipo_horario, cl_funcionario
        where   th_creador *= fu_funcionario
           and  th_tipo > @i_tipoh      
           and  th_estado = 'V'
        order   by th_tipo
        ******/
        
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

/* ** Help ** */
if @i_operacion = "H"
begin
If @t_trn = 15065
begin
	if @i_tipo = "A"
	begin
	set rowcount 20
	if @i_modo = 0
		select "Codigo" = th_tipo,
			"Descripcion" = convert(char(30), th_descripcion)
		  from ad_tipo_horario
		 where  th_estado = 'V'
		 order by th_tipo
	else
	if @i_modo = 1
		select "Codigo" = th_tipo,
		       "Descripcion" =  convert(char(30),th_descripcion)
		  from ad_tipo_horario
		 where th_tipo > @i_tipoh
		   and th_estado = 'V'
		 order by th_tipo
	set rowcount 0
	return 0
	end


	if @i_tipo = "V"
	begin
		select convert(char(30),th_descripcion)
		  from ad_tipo_horario
		 where th_tipo = @i_tipoh
		   and th_estado = 'V'

		if @@rowcount = 0
		begin
			/* no existe dato solicitado */
			exec sp_cerror
				@t_debug        = @t_debug,
				@t_file         = @t_file,
				@t_from         = @w_sp_name,
				@i_num          = 101001
			return 1
		end
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
return 0
go

