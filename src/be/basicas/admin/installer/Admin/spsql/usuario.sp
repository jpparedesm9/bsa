/************************************************************************/
/*      Archivo:                usuario.sp                              */
/*      Stored procedure:       sp_usuario                              */
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
/*      Insercion de usuarios                                           */
/*      Actualizacion del usuario                                       */
/*      Borrado del usuario                                             */
/*      Busqueda del usuario                                            */
/*      Query del usuario                                               */
/*      Ayuda del usuario                                               */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      25/Nov/1992     L. Carvajal     Emision inicial                 */
/*      07/Jun/1993     M. Davila       Search sin error                */
/*      15/Dic/1993     P. Martinez     Logins al transrv               */
/*      22/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*	16/Nov/00	A.Rodríguez	Control de tamaño del Passwd	*/
/*					Control de repet. del Passwd	*/
/*	18/Ene/01	A.Rodríguez	Nuevo esquema de encriptacion	*/
/*					de passwods COBIS		*/
/*	25/Ago/04	A.Duque		Validación de histórico de clave*/
/*					desde Branch sin NCS		*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_usuario')
   drop proc sp_usuario
go

create proc sp_usuario (
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
	@t_offset		varbinary(32) =NULL,	-- ARO:18/01/2001   CRYPWD
	@t_tampwd		int =NULL,		-- ARO:18/01/2001   CRYPWD
	@t_ejec			char(1) = NULL,		-- ADU:2003-01-02   Reejecución del password
	@i_operacion            char(1),
	@i_tipo                 char(1) = null,
	@i_modo                 smallint = null,
	@i_filial               tinyint = null,
	@i_oficina              smallint = null,
	@i_nodo                 tinyint = null,
	@i_login                varchar(30) = NULL,
	@i_creador              smallint = NULL,
	@i_clave                varchar(30) = NULL,
	@i_fecha_asig           datetime = NULL,
        @i_estado               varchar(1) = 'V',
	@i_funcionario          smallint = NULL, /* PES 1999/09/02 */
	@i_flag			char(1) = 'S',	 /* PES 2000/06/06 */
        @i_central_transmit     varchar(1) = null,
	@i_formato_fecha	int=null
)
as
declare
	@w_sp_name              varchar(32),
	@w_today                datetime,
	@w_fecha_asig           datetime,
	@w_filial               tinyint,
	@w_oficina              smallint,
	@w_nodo                 tinyint,
	@w_creador              smallint,
	@w_login                varchar(24),
	@w_clave                varchar(30),
	@v_fecha_asig           datetime,
	@v_filial               tinyint,
	@v_oficina              smallint,
	@v_nodo                 tinyint,
	@v_creador              smallint,
	@v_login                varchar(24),
	@v_clave                varchar(30),
	@o_fecha_asig           datetime,
	@o_funcionario          smallint, /* PES 1999/09/02 */
	@o_nombre_fun           descripcion,
	@o_filial               tinyint,
	@o_oficina              smallint,
	@o_nodo                 tinyint,
	@o_nombre_f             descripcion,
	@o_nombre_o             descripcion,
	@o_nombre_n             descripcion,
	@o_creador              smallint,
	@o_login                varchar(24),
	@o_clave                varchar(30),
	@w_siguiente            int,
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_crea          descripcion,
	@o_estado		varchar(1),
	@w_return               int,
	@w_cmdtransrv           varchar(64),
        @w_clave_re             int,
        @w_nt_nombre            varchar(32),
        @w_num_nodos            smallint,
        @w_contador             smallint,
        @w_tp			tinyint,
        @w_tmp			tinyint,
        @w_npch			tinyint,
        @w_clave_his		varchar(30),
	@w_offset_his		varbinary(32),	-- ARO:19/01/2001
        @w_contador_his		int,
        @w_sec_his		int,
        @w_pwd			char(1)		-- ADU:25-08-2004

