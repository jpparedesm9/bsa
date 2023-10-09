/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_directa2')
   drop proc sp_directa2
go

create proc sp_directa2 (
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
	@i_modo 		smallint = null,
	@i_filial_d		tinyint = null,
	@i_oficina_d		smallint = null,
	@i_nodo_d		tinyint = null,
	@i_filial_h		tinyint = null,
	@i_oficina_h		smallint = null,
	@i_nodo_h		tinyint = null,
	@i_protocolo		char(1) = NULL,
	@i_tlink		char(1) = NULL,
	@i_link			tinyint = NULL,
	@i_secuencial		tinyint = NULL,
	@i_prioridad		char(1) = NULL,
	@i_half_full		char(1) = 'H'
)
as
declare
	@w_sp_name		varchar(32),
	@w_today		datetime,
	@w_nombre_f_d		descripcion,
	@w_nombre_o_d		descripcion,
	@w_nombre_n_d		descripcion,
	@w_nombre_f_h		descripcion,
	@w_nombre_o_h		descripcion,
	@w_nombre_n_h		descripcion,
	@w_protocolo		char(1),
	@w_tlink		char(1),
	@w_link			tinyint,
	@w_secuencial		tinyint,
	@w_prioridad		char(1),
	@v_protocolo		char(1),
	@v_tlink		char(1),
	@v_link			tinyint,
	@v_secuencial		tinyint,
	@v_prioridad		char(1),
	@o_siguiente		int,
	@o_nombre_f_d		descripcion,
	@o_nombre_o_d		descripcion,
	@o_nombre_n_d		descripcion,
	@o_nombre_f_h		descripcion,
	@o_nombre_o_h		descripcion,
	@o_nombre_n_h		descripcion,
	@o_protocolo		char(1),
	@o_tlink		char(1),
	@o_link			tinyint,
	@o_secuencial		tinyint,
	@o_prioridad		char(1),
	@v_fecha_ult_mod	datetime,
	@w_fecha_ult_mod	datetime,
	@o_nombre_pr		descripcion,
	@o_nombre_tl		descripcion,
	@w_return		int

select @w_today = @s_date
select @w_sp_name = 'sp_directa'

