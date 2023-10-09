/************************************************************************/
/*      Archivo:                pro_tran.sp                             */
/*      Stored procedure:       sp_pro_transaccion                      */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 28-Nov-1992                                 */
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
/*      Insercion de producto - transaccion                             */
/*      Actualizacion del producto - transaccion                        */
/*      Borrado del producto - transaccion                              */
/*      Busqueda del producto - transaccion                             */
/*      Query del producto - transaccion                                */
/*      Ayuda del producto - transaccion                                */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      28/Nov/1992     L. Carvajal     Emision inicial                 */
/*      07/Jun/1993     M. Davila       Search sin error                */
/*      02/Mar/1994     F.Espinosa      Query                           */
/*      04/May/1995     S. Vinces       Admin Distribuido               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_pro_transaccion')
   drop proc sp_pro_transaccion



go
create proc sp_pro_transaccion (
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
	@i_tipo_h               varchar(1)     = null,
	@i_modo                 smallint    = null,
	@i_producto             tinyint     = NULL,
	@i_tipo                 varchar(1)     = NULL,
	@i_moneda               tinyint     = NULL,
	@i_transaccion          int    = NULL,
	@i_procedure            int    = NULL,
	@i_rol                  tinyint     = NULL,
	@i_lote			char(1)     = NULL,
        @i_central_transmit     varchar (1) = NULL
)
as
declare
	@w_today                datetime,
	@w_sp_name              varchar(32),
	@o_siguiente            int,
	@o_nombre_p             descripcion,
	@o_nombre_m             descripcion,
	@o_nombre_t             descripcion,
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@w_procedure            int,
	@v_procedure            int,
	@o_transaccion          int,
	@o_des_transaccion      descripcion,
	@o_procedimiento        int,
	@o_des_procedimiento    descripcion,
	@w_return               int,
	@w_comando              descripcion,
	@w_num_nodos            smallint,    
	@w_contador             smallint,    
	@w_cmdtransrv		varchar(60),
	@w_clave		int,
	@w_nt_nombre		varchar(32)

select @w_today = @s_date
select @w_sp_name = 'sp_pro_transaccion'

/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and ( @i_central_transmit is NULL) 
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1))
end

/** Insert  **/
if @i_operacion = 'I'
begin
if @t_trn = 534
begin
 /* chequeo de claves foraneas */
  if (@i_producto is NULL  OR @i_moneda is NULL 
      OR @i_tipo is NULL   OR @i_transaccion is NULL)
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
	select tn_trn_code
	  from cl_ttransaccion
	where tn_trn_code = @i_transaccion)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151007
	   /*  'No existe transaccion' */
	return 1
  end

  if not exists (
	select pm_producto
	  from cl_pro_moneda
	 where pm_producto = @i_producto
	   and pm_moneda   = @i_moneda
	   and pm_tipo     = @i_tipo)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101031
	   /*  'No existe producto moneda' */
	return 1
  end

  if not exists (
	select  pd_procedure
	  from  ad_procedure
	 where  pd_procedure = @i_procedure)
  begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151008
		/* No existe procedimiento */
	return 1
  end

  if exists ( select pt_producto  from ad_pro_transaccion
	       where pt_producto  = @i_producto 
	         and pt_tipo      = @i_tipo       
	         and pt_moneda    = @i_moneda     
	         and pt_transaccion = @i_transaccion
	         and pt_procedure   = @i_procedure )
  begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151072
		/* Ya existe producto transaccion ' */
	return 1
  end

  if exists ( select pt_producto  from ad_pro_transaccion
	       where pt_producto  = @i_producto 
	         and pt_tipo      = @i_tipo       
	         and pt_moneda    = @i_moneda     
	         and pt_transaccion = @i_transaccion)
  begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151036
		/* Ya existe codigo de transaccion ' */
	return 1
  end

  begin tran
    insert into ad_pro_transaccion  (pt_producto, pt_moneda,
				     pt_tipo, pt_transaccion, pt_estado,
				     pt_procedure, pt_fecha_ult_mod)
			    values (@i_producto, @i_moneda,
				    @i_tipo, @i_transaccion, 'V', 
				    @i_procedure, @w_today)
    if @@error != 0
    begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153009
	   /*  'Error en insercion de producto transaccion' */
	 return 1
    end

   /* transaccion de servicio */
   insert into ts_pro_transaccion (secuencia, tipo_transaccion, clase, fecha,
				   oficina_s, usuario, terminal_s, srv, lsrv,
				   producto, moneda, tipo, transaccion,
				   estado, procedimiento, fecha_ult_mod)
			   values (@s_ssn, 534, 'N', @s_date,
				   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
				   @i_producto, @i_moneda,
				   @i_tipo, @i_transaccion, 
				   'V', @i_procedure, @w_today)
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

  exec REENTRY...rp_gen_rolspro
  select @w_cmdtransrv = @s_lsrv +'...rp_load_rolspro'
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
					@i_producto    = @i_producto,
					@i_tipo        = @i_tipo,
					@i_moneda      = @i_moneda,
					@i_transaccion = @i_transaccion,
					@i_procedure   = @i_procedure,
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


