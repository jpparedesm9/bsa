/************************************************************************/
/*	Archivo:		proaso.sp				*/
/*	Stored procedure:	sp_pro_aso				*/
/*	Base de datos:		cobis					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 15-Nov-1992					*/
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
/*	Este programa procesa las transacciones del stored procedure	*/
/*	Insercion de posicion						*/
/*	Actualizacion de posicion					*/
/*	Ayuda de posicion						*/
/*	Query de posicion						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_pro_aso')
   drop proc sp_pro_aso
go

create proc sp_pro_aso (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
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
	@i_tipo		   	tinyint = null,
	@i_modo		   	tinyint = null,
	@i_base		   	tinyint = null,
	@i_btipo	   	char(1) = null,
	@i_asociado	   	tinyint = null,
	@i_atipo	   	char(1) = null
)
as
declare
	@w_sp_name	    varchar(32),
	@w_today	    datetime,
	@w_var		    int

select @w_today = @s_date
select @w_sp_name = 'sp_pro_aso'



/** Insert **/
If @i_operacion = 'I'
begin
if @t_trn = 1517
begin
/* Verificacion de claves foraneas */
select	@w_var = null
  from	cl_producto
 where	pd_producto = @i_base
   and	pd_tipo = @i_btipo
if @@rowcount = 0
begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101032
	 /*'No existe producto base'*/
     return 1
end

select	@w_var = null
  from	cl_producto
 where	pd_producto = @i_asociado
   and  pd_tipo = @i_atipo
if @@rowcount = 0
begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101032
	       /*'No existe producto asociado'*/
     return 1
end

begin tran
      insert into cl_pro_asociado (pp_base, pp_btipo,
                                   pp_asociado, pp_atipo, pp_fecha)
			   values (@i_base, @i_btipo, 
                                   @i_asociado, @i_atipo, @w_today)
      if @@error != 0
      begin
	 exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103037
	   /* 'Error en la creacion de producto asociado'*/
	 return 1
      end
      /* Transaccion servicios - cl_pro_asociado */

      insert into ts_pro_asociado (secuencia, tipo_transaccion, clase, fecha,
		  oficina_s, usuario, terminal_s, srv, lsrv,
		  base, btipo, asociado, atipo, fecha_reg)
      values (@s_ssn, 1517, 'N', @s_date,
	      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	      @i_base, @i_btipo, @i_asociado, @i_atipo, @w_today)
      if @@error != 0
      begin
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	     /* 'Error en creacion de transaccion de servicios'*/
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


/** Delete **/
if @i_operacion = 'D'
begin
if @t_trn = 1518
begin
/* Verificacion de claves foraneas */
select	@w_var = null
  from	cl_producto
 where	pd_producto = @i_base
   and  pd_tipo = @i_btipo
if @@rowcount = 0
begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101032
	 /*'No existe producto base'*/
     return 1
end

select	@w_var = null
  from	cl_producto
 where	pd_producto = @i_asociado
   and  pd_tipo = @i_atipo
if @@rowcount = 0
begin
     exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101032
	 /*'No existe producto base'*/
     return 1
end
begin tran
	delete from cl_pro_asociado
	 where pp_base = @i_base
           and pp_btipo = @i_btipo
	   and pp_asociado = @i_asociado
           and pp_atipo = @i_atipo
	if @@error != 0
	begin
		exec sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 107037
		/* Error al borrar producto asociado */
		return 1
	end	
	/* Transaccion de servicios */

      insert into ts_pro_asociado (secuencia, tipo_transaccion, clase, fecha,
		  oficina_s, usuario, terminal_s, srv, lsrv,
		  base, btipo, asociado, atipo, fecha_reg)
      values (@s_ssn, 1518, 'D', @s_date,
	      @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
	      @i_base, @i_btipo, @i_asociado, @i_atipo, @w_today)
      if @@error != 0
      begin
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	     /* 'Error en creacion de transaccion de servicios'*/
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



/** Search **/
If @i_operacion = 'S'
begin
If @t_trn = 15023
begin
if @i_tipo = 0
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Pd. Base' = pp_base,
                        'Tipo ' = pp_btipo,
			'Descripcion B.' = x.pd_descripcion,
			'Pd. Asociado' = pp_asociado,
			'Tipo' = pp_atipo,
			'Descripcion A.' = y.pd_descripcion
		  from 	cl_pro_asociado, cl_producto x, cl_producto y
		 where  x.pd_producto = pp_base
                   and  x.pd_tipo = pp_btipo
		   and  y.pd_producto = pp_asociado
  		   and  y.pd_tipo = pp_atipo
/*    		if @@rowcount = 0
    		begin
       			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101034
	 		 /*	'No existe producto asociado'*/
		set rowcount 0
       		return 1
   		end
*/
	end
	if @i_modo = 1
	begin
		select 'Pd. Base' = pp_base,
                        'Tipo ' = pp_btipo,
			'Descripcion B.' = x.pd_descripcion,
			'Pd. Asociado' = pp_asociado,
			'Tipo' = pp_atipo,
			'Descripcion A.' = y.pd_descripcion
		  from 	cl_pro_asociado, cl_producto x, cl_producto y
		 where  x.pd_producto = pp_base
		   and  y.pd_producto = pp_asociado
		   and  (
			(pp_base > @i_base)
		    or  ((pp_base = @i_base) and (pp_btipo > @i_btipo))
		    or  ((pp_base = @i_base) and (pp_btipo = @i_btipo)
			and (pp_asociado > @i_asociado))
		    or  ((pp_base = @i_base) and (pp_btipo = @i_btipo)
			and (pp_asociado = @i_asociado)
			and (pp_atipo > @i_atipo))
			)
/*    		if @@rowcount = 0
    		begin
       			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101034
	 		 /*	'No existe producto asociado'*/
		set rowcount 0
       		return 1
   		end
*/
	end
set rowcount 0
return 0
end
if @i_tipo = 1
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'P. Asociado' = pp_asociado,
			'Tipo' = pp_atipo,
			'Descripcion' = pd_descripcion
		  from 	cl_pro_asociado, cl_producto
		 where 	pd_producto = pp_asociado
		   and  pp_base = @i_base
		   and  pp_btipo = @i_btipo
/*    		if @@rowcount = 0
    		begin
       			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101034
	 		 /*	'No existe producto asociado'*/
		set rowcount 0
       		return 1
   		end
*/
	end
	if @i_modo = 1
	begin
		select 	'P. Asociado' = pp_asociado,
			'Tipo' = pp_atipo,
			'Descripcion' = pd_descripcion
		  from 	cl_pro_asociado, cl_producto
		 where 	pd_producto = pp_asociado
		   and  pp_base = @i_base
		   and  pp_btipo = @i_btipo
		   and	(
			(pp_asociado > @i_asociado)
		    or	((pp_asociado = @i_asociado) and (pp_atipo > @i_atipo))
			)
/*    		if @@rowcount = 0
    		begin
       			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101034
	 		 /*	'No existe producto asociado'*/
		set rowcount 0
       		return 1
   		end
*/
	end
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
go

