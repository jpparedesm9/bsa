/************************************************************************/
/*	Archivo: 		relacion.sp				*/
/*	Stored procedure: 	sp_relacion				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           G. Jaramillo                        	*/
/*	Fecha de escritura:     04-Agosto-1993				*/
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
/*	   Mantenimiento al catalogo de Plan General                    */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	09-Feb-1999	Juan C. G¢mez	Nuevo par metro y eliminaci¢n 	*/
/*					del substring	JCG10		*/
/*	08-Mar-1999	Juan C. G¢mez	Cambio en el query JCG20	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relacion')
	drop proc sp_relacion
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_relacion    (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa 	tinyint = null,
	@i_cuenta 	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_transer	char(1) = null,
	@i_cuenta1	cuenta = null,
	@i_cuenta2	cuenta = null,
	@i_oficina1	smallint = null,
	@i_area1	smallint = null,
	@i_movimiento	char(1)  = "%",
	@i_sinonimo	char(20) = null,
	@i_error	smallint = null,
	@i_estado	char(1) = 'Z'
)
as
declare	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_existe	int,		/* codigo existe = 1
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */
	@w_cuenta 	cuenta,
	@w_area		smallint,
	@w_area1	smallint,
	@w_area2	smallint,
	@w_oficina1	smallint,
	@w_oficina2	smallint

select @w_sp_name = 'sp_relacion'

/************************************************/
/*  Tipo de Transaccion = 607X 			*/

if (@t_trn <> 6071 and @i_operacion = 'I') or
   (@t_trn <> 6075 and @i_operacion = 'S') or
   (@t_trn <> 6337 and @i_operacion = 'A') or
   (@t_trn <> 6079 and (@i_operacion = 'E' or @i_operacion = 'D')) or
   (@t_trn <> 6080 and @i_operacion = 'M') or
   (@t_trn <> 6076 and @i_operacion = 'V') or
   (@t_trn <> 6081 and @i_operacion = 'Q')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		s_ssn		= @s_ssn,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,
		i_cuenta 	= @i_cuenta,
		i_oficina 	= @i_oficina
	exec cobis..sp_end_debug
end

if @i_area is null
begin
	select  @w_area1 = 0,
	       	@w_area2 = 9999
end
else begin
	select 	@w_area1 = @i_area,
	       	@w_area2 = @i_area
end

if @i_oficina is null
begin
	select 	@w_oficina1 = 0,
	      	@w_oficina2 = 9999
end
else begin
	select  @w_oficina1 = @i_oficina,
		@w_oficina2 = @i_oficina
end


if @i_operacion = 'I'
begin
	begin tran
		if exists (select 1 from cb_plan_general
				where   pg_empresa = @i_empresa and
				pg_oficina = @i_oficina and
				pg_area    = @i_area and
				pg_cuenta = @i_cuenta)
		begin
			/* 'Cuenta de movimiento ya existe' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601053
			return 1
		end
		else
		begin
			insert cb_plan_general (pg_empresa,pg_cuenta,
			pg_oficina,pg_area,pg_clave)
			values (@i_empresa,@i_cuenta,@i_oficina,@i_area,
			convert(varchar(30), convert(varchar(5),@i_empresa) + 
			convert(varchar(15),@i_cuenta) + convert(varchar(8),@i_oficina) + 
			convert(varchar(8),@i_area)))
			if @@error <> 0
			begin	/* 'Error en la insercion de la relacion cuenta-oficina'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file       = @t_file,
				@t_from       = @w_sp_name,
				@i_num        = 601054
				return 1
			end

			if @i_transer = 'S'
			begin
				/* TRANSACCION DE SERVICIO */
				insert into ts_plan_general
				values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
				@i_empresa,@i_cuenta,@i_oficina,@i_area)
				if @@error <> 0
				begin
					/* 'Error en insercion de transaccion de servicio' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 603032
					return 1
				end
			end
		end
	commit tran
	return 0
end       /* operacion 'I' */



