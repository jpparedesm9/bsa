/************************************************************************/
/*	Archivo:		x25.sp					*/
/*	Stored procedure:	sp_x25					*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 7-Dic-1992					*/
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
/*	Insercion de x.25						*/
/*	Actualizacion de x.25						*/
/*	Borrado de x.25							*/
/*	Busqueda de x.25						*/
/*	Query de x.25							*/
/*	Ayuda de x.25							*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	7/Dic/1992	L. Carvajal	Emision inicial			*/
/*	7/Jun/1993	M. Davila	Search sin error		*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_x25')
   drop proc sp_x25
go

create proc sp_x25 (
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
	@i_filial		tinyint = null,
	@i_oficina		smallint = null,
	@i_nodo			tinyint = null,
	@i_tlink		char(1) = NULL,
	@i_link			tinyint = NULL
)
as
declare
	@w_today		datetime,
	@w_sp_name		varchar(32),
	@o_nombre_f		descripcion,
	@o_nombre_o		descripcion,
	@o_nombre_n		descripcion,
	@o_tlink		char(1),
	@o_nombre_tl		descripcion,
	@o_link			tinyint,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime

select @w_today = @s_date
select @w_sp_name = 'sp_x25'




/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 510
begin
/* chequeo de claves foraneas */
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL 
      OR @i_link is NULL OR @i_tlink is NULL)
  begin
/*  'No se llenaron todos los campos' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	return 1
   end

  if not exists (
	select li_filial
	  from ad_link
	 where li_oficina = @i_oficina
	   and li_filial = @i_filial
	   and li_nodo = @i_nodo
	   and li_tipo = @i_tlink
	   and li_link = @i_link
	   and li_estado = 'V')
  begin
/*  'No existe link' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151012
	return 1
  end

  if  exists (
	select x_filial from ad_x25 
	 where x_filial   = @i_filial  
	   and x_oficina  = @i_oficina  and  x_nodo   = @i_nodo 
	   and x_tlink    = @i_tlink    and  x_link  = @i_link )
  begin
/*  'Ya existe enlace x25 para ese nodo ' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151065
	return 1
  end

  begin tran
     insert into ad_x25  (x_filial, x_oficina, x_nodo, x_tlink,
			  x_link, x_25, x_estado, x_fecha_ult_mod)
	          values (@i_filial, @i_oficina, @i_nodo, @i_tlink,
			  @i_link, 'X', 'V', @w_today)
     if @@error != 0
     begin
/*  'Error en insercion de X.25' */
      exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153017
	return 1
     end

/* transaccion de servicio */
   insert into ts_x25 (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       filial, oficina, nodo, tlink,
		       link, x25, estado, fecha_ult_mod)
	       values (@s_ssn, 510, 'N', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_filial, @i_oficina, @i_nodo, @i_tlink,
		       @i_link, 'X', 'V', @w_today)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
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
if @t_trn = 512
begin
 /* chequeo de claves foraneas */
  if (@i_filial is NULL  OR @i_oficina is NULL OR @i_nodo is NULL 
      OR @i_link is NULL OR @i_tlink is NULL)
  begin
/*  'No se llenaron todos los campos' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	return 1
   end

	select @w_fecha_ult_mod = x_fecha_ult_mod
	  from ad_x25
	 where x_oficina = @i_oficina
	   and x_filial = @i_filial
	   and x_nodo = @i_nodo
	   and x_tlink = @i_tlink
	   and x_link = @i_link
	   and x_estado = 'V'
  if @@rowcount = 0
  begin
/*     'No existe X.25' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151021
	return 1
  end

  /* verificacion de referencias */
  if exists (
	select xc_filial
	  from ad_x25_config
	 where xc_oficina = @i_oficina
	   and xc_filial = @i_filial
	   and xc_nodo = @i_nodo
	   and xc_tlink = @i_tlink
	   and xc_link = @i_link
	   and xc_estado = 'V')
  begin
/*  'Existe referencia en configuracion X25' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157048
	return 1
  end

  /* borrado de X.25 */
  begin tran
    Delete ad_x25
     where x_oficina = @i_oficina
       and x_filial = @i_filial
       and x_nodo = @i_nodo
       and x_tlink = @i_tlink
       and x_link = @i_link
     if @@error != 0
     begin
/*  'Error en eliminacion de X.25' */
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157034
	return 1
     end

/* transaccion de servicio */
   insert into ts_x25 (secuencia, tipo_transaccion, clase, fecha,
		       oficina_s, usuario, terminal_s, srv, lsrv,
		       filial, oficina, nodo, tlink,
		       link, x25, estado, fecha_ult_mod)
	       values (@s_ssn, 512, 'B', @s_date,
		       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
		       @i_filial, @i_oficina, @i_nodo, @i_tlink,
		       @i_link, 'X', 'V', @w_fecha_ult_mod)
   if @@error != 0
   begin