/** Update **/
if @i_operacion = 'U'
begin
if @t_trn = 535
begin
 /* chequeo de claves foraneas */
  if (@i_producto is NULL  OR @i_moneda is NULL 
      OR @i_tipo is NULL   OR @i_transaccion is NULL)
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
	select tn_trn_code
	  from cl_ttransaccion
	 where tn_trn_code = @i_transaccion)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151007
	   /*  'No existe transaccion' */
	return 1
  end

  if not exists (
	select pm_producto
	  from cl_pro_moneda
	 where pm_producto = @i_producto
	   and pm_moneda   = @i_moneda
	   and pm_tipo     = @i_tipo)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 101031
	   /*  'No existe producto moneda' */
	return 1
  end
  if not exists (
	select  pd_procedure
	  from  ad_procedure
	 where  pd_procedure = @i_procedure)
  begin
	exec sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 151008
		/* No existe procedimiento */
	return 1
  end

  /* Chequeo de campos a actualizar */
  select @w_procedure = pt_procedure
    from ad_pro_transaccion
   where pt_transaccion = @i_transaccion
     and pt_producto = @i_producto
     and pt_tipo = @i_tipo
     and pt_moneda = @i_moneda

  select @v_procedure = @w_procedure

  if @w_procedure = @i_procedure
	select @w_procedure = null, @v_procedure = null
  else
	select @w_procedure = @i_procedure
  begin tran
    update ad_pro_transaccion 
       set pt_procedure = @i_procedure,
	   pt_fecha_ult_mod = @w_today
     where pt_transaccion = @i_transaccion
       and pt_producto = @i_producto
       and pt_tipo = @i_tipo
       and pt_moneda = @i_moneda

    if @@error != 0
    begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153009
	   /*  'Error en insercion de producto transaccion' */
	 return 1
    end

   /* transaccion de servicio */
   insert into ts_pro_transaccion (secuencia, tipo_transaccion, clase, fecha,
				   oficina_s, usuario, terminal_s, srv, lsrv,
				   producto, moneda, tipo, transaccion,
				   estado, procedimiento, fecha_ult_mod)
			   values (@s_ssn, 535, 'P', @s_date,
				   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
				   @i_producto, @i_moneda, @i_tipo, 
				   @i_transaccion, 'V',  @v_procedure, @w_today)
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
   insert into ts_pro_transaccion (secuencia, tipo_transaccion, clase, fecha,
				   oficina_s, usuario, terminal_s, srv, lsrv,
				   producto, moneda, tipo, transaccion,
				   estado, procedimiento, fecha_ult_mod)
			   values (@s_ssn, 535, 'A', @s_date,
				   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
				   @i_producto, @i_moneda, @i_tipo, 
				   @i_transaccion, 'V',  @w_procedure, @w_today)
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


   
  exec REENTRY...rp_gen_rolspro
  select @w_cmdtransrv = @s_lsrv +'...rp_load_rolspro'
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
					@i_producto    = @i_producto,
					@i_tipo        = @i_tipo,
					@i_moneda      = @i_moneda,
					@i_transaccion = @i_transaccion,
					@i_procedure   = @i_procedure,
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


/* ** delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 536
begin
 /* chequeo de claves foraneas */
  if (@i_producto is NULL  OR @i_moneda is NULL 
      OR @i_tipo is NULL   OR @i_transaccion is NULL
      OR @i_procedure is NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
	select @w_fecha_ult_mod = pt_fecha_ult_mod,
	       @w_procedure = pt_procedure
	  from ad_pro_transaccion
	 where pt_transaccion = @i_transaccion
	   and pt_procedure = @i_procedure
	   and pt_producto = @i_producto
	   and pt_tipo = @i_tipo
	   and pt_moneda = @i_moneda
	   and pt_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151011
	   /*  'No existe producto transaccion' */
	return 1
  end

  /* verificacion de referencias */
  if exists (
	select ta_producto
	  from ad_tr_autorizada
	 where ta_producto =  @i_producto
	   and ta_tipo = @i_tipo
	   and ta_moneda = @i_moneda
	   and ta_transaccion = @i_transaccion
	   and ta_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157018
	   /*  'Existe referencia en transaccion autorizada' */
	return 1
  end

  /* borrado de producto transaccion */
  begin tran
   Delete ad_pro_transaccion
    where pt_transaccion = @i_transaccion
      and pt_procedure = @i_procedure
      and pt_producto = @i_producto
      and pt_tipo = @i_tipo
      and pt_moneda = @i_moneda
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157020
	   /*  'Error en eliminacion de producto transaccion' */
	return 1
   end

  /* transaccion de servicio */
   insert into ts_pro_transaccion (secuencia, tipo_transaccion, clase, fecha,
				   oficina_s, usuario, terminal_s, srv, lsrv,
				   producto, moneda, tipo, transaccion,
				   estado, procedimiento, fecha_ult_mod)
			   values (@s_ssn, 536, 'B', @s_date,
				   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
				   @i_producto, @i_moneda, @i_tipo,
				   @i_transaccion, 'V', @w_procedure, 
				   @w_fecha_ult_mod)
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

  exec REENTRY...rp_gen_rolspro
  select @w_cmdtransrv = @s_lsrv +'...rp_load_rolspro'
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
					@i_producto    = @i_producto,
					@i_tipo        = @i_tipo,
					@i_moneda      = @i_moneda,
					@i_transaccion = @i_transaccion,
					@i_procedure   = @i_procedure,
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

if @i_operacion = 'S' OR @i_operacion = 'H' or @i_operacion = 'Q'
begin
	exec @w_return = sp_cons_pro_transaccion
		@t_debug                  = @t_debug,
		@t_file                    = @t_file,
		@t_from                    = @w_sp_name,
		@t_trn                     = @t_trn,
		@i_operacion               = @i_operacion,
		@i_modo                    = @i_modo,
		@i_tipo_h                  = @i_tipo_h, 
		@i_producto                = @i_producto, 
		@i_tipo                    = @i_tipo, 
		@i_moneda                  = @i_moneda, 
		@i_transaccion             = @i_transaccion,    
		@i_procedure               = @i_procedure,      
		@i_rol                     = @i_rol,
		@i_lote			   = @i_lote
	if @w_return != 0
		return @w_return
return 0
end
go
