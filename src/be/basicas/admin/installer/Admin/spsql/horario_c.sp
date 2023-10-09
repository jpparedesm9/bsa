/************************************************************************/
/*      Archivo:                comphora.sp                             */
/*      Stored procedure:       sp_horario_c                            */
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
/*      Insercion de horario                                            */
/*      Actualizacion del horario                                       */
/*      Borrado del horario                                             */
/*      Busqueda del horario                                            */
/*      Query del horario                                               */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      09/Feb/1994     F.Espinosa      Emision inicial                 */
/*      20/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      04/May/95       S. Vinces       Admin Distribuido               */
/*      18/Abr/2016     BBO             Migracion SYB-SQL FAL           */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_horario_c')
   drop proc sp_horario_c
go

create proc sp_horario_c (
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
	@i_tipo                 varchar(1) = null,
	@i_modo                 smallint = NULL,
	@i_tipoh                tinyint = NULL,
	@i_secuencial           tinyint = NULL,
	@i_dia                  varchar(2) = NULL,
	@i_hr_inicio            varchar(8) = NULL,		--ADU:2004-02-02
	@i_hr_fin               varchar(8) = NULL,		--ADU:2004-02-02
	@i_creador              smallint = NULL,
	@i_borrar               varchar(1) = "S",
	@i_central_transmit     varchar(1) = null,
	@i_formato_fecha	int=null
)
as
declare
	@w_today                datetime,
	@w_sp_name              varchar(32),
	@w_tipoh                tinyint,
	@w_secuencial           tinyint,
	@w_ult_secuencial       tinyint,
	@w_dia                  char(2),
	@w_hr_inicio            datetime,
	@w_hr_fin               datetime,
	@w_fecha_crea           datetime,
	@w_creador              smallint,
	@v_tipo                 tinyint,
	@v_secuencial           tinyint,
	@v_dia                  char(2),
	@v_hr_inicio            datetime,
	@v_hr_fin               datetime,
	@v_fecha_crea           datetime,
	@v_creador              smallint,
	@w_siguiente            int,
	@o_dia                  char(2),
	@o_des_dia              varchar(32),    
	@o_hr_inicio            varchar(12),
	@o_hr_fin               varchar(12),
	@o_fecha_crea           datetime,
	@o_creador              smallint,
	@o_secuencial           tinyint,        
	@w_fecha_ult_mod        datetime,
	@v_fecha_ult_mod        datetime,
	@o_nombre_crea          descripcion,
	@w_comando              descripcion,
	@w_return		int,
        @w_cmdtransrv           varchar(64),
	@w_nt_nombre        	varchar(32),
	@w_num_nodos        	smallint,    
	@w_contador          	smallint,
	@w_clave		int 

select @w_today = @s_date
select @w_sp_name = 'sp_horario_c'

/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char (1))
end