/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 544
begin
 /* chequeo de claves foraneas */
  if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
      OR @i_prioridad is NULL)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

  select  @w_protocolo = di_protocolo,
	  @w_tlink = di_tlink,
	  @w_link = di_link,
	  @w_secuencial = di_secuencial,
	  @w_prioridad = di_prioridad,
	  @v_fecha_ult_mod = di_fecha_ult_mod
    from ad_directa
   where di_oficina_d = @i_oficina_d
     and di_filial_d = @i_filial_d
     and di_nodo_d = @i_nodo_d
     and di_oficina_h = @i_oficina_h
     and di_filial_h = @i_filial_h
     and di_nodo_h = @i_nodo_h
     and di_subtipo = 'D'
     and di_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151018
	   /*  'No existe ruta directa' */
	return 1
  end

  if not exists (
	select xc_protocolo
	  from ad_x25_config
	 where xc_secuencial = @i_secuencial
	   and xc_tlink = @i_tlink
	   and xc_link = @i_link
	   and xc_protocolo = @i_protocolo
	   and xc_oficina = @i_oficina_d
	   and xc_filial = @i_filial_d
	   and xc_nodo = @i_nodo_d
	   and xc_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
	   /*  'No existe aplicacion' */
	return 1
  end

/*** verificacion de campos a actualizar ****/
  select @v_protocolo = @w_protocolo,
	 @v_tlink = @w_tlink,
	 @v_link = @w_link,
	 @v_secuencial = @w_secuencial,
	 @v_prioridad = @w_prioridad

  if @w_protocolo = @i_protocolo
   select @w_protocolo = null, @v_protocolo = null
  else
   select @w_protocolo = @i_protocolo

  if @w_tlink = @i_tlink
   select @w_tlink = null, @v_tlink = null
  else
   select @w_tlink = @i_tlink

  if @w_link = @i_link
   select @w_link = null, @v_link = null
  else
   select @w_link = @i_link

  if @w_secuencial = @i_secuencial
   select @w_secuencial = null, @v_secuencial = null
  else
   select @w_secuencial = @i_secuencial

  if @w_prioridad = @i_prioridad
   select @w_prioridad = null, @v_prioridad = null
  else
   select @w_prioridad = @i_prioridad

  begin tran
   Update ad_directa
      set di_protocolo = @i_protocolo,
	  di_tlink = @i_tlink,
	  di_link= @i_link,
	  di_secuencial = @i_secuencial,
	  di_prioridad = @i_prioridad,
	  di_fecha_ult_mod = @w_today
    where di_oficina_d = @i_oficina_d
      and di_filial_d = @i_filial_d
      and di_nodo_d = @i_nodo_d
      and di_oficina_h = @i_oficina_h
      and di_filial_h = @i_filial_h
      and di_nodo_h = @i_nodo_h
      and di_subtipo = 'D'
     if @@error != 0
     begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155015
	   /*  'Error en actualizacion de ruta directa' */
	return 1
     end

  /* transaccion de servicio */
   insert into ts_directa (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   filial_d, oficina_d, nodo_d, filial_h, oficina_h,
			   nodo_h, tlink, link, protocolo, secuencial,
			   prioridad, nombre_f_d, nombre_o_d,
			   nombre_n_d, nombre_f_h, nombre_o_h, nombre_n_h,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 544, 'P', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			   @i_filial_d, @i_oficina_d, @i_nodo_d,
			   @i_filial_h, @i_oficina_h, @i_nodo_h,
			   @v_tlink, @v_link, @v_protocolo,
			   @v_secuencial, @v_prioridad, null, null, null,
			   null, null, null, null, @v_fecha_ult_mod)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
        return 1
   end

   insert into ts_directa (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   filial_d, oficina_d, nodo_d, filial_h, oficina_h,
			   nodo_h, tlink, link, protocolo, secuencial,
			   prioridad, nombre_f_d, nombre_o_d,
			   nombre_n_d, nombre_f_h, nombre_o_h, nombre_n_h,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 544, 'A', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			   @i_filial_d, @i_oficina_d, @i_nodo_d,
			   @i_filial_h, @i_oficina_h, @i_nodo_h,
			   @w_tlink, @w_link, @w_protocolo,
			   @w_secuencial, @w_prioridad, null, null, null,
			   null, null, null, null, @w_today)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
        return 1
   end
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

/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 545
begin
 /* chequeo de claves foraneas */
  if (@i_filial_d is NULL  OR @i_oficina_d is NULL OR @i_nodo_d is NULL
      OR @i_filial_h is NULL  OR @i_oficina_h is NULL OR @i_nodo_h is NULL
     )
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
  select  @w_protocolo = di_protocolo,
	  @w_tlink = di_tlink,
	  @w_link = di_link,
	  @w_secuencial = di_secuencial,
	  @w_prioridad = di_prioridad,
	  @w_fecha_ult_mod = di_fecha_ult_mod
    from ad_directa
   where di_oficina_d = @i_oficina_d
     and di_filial_d = @i_filial_d
     and di_nodo_d = @i_nodo_d
     and di_oficina_h = @i_oficina_h
     and di_filial_h = @i_filial_h
     and di_nodo_h = @i_nodo_h
     and di_subtipo = 'D'
     and di_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151018
	   /*  'No existe ruta directa' */
	return 1
  end

  /* borrado de ruta directa */
  begin tran
    Delete ad_directa
     where di_oficina_d = @i_oficina_d
       and di_filial_d = @i_filial_d
       and di_nodo_d = @i_nodo_d
       and di_oficina_h = @i_oficina_h
       and di_filial_h = @i_filial_h
       and di_nodo_h = @i_nodo_h
  if @@error != 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157037
	   /*  'Error en eliminacion de ruta directa' */
	return 1
  end

   /* transaccion de servicio */
   insert into ts_directa (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   filial_d, oficina_d, nodo_d, filial_h, oficina_h,
			   nodo_h, tlink, link, protocolo, secuencial,
			   prioridad, nombre_f_d, nombre_o_d,
			   nombre_n_d, nombre_f_h, nombre_o_h, nombre_n_h,
			   estado, fecha_ult_mod)
		   values (@s_ssn, 545, 'B', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			   @i_filial_d, @i_oficina_d, @i_nodo_d,
			   @i_filial_h, @i_oficina_h, @i_nodo_h,
			   @w_tlink, @w_link, @w_protocolo,
			   @w_secuencial, @w_prioridad, null, null, null,
			   null, null, null, null, @w_today)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
        return 1
   end
   
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

go