select @w_today = @s_date
select @w_sp_name = 'sp_usuario'


if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' or @i_operacion = 'U2' ) and (@i_central_transmit is NULL)
begin
    create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char(1) )
end
/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 567
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_creador is NULL OR @i_login is NULL)
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
	select nl_nodo
	  from ad_nodo_oficina
	  where nl_nodo = @i_nodo
	    and nl_filial = @i_filial
	    and nl_oficina = @i_oficina
 	    and nl_fecha_habil is not NULL) 
--	    and nl_fecha_habil != NULL) /* RLA 24/Feb/2000 */
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151002
	   /*  'No existe nodo oficina habilitado' */
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
	   /*  'No existe funcionario ' */
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
 
  if  exists (
	select us_login       
	  from ad_usuario     
	  where us_filial      = @i_filial   
            and us_oficina     = @i_oficina
            and us_nodo        = @i_nodo
	    and us_login       = @i_login ) 
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151061
	   /*  'Usuario ya tiene login en ese nodo' */
	return 1
  end
 
  begin tran
	insert into ad_usuario (us_filial, us_oficina, us_nodo,
				us_fecha_asig, us_creador, us_login, 
				us_estado, us_fecha_ult_mod)
		     values    (@i_filial, @i_oficina, @i_nodo,
				@i_fecha_asig, @i_creador, @i_login,
				'V', @w_today)
  if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153004
	   /*  'Error en insercion de usuario' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_usuario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   filial, oficina, nodo, login, fecha_asig, creador,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 567, 'N', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   @i_filial, @i_oficina, @i_nodo, @i_login,
			   @i_fecha_asig, @i_creador, 'V', @w_today)
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

  select @i_clave = fu_clave
    from cl_funcionario
   where fu_login = @i_login

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
					@s_user        = @s_user,           
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_filial      = @i_filial,
					@i_oficina     = @i_oficina,
					@i_nodo        = @i_nodo,
					@i_login       = @i_login,
					@i_creador     = @i_creador,
					@i_clave       = @i_clave,
					@i_estado      = @i_estado,     
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
if @t_trn = 568
begin
  if @i_flag = 'N'
  begin
   /* chequeo de claves foraneas */
    if (@i_filial = NULL OR @i_oficina = NULL OR @i_nodo = NULL
      OR @i_login = NULL)
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
     end

    select  @w_fecha_asig = us_fecha_asig,
	    @w_creador = us_creador,
	    @w_clave = fu_clave,
  	    @w_fecha_ult_mod = us_fecha_ult_mod
      from ad_usuario, cl_funcionario
     where us_nodo = @i_nodo
       and us_filial = @i_filial
       and us_oficina = @i_oficina
       and us_login = @i_login
       and fu_login = us_login

    if @@rowcount = 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151005
	   /*  'No existe usuario'*/
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




    /*** verificacion de campos a actualizar ***/
    select @v_fecha_asig = @w_fecha_asig,
	   @v_creador = @w_creador,
 	   @v_fecha_ult_mod = @w_fecha_ult_mod

    if @w_fecha_asig = @i_fecha_asig
     select @w_fecha_asig = null, @v_fecha_asig = null
    else
     select @w_fecha_asig = @i_fecha_asig

    if @w_creador = @i_creador
     select @w_creador = null, @v_creador = null
    else
     select @w_creador = @i_creador

    if @w_clave = @i_clave
     select @w_clave = null, @v_clave = null
    else
     select @w_clave = @i_clave


    begin tran
     Update ad_usuario
        set 
	    us_fecha_asig = @i_fecha_asig,
  	    us_creador = @i_creador,
	    us_fecha_ult_mod = @w_today,
	    us_estado = @i_estado
      where us_nodo = @i_nodo
        and us_filial = @i_filial
        and us_oficina = @i_oficina
        and us_login = @i_login

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155005
	   /*  'Error en actualizacion de usuario' */
	return 1
    end

   /* transaccion de servicio */
   insert into ts_usuario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   filial, oficina, nodo, login, fecha_asig, creador,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 568, 'P', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   @i_filial, @i_oficina, @i_nodo, @i_login,
			   @v_fecha_asig, @v_creador, null,
			   @v_fecha_ult_mod)
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

   /* transaccion de servicio */
   insert into ts_usuario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   filial, oficina, nodo, login, fecha_asig, creador,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 568, 'A', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   @i_filial, @i_oficina, @i_nodo, @i_login,
			   @w_fecha_asig, @w_creador, null,
			   @w_today)
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
  end	/*flag N*/

  /*Si es actualizacion de clave*/
  if @i_flag = 'S'
  begin


    /*** Chequeo de longitud minima de Password ***/
     /*** ARO: 15 de Noviembre ***/
     
     
     select @w_tmp=isnull(pa_tinyint,0)
     from cl_parametro
     where pa_producto='ADM' and
     pa_nemonico='TMP'
     
     if @@rowcount=0
     begin
       exec sp_cerror
    		@t_debug        = @t_debug,
    		@t_file         = @t_file,
    		@t_from         = @w_sp_name,
    		@i_num          = 151122
    	  /*   No existe Parámetro General  */
       return 1 
     end
     

     --ADU: 2004-08-25
     select @w_tp=isnull(@t_tampwd,0), @w_pwd='O'    
     
     if @w_tp=0 and isnull(datalength(@i_clave),0)>0
     	select @w_tp=isnull(datalength(@i_clave),0), @w_pwd='C'
     
     if @w_tp<@w_tmp 
     begin
        exec sp_cerror
    		@t_debug        = @t_debug,
    		@t_file         = @t_file,
    		@t_from         = @w_sp_name,
    		@i_num          = 151123

    	print "Longitud  minima del Password es " + convert(varchar(5),@w_tmp) + " caracteres"
    	
    	  /*   Longitud de Password incorrecta */
       return 1 
     end
    
    /**** FIN ARO ****/

    /*** Control  de Repeticion Historica de Passwords ***/
    /*** ARO: 16 de Noviembre ***/
    
     select @w_npch=isnull(pa_tinyint,0)
     from cl_parametro
     where pa_producto='ADM' and
     pa_nemonico='NPCH'
     
     if @@rowcount=0
     begin
       exec sp_cerror
    		@t_debug        = @t_debug,
    		@t_file         = @t_file,
    		@t_from         = @w_sp_name,
    		@i_num          = 151124
    	  /*   No existe Parámetro General  */
       return 1 
     end
     
     declare CUR_CLAVES cursor for
     select ch_clave,		--ADU: 2004-08-25
            ch_offset
     from cl_clave_his
     where ch_login=@i_login
     order by ch_secuencial desc
     
     open CUR_CLAVES
     
     select @w_contador_his=0
     fetch CUR_CLAVES into @w_clave_his,@w_offset_his		--ADU: 2004-08-25
     
     while (@@fetch_status != -1) and (@w_contador_his < @w_npch)
     begin
     	if (@w_clave_his=@i_clave and @w_pwd='C') or (@w_offset_his=@t_offset and @w_pwd='O')	--ADU: 2004-08-25
     	begin
       		exec sp_cerror
    		@t_debug        = @t_debug,
    		@t_file         = @t_file,
    		@t_from         = @w_sp_name,
    		@i_num          = 151125
    	  	/*   No existe Parámetro General  */
       		return 1      	
     	end
	select @w_contador_his=@w_contador_his+1
	fetch CUR_CLAVES into @w_clave_his, @w_offset_his		-- ARO:19/01/2001  CRYPWD
     end
     close CUR_CLAVES
     deallocate CUR_CLAVES
    
    /***** FIN ARO ****/


