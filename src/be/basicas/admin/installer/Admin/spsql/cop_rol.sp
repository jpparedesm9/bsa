/************************************************************************/
/*      Archivo:                coprol.sp                               */
/*      Stored procedure:       sp_cop_rol                               */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 22-Feb-1995                                 */
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
/*      Este programa procesa la copia de roles con sus productos y     */
/*      transacciones hacia un nuevo rol                                */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      22/May/95       S. Vinces       Admin Distribuido               */
/*      06/Sep/2013     J.Tagle         Modificacion al Copiar Rol      */
/*      10/Mar/2016     N.Martillo      Autorizar zona de navegacion,   */
/*      								componentes, modulos, agentes   */
/*      								paginas						    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_cop_rol')
   drop proc sp_cop_rol
go

create proc sp_cop_rol (
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
	@i_rol                  tinyint,
	@i_descripcion          descripcion,
	@i_secuencial           smallint = NULL,  
	@t_show_version         bit  = 0,
	@i_central_transmit     varchar(1) = NULL,
    @i_copiar_trn_aut       char(1) = 'S' /* ECA: Bandera para identificar si la copia de rol */
                           /*   viene desde la pantalla de Administración de seguridades */
)
as
declare
	@w_return               int,
	@w_clave 	          int,
	@w_sp_name              varchar(32),
	@w_creador              smallint,
	@w_siguiente            int,
	@w_clave_re             int,
	@w_num_nodos            smallint,
	@w_contador             smallint,
	@w_comando              descripcion,
	@w_cmdtransrv            varchar(64),
	@w_nt_nombre            varchar(32)
		

select @w_sp_name = 'sp_cop_rol'

------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_cop_rol, version 4.0.0.0'
      return 0
end


if (@t_trn = 15106 ) and (@i_central_transmit is NULL)
	begin
	create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char(1) ) 
	end