if @i_operacion = 'S'    /* Search */
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select pg_oficina,pg_area
		from cb_plan_general,cb_oficina,cb_area
		where 	pg_empresa = @i_empresa and
			pg_oficina = of_oficina and
			pg_area = ar_area and
			pg_cuenta  = @i_cuenta  and
                        of_empresa = @i_empresa and
			of_movimiento = 'S' and
                        ar_empresa = @i_empresa and
			ar_movimiento = 'S'
                order by pg_oficina, pg_area
		if @@rowcount = 0
		begin
		      /* 'No existen Cuentas'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601029
			return 1
		end
	end
	else
	begin
		select pg_oficina,pg_area
		from cb_plan_general,cb_oficina,cb_area
		where pg_empresa = @i_empresa and
		      ((pg_oficina = @i_oficina1 and pg_area > @i_area1) or
			(pg_oficina > @i_oficina1)) and
			pg_cuenta = @i_cuenta and
			pg_oficina = of_oficina and
			pg_area = ar_area and
                        of_empresa = @i_empresa and
			of_movimiento = 'S' and
                        ar_empresa = @i_empresa and
			ar_movimiento = 'S'
                order by pg_oficina, pg_area
		if @@rowcount = 0
		begin
			return 1
		end
	end
	return 0
end


if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
			select 	'Cuenta' = pg_cuenta,
				'Nombre de Cuenta' = cu_nombre,
				'Oficina' = pg_oficina  ,
				'Area '   = pg_area,
				'Moneda '   = cu_moneda,
				'Estado '   = cu_estado,
				'Movimiento'   = cu_movimiento,
                                'Afectacion' = cu_acceso
			from cob_conta..cb_plan_general,cb_cuenta
			where pg_empresa = @i_empresa and
			     (pg_oficina between @w_oficina1 and @w_oficina2)
			 and (pg_area between @w_area1 and @w_area2) and
			      pg_cuenta like @i_cuenta and
			      pg_empresa = cu_empresa and
			      pg_cuenta = cu_cuenta
                          and cu_movimiento like @i_movimiento
			  and cu_estado <> @i_estado
			order by pg_cuenta, pg_oficina, pg_area
	end /* modo = 0 */
	else begin
		select 	'Cuenta' = pg_cuenta,
			'Nombre de Cuenta' = cu_nombre,
			'Oficina' = pg_oficina ,
			'Area' = pg_area,
			'Moneda '   = cu_moneda,
			'Estado '   = cu_estado,
			'Movimiento'   = cu_movimiento,
                        'Afectacion' = cu_acceso
		from cob_conta..cb_plan_general,cb_cuenta
		where pg_empresa = @i_empresa and
		      (pg_oficina between @w_oficina1 and @w_oficina2) and
		      (pg_area between @w_area1 and @w_area2) and
		      ((pg_cuenta like @i_cuenta1 and
		        pg_oficina = @i_oficina1 and
			pg_area > @i_area1)       or
		       (pg_cuenta like @i_cuenta1  and
			pg_oficina > @i_oficina1) or
		       (pg_cuenta > @i_cuenta1))   and
		       pg_empresa = cu_empresa and
                       pg_cuenta = cu_cuenta and
		       cu_movimiento like @i_movimiento
		   and cu_estado <> @i_estado
		   order by pg_cuenta, pg_oficina, pg_area
	end /* modo 1 */

	if @@rowcount = 0
	begin
           if @i_error <> 1
           begin
	      /* 'No existen Cuentas'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601029
           end
           set rowcount 0
           return 1
	end
        set rowcount 0
	return 0
end


if @i_operacion = 'D'
begin
	select cu_nombre
	from cob_conta..cb_plan_general,cob_conta..cb_cuenta
	where 	pg_empresa = @i_empresa and
		pg_cuenta = @i_cuenta and
		pg_empresa = cu_empresa and
		pg_cuenta = cu_cuenta and
                cu_movimiento = 'S'
	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601109
		return 1
	end
	return 0
end


if @i_operacion = 'E'
begin
	select cu_nombre
	from cob_conta..cb_plan_general,cob_conta..cb_cuenta
	where 	pg_empresa = @i_empresa and
		pg_cuenta = @i_cuenta and
		pg_empresa = cu_empresa and
		pg_cuenta = cu_cuenta
	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601065
		return 1
	end
	return 0
end


if @i_operacion = 'Q'
begin
	select cu_nombre
	from cob_conta..cb_plan_general,cob_conta..cb_cuenta
	where 	pg_empresa = @i_empresa and
		pg_oficina = @i_oficina and
		pg_area = @i_area and
		pg_cuenta = @i_cuenta and
		pg_empresa = cu_empresa and
		pg_cuenta = cu_cuenta
	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no esta asociada como de Presupuesto'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601024
		return 1
	end
	return 0
end


if @i_operacion = 'V'
begin
	select cu_cuenta, substring(cu_nombre,1,32)
	from cob_conta..cb_plan_general,cob_conta..cb_cuenta
	where 	pg_empresa = @i_empresa and
		pg_oficina = @i_oficina and
		pg_cuenta = @i_cuenta and
		pg_empresa = cu_empresa and
		pg_cuenta = cu_cuenta
	if @@rowcount = 0
	begin
		/* 'Cuenta consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601028
		return 1
	end
	return 0
end


/*I-----------------------------------------I*/
/*I Operacion M= Procesos Multiples         I*/
/*I Copia plan general de una oficina a otraI*/
/*I-----------------------------------------I*/
if @i_operacion= 'M'
begin
   declare cursor_plangeneral cursor
       for select pg_area,pg_cuenta
             from cb_plan_general
            where pg_empresa = @i_empresa
              and pg_oficina = @i_oficina
       for read only
   --set cursor rows 1 for cursor_plangeneral
   open cursor_plangeneral
   select @w_existe = 0
   begin tran
   fetch cursor_plangeneral into @w_area, @w_cuenta
   while (@@fetch_status = 0)
   begin
	if exists (select 1 from cb_plan_general where
	                       pg_empresa = @i_empresa and
	                       pg_oficina = @i_oficina1 and
	                       pg_area    = @w_area and
	                       pg_cuenta  = @w_cuenta)
	goto LABEL2
	else
	begin
		insert cb_plan_general (pg_empresa,pg_cuenta,pg_oficina,pg_area,pg_clave)
		values (@i_empresa,@w_cuenta,@i_oficina1,@w_area,
		convert(varchar(30), convert(varchar(5),@i_empresa) + 
		convert(varchar(15),@w_cuenta) + convert(varchar(8),@i_oficina1) + 
		convert(varchar(8),@w_area)))
	end
LABEL2:
       fetch cursor_plangeneral into @w_area, @w_cuenta
   end
   commit tran
   close cursor_plangeneral
   deallocate cursor_plangeneral
   return 0
end

go