/*  'Error en creacion de transaccion de servicio' */
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
If @t_trn = 15083
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Filial' = x_filial,
		'Filial' = fi_abreviatura,
		'Cod. Oficina' = x_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. Nodo' = x_nodo,
		'Nodo' = substring(nl_nombre, 1, 20),
		'Tipo de link' = x_tlink,
		'No. Link' = x_link
	 from	ad_x25, cl_filial, cl_oficina, ad_nodo_oficina
	where	x_filial = fi_filial
	  and	x_oficina = of_oficina
	  and	x_nodo = nl_nodo
	  and	x_filial = nl_filial
	  and	x_oficina = nl_oficina
	  and	x_estado = 'V'
	order	by x_filial, x_oficina, x_nodo, x_tlink, x_link
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
	select	'Cod. Filial' = x_filial,
		'Filial' = fi_abreviatura,
		'Cod. Oficina' = x_oficina,
		'Oficina' = substring(of_nombre, 1, 20),
		'Cod. Nodo' = x_nodo,
		'Nodo' = substring(nl_nombre, 1, 20),
		'Tipo' = x_tlink,
		'No. Link' = x_link
	 from	ad_x25, cl_filial, cl_oficina, ad_nodo_oficina
	where	x_filial = fi_filial
	  and	x_oficina = of_oficina
	  and	x_nodo = nl_nodo
	  and	x_filial = nl_filial
	  and	x_oficina = nl_oficina
	  and  (
		(x_filial > @i_filial)
	  or	((x_filial = @i_filial) and (x_oficina > @i_oficina))
	  or	((x_filial = @i_filial) and (x_oficina = @i_oficina)
		and (x_nodo > @i_nodo))
	  or	((x_filial = @i_filial) and (x_oficina = @i_oficina)
		and (x_nodo = @i_nodo) and (x_tlink > @i_tlink))
	  or	((x_filial = @i_filial) and (x_oficina = @i_oficina)
		and (x_nodo = @i_nodo) and (x_tlink = @i_tlink)
		and (x_link > @i_link))
	       )
	  and	x_estado = 'V'
	order	by x_filial, x_oficina, x_nodo, x_tlink, x_link
       set rowcount 0
       return 0
     end
    if @i_modo = 2
     begin
	select 'No. Link' = x_link,
	       'Tipo de link' = x_tlink,
	       'Descripcion'=	substring(tl_descripcion,1,20)
	 from	ad_x25, ad_tlink
	where	x_tlink = tl_tipo_link
	  and	x_oficina = @i_oficina
	  and	x_nodo = @i_nodo
	  and	x_filial = @i_filial
	  and	x_estado = 'V'
	order	by x_link, x_tlink
       set rowcount 0
       return 0
     end
     if @i_modo = 3
     begin
	select 'No. Link' = x_link,
	       'Tipo de link' = x_tlink,
	       'Descripcion'=	substring(tl_descripcion,1,20)
	 from	ad_x25, ad_tlink
	where	x_tlink = tl_tipo_link
	  and	x_oficina = @i_oficina
	  and	x_nodo = @i_nodo
	  and	x_filial = @i_filial
	  and  (
		((x_tlink > @i_tlink))
	  or	((x_tlink = @i_tlink) and (x_link > @i_link))
	       )
	  and	x_estado = 'V'
	order	by x_link, x_tlink
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
If @t_trn = 15084
begin
	select	@o_nombre_f = fi_nombre,
		@o_nombre_o = of_nombre,
		@o_nombre_n = nl_nombre,
		@o_tlink = x_tlink,
		@o_nombre_tl = tl_descripcion
	 from	ad_x25, cl_filial, cl_oficina, ad_nodo_oficina, ad_tlink
	where	x_filial = fi_filial
	  and	x_oficina = of_oficina
	  and	x_nodo = nl_nodo
	  and	x_filial = nl_filial
	  and	x_oficina = nl_oficina
	  and	x_tlink = tl_tipo_link
	  and   x_filial = @i_filial
	  and   x_oficina = @i_oficina
	  and   x_nodo = @i_nodo
	  and   x_tlink = @i_tlink
	  and   x_link = @i_link
	  and	x_estado = 'V'
       if @@rowcount = 0
       begin
/*  'No existe X.25' */
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151021
	 return 1
       end
       select @i_filial, @o_nombre_f, @i_oficina, @o_nombre_o, @i_nodo,
	      @o_nombre_n, @i_tlink, @o_nombre_tl, @i_link
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