/* ** Copiar ** */
if @t_trn = 15106
begin
	/* chequeo de claves foraneas */
	select @w_creador = fu_funcionario
	  from cl_funcionario
	  where fu_login = @s_user
	if @@rowcount = 0
	begin
		/*  'No existe funcionario' */
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 101036
		return 1
	  end

	if not exists (
		select ro_rol   
		  from ad_rol   
		  where ro_rol = @i_rol)
	begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 151026
		   /*  'No existe rol'*/
		return 1
	end

	if not exists (
	 	select pr_rol   
	 	  from ad_pro_rol
	 	  where pr_rol = @i_rol)
	begin
	 	exec sp_cerror
	 	   @t_debug      = @t_debug,
	 	   @t_file       = @t_file,
	 	   @t_from       = @w_sp_name,
	 	   @i_num        = 151031
	 	   /*  'No existe producto asociado'*/
	 	return 1
	end

	--FLO
	if(@i_copiar_trn_aut = 'S') /* ECA: No verificar transacciones autorizadas si @i_copiar_trn_aut es igual a 'N'*/
    begin
	    if not exists (
	    	select ta_rol   
	    	  from ad_tr_autorizada
	    	  where ta_rol = @i_rol)
	    begin
	    	exec sp_cerror
	    	   @t_debug      = @t_debug,
	    	   @t_file       = @t_file,
	    	   @t_from       = @w_sp_name,
	    	   @i_num        = 151033
	    	   /*  'No existe transaccion autorizada asociada'*/
	    	return 1
	    end
	end
	
	if  exists (
		select ro_descripcion
		  from ad_rol
		  where ro_descripcion = @i_descripcion)
	begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 151075
		   /*  Ya existe descripcion de rol */
		return 1
	end


  begin tran
	if @i_secuencial  is NULL
        begin
	           exec @w_return = sp_cseqnos @i_tabla = 'ad_rol',
				    @o_siguiente = @w_siguiente out
		if @w_return != 0
			return @w_return

		select @i_secuencial = @w_siguiente 
        end
	else
		select @w_siguiente = @i_secuencial

	/*  Copiando el rol  */
	insert into ad_rol
		(ro_rol, ro_filial, ro_descripcion, ro_fecha_crea,
		 ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	select  @w_siguiente, ro_filial, @i_descripcion, @s_date,
		@w_creador, "V", @s_date, ro_time_out
	from ad_rol 
	where ro_rol = @i_rol
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
	/*  Copiando los productos asociados al rol  */
	if exists (select 1 from ad_pro_rol where pr_rol = @w_siguiente)
		delete from ad_pro_rol where pr_rol = @w_siguiente
	insert into ad_pro_rol 
		(pr_rol, pr_producto, pr_tipo, pr_moneda, pr_fecha_crea,
		 pr_autorizante, pr_estado, pr_fecha_ult_mod, 
		 pr_menu_inicial)
	select   @w_siguiente, pr_producto, pr_tipo, pr_moneda, @s_date,
		 @w_creador, "V", @s_date,
		 pr_menu_inicial
	from ad_pro_rol 
	where pr_rol = @i_rol
	if @@error != 0
	begin
	    exec sp_cerror
	       @t_debug       = @t_debug,
	       @t_file        = @t_file,
	       @t_from        = @w_sp_name,
	       @i_num         = 153008
	       /*  'Error en insercion de rol' */
	    return 1
	end
	/*  Copiando transacciones autorizadas  */
	--FLO
	if(@i_copiar_trn_aut = 'S')  /* ECA: No copiar transacciones autorizadas si @i_copiar_trn_aut es igual a 'N' */
   begin
		if exists (select 1 from ad_tr_autorizada where ta_rol = @w_siguiente)
			delete from ad_tr_autorizada where ta_rol = @w_siguiente   
		insert into ad_tr_autorizada
			(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
			 ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
		select   ta_producto, ta_tipo, ta_moneda, ta_transaccion, @w_siguiente,
			 @s_date, @w_creador, "V", @s_date
		from ad_tr_autorizada 
		where ta_rol = @i_rol
		if @@error != 0
		begin
		    exec sp_cerror
		       @t_debug       = @t_debug,
		       @t_file        = @t_file,
		       @t_from        = @w_sp_name,
		       @i_num         = 153010
		       /*  'Error en insercion de transacciones autorizadas' */
		    return 1
		end
    end
	/*  Copiando autorizacion de componentes  */ 
	if exists (select 1 from an_role_component where rc_rol = @w_siguiente)
			delete from an_role_component where rc_rol = @w_siguiente   
		insert into an_role_component
			(rc_co_id, rc_rol)
		select   rc_co_id, @w_siguiente
		from an_role_component 
		where rc_rol = @i_rol
		if @@error != 0
		begin
		    exec sp_cerror
		       @t_debug       = @t_debug,
		       @t_file        = @t_file,
		       @t_from        = @w_sp_name,
		       @i_num         = 157230
		       /*  'Error en autorizacion de componentes' */
		    return 1
	end
	/*  Copiando autorizacion de modulos  */
	if exists (select 1 from an_role_module where rm_rol = @w_siguiente)
			delete from an_role_module where rm_rol = @w_siguiente   
		insert into an_role_module
			(rm_mo_id, rm_rol)
		select   rm_mo_id, @w_siguiente
		from an_role_module 
		where rm_rol = @i_rol
		if @@error != 0
		begin
		    exec sp_cerror
		       @t_debug       = @t_debug,
		       @t_file        = @t_file,
		       @t_from        = @w_sp_name,
		       @i_num         = 157231
		       /*  'Error en autorizacion de modulos' */
		    return 1
	end
	/*  Copiando autorizacion de pages  */
	if exists (select 1 from an_role_page where rp_rol = @w_siguiente)
			delete from an_role_page where rp_rol = @w_siguiente   
		insert into an_role_page
			(rp_pa_id, rp_rol)
		select   rp_pa_id, @w_siguiente
		from an_role_page 
		where rp_rol = @i_rol
		if @@error != 0
		begin
		    exec sp_cerror
		       @t_debug       = @t_debug,
		       @t_file        = @t_file,
		       @t_from        = @w_sp_name,
		       @i_num         = 157232
		       /*  'Error en autorizacion de paginas' */
		    return 1
	end
	/*  Copiando autorizacion de agentes  */
	if exists (select 1 from an_role_agent where ra_rol = @w_siguiente)
			delete from an_role_agent where ra_rol = @w_siguiente   
		insert into an_role_agent
			(ra_ag_id, ra_rol, ra_order)
		select   ra_ag_id, @w_siguiente, ra_order
		from an_role_agent 
		where ra_rol = @i_rol
		if @@error != 0
		begin
		    exec sp_cerror
		       @t_debug       = @t_debug,
		       @t_file        = @t_file,
		       @t_from        = @w_sp_name,
		       @i_num         = 157927
		       /*  'Error al procesar las autorizaciones de Agentes al Rol' */
		    return 1
	end
	/*  Copiando autorizacion de zona de navegacion  */
	if exists (select 1 from an_role_navigation_zone where rn_rol = @w_siguiente)
			delete from an_role_navigation_zone where rn_rol = @w_siguiente   
		insert into an_role_navigation_zone
			(rn_rol, rn_nz_id)
		select   @w_siguiente, rn_nz_id
		from an_role_navigation_zone 
		where rn_rol = @i_rol
		if @@error != 0
		begin
		    exec sp_cerror
		       @t_debug       = @t_debug,
		       @t_file        = @t_file,
		       @t_from        = @w_sp_name,
		       @i_num         = 157233
		       /*  'Error en autorizacion de zonas de navegacion' */
		    return 1
	end
  commit tran
  
  -- select @w_siguiente

   exec REENTRY...rp_gen_rol 
   select @w_comando = @s_lsrv +'...rp_load_rol'
   exec @w_comando
   
   exec REENTRY...rp_gen_rolspro
   select @w_comando = @s_lsrv +'...rp_load_rolspro'
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
					@s_user        = @s_user,             
					@t_trn         = @t_trn,           
					@i_rol         = @i_rol,       
					@i_creador     = @w_creador,       
					@i_descripcion = @i_descripcion,
					@i_secuencial  = @i_secuencial,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave_re out

			if @w_return <> 0
				return @w_return

			exec @w_return = cobis..sp_reentry
				@i_key = @w_clave_re,
				@i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
  /******************************* Para   Unix  **************************/

    select @w_siguiente
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
go
