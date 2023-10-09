/************************************************************************/
/*	Archivo:		x25_conf.sp				*/
/*	Stored procedure:	sp_x25_config				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 8-Dic-1992					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	Insercion de aplicacion						*/
/*	Actualizacion de aplicacion					*/
/*	Borrado de aplicacion						*/
/*	Busqueda de aplicacion						*/
/*	Query de aplicacion						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	8/Dic/1992	L. Carvajal	Emision inicial			*/
/*	7/Jun/1993	M. Davila	Search sin error		*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_x25_config')
   drop proc sp_x25_config
go

create proc sp_x25_config (
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
	@t_trn			smallint = null,
	@i_operacion		char(1),
	@i_modo 		smallint = null,
        @i_tipo			char(1)= null,
        @i_filial               tinyint = null,
        @i_oficina              smallint = null,
        @i_nodo                 tinyint = null,
        @i_tlink                char(1) = NULL,
        @i_link                 tinyint = NULL,
        @i_protocolo            char(1) = NULL,
        @i_secuencial           tinyint = NULL, 
        @i_nombre               descripcion = NULL,
        @i_direccion            varchar(30) = NULL,
        @i_subdireccion         varchar(30) = NULL
)
as
declare
	@w_sp_name		varchar(32),
        @w_today                datetime,
        @w_secuencial           tinyint,
        @w_estado               char(1),
        @w_nombre               descripcion,
        @w_direccion            varchar(30),
        @w_subdireccion         varchar(30),
        @v_secuencial           tinyint,        
        @v_nombre               descripcion,
        @v_direccion            varchar(30),
        @v_subdireccion         varchar(30),
	@o_nombre		descripcion,
        @o_direccion            varchar(30),
        @o_subdireccion         varchar(30),
        @o_secuencial           tinyint,        
	@o_nombre_f             descripcion,
	@o_nombre_o             descripcion,
	@o_nombre_n		descripcion,
	@o_nombre_pr		descripcion,
	@o_nombre_tl		descripcion,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime

select @w_today = @s_date
select @w_sp_name = 'sp_x25_config'

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 501
begin
/* chequeo de claves foraneas */
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_link is NULL OR @i_tlink is NULL OR @i_protocolo is NULL
      OR @i_direccion is NULL)
  begin
/* No se llenaron todos  los campos*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	return 1
   end
if @i_protocolo = 'X'
  if not exists (
        select x_filial
          from ad_x25
         where x_oficina = @i_oficina
           and x_filial = @i_filial
           and x_nodo = @i_nodo
           and x_tlink = @i_tlink
           and x_link = @i_link
           and x_25 = @i_protocolo
           and x_estado = 'V')
  begin
/* No existe X25 */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151021
        return 1
  end

  if not exists (
	select pr_protocolo
	  from ad_protocolo
	 where pr_protocolo = @i_protocolo
	   and pr_estado = 'V')
  begin
	exec sp_cerror
/*  'No existe protocolo'*/
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
        return 1
  end


  select @w_estado = null
  select @w_secuencial = xc_secuencial,
	 @w_estado = xc_estado
    from ad_x25_config
   where xc_oficina = @i_oficina
     and xc_filial = @i_filial
     and xc_nodo = @i_nodo
     and xc_tlink = @i_tlink
     and xc_link = @i_link
     and xc_protocolo = @i_protocolo
  if @@rowcount = 0
    select @w_secuencial = 1
  else
   begin
    if @w_estado is null
    begin
/*  'No existe aplicacion habilitada'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
        return 1
    end
    select @w_secuencial = @w_secuencial + 1
   end

  begin tran
     insert into ad_x25_config (xc_filial, xc_oficina, xc_nodo,
				xc_tlink, xc_link, xc_protocolo,
				xc_secuencial, xc_nombre, xc_direccion,
				xc_subdireccion, xc_estado, xc_fecha_ult_mod)
                        values (@i_filial, @i_oficina, @i_nodo,
                                @i_tlink, @i_link, @i_protocolo,
                                @w_secuencial, @i_nombre, @i_direccion,
				@i_subdireccion, 'V', @w_today)
     if @@error != 0
     begin
/*  'Error en insercion de aplicacion'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153018
        return 1
     end

/* transaccion de servicio */
   insert into ts_x25_config (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s,srv, lsrv,
			      filial, oficina, nodo, tlink, link, protocolo,
			      secuencial, nombre, direccion, subdireccion,
			      estado, fecha_ult_mod)
		     values  (@s_ssn,501, 'N', @s_date,
			      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			      @i_filial, @i_oficina, @i_nodo, @i_tlink, @i_link,
			      @i_protocolo, @w_secuencial, @i_nombre,
			      @i_direccion, @i_subdireccion, 'V', @w_today)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	return 1
   end
  commit tran
 select @w_secuencial
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
if @t_trn = 502
begin
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_link is NULL OR @i_tlink is NULL OR @i_protocolo is NULL
      OR @i_secuencial is NULL OR @i_direccion is NULL)
  begin
