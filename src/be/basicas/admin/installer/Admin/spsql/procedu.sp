/************************************************************************/
/*      Archivo:                procedu.sp                              */
/*      Stored procedure:       sp_procedure                            */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 30-Nov-1992                                 */
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
/*      Insercion de procedure                                          */
/*      Actualizacion del procedure                                     */
/*      Borrado del procedure                                           */
/*      Busqueda del procedure                                          */
/*      Query del procedure                                             */
/*      Ayuda del procedure                                             */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      30/Nov/1992     L. Carvajal     Emision inicial                 */
/*      30/Abr/1993     M. Davila       Aumento de campo pd_archivo     */
/*      07/Jun/1993     M. Davila       Search sin error                */
/*      20/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      08/May/95       S. Vinces       Admin Distribuido               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_procedure')
   drop proc sp_procedure
go

create proc sp_procedure (
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
	@i_procedure            int = NULL,
	@i_stored_procedure     varchar(30) = NULL,
	@i_base_datos           varchar(30) = NULL,
	@i_archivo              varchar(14) = NULL,
	@i_valor                varchar(30) = NULL,
        @i_central_transmit     varchar(1) =NULL 
)
as
declare
	@w_today                datetime,
	@w_sp_name              varchar(32),
	@w_return               int,
	@w_procedure            int,
	@w_stored_procedure     varchar(30),
	@w_base_datos           varchar(30),
	@w_archivo              varchar(14),
	@v_procedure            int,
	@v_stored_procedure     varchar(30),
	@v_base_datos           varchar(30),
	@v_archivo              varchar(14),
	@o_stored_procedure     varchar(30),
	@o_base_datos           varchar(30),
	@o_archivo              varchar(14),
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@w_comando              descripcion,
	@w_nt_nombre		varchar(32),
	@w_num_nodos        smallint,    
	@w_contador          smallint,    
	@w_cmdtransrv	    varchar(60),
	@w_clave		int

select @w_today = @s_date
select @w_sp_name = 'sp_procedure'


/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char(1))
end


if @i_operacion = 'I' 
begin
if @t_trn = 528
begin
  if (@i_stored_procedure is NULL OR @i_base_datos is NULL OR @i_archivo is NULL)
  	begin 	
		exec sp_cerror  @t_debug      = @t_debug,
	   			@t_file       = @t_file,
	   			@t_from       = @w_sp_name,
	   			@i_num        = 151001
	   	/*  'No se llenaron todos los campos' */
		return 1
  	end
  if exists (select pd_procedure
	       from ad_procedure
	      where pd_procedure = @i_procedure)
  	begin 	
		exec sp_cerror  @t_debug      = @t_debug,
	   			@t_file       = @t_file,
	   			@t_from       = @w_sp_name,
	   			@i_num        = 151059
	   	/*  'Codigo de Proceso ya existe ' */
		return 1
  	end


  begin tran

   insert into ad_procedure (pd_procedure, pd_stored_procedure,
			     pd_base_datos, pd_estado, pd_fecha_ult_mod,
			     pd_archivo)
		     values (@i_procedure, @i_stored_procedure,
			     @i_base_datos, 'V', @w_today,
			     @i_archivo)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153021
	   /*  'Error en insercion de stored procedure' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_procedure (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     pprocedure, stored_procedure, base_datos, estado,
			     fecha_ult_mod, archivo)
		     values (@s_ssn, 528, 'N', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv, 
			     @i_procedure, @i_stored_procedure, @i_base_datos,
			     'V', @w_today, @i_archivo)
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
				@i_operacion    = @i_operacion,
				@i_procedure    = @i_procedure,
				@i_stored_procedure  = @i_stored_procedure,
				@i_base_datos        = @i_base_datos,
				@i_archivo           = @i_archivo,
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
if @t_trn = 529
begin
  if (@i_procedure is NULL OR @i_stored_procedure is NULL
      OR @i_base_datos is NULL OR @i_archivo is NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
  
  select  @w_stored_procedure = pd_stored_procedure,
	  @w_base_datos = pd_base_datos,
	  @v_fecha_ult_mod = pd_fecha_ult_mod,
	  @w_archivo = pd_archivo
    from ad_procedure
   where pd_procedure = @i_procedure
     and pd_estado = 'V'
 if @@rowcount = 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151008
	   /*  'No existe stored procedure' */
	return 1
  end