/**** ARO:19/01/2001 CRYPWD ***/
/*** ?????
   if isnull(@i_clave,"") != ""
   begin
    update cl_funcionario
       set fu_clave = @i_clave
     where fu_login= @i_login
***/
   if @w_tp<>0 
   begin
    update cl_funcionario
       set fu_clave  = @i_clave,
       	   fu_offset = @t_offset
     where fu_login= @i_login

/** FIN ARO CRYPWD ***/
   
    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155005
	   /*  'Error en actualizacion de usuario' */
	return 1
    end

    update ad_usuario
       set us_fecha_ult_mod = @s_date
    where  us_login = @i_login

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155005
	   /*  'Error en actualizacion de usuario' */
	return 1
    end

    /**** ARO: 16 de Noviembre del 2000 ***/
    /*** Control Historico de Passwords (evitar repeticiones) ****/

    select @w_sec_his=isnull(max(ch_secuencial),0)+1
    from cl_clave_his
    where ch_login=@i_login
    
    insert into cl_clave_his (
    	ch_login,
    	ch_secuencial,
    	ch_fecha,
    	ch_clave,
	ch_offset)
    values (
    	@i_login,
    	@w_sec_his,
    	getdate(),
    	@i_clave,
	@t_offset)

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 153051
	   /*  'Error en insercion en CL_CLAVE_HIS' */
	return 1
    end

    /***** FIN ARO ******/

   end
  end	/*fin flag S*/

  commit tran

  /*Si es cambio de password */
  if @i_flag = 'S'
  begin
    /* Generacion del comando al transrv */
    select @w_cmdtransrv = @s_lsrv +'...sp_droplogin'
    exec @w_cmdtransrv
	 @loginame = @i_login
    select @w_cmdtransrv = @s_lsrv +'...sp_addlogin'
    exec @w_cmdtransrv
	 @loginame = @i_login,
	 @passwd   = @i_clave
  end

  select @i_clave = fu_clave
    from cl_funcionario
   where fu_login = @i_login

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
					@s_user        = @s_user,           
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_filial      = @i_filial,
					@i_oficina     = @i_oficina,
					@i_nodo        = @i_nodo,
					@i_login       = @i_login,
					@i_creador     = @i_creador,
					@i_clave       = @i_clave,
					@i_estado      = @i_estado,     
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
if @t_trn = 569
begin
 /* chequeo de claves foraneas */
  if (@i_filial = NULL OR @i_oficina = NULL OR @i_nodo = NULL
      OR @i_login = NULL)
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
   end
  select  @w_fecha_asig = us_fecha_asig,
	  @w_creador = us_creador,
	  @w_fecha_ult_mod = us_fecha_ult_mod
    from ad_usuario, cl_funcionario
   where us_nodo    = @i_nodo
     and us_filial  = @i_filial
     and us_oficina = @i_oficina
     and us_login   = @i_login
     and fu_login   = us_login
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151005
	   /*  'No existe usuario' */
	return 1
  end

  /* borrado de usuario */
  begin tran
   Delete ad_usuario
    where us_nodo = @i_nodo
      and us_filial = @i_filial
      and us_oficina = @i_oficina
      and us_login = @i_login
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157013
	   /*  'Error en eliminacion de usuario ' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_usuario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   filial, oficina, nodo, login, fecha_asig, creador,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 569, 'B', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
			   @i_filial, @i_oficina, @i_nodo, @i_login,
			   @w_fecha_asig, @w_creador, 'V',
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
					@s_user        = @s_user,           
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_filial      = @i_filial,
					@i_oficina     = @i_oficina,
					@i_nodo        = @i_nodo,
					@i_login       = @i_login,
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
If @t_trn = 15078
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select  'Cod. Filial' = us_filial,
		'Filial' = fi_abreviatura,
		'Cod. Oficina' = us_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. Nodo' = us_nodo,
		'Nodo' = substring(nl_nombre, 1, 20),
		'Login' = us_login,
		'Creador' = us_creador,
		'Nombre Creador' = fu_nombre
	 from   ad_usuario, cl_filial, cl_oficina, ad_nodo_oficina,
		cl_funcionario
	where   us_filial  = fi_filial
	  and   us_creador = fu_funcionario
	  and   us_oficina = of_oficina
	  and   us_nodo    = nl_nodo
	  and   us_filial = nl_filial
	  and   us_oficina = nl_oficina
	order   by us_filial, us_oficina, us_nodo, us_login
       set rowcount 0
     end
     if @i_modo = 1
     begin
	select  'Cod. Filial' = us_filial,
		'Filial' = fi_abreviatura,
		'Cod. Oficina' = us_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. Nodo' = us_nodo,
		'Nodo' = substring(nl_nombre, 1, 20),
		'Login' = us_login,
		'Creador' = us_creador,
		'Nombre creador' = fu_nombre
	 from   ad_usuario, cl_filial, cl_oficina, ad_nodo_oficina,
		cl_funcionario
	where   us_filial  = fi_filial
	  and   us_creador = fu_funcionario
	  and   us_oficina = of_oficina
	  and   us_nodo    = nl_nodo
	  and   us_filial  = nl_filial
	  and   us_oficina = nl_oficina
	  and  ( 
		(us_filial > @i_filial)
	  or    ((us_filial = @i_filial) and (us_oficina > @i_oficina))
	  or    ((us_filial = @i_filial) and (us_oficina = @i_oficina)
		and (us_nodo > @i_nodo))
	  or    ((us_filial = @i_filial) and (us_oficina = @i_oficina)
		and (us_nodo = @i_nodo) and (us_login > @i_login))
	       )
	order   by us_filial, us_oficina, us_nodo, us_login
       set rowcount 0
     end
     if @i_modo = 2
     begin
	select 'C.F.' = us_filial,
	       'Filial' = substring(fi_nombre,1,20),
	       'C.O.' = us_oficina,
	       'Oficina' = substring(of_nombre,1,20),
	       'C.N.' = us_nodo,
	       'Nodo' = substring(nl_nombre,1,20)
	  from ad_usuario, cl_filial, cl_oficina, ad_nodo_oficina
	 where us_login = @i_login
	   and us_filial = fi_filial
	   and us_oficina = of_oficina
	   and us_nodo = nl_nodo
           and nl_oficina = us_oficina

       set rowcount 0
     end
     if @i_modo = 3
     begin
	select 'C.F.' = us_filial,
	       'Filial' = substring(fi_nombre,1,20),
	       'C.O.' = us_oficina,
	       'Oficina' = substring(of_nombre,1,20),
	       'C.N.' = us_nodo,
	       'Nodo' = substring(nl_nombre,1,20)
	  from ad_usuario, cl_filial, cl_oficina, ad_nodo_oficina
	 where us_login = @i_login
	   and us_filial = fi_filial
	   and us_oficina = of_oficina
	   and us_nodo = nl_nodo
           and nl_oficina = us_oficina
	   and (
		(us_filial > @i_filial)
	    or ((us_filial = @i_filial) and (us_oficina > @i_oficina))
	    or ((us_filial = @i_filial) and (us_oficina > @i_oficina)
		and (us_nodo > @i_nodo))
	       )

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


/* ** Password ** */
if @i_operacion = 'P'
begin
If @t_trn = 15103
begin
	select  fu_clave
	 from   ad_usuario, cl_funcionario
	where   us_filial = @i_filial
	  and   us_oficina = @i_oficina
	--and   us_nodo = @i_nodo
	  and   us_login = @i_login
	  and   fu_login = us_login

	if @@rowcount = 0
	begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151005
	   /*  'No existe Usuario' */
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


