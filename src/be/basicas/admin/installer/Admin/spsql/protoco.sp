/************************************************************************/
/*	Archivo:		protoco.sp				*/
/*	Stored procedure:	sp_protoco				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 4-Dic-1992					*/
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
/*	Insercion de protcolo						*/
/*	Actualizacion de protocolo					*/
/*	Borrado de protocolo						*/
/*	Busqueda de protocolo						*/
/*	Query de protocolo						*/
/*	Ayuda de protocolo						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	4/Dic/1992	L. Carvajal	Emision inicial			*/
/*	7/Jun/1993	M. Davila	Search sin error		*/
/*	20/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_protocolo')
   drop proc sp_protocolo
go

create proc sp_protocolo (
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
	@i_tipo			char(1) = null,
	@i_modo 		smallint = null,
	@i_protocolo		char(1) = null,
	@i_descripcion		descripcion = NULL
)
as
declare
	@w_today		datetime,
	@w_sp_name		varchar(32),
	@w_descripcion		descripcion,
	@v_descripcion		descripcion,
	@o_siguiente		int,
	@o_descripcion		descripcion,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime

select @w_today = @s_date
select @w_sp_name = 'sp_protocolo'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 531
begin
  if (@i_protocolo is NULL OR @i_descripcion is NULL)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
  
  begin tran
   insert into ad_protocolo (pr_protocolo, pr_descripcion, pr_estado,
			     pr_fecha_ult_mod)
		     values (@i_protocolo, @i_descripcion, 'V', @w_today)
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153016
	   /*  'Error en insercion de protocolo' */
	return 1
   end

  /* transaccion de servicio */
   insert into ts_protocolo (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     protocolo, descripcion, estado, fecha_ult_mod)
		     values (@s_ssn, 531, 'N', @s_date,
		             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			     @i_protocolo, @i_descripcion, 'V', @w_today)
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


/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 532
begin
  if (@i_protocolo is NULL OR @i_descripcion is NULL)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
  
  select @w_descripcion = pr_descripcion,
	 @v_fecha_ult_mod = pr_fecha_ult_mod
    from ad_protocolo
   where pr_protocolo = @i_protocolo
     and pr_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
	   /*  'No existe tipo de protocolo' */
	return 1
  end

/*** verificacion de campos a actualizar ***/
  select @v_descripcion = @w_descripcion

  if @w_descripcion = @i_descripcion
   select @w_descripcion = null, @v_descripcion = null
  else
   select @w_descripcion = @i_descripcion

  begin tran
   Update ad_protocolo
      set pr_descripcion = @i_descripcion,
	  pr_fecha_ult_mod = @w_today
    where pr_protocolo = @i_protocolo
  if @@error != 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155013
	   /*  'Error en actualizacion de protocolo' */
	return 1
  end

  /* transaccion de servicio */
   insert into ts_protocolo (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     protocolo, descripcion, estado, fecha_ult_mod)
		     values (@s_ssn, 532, 'P', @s_date,
		             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			     @i_protocolo, @v_descripcion, null,
			     @v_fecha_ult_mod)
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

  /* transaccion de servicio */
   insert into ts_protocolo (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     protocolo, descripcion, estado, fecha_ult_mod)
		     values (@s_ssn, 532, 'A', @s_date,
		             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			     @i_protocolo, @w_descripcion, null,
			     @w_today)
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
if @t_trn = 533
begin
  if (@i_protocolo is NULL)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end
  
  select @w_descripcion = pr_descripcion,
	 @w_fecha_ult_mod = pr_fecha_ult_mod
    from ad_protocolo
   where pr_protocolo = @i_protocolo
     and pr_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
	   /*  'No existe tipo de protocolo' */
	return 1
  end

  /* verificacion de referencias */
  if exists (
	select in_protocolo
	  from ad_interface
	 where in_protocolo = @i_protocolo
	   and in_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157030
	   /*  'Existe referencia en interface' */
	return 1
  end

  /* borrado de protocolo */
  begin tran
   Delete ad_protocolo
    where pr_protocolo = @i_protocolo
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157032
	   /*  'Error en eliminacion de protocolo' */
	return 1
   end

  /* transaccion de servicio */
   insert into ts_protocolo (secuencia, tipo_transaccion, clase, fecha,
		             oficina_s, usuario, terminal_s, srv, lsrv,
			     protocolo, descripcion, estado, fecha_ult_mod)
		     values (@s_ssn, 533, 'B', @s_date,
		             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			     @i_protocolo, @w_descripcion, 'V',
			     @w_fecha_ult_mod)
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


/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15038
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select	'Cod. Protocolo' = pr_protocolo,
		'Descripcion' = substring(pr_descripcion, 1, 20)
	 from	ad_protocolo
	where	pr_estado = 'V'
	order	by pr_protocolo
       set rowcount 0
     end
     if @i_modo = 1
     begin
	select	'Cod. Protocolo' = pr_protocolo,
		'Descripcion' = substring(pr_descripcion, 1, 20)
	 from	ad_protocolo
	where	pr_protocolo > @i_protocolo
	  and	pr_estado = 'V'
	order	by pr_protocolo
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
If @t_trn = 15039
begin
	 select   @o_descripcion =  pr_descripcion
	   from	  ad_protocolo
	  where   pr_estado = 'V'
	    and	  pr_protocolo = @i_protocolo
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
	   /*  'No existe tipo de protocolo' */
	  return 1
	 end
	 select @i_protocolo, @o_descripcion
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
If @t_trn = 15040
begin
 if @i_tipo = 'A'
 begin
	 select   pr_protocolo, substring(pr_descripcion,1,20)
	   from	  ad_protocolo
	  where   pr_estado = 'V'
	   order  by pr_protocolo
 end
 if @i_tipo = 'V'
 begin
	 select   substring(pr_descripcion,1,20)
	   from	  ad_protocolo
	  where   pr_estado = 'V'
	    and	  pr_protocolo = @i_protocolo
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151013
	   /*  'No existe tipo de protocolo' */
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