/*** verificacion de campos a actualizar ****/
  select @v_stored_procedure = @w_stored_procedure,
	 @v_base_datos = @w_base_datos,
	 @v_archivo = @w_archivo

  if @w_stored_procedure= @i_stored_procedure
   select @w_stored_procedure = null, @v_stored_procedure = null
  else
   select @w_stored_procedure = @i_stored_procedure

  if @w_base_datos = @i_base_datos
   select @w_base_datos = null, @v_base_datos = null
  else
   select @w_base_datos = @i_base_datos

  if @w_archivo = @i_archivo
   select @w_archivo = null, @v_archivo = null
  else
   select @w_archivo = @i_archivo

  begin tran
   Update ad_procedure
      set pd_stored_procedure = @i_stored_procedure,
	  pd_base_datos = @i_base_datos,
	  pd_fecha_ult_mod = @w_today,
	  pd_archivo = @i_archivo
    where pd_procedure = @i_procedure
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155017
	   /*  'Error en actualizacion de stored procedure' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_procedure (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     pprocedure, stored_procedure, base_datos, estado,
			     fecha_ult_mod, archivo)
		     values (@s_ssn, 529, 'P', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv, 
			     @i_procedure, @v_stored_procedure, @v_base_datos,
			     null, @v_fecha_ult_mod, @v_archivo)
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

   insert into ts_procedure (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     pprocedure, stored_procedure, base_datos, estado,
			     fecha_ult_mod, archivo)
		     values (@s_ssn, 529, 'A', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv, 
			     @i_procedure, @w_stored_procedure, @w_base_datos,
			     null, @w_today, @w_archivo)
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
				@i_operacion    = @i_operacion,
				@i_procedure    = @i_procedure,
				@i_stored_procedure  = @i_stored_procedure,
				@i_base_datos        = @i_base_datos,
				@i_archivo           = @i_archivo,
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
if @t_trn = 530
begin
  if (@i_procedure is NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
  
  select  @w_stored_procedure = pd_stored_procedure,
	  @w_base_datos      = pd_base_datos,
	  @w_fecha_ult_mod   = pd_fecha_ult_mod,
	  @w_archivo         = pd_archivo
  from ad_procedure
  where pd_procedure = @i_procedure
    and pd_estado = 'V'
if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151008
	   /*  'No existe stored procedure' */
	return 1
  end

  /* verificacion de referencias */
  if exists (
	select pt_procedure
	  from ad_pro_transaccion
	 where pt_procedure = @i_procedure
	   and pt_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157020
	   /*  'Existe referencia en producto-transaccion */
	return 1
  end

  /* borrado de procedure */
  begin tran
   Delete ad_procedure
    where pd_procedure = @i_procedure
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157024
	   /*  'Error en eliminacion de stored procedure' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_procedure (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     pprocedure, stored_procedure, base_datos, estado,
			     fecha_ult_mod, archivo)
		     values (@s_ssn, 530, 'B', @s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv, 
			     @i_procedure, @w_stored_procedure, @w_base_datos,
			     'V', @w_fecha_ult_mod, @w_archivo)
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
				@i_operacion    = @i_operacion,
				@i_procedure    = @i_procedure,
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
If @t_trn = 15026
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select  'Cod. Proc' = pd_procedure,
		'Nombre' = substring(pd_stored_procedure, 1, 20),
		'Base de Datos' = substring(pd_base_datos, 1, 20),
		'Archivo' = pd_archivo
	 from   ad_procedure
	where   pd_estado = 'V'
	order   by pd_procedure
	
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */
	
	
       set rowcount 0
     end
     if @i_modo = 1
     begin
	select  'Cod. Proc' = pd_procedure,
		'Nombre' = substring(pd_stored_procedure, 1, 20),
		'Base de Datos' = substring(pd_base_datos, 1, 20),
		'Archivo' = pd_archivo
	 from   ad_procedure
	where   pd_procedure > @i_procedure
	  and   pd_estado = 'V'
	order   by pd_procedure
	
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

	
       set rowcount 0
     end

     if @i_modo = 2
     begin
	select  'Cod. Proc' = pd_procedure,
		'Nombre' = substring(pd_stored_procedure, 1, 20),
		'Base de Datos' = substring(pd_base_datos, 1, 20),
		'Archivo' = pd_archivo
	 from   ad_procedure
	where   pd_estado = 'V'
	  and   pd_stored_procedure like @i_valor
	order   by pd_stored_procedure

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

	
       set rowcount 0
     end
     if @i_modo = 3
     begin
	select  'Cod. Proc' = pd_procedure,
		'Nombre' = substring(pd_stored_procedure, 1, 20),
		'Base de Datos' = substring(pd_base_datos, 1, 20),
		'Archivo' = pd_archivo
	 from   ad_procedure
	where   substring(pd_stored_procedure,1,20) > @i_stored_procedure
	  and   pd_estado = 'V'
	  and   pd_stored_procedure like @i_valor
	order   by pd_stored_procedure

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

	
       set rowcount 0
     end

     if @i_modo = 4
     begin
	select  'Cod. Proc' = pd_procedure,
		'Nombre' = substring(pd_stored_procedure, 1, 20),
		'Base de Datos' = substring(pd_base_datos, 1, 20),
		'Archivo' = pd_archivo
	 from   ad_procedure
	where   pd_estado = 'V'
	  and   convert(char,pd_procedure) like @i_valor
	order   by pd_procedure

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

	
       set rowcount 0
     end
     if @i_modo = 5
     begin
	select  'Cod. Proc' = pd_procedure,
		'Nombre' = substring(pd_stored_procedure, 1, 20),
		'Base de Datos' = substring(pd_base_datos, 1, 20),
		'Archivo' = pd_archivo
	 from   ad_procedure
	where   pd_procedure > @i_procedure
	  and   pd_estado = 'V'
	  and   convert(char,pd_procedure) like @i_valor
	order   by pd_procedure

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */

	
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
If @t_trn = 15027
begin
	 select   @o_stored_procedure = pd_stored_procedure,
		  @o_base_datos = pd_base_datos,
		  @o_archivo = pd_archivo
	   from   ad_procedure
	  where   pd_procedure = @i_procedure
	    and   pd_estado  = 'V'
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151008
	   /*  'No existe stored procedure' */
	  return 1
	 end
	 select @i_procedure, @o_stored_procedure, @o_base_datos, @o_archivo
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
If @t_trn = 15028
begin
 if @i_tipo = 'A'
 begin
	set rowcount 20
	if @i_modo = 0
		select   'Codigo' = pd_procedure,
			 'Procedimiento' = pd_stored_procedure
		  from   ad_procedure
		 where   pd_estado  = 'V'
		 order  by pd_procedure
	else
         begin
	    if @i_modo = 1
		select  'Codigo' = pd_procedure,
			'Procedimiento' = pd_stored_procedure
		  from    ad_procedure
		 where   pd_estado  = 'V'
		   and   pd_procedure > @i_procedure
		 order  by pd_procedure
          end
	set rowcount 0
	return 0
 end
 if @i_tipo = 'V'
 begin
	 select   pd_stored_procedure
	   from   ad_procedure
	  where   pd_procedure = @i_procedure
	    and   pd_estado  = 'V'
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151008
	   /*  'No existe stored procedure' */
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