/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15079
begin
	select  @o_nombre_f = fi_nombre,
		@o_nombre_o = of_nombre,
		@o_nombre_n = nl_nombre,
		@o_creador = us_creador,
		@o_fecha_asig = us_fecha_asig,
		@o_estado = us_estado
	 from   ad_usuario, cl_filial, cl_oficina, ad_nodo_oficina
	where   us_filial = fi_filial 
	  and   us_oficina = of_oficina
	  and   us_nodo = nl_nodo
	  and   us_filial = nl_filial
	  and   us_oficina = nl_oficina
	  and   us_filial = @i_filial
	  and   us_oficina = @i_oficina
	  and   us_nodo = @i_nodo
	  and   us_login = @i_login
	if @@rowcount = 0
	begin
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151005
	   /*  'No existe Usuario' */
	 return 1
       end

       select  @o_nombre_crea = fu_nombre               
	  from cl_funcionario
	 where fu_funcionario = @o_creador
	 if @@rowcount = 0
	 begin
	   exec sp_cerror
	     @t_debug     = @t_debug,
	     @t_file      = @t_file,
	     @t_from      = @w_sp_name,
	     @i_num       = 101036
	     /* 'No existe funcionario' */
	 end

	   select  @o_nombre_fun = fu_nombre,
		@o_funcionario = fu_funcionario
	  from cl_funcionario
	 where fu_login = @i_login
	 if @@rowcount = 0
	 begin
	   exec sp_cerror
	     @t_debug     = @t_debug,
	     @t_file      = @t_file,
	     @t_from      = @w_sp_name,
	     @i_num       = 101036
	     /* 'No existe funcionario' */
	 end

       select @i_filial, @o_nombre_f, @i_oficina, @o_nombre_o, @i_nodo,
	      @o_nombre_n,  @o_funcionario, @o_nombre_fun, @i_login, 
	      @o_creador, @o_nombre_crea,
	      convert(char(10), @o_fecha_asig, @i_formato_fecha), @o_estado
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
If @t_trn = 15080
begin
 if @i_tipo = 'A'
 begin
	 select   'Login' = substring(us_login,1,20),
		  'Nombre' = substring(fu_nombre,1,30)
	   from   ad_usuario, cl_funcionario
	  where   us_filial = @i_filial
	    and   us_oficina = @i_oficina
	    and   us_nodo   = @i_nodo
	    and   fu_login = us_login
	   order  by us_login
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