/* 'No se llenaron todos los campos'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
  end

  select @w_nombre = xc_nombre,
	 @w_direccion = xc_direccion,
	 @w_subdireccion = xc_subdireccion,
	 @v_fecha_ult_mod = xc_fecha_ult_mod
    from ad_x25_config
   where xc_oficina = @i_oficina
     and xc_filial = @i_filial
     and xc_nodo = @i_nodo
     and xc_tlink = @i_tlink
     and xc_link = @i_link
     and xc_protocolo = @i_protocolo
     and xc_secuencial = @i_secuencial
     and xc_estado = 'V'
 if @@rowcount = 0
  begin
/* 'No existe aplicacion' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
        return 1
  end

/*** verificacion de campos a actualizar ***/
  select @v_nombre = @w_nombre,
         @v_direccion = @w_direccion,
         @v_subdireccion = @w_subdireccion

  if @w_nombre = @i_nombre
   select @w_nombre = null, @v_nombre = null
  else
   select @w_nombre = @i_nombre

  if @w_direccion = @i_direccion
   select @w_direccion = null, @v_direccion = null
  else
   select @w_direccion = @i_direccion

  if @w_subdireccion = @i_subdireccion
   select @w_subdireccion = null, @v_subdireccion = null
  else
   select @w_subdireccion = @i_subdireccion

  begin tran
   Update ad_x25_config
      set xc_nombre = @i_nombre,
	  xc_direccion = @i_direccion,
	  xc_subdireccion = @i_subdireccion,
	  xc_fecha_ult_mod = @w_today
    where xc_oficina = @i_oficina
      and xc_filial = @i_filial
      and xc_nodo = @i_nodo
      and xc_tlink = @i_tlink
      and xc_link = @i_link
      and xc_protocolo = @i_protocolo
      and xc_secuencial = @i_secuencial
   if @@error != 0
   begin
/* 'Error en actualizacion de aplicacion'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155014
	return 1
   end

/* transaccion de servicio */
   insert into ts_x25_config (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s,srv, lsrv,
			     filial, oficina, nodo, tlink, link, protocolo,
			     secuencial, nombre, direccion, subdireccion,
			     estado, fecha_ult_mod)
		     values (@s_ssn, 502, 'P',@s_date,
			     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			     @i_filial, @i_oficina, @i_nodo, @i_tlink, @i_link,
			     @i_protocolo, @i_secuencial, @v_nombre,
			     @v_direccion, @v_subdireccion, null,
			     @v_fecha_ult_mod)
   if @@error != 0
   begin
/* 'Error en creacion de transaccion de servicio'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	return 1
   end

/* transaccion de servicio */
   insert into ts_x25_config (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s,srv, lsrv,
			      filial, oficina, nodo, tlink, link, protocolo,
			      secuencial, nombre, direccion, subdireccion,
			      estado, fecha_ult_mod)
		     values  (@s_ssn, 502, 'A', @s_date,
			      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			      @i_filial, @i_oficina, @i_nodo, @i_tlink, @i_link,
			      @i_protocolo, @i_secuencial, @w_nombre,
			      @w_direccion, @w_subdireccion, null,
			      @w_today)
   if @@error != 0
   begin
/* 'Error en creacion de transaccion de servicio'*/
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
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
if @t_trn = 503
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL
      OR @i_link is NULL OR @i_tlink is NULL OR @i_protocolo is NULL
      OR @i_secuencial is NULL)
  begin
