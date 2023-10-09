/************************************************************************/
/*	Archivo:		pro_rol.sp				*/
/*	Stored procedure:	sp_pro_rol				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 27-Nov-1992					*/
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
/*	Insercion de producto - rol					*/
/*	Actualizacion del producto - rol				*/
/*	Borrado del producto - rol					*/
/*	Busqueda del producto - rol					*/
/*	Query del producto - rol					*/
/*	Ayuda del producto - rol					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	27/Nov/1992	L. Carvajal	Emision inicial			*/
/*      07/Jun/1993     M. Davila       Search sin error                */
/*	21/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_pro_rol')
   drop proc sp_pro_rol
go

create proc sp_pro_rol (
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
	@i_operacion		varchar(1),
	@i_tipo_h		varchar(1) = null,
	@i_modo			smallint = null,
	@i_rol			tinyint = null,
	@i_producto		tinyint = NULL,
	@i_tipo			varchar(1) = NULL,
	@i_moneda		tinyint = NULL,
	@i_autorizante		smallint = NULL,
	@i_fecha_crea		datetime = null,
        @i_central_transmit     varchar (1) = NULL,
	@i_formato_fecha	int = null
)
as
declare
	@w_today		datetime,
	@w_sp_name		varchar(32),
	@w_rol			tinyint,
	@w_producto		tinyint,
	@w_moneda		tinyint,
	@w_tipo			char(1),
	@w_autorizante		smallint,
	@v_rol			tinyint,
	@v_producto		tinyint,
	@v_moneda		tinyint,
	@v_tipo			char(1),
	@v_autorizante		smallint,
	@o_siguiente		int,
	@o_rol			tinyint,
	@o_producto		tinyint,
	@o_moneda		tinyint,
	@o_nombre_r		descripcion,
	@o_nombre_p		descripcion,
	@o_nombre_m		descripcion,
	@o_tipo			char(1),
	@o_autorizante		smallint,
	@o_fecha_crea		datetime,
	@w_fecha_crea		datetime,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime,
	@o_nombre_aut		descripcion,
	@w_return		int,
	@w_nt_nombre            varchar(32),
	@w_num_nodos            smallint,    
	@w_contador             smallint,
	@w_cmdtransrv		varchar(60),
	@w_clave		int

select @w_today = @s_date
select @w_sp_name = 'sp_pro_rol'


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 525
begin
 /* chequeo de claves foraneas */
  if (@i_rol is NULL OR @i_producto is NULL  
      OR @i_moneda is NULL OR @i_autorizante is NULL)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

  if not exists (
	select ro_rol
	  from ad_rol
	 where ro_rol = @i_rol
	   and ro_estado = 'V')
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151026
	   /*  'No existe rol'*/
	return 1
  end

  if not exists (
	select pm_producto
	  from cl_pro_moneda
	 where pm_producto = @i_producto
	   AND pm_moneda   = @i_moneda
	   AND pm_tipo     = @i_tipo)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101031
	   /*  'No existe producto moneda' */
	return 1
  end

  if not exists (
	select fu_funcionario
	  from cl_funcionario
	 where fu_funcionario = @i_autorizante)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
	   /*  'No existe funcionario' */
	return 1
  end

  begin tran
    insert into ad_pro_rol  (pr_rol, pr_producto, pr_moneda, pr_tipo,
			     pr_fecha_crea, pr_autorizante, pr_estado,
			     pr_fecha_ult_mod)
		    values ( @i_rol, @i_producto, @i_moneda, @i_tipo,
			     @i_fecha_crea, @i_autorizante, 'V', @w_today)
    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153008
	   /*  'Error en insercion de producto rol' */
	return 1
    end

   /* transaccion de servicio */
   insert into ts_pro_rol (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   rol, producto, moneda, tipo, fecha_crea,
			   autorizante, estado, fecha_ult_mod)
		   values (@s_ssn, 525, 'N', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			   @i_rol, @i_producto, @i_moneda, @i_tipo,
			   @i_fecha_crea, @i_autorizante, 'V', @w_today)
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
if @t_trn = 527
begin
 /* chequeo de claves foraneas */
  if (@i_rol is NULL OR @i_producto is NULL  
      OR @i_moneda is NULL)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	  /* 'No se llenaron todos los campos' */
	return 1
  end

	select @w_fecha_crea	= pr_fecha_crea,
	       @w_autorizante	= pr_autorizante,
	       @w_fecha_ult_mod = pr_fecha_ult_mod
	  from ad_pro_rol
	 where pr_rol = @i_rol
	   and pr_producto = @i_producto
	   and pr_tipo = @i_tipo
	   and pr_moneda = @i_moneda
	   and pr_estado = 'V'
  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151010
	   /*  'No existe producto rol' */
	return 1
  end

  /* Verificacion de referencias */
  if exists (
	select ta_producto
	  from ad_tr_autorizada
	 where ta_producto = @i_producto
	   and ta_tipo = @i_tipo
	   and ta_moneda = @i_moneda
	   and ta_rol = @i_rol
	   and ta_estado = 'V')
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157018
	   /*  'Existe referencia de transaccion autorizada' */
	return 1
   end

  /* borrado de pro rol */
  begin tran
   Delete ad_pro_rol
    where pr_rol = @i_rol
      and pr_producto = @i_producto
      and pr_tipo = @i_tipo
      and pr_moneda = @i_moneda
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157019
	   /*  'Error en eliminacion de pro_rol' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_pro_rol (secuencia, tipo_transaccion, clase, fecha,
		           oficina_s, usuario, terminal_s, srv, lsrv,
			   rol, producto, moneda, tipo, fecha_crea,
			   autorizante, estado, fecha_ult_mod)
		   values (@s_ssn, 527, 'B', @s_date,
		           @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			   @i_rol, @i_producto, @i_moneda, @i_tipo,
			   @w_fecha_crea, @w_autorizante, 'V', @w_fecha_ult_mod)
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
If @t_trn = 15017
begin
     set rowcount 20
     if @i_modo = 0
     begin
        select 	'Cod. Producto' = pr_producto,
		'Tipo' = pr_tipo,
		'Cod. Moneda' = pr_moneda,
		'Descripcion' = substring(pm_descripcion,1,40),
  		'Autorizante' = pr_autorizante,
		'Nombre_aut' = fu_nombre
	 from	ad_pro_rol, cl_pro_moneda, cl_funcionario
	where	pr_producto = pm_producto
	  and	pr_tipo = pm_tipo
	  and	pr_moneda = pm_moneda
          and   pr_autorizante = fu_funcionario
          and   pr_rol = @i_rol
          and   pr_estado = 'V'
        order   by pr_producto, pr_tipo, pr_moneda
       set rowcount 0
     end
     if @i_modo = 1
     begin
        select  'Cod. Producto' = pr_producto,
		'Tipo' = pr_tipo,
		'Cod. Moneda' = pr_moneda,
		'Descripcion' = substring(pm_descripcion,1,40),
  		'Autorizante' = pr_autorizante,
		'Nombre_aut' = fu_nombre
	 from	ad_pro_rol, cl_pro_moneda, cl_funcionario
	where	pr_producto = pm_producto
	  and	pr_tipo = pm_tipo
	  and	pr_moneda = pm_moneda
          and   pr_autorizante = fu_funcionario
          and   pr_rol = @i_rol
          and  ( 
                ((pr_producto > @i_producto))
          or    ((pr_producto = @i_producto) and (pr_tipo > @i_tipo))
          or    ((pr_producto = @i_producto)
                and (pr_tipo = @i_tipo) and (pr_moneda > @i_moneda))
               )
          and   pr_estado = 'V'
        order   by pr_rol, pr_producto, pr_tipo, pr_moneda
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
If @t_trn = 15018
begin
	select	@o_nombre_r = ro_descripcion,
		@o_nombre_p = pd_descripcion,
		@o_nombre_m = mo_descripcion,
		@o_autorizante = pr_autorizante,
		@o_fecha_crea = pr_fecha_crea
	   from	ad_pro_rol, cl_producto, cl_moneda, ad_rol
          where   pr_rol = ro_rol	     and pr_rol = @i_rol
            and   pr_producto = pd_producto  and pr_producto = @i_producto
	    and   pr_moneda = mo_moneda      and pr_moneda = @i_moneda
	    and   pr_tipo = @i_tipo
	    and   pr_estado = 'V'
       if @@rowcount = 0
       begin
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151010
	   /*  'No existe producto rol' */
	 return 1
       end

       select @o_nombre_aut = fu_nombre
	 from cl_funcionario
	where fu_funcionario = @o_autorizante
       if @@rowcount = 0
       begin
	 exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 101036
	   /*  'No existe funcionario' */
	 return 1
       end
       select @i_rol, @o_nombre_r, @i_producto, @o_nombre_p, @i_tipo,
	      @i_moneda, @o_nombre_m, @o_autorizante, @o_nombre_aut,
	      convert(char(10), @o_fecha_crea, @i_formato_fecha)
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
If @t_trn = 15019
begin
 if @i_tipo_h = 'A'
 begin
         select   substring(ro_descripcion,1,20),
                  substring(pd_descripcion,1,20), pr_tipo,
                  substring(mo_descripcion,1,20)
           from   ad_pro_rol, cl_producto, cl_moneda, ad_rol
          where   pr_rol = ro_rol
            and   pr_producto = pd_producto
            and   pr_moneda = mo_moneda
            and   pr_estado = 'V'  
           order  by pr_rol, ro_descripcion, pd_descripcion
 end
 if @i_tipo_h = 'V'
 begin
         select   substring(ro_descripcion,1,20),
                  substring(pd_descripcion,1,20), pr_tipo,
                  substring(mo_descripcion,1,20)
           from   ad_pro_rol, cl_producto, cl_moneda, ad_rol
          where   pr_rol = ro_rol	     and pr_rol = @i_rol
            and   pr_producto = pd_producto  and pr_producto = @i_producto
            and   pr_moneda = mo_moneda      and pr_moneda = @i_moneda
            and   pr_estado = 'V'  
	 if @@rowcount = 0
	 begin
	  exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151010
	   /*  'No existe producto rol' */
	  return 1
	 end
 end
 return  0
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

