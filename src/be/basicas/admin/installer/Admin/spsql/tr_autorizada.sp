/************************************************************************/
/*      Archivo:                tr_autor.sp                             */
/*      Stored procedure:       sp_tr_autorizada                        */
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
/*      Insercion de transaccion autorizada                             */
/*      Borrado de transaccion autorizada                               */
/*      Busqueda de transaccion autorizada                              */
/*      Query de transaccion autorizada                                 */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      30/Nov/1992     L. Carvajal     Emision inicial                 */
/*      07/Jun/1993     M. Davila       Search sin error                */
/*      22/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      04/May/95       S. Vinces       Admin Distribuido               */
/*      13/Nov/2007     Paul Borja      Que no se quede en el while     */
/*      21/Abr/2016     BBO             Migracion SYB-SQL FAL           */
/************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_tr_autorizada')
   drop proc sp_tr_autorizada
go

create proc sp_tr_autorizada (
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
	@i_operacion            char(1),
	@i_modo                 smallint = null,
	@i_producto             tinyint  = NULL,
	@i_tipo                 char(1)  = NULL,
	@i_moneda               tinyint  = NULL,
	@i_transaccion          int = NULL,
	@i_rol                  tinyint  = NULL,
	@i_autorizante          smallint = NULL,
	@i_fecha_aut            datetime = NULL,
	@i_central_transmit     char(1) = null,
	@i_formato_fecha	int=null,
	@i_funcionario		smallint=null
)
as
declare
	@w_today                datetime,
	@w_sp_name              varchar(32),
	@o_siguiente            int,
	@o_autorizante          tinyint,
	@o_nombre_p             descripcion,
	@o_nombre_m             descripcion,
	@o_nombre_t             descripcion,
	@o_nombre_r             descripcion,
	@o_nombre_aut           descripcion,
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_fecha_aut            datetime,
	@w_nt_nombre		varchar(32),
	@w_fecha_aut            datetime,
	@w_autorizante          int,
	@w_return               int,
	@w_comando              descripcion,
	@w_num_nodos        	smallint,    
	@w_contador          	smallint,
	@w_cmdtransrv		varchar(60),
	@w_clave		int

select @w_today = @s_date
select @w_sp_name = 'sp_tr_autorizada'

/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'D') and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1))
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 564
begin
 /* chequeo de claves foraneas */
  if (@i_producto is NULL  OR @i_moneda is NULL 
      OR @i_tipo is NULL   OR @i_transaccion is NULL
      OR @i_rol is NULL    OR @i_autorizante is NULL)
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
	select pt_transaccion
	  from ad_pro_transaccion
	 where pt_transaccion = @i_transaccion
	   and pt_producto = @i_producto
	   and pt_moneda = @i_moneda
	   and pt_tipo = @i_tipo
	   and pt_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151011
	   /*  'No existe producto transaccion' */
	return 1
  end

  if not exists (
	select pr_producto
	  from ad_pro_rol
	 where pr_producto = @i_producto
	   AND pr_moneda   = @i_moneda
	   AND pr_rol      = @i_rol
	   AND pr_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151010
	   /*  'No existe producto rol' */
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

  begin tran
    insert into ad_tr_autorizada (ta_producto, ta_moneda, ta_tipo, 
				  ta_transaccion, ta_rol, ta_fecha_aut,
				  ta_autorizante, ta_estado, ta_fecha_ult_mod)
			    values (@i_producto, @i_moneda, @i_tipo, 
				    @i_transaccion, @i_rol, @i_fecha_aut,
				    @i_autorizante, 'V', @w_today)
    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153010
	   /*  'Error en insercion de transaccion autorizada' */
	return 1
    end

   /* transaccion de servicio */
   insert into ts_tr_autorizada (secuencia, tipo_transaccion, clase, fecha,
				 oficina_s, usuario, terminal_s, srv, lsrv,
				 producto, moneda, tipo, transaccion, rol,
				 fecha_aut, autorizante, estado, fecha_ult_mod)
			 values (@s_ssn, 564, 'N', @s_date,
				 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,     
				 @i_producto, @i_moneda, @i_tipo,
				 @i_transaccion, @i_rol, @i_fecha_aut,
				 @i_autorizante, 'V', @w_today)
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
if @w_num_nodos > 0
begin
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
					@i_rol         = @i_rol,         
					@i_autorizante = @i_autorizante,
					@i_fecha_aut   = @i_fecha_aut,
					@i_central_transmit = 'S',
					@o_clave 	= @w_clave out

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
end -- solo si hay num nodos
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
if @t_trn = 566
begin
 /* chequeo de claves foraneas */
  if (@i_producto is NULL  OR @i_moneda is NULL 
      OR @i_tipo is NULL   OR @i_transaccion is NULL
      OR @i_rol is NULL   )
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

	select @w_fecha_ult_mod = ta_fecha_ult_mod,
	       @w_autorizante = ta_autorizante,
	       @w_fecha_aut = ta_fecha_aut
	  from ad_tr_autorizada
	 where ta_transaccion = @i_transaccion
	   and ta_producto = @i_producto
	   and ta_moneda = @i_moneda
	   and ta_tipo = @i_tipo
	   and ta_rol = @i_rol
	   and ta_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151023
	   /*  'No existe transaccion autorizada' */
	return 1
  end

  /* borrado de transaccion autorizada */
  begin tran
   Delete ad_tr_autorizada
    where ta_transaccion = @i_transaccion
      and ta_producto = @i_producto
      and ta_moneda = @i_moneda
      and ta_tipo = @i_tipo
      and ta_rol = @i_rol
    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157025
	   /*  'Error en eliminacion de transaccion autorizada' */
	return 1
    end

  /* transaccion de servicio */
   insert into ts_tr_autorizada (secuencia, tipo_transaccion, clase, fecha,
				 oficina_s, usuario, terminal_s, srv, lsrv,
				 producto, moneda, tipo, transaccion, rol,
				 fecha_aut, autorizante, estado, fecha_ult_mod)
			 values (@s_ssn, 566, 'B', @s_date,
				 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,     
				 @i_producto, @i_moneda, @i_tipo,
				 @i_transaccion, @i_rol, @w_fecha_aut,
				 @w_autorizante, 'V', @w_fecha_ult_mod)
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
if @w_num_nodos > 0
begin
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
					@i_rol         = @i_rol,         
					@i_central_transmit = 'S',
					@o_clave 	= @w_clave out

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
end -- solo si hay num nodos
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
If @t_trn = 15069
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select  'Cod. transaccion' = ta_transaccion,
		'Transaccion' = substring(tn_descripcion, 1, 20),
		'Autorizante' = ta_autorizante,
		'Nombre Aut.' = fu_nombre               
	from    ad_tr_autorizada, cl_funcionario, cl_ttransaccion
	where   ta_producto = @i_producto
	and     ta_autorizante = fu_funcionario
	and     ta_moneda = @i_moneda
	and     ta_transaccion = tn_trn_code
	and     ta_rol = @i_rol
	and     ta_tipo = @i_tipo
	and     ta_estado = 'V'
	order   by ta_transaccion

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
	select  'Cod. transaccion' = ta_transaccion,
		'Transaccion' = substring(tn_descripcion, 1, 20),
		'Autorizante' = ta_autorizante,
		'Nombre Aut.' = fu_nombre               
	from    ad_tr_autorizada, cl_funcionario, cl_ttransaccion
	where   ta_producto = @i_producto
	and     ta_autorizante = fu_funcionario
	and     ta_moneda = @i_moneda
	and     ta_transaccion = tn_trn_code
	and     ta_rol = @i_rol
	and     ta_tipo = @i_tipo
	and     ta_transaccion > @i_transaccion
	and     ta_estado = 'V'
	order   by ta_transaccion
	
	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
	/*Comentado por CNA 31-01-2001 para evitar problemas de cargar un grid vacio*/
        /*if @@rowcount=0
        Begin
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 151121
        	set rowcount 0
        	return 1
        End*/
        /* Fin ARO */

	
       set rowcount 0
     end
     if @i_modo = 2
     begin
	select  'Cod.' = ta_transaccion,
		'Transaccion' = tn_descripcion,
		'Abreviatura' = tn_nemonico
	from    ad_tr_autorizada, cl_ttransaccion
	where   ta_producto = @i_producto
	and     ta_tipo = @i_tipo
	and     ta_moneda = @i_moneda
	and     ta_rol = @i_rol
	and     ta_transaccion = tn_trn_code
	and     ta_estado = 'V'

	order   by ta_transaccion

	/* ARO: 2 de Junio del 2000: Corrección Siguientes        
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
        Fin ARO */


       set rowcount 0
     end
     if @i_modo = 3
     begin
	select  'Cod.' = ta_transaccion,
		'Transaccion' = tn_descripcion,
		'Abreviatura' = tn_nemonico
	from    ad_tr_autorizada, cl_ttransaccion
	where   ta_producto = @i_producto
	and     ta_tipo = @i_tipo
	and     ta_moneda = @i_moneda
	and     ta_rol = @i_rol
	and     ta_transaccion > @i_transaccion
	and     ta_transaccion = tn_trn_code
	and     ta_estado = 'V'
	order   by ta_transaccion

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
	select  ta_transaccion
	from    ad_tr_autorizada
	where   ta_rol = @i_rol
	and     ta_estado = 'V'
	order   by ta_transaccion
	
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
	select  ta_transaccion
	from    ad_tr_autorizada
	where   ta_rol = @i_rol
	and     ta_transaccion > @i_transaccion
	and     ta_estado = 'V'
	order   by ta_transaccion

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
-- Incio JMU 10/Feb/2005
     if @i_modo = 6
     begin
	   select  "Cod. Trab." = fu_funcionario, 
			"Funcionario" = fu_login, 
			"Estado Trab." = fu_estado, 
			"Cod. Rol" = ur_rol, 
			"Rol"  = ro_descripcion 
		from ad_usuario_rol, cl_funcionario, ad_rol 
		where ur_rol in (select distinct ta_rol from ad_tr_autorizada where ta_transaccion = @i_transaccion)
		and ur_login = fu_login
		and ro_rol = ur_rol
		order by fu_funcionario, ur_rol

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
     if @i_modo = 7
     begin
	   select  "Cod. Trab." = fu_funcionario, 
			"Funcionario" = fu_login, 
			"Estado Trab." = fu_estado, 
			"Cod. Rol" = ur_rol, 
			"Rol"  = ro_descripcion 
		from ad_usuario_rol, cl_funcionario, ad_rol
		where ur_rol in (select distinct ta_rol from ad_tr_autorizada where ta_transaccion = @i_transaccion)
		and ur_login = fu_login
		and fu_funcionario > @i_funcionario
		and ro_rol = ur_rol
		order by fu_funcionario, ur_rol
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
-- fin JMU 10/Feb/2005
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
If @t_trn = 15070
begin
	select  @o_nombre_p = pd_descripcion,
		@o_nombre_m = mo_descripcion,
		@o_nombre_t = tn_descripcion,
		@o_nombre_r = ro_descripcion,
		@o_autorizante = ta_autorizante,
		@o_fecha_aut = ta_fecha_aut
	 from   ad_tr_autorizada, cl_producto, cl_moneda, 
		cl_ttransaccion, ad_rol
	where   ta_producto = pd_producto
	  and   ta_moneda = mo_moneda
	  and   ta_transaccion = tn_trn_code
	  and   ta_rol = ro_rol
	  and   ta_producto =  @i_producto
	  and   ta_tipo = @i_tipo
	  and   ta_moneda = @i_moneda
	  and   ta_transaccion = @i_transaccion
	  and   ta_rol = @i_rol
	  and   ta_estado = 'V'
	if @@rowcount = 0
	begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151023
	   /*  'No existe transaccion auotrizada */
	 return 1
	end

	select  @o_nombre_aut = fu_nombre
	from    cl_funcionario
	where   fu_funcionario = @o_autorizante
	if @@rowcount = 0
	begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151023
	   /*  'No existe transaccion auotrizada */
	 return 1
	end

	select  @i_producto, @o_nombre_p, @i_tipo, @i_moneda, @o_nombre_m,
		@i_transaccion, @o_nombre_t, @i_rol, @o_nombre_r, @o_autorizante,
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
go