/* 'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
        return 1
  end

  select @w_nombre = xc_nombre,
	 @w_direccion = xc_direccion,
	 @w_subdireccion = xc_subdireccion,
	 @w_fecha_ult_mod = xc_fecha_ult_mod
    from ad_x25_config
   where xc_oficina = @i_oficina
     and xc_filial = @i_filial
     and xc_nodo = @i_nodo
     and xc_tlink = @i_tlink
     and xc_link = @i_link
     and xc_protocolo = @i_protocolo
     and xc_secuencial = @i_secuencial
     and xc_estado = 'V'
  if @@rowcount = 0
  begin
/* 'No existe aplicacion' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
        return 1
  end

  /* verificacion de referencias */
  if exists (
	select di_protocolo
	  from ad_directa
	 where di_secuencial = @i_secuencial
	   and di_tlink = @i_tlink
	   and di_link = @i_link
	   and di_protocolo = @i_protocolo
	   and di_oficina_d = @i_oficina
	   and di_filial_d = @i_filial
	   and di_nodo_d = @i_nodo
	   and di_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157003
	   /*  'Existe referencia en directa' */
	return 1
  end

  if exists (
	select di_protocolo
	  from ad_directa
	 where di_secuencial = @i_secuencial
	   and di_tlink = @i_tlink
	   and di_link = @i_link
	   and di_protocolo = @i_protocolo
	   and di_oficina_h = @i_oficina
	   and di_filial_h = @i_filial
	   and di_nodo_h = @i_nodo
	   and di_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157003
	   /*  'Existe referencia en directa' */
	return 1
  end

  /* borrado de x25_config */
  begin tran
    Delete ad_x25_config
     where xc_oficina = @i_oficina
       and xc_filial = @i_filial
       and xc_nodo = @i_nodo
       and xc_tlink = @i_tlink
       and xc_link = @i_link
       and xc_protocolo = @i_protocolo
       and xc_secuencial = @i_secuencial
   if @@error != 0
   begin
/*  'Error en eliminacion de aplicacion' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157038
        return 1
   end

  /* transaccion de servicio */
   insert into ts_x25_config (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s,srv, lsrv,
			      filial, oficina, nodo, tlink, link, protocolo,
			      secuencial, nombre, direccion, subdireccion,
			      estado, fecha_ult_mod)
		     values  (@s_ssn, 503, 'B', @s_date,
			      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
			      @i_filial, @i_oficina, @i_nodo, @i_tlink, @i_link,
			      @i_protocolo, @i_secuencial, @w_nombre,
			      @w_direccion, @w_subdireccion, 'V',
			      @w_fecha_ult_mod)
   if @@error != 0
   begin
/* 'Error en creacion de transaccion de servicio' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
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

/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15085
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Filial' = xc_filial,
		'Filial' = fi_abreviatura,
		'Cod. Oficina' = xc_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. Nodo' = xc_nodo,
		'Nodo' = substring(nl_nombre, 1, 20),
		'Protocolo' = xc_protocolo,
		'Tipo de link' = xc_tlink,
		'No. Link' = xc_link,
		'Secuencial' = xc_secuencial,
		'Nombre' = xc_nombre,
		'Direccion' = xc_direccion,
		'Subdireccion' = xc_subdireccion
	 from	ad_x25_config, cl_filial, cl_oficina, ad_nodo_oficina
	where	xc_filial = fi_filial
	  and	xc_oficina = of_oficina
	  and	xc_nodo = nl_nodo
	  and	xc_filial = nl_filial
	  and	xc_oficina = nl_oficina
	  and	xc_estado = 'V'
	order	by xc_filial, xc_oficina, xc_nodo, xc_protocolo, xc_tlink,
		xc_link, xc_secuencial
       set rowcount 0
     end
     
     if @i_modo = 1
     begin
	select	'Cod. Filial' = xc_filial,
		'Filial' = fi_abreviatura,
		'Cod. Oficina' = xc_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. Nodo' = xc_nodo,
		'Nodo' = substring(nl_nombre, 1, 20),
		'Protocolo' = xc_protocolo,
		'Tipo de link' = xc_tlink,
		'No. Link' = xc_link,
		'Secuencial' = xc_secuencial,
		'Nombre' = xc_nombre,
		'Direccion' = xc_direccion,
		'Subdireccion' = xc_subdireccion
	 from	ad_x25_config, cl_filial, cl_oficina, ad_nodo_oficina
	where	xc_filial = fi_filial
	  and	xc_oficina = of_oficina
	  and	xc_nodo = nl_nodo
	  and	xc_filial = nl_filial
	  and	xc_oficina = nl_oficina
	  and  (
		(xc_filial > @i_filial)
	  or	((xc_filial = @i_filial) and (xc_oficina > @i_oficina))
	  or	((xc_filial = @i_filial) and (xc_oficina = @i_oficina)
		and (xc_nodo > @i_nodo))
	  or	((xc_filial = @i_filial) and (xc_oficina = @i_oficina)
		and (xc_nodo = @i_nodo) and (xc_protocolo > @i_protocolo))
	  or	((xc_filial = @i_filial) and (xc_oficina = @i_oficina)
		and (xc_nodo = @i_nodo) and (xc_protocolo = @i_protocolo)
		and (xc_tlink > @i_tlink))
	  or	((xc_filial = @i_filial) and (xc_oficina = @i_oficina)
		and (xc_nodo = @i_nodo) and (xc_protocolo = @i_protocolo)
		and (xc_tlink = @i_tlink) and (xc_link > @i_link))
	  or	((xc_filial = @i_filial) and (xc_oficina = @i_oficina)
		and (xc_nodo = @i_nodo) and (xc_protocolo = @i_protocolo)
		and (xc_tlink = @i_tlink) and (xc_link = @i_link)
		and (xc_secuencial > @i_secuencial))
	       )
	  and	xc_estado = 'V'
	order	by xc_filial, xc_oficina, xc_nodo, xc_protocolo, xc_tlink,
		xc_link, xc_secuencial
       set rowcount 0
     end
     if @i_modo = 2
     begin
	select	'Secuencial' = xc_secuencial,
		'Nombre' = xc_nombre,
		'Direccion' = xc_direccion,
		'Subdireccion' = xc_subdireccion
	 from	ad_x25_config
	where	xc_filial = @i_filial
	  and	xc_oficina = @i_oficina
	  and	xc_nodo = @i_nodo
	  and	xc_protocolo = @i_protocolo
	  and	xc_tlink = @i_tlink
	  and	xc_link = @i_link
	  and	xc_estado = 'V'
	order	by xc_filial, xc_oficina, xc_nodo, xc_protocolo,
		xc_tlink, xc_link, xc_secuencial
       set rowcount 0
     end
    if @i_modo = 3
     begin
	select	'Secuencial' = xc_secuencial,
		'Nombre' = xc_nombre,
		'Direccion' = xc_direccion,
		'Subdireccion' = xc_subdireccion
	 from	ad_x25_config
	where	xc_filial = @i_filial
	  and	xc_oficina = @i_oficina
	  and	xc_nodo = @i_nodo
	  and	xc_protocolo = @i_protocolo
	  and	xc_tlink = @i_tlink
	  and	xc_link = @i_link
	  and	xc_secuencial > @i_secuencial
	  and	xc_estado = 'V'
	order	by xc_filial, xc_oficina, xc_nodo, xc_protocolo,
		xc_tlink, xc_link, xc_secuencial
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
If @t_trn = 15086
begin
	select	@o_nombre_f = fi_nombre,
		@o_nombre_o = of_nombre,
		@o_nombre_n = nl_nombre,
		@o_nombre = xc_nombre,
		@o_direccion = xc_direccion,
		@o_subdireccion = xc_subdireccion
	 from	ad_x25_config, cl_filial, cl_oficina, ad_nodo_oficina
	where	xc_filial = fi_filial
	  and	xc_oficina = of_oficina
	  and	xc_nodo = nl_nodo
	  and	xc_filial = nl_filial
	  and	xc_oficina = nl_oficina
	  and	xc_filial = @i_filial
	  and	xc_oficina = @i_oficina
	  and	xc_nodo = @i_nodo
	  and	xc_protocolo = @i_protocolo
	  and	xc_tlink = @i_tlink
	  and	xc_link  = @i_link
	  and	xc_secuencial = @i_secuencial
	  and	xc_estado = 'V'
       if @@rowcount = 0
       begin
/*  'No existe aplicaci"n' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
	 return 1
       end

       select @o_nombre_pr = pr_descripcion
	 from ad_protocolo
	where pr_protocolo = @i_protocolo
       if @@rowcount = 0
       begin
/*  'No existe protocolo' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
	 return 1
       end

       select @o_nombre_tl = tl_descripcion
	 from ad_tlink
	where tl_tipo_link = @i_tlink
       if @@rowcount = 0
       begin
/* 'No existe tipo de link' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151009
	 return 1
       end
       select @i_filial, @o_nombre_f, @i_oficina, @o_nombre_o,
	      @i_nodo, @o_nombre_n, @i_protocolo, @o_nombre_pr, @i_tlink,
	      @o_nombre_tl, @i_link, @i_secuencial, @o_nombre, @o_direccion,
 	      @o_subdireccion
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


/* ** Help ** */
if @i_operacion = 'H'
begin
If @t_trn = 15087
begin
    if @i_tipo = 'V'
    begin
	select	xc_nombre
	 from	ad_x25_config
	where	xc_filial = @i_filial
	  and 	xc_oficina = @i_oficina
	  and	xc_nodo	   = @i_nodo
	  and   xc_protocolo = @i_protocolo
	  and   xc_link = @i_link
	  and   xc_tlink = @i_tlink 
	  and   xc_secuencial = @i_secuencial
	  and	xc_estado = 'V'
       if @@rowcount = 0
       begin
/*  'No existe aplicaci"n' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151014
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
go