/* ** Insert ** */
if @i_operacion = 'I' 
begin
if @t_trn = 507
begin
 /* chequeo de claves foraneas */
  if (@i_tipoh is NULL OR @i_dia is NULL OR  @i_hr_inicio is NULL 
     OR @i_hr_fin is NULL OR @i_creador is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
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

 
 if not exists(
   select th_tipo 
     from ad_tipo_horario
    where th_tipo = @i_tipoh
      and th_estado = 'V')
  begin
/*  'No existe tipo horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151047
	return 1
  end
  
  begin tran
   if @i_secuencial is NULL
    begin
      select @w_ult_secuencial = th_ult_secuencial + 1
	from ad_tipo_horario
       where th_tipo = @i_tipoh
      select @i_secuencial = @w_ult_secuencial
     end
    else
         select @w_ult_secuencial = @i_secuencial

    update ad_tipo_horario
	set th_ult_secuencial = @w_ult_secuencial
	where th_tipo = @i_tipoh
    insert into ad_horario (ho_tipo_horario, ho_secuencial, ho_dia,
			    ho_hr_inicio, ho_hr_fin,
			    ho_fecha_crea, ho_creador, ho_estado,
			    ho_fecha_ult_mod)
		    values (@i_tipoh, @w_ult_secuencial, @i_dia,
			    convert(datetime,@i_hr_inicio), 
			    convert(datetime,@i_hr_fin),
			    @w_today, @i_creador, 'V', @w_today)
    if @@error != 0
    begin

/*  'Error en insercion de horario ' */
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
		 values ( @s_ssn, 507, 'N', @s_date,
			  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			  @i_tipoh, @w_ult_secuencial, @i_dia,
			  convert(datetime,@i_hr_inicio), 
			  convert(datetime,@i_hr_fin),
			  @w_today, @i_creador, 'V', @w_today)

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
  select @w_ult_secuencial 

  exec REENTRY...rp_gen_loghorol
        select @w_cmdtransrv = @s_lsrv +'...rp_load_loghorol'
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
					@i_tipoh       = @i_tipoh, 
					@i_secuencial  = @i_secuencial,
					@i_dia         = @i_dia,
					@i_hr_inicio   = @i_hr_inicio,
					@i_hr_fin      = @i_hr_fin,
					@i_creador     = @i_creador,
					@i_borrar      = @i_borrar,  
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
if @t_trn = 508
begin
 /* chequeo de claves foraneas */
  if (@i_tipoh is NULL OR @i_secuencial is NULL OR @i_dia is NULL OR
  @i_hr_inicio is NULL OR @i_hr_fin is NULL OR @i_creador is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
  end

  select  @w_dia = ho_dia,
	  @w_hr_inicio = ho_hr_inicio,
	  @w_hr_fin = ho_hr_fin,
	  @w_fecha_crea = ho_fecha_crea,
	  @w_creador = ho_creador,
	  @w_fecha_ult_mod = ho_fecha_ult_mod
     from ad_horario
    where ho_tipo_horario = @i_tipoh
      and ho_secuencial = @i_secuencial
      and ho_estado = 'V'
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
  select @v_dia = @w_dia,
	 @v_hr_inicio = @w_hr_inicio,
	 @v_hr_fin = @w_hr_fin,
	 @v_fecha_crea = @w_fecha_crea,
	 @v_creador = @w_creador,
	 @v_fecha_ult_mod = @w_fecha_ult_mod

  if @w_dia = @i_dia
   select @w_dia = null, @v_dia= null
  else
   select @w_dia = @i_dia

  if @w_hr_inicio = @i_hr_inicio
   select @w_hr_inicio = null, @v_hr_inicio = null
  else
   select @w_hr_inicio = @i_hr_inicio

  if @w_hr_fin = @i_hr_fin
   select @w_hr_fin = null, @v_hr_fin= null
  else
   select @w_hr_fin = @i_hr_fin

  if @w_creador = @i_creador
   select @w_creador = null, @v_creador = null
  else
   select @w_creador = @i_creador

  begin tran
   Update ad_horario
      set ho_dia = @i_dia,
	  ho_hr_inicio = convert(datetime,@i_hr_inicio),
	  ho_hr_fin = convert(datetime,@i_hr_fin),
	  ho_creador = @i_creador,
	  ho_fecha_ult_mod = @w_today
   where ho_tipo_horario = @i_tipoh
     and ho_secuencial = @i_secuencial
   if @@error != 0
   begin
/* 'Error en actualizacion de horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 155008
	return 1
    end

/* transaccion de servicio */
   insert into ts_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo_horario,secuencial, dia, hr_inicio,
			   hr_fin, fecha_crea, creador, estado,
			   fecha_ult_mod)
		   values (@s_ssn, 508, 'P', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			   @i_tipoh,@i_secuencial, @v_dia, 
			   @v_hr_inicio,@v_hr_fin, 
		 	   @v_fecha_crea, @v_creador, null,
			   @v_fecha_ult_mod)
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

   insert into ts_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo_horario,secuencial, dia, hr_inicio,
			   hr_fin, fecha_crea, creador, estado, fecha_ult_mod)
		   values (@s_ssn, 508, 'A', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			   @i_tipoh,@i_secuencial, @w_dia, 
			   @w_hr_inicio, @w_hr_fin, 
			   @w_fecha_crea, @w_creador, null, @w_today)
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

  /* Cambios para Admin Distribuido */
  /* Actualizar la informacion en el transrv */
  exec REENTRY...rp_gen_loghorol
  select @w_cmdtransrv = @s_lsrv +'...rp_load_loghorol'
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
					@i_tipoh       = @i_tipoh, 
					@i_secuencial  = @i_secuencial,
					@i_dia         = @i_dia,
					@i_hr_inicio   = @i_hr_inicio,
					@i_hr_fin      = @i_hr_fin,
					@i_creador     = @i_creador,
					@i_borrar      = @i_borrar,  
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
if @t_trn = 509
begin
 /* chequeo de claves foraneas */
  if (@i_tipoh is NULL OR @i_secuencial is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151001
	return 1
  end

  select  @w_dia = ho_dia,
	  @w_hr_inicio = ho_hr_inicio,
	  @w_hr_fin = ho_hr_fin,
	  @w_fecha_crea = ho_fecha_crea,
	  @w_creador = ho_creador,
	  @w_fecha_ult_mod = ho_fecha_ult_mod
     from ad_horario
    where ho_tipo_horario = @i_tipoh
      and ho_secuencial = @i_secuencial
      and ho_estado = 'V'
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


  /* borrado de horario */
   begin tran
    Delete ad_horario
     where ho_secuencial = @i_secuencial
       and ho_tipo_horario = @i_tipoh
    if @@error != 0
    begin
/*  'Error en eliminacion de horario' */
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 157017
	return 1
    end

  /* 'Transaccion de Servicion ' */ 
   insert into ts_horario (secuencia, tipo_transaccion, clase, fecha,
			   oficina_s, usuario, terminal_s, srv, lsrv,
			   tipo_horario, secuencial, dia, hr_inicio,
			   hr_fin, fecha_crea, creador, estado,
			   fecha_ult_mod)
		   values (@s_ssn, 509, 'B', @s_date,
			   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			   @i_tipoh, @i_secuencial, @w_dia, 
			   @w_hr_inicio, @w_hr_fin, 
			   @w_fecha_crea, @w_creador, 'V',
			   @w_fecha_ult_mod)
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
  
   	if @i_borrar = "S"
     	begin 
  	/* Cambios para Admin Distribuido */
  	/* Actualizar la informacion en el transrv */
  		exec REENTRY...rp_gen_loghorol
        	select @w_cmdtransrv = @s_lsrv +'...rp_load_loghorol'
         	exec @w_cmdtransrv
  	end   
 
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
					@i_tipoh       = @i_tipoh, 
					@i_secuencial  = @i_secuencial,
					@i_borrar      = @i_borrar,  
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
if @t_trn = 1585
begin
     set rowcount 20
     if @i_modo = 0
     begin
        select  'Secuencial'    = ho_secuencial,
                'Cod. Dia'      = ho_dia,
                'Dia'           = substring(valor,1,20),
                --INICIO
                -- JLO: 01/11/2001 Cambio que se realiza para que la hora se muestre como
                -- 00:00 y no como se muestra 0:0
                --'Hora inicio' =  str(datepart(hour, ho_hr_inicio),2) + ':'+
                --		 str(datepart(mi, ho_hr_inicio),2),
                --'Hora final' =   str(datepart(hour, ho_hr_fin),2) + ':' +
                --		 str(datepart(mi, ho_hr_fin),2),
                'Hora inicio'   =  convert(varchar(8),ho_hr_inicio, 108),
                'Hora final'    =  convert(varchar(8),ho_hr_fin, 108),
                --FIN
                'Creador' = ho_creador,
                'Nombre Creador' = fu_nombre
         --inicio mig syb-sql 18042016       
         from   ad_horario
                left outer join cl_funcionario on ho_creador = fu_funcionario
                inner join cl_tabla y on y.tabla = 'ad_dia_semana'           
                inner join cl_catalogo x on x.tabla = y.codigo
                                        and x.codigo = ho_dia
          where ho_tipo_horario = @i_tipoh      
           and  ho_estado       = 'V'
         order  by ho_dia,ho_hr_inicio   
         --fin mig syb-sql 18042016
         
          /********* MIGRACION SYB-SQL
         from   ad_horario, cl_funcionario, cl_catalogo x, cl_tabla y
        where   ho_creador *= fu_funcionario
           and  ho_tipo_horario = @i_tipoh      
           and  ho_estado = 'V'
           and  x.codigo = ho_dia
           and  y.tabla = 'ad_dia_semana'
           and  x.tabla = y.codigo
        order   by ho_dia,ho_hr_inicio
        *********/        
        
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
        select  'Secuencial'   = ho_secuencial,
                'Cod. Dia'      = ho_dia,
                'Dia'           = substring(valor,1,20),
                --INICIO
                -- JLO: 01/11/2001 Cambio que se realiza para que la hora se muestre como
                -- 00:00 y no como se muestra 0:0
                --'Hora inicio' =  str(datepart(hour, ho_hr_inicio),2) + ':'+
                --		 str(datepart(mi, ho_hr_inicio),2),
                --'Hora final' =   str(datepart(hour, ho_hr_fin),2) + ':' +
                --		 str(datepart(mi, ho_hr_fin),2),
                'Hora inicio' =  convert(varchar(5),ho_hr_inicio, 108),
                'Hora final' =   convert(varchar(5),ho_hr_fin, 108),		
                -- FIN
                'Creador' = ho_creador,
                'Nombre Creador' = fu_nombre
         --inicio mig syb-sql 18042016       
         from   ad_horario
                left outer join cl_funcionario on ho_creador = fu_funcionario
                inner join cl_tabla y on y.tabla = 'ad_dia_semana'           
                inner join cl_catalogo x on x.tabla = y.codigo
                                        and x.codigo = ho_dia
          where ho_tipo_horario = @i_tipoh      
           and  ho_estado       = 'V'
           and   ho_secuencial  > @i_secuencial
         order  by ho_dia,ho_hr_inicio   
         --fin mig syb-sql 18042016
        
        /******** MIGRACION SYB-SQL
         from   ad_horario, cl_funcionario, cl_catalogo x, cl_tabla y 
        where   ho_creador *= fu_funcionario
          and   ho_tipo_horario = @i_tipoh
          and   ho_estado = 'V'
          and   x.codigo = ho_dia
          and   y.tabla = 'ad_dia_semana'
          and   x.tabla = y.codigo
          and   ho_secuencial > @i_secuencial
        order   by ho_dia,ho_hr_inicio       
        *****/
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
if @t_trn = 1586
begin
	select  @o_secuencial = ho_secuencial,
            @o_dia = ho_dia,
            @o_des_dia = valor,
            --INICIO
            -- JLO: 01/11/2001 Cambio que se realiza para que la hora se muestre como
            -- 00:00 y no como se muestra 0:0
            --@o_hr_inicio =  str(datepart(hour, ho_hr_inicio),2) + ':'+
            --		 str(datepart(mi, ho_hr_inicio),2),
            --@o_hr_fin =   str(datepart(hour, ho_hr_fin),2) + ':' +
            --		 str(datepart(mi, ho_hr_fin),2),
            @o_hr_inicio =  convert(varchar(5),ho_hr_inicio, 108),
            @o_hr_fin =   convert(varchar(5),ho_hr_fin, 108),
            --FIN
            @o_creador = ho_creador,
            @o_nombre_crea = fu_nombre,
            @o_fecha_crea = ho_fecha_crea
     --inicio mig syb-sql 18042016       
     from   ad_horario
            left outer join cl_funcionario on ho_creador = fu_funcionario
            inner join cl_tabla y on y.tabla = 'ad_dia_semana'           
            inner join cl_catalogo x on x.tabla = y.codigo
                                    and x.codigo = ho_dia
      where ho_tipo_horario = @i_tipoh     
        and ho_secuencial = @i_secuencial
        and ho_estado = 'V'
      order by ho_dia,ho_hr_inicio   
     --fin mig syb-sql 18042016
        
      /****** MIGRACION SYB-SQL  
	 from   ad_horario, cl_funcionario, cl_catalogo x, cl_tabla y
	where   ho_tipo_horario = @i_tipoh
	  and   ho_secuencial = @i_secuencial
	  and   ho_creador *= fu_funcionario
	  and   ho_estado = 'V'
	  and   x.codigo = ho_dia
	  and   y.tabla = 'ad_dia_semana'
	  and   x.tabla = y.codigo
      ******/
      
	if @@rowcount = 0
	begin
/*  'No existe Horario' */
	 exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151006
	  return 1
	end
	select  @o_secuencial, @o_dia, @o_des_dia, @o_hr_inicio, @o_hr_fin,
	  @o_creador, @o_nombre_crea, convert(char(10), @o_fecha_crea, 111)
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