/* ** help  funcionario** */
if @i_operacion = 'F'
begin
If @t_trn = 15093
begin
 if @i_tipo = 'A'
 begin
    set rowcount 20
    if @i_modo = 0
    begin
	 select   'Codigo' = fu_funcionario,
		  'Nombre'  = fu_nombre,
		  'Login'  = fu_login
	   from   cl_funcionario
	   order  by fu_funcionario
    end

    if @i_modo = 1
    begin
	 select   'Codigo' = fu_funcionario,
		  'Nombre'  = fu_nombre,
		  'Login'  = fu_login
	   from   cl_funcionario
	   where  fu_funcionario > @i_funcionario
	   order  by fu_funcionario
    end
    set rowcount 0
 end

 if @i_tipo = 'V'
 begin
	 select   fu_nombre, fu_login
	   from   cl_funcionario
	  where   fu_funcionario = @i_funcionario
	if @@rowcount = 0
 	begin
   		exec sp_cerror
     		@t_debug     = @t_debug,
     		@t_file      = @t_file,
     		@t_from      = @w_sp_name,
     		@i_num       = 101036
     		/* 'No existe funcionario' */
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

if @i_operacion = 'G'
begin
if @t_trn = 15099
begin
	 select   nl_nombre
	   from   ad_usuario, ad_nodo_oficina
	  where   us_login = @i_login
	   and    us_filial = nl_filial
	   and    us_oficina = nl_oficina
	   and    us_nodo = nl_nodo
	   order  by nl_nombre
	 if @@rowcount = 0
	 begin
		exec sp_cerror
		   @t_debug      = @t_debug,
		   @t_file       = @t_file,
		   @t_from       = @w_sp_name,
		   @i_num        = 151005
		   /*  'No existe usuario' */
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
