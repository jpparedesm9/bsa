/************************************************************************/
/*	Archivo: 		plgenpre.sp  			        */
/*	Stored procedure: 	sp_plgenpre				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Gonzalo Jaramillo  	        	*/
/*	Fecha de escritura:     24-Octubre-1994				*/
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
/*	   Mantenimiento al catalogo de Plan general de Presupuesto     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	24/Oct/1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_plgenpre')
	drop proc sp_plgenpre  

go
create proc sp_plgenpre (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa              tinyint = null,
	@i_cuenta_presu		cuenta= null,
	@i_oficina_pre		smallint=null,
	@i_area_pre		smallint=null,
	@i_cuenta         	cuenta= null,
	@i_oficina		smallint = null,
	@i_area  		smallint = null, 
	@i_bandera  		int = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_cuenta_presu		cuenta,
	@w_oficina_pre		smallint,
	@w_area_pre		smallint,
	@w_cuenta         	cuenta,
	@w_empresa		tinyint,
	@w_oficina		smallint,
	@w_area			smallint,
	@w_existe		int,
        @flag1 			int, 
	@padre_cta		char(20)


select @w_today = getdate()
select @w_sp_name = 'sp_plgenpre'


/************************************************/
/*  Tipo de Transaccion = 601X 			*/

if (@t_trn <> 6591 and @i_operacion = 'I') or
   (@t_trn <> 6592 and @i_operacion = 'U') or
   (@t_trn <> 6593 and @i_operacion = 'D') or
   (@t_trn <> 6596 and @i_operacion = 'Q')
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
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,
		i_cuenta_presu  = @i_cuenta_presu,
		i_cuenta   	= @i_cuenta ,
                i_oficina	= @i_oficina,
		i_area		= @i_area
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

-- M. Morales 11/10/1999


        if exists(
	select  *
	from cob_conta..cb_general_presupuesto
	where 	gp_empresa = @i_empresa and 
		gp_cuenta_presupuesto = @i_cuenta_presu and
		gp_oficina_presupuesto = @i_oficina_pre and
		gp_area_presupuesto = @i_area_pre and
		gp_cuenta = @i_cuenta and
		gp_oficina = @i_oficina_pre and
		gp_area    = @i_area_pre
        )
	Begin
		select @w_existe = 1 
		if @i_operacion != 'I'
		begin
			select  @w_empresa = gp_empresa,
				@w_cuenta_presu = gp_cuenta_presupuesto,
				@w_cuenta = gp_cuenta,
				@w_oficina = gp_oficina,
				@w_area    = gp_area
			from cob_conta..cb_general_presupuesto
			where 	gp_empresa = @i_empresa and 
				gp_cuenta_presupuesto = @i_cuenta_presu and
				gp_oficina_presupuesto = @i_oficina_pre and
				gp_area_presupuesto = @i_area_pre and
				gp_cuenta = @i_cuenta and
				gp_oficina = @i_oficina_pre and
				gp_area    = @i_area_pre
		End
	End
	else
		select @w_existe = 0

	

/*
if @i_operacion = 'I'
begin
        if exists(
	select  *
	from cob_conta..cb_general_presupuesto
	where 	gp_empresa = @i_empresa and 
		gp_cuenta_presupuesto = @i_cuenta_presu and
		gp_oficina_presupuesto = @i_oficina_pre and
		gp_area_presupuesto = @i_area_pre and
		gp_cuenta = @i_cuenta and
		gp_oficina = @i_oficina_pre and
		gp_area    = @i_area_pre
        )
		select @w_existe = 1 
	else
		select @w_existe = 0

end
else
begin

	select  @w_empresa = gp_empresa,
		@w_cuenta_presu = gp_cuenta_presupuesto,
		@w_cuenta = gp_cuenta,
		@w_oficina = gp_oficina,
		@w_area    = gp_area
	from cob_conta..cb_general_presupuesto
	where 	gp_empresa = @i_empresa and 
		gp_cuenta_presupuesto = @i_cuenta_presu and
		gp_oficina_presupuesto = @i_oficina_pre and
		gp_area_presupuesto = @i_area_pre and
		gp_cuenta = @i_cuenta and
		gp_oficina = @i_oficina_pre and
		gp_area    = @i_area_pre

	if @@rowcount > 0
		select @w_existe = 1 
	else
		select @w_existe = 0
end
*/

-- M. Morales 11/10/1999
/* Insercion de cuenta */
/*************************/

if @i_operacion = 'I'
begin

if @i_bandera = 1 
begin	
	if not exists (select *
			from cb_plan_general_presupuesto
			where pgp_empresa = @i_empresa and
			pgp_oficina = @i_oficina_pre and
			pgp_area = @i_area_pre and
			pgp_cuenta = @i_cuenta_presu)
	begin
		/* 'Relacion cuenta,oficina,area de presupuesto no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601166
		return 1
	end


	if not exists (select *
			from cb_plan_general
			where pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
			pg_area = @i_area and
			pg_cuenta = @i_cuenta)
	begin
		/* 'Relacion cuenta,oficina,area del plan general no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601167
		return 1
	end


	if @w_existe = 1 
	begin
		/* 'Codigo de plan general de presupuesto ya existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601142
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	print 'antes'
	if exists (select *
			from cob_conta..cb_general_presupuesto
			where gp_empresa = @i_empresa and
			gp_oficina = @i_oficina_pre and
			gp_area = @i_area_pre and
			gp_cuenta = @i_cuenta_presu)
	begin

		/* 'Ya existe la cuenta con la asociacion en la tabla ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609142
		return 1

        end
	print 'despues'

	begin tran
		insert into cob_conta..cb_general_presupuesto
		(gp_empresa,gp_cuenta_presupuesto,gp_oficina_presupuesto,
		 gp_area_presupuesto,gp_cuenta,gp_oficina,gp_area)
		values (@i_empresa,@i_cuenta_presu,@i_oficina_pre,
			@i_area_pre,@i_cuenta,@i_oficina,@i_area)
		if @@error <> 0 
		begin
		/*'Error en insercion de Plan general de presupuesto'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603054
			return 1
		end

	commit tran
	return 0

end 
else
begin

/*	if not exists (select *
			from cb_plan_general_presupuesto
			where pgp_empresa = @i_empresa and
			pgp_oficina = @i_oficina_pre and
			pgp_area = @i_area_pre and
			pgp_cuenta = @i_cuenta_presu)
	begin
		/* 'Relacion cuenta,oficina,area de presupuesto no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601166
		return 1
	end */

	
	if not exists (select *
			from cb_plan_general
			where pg_empresa = @i_empresa and
			pg_oficina = @i_oficina and
			pg_area = @i_area and
			pg_cuenta = @i_cuenta)
	begin
		/* 'Relacion cuenta,oficina,area del plan general no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601167
		return 1
	end


	if @w_existe = 1 
	begin
		/* 'Codigo de plan general de presupuesto ya existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601142
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	if exists (select *
			from cob_conta..cb_general_presupuesto
			where gp_empresa = @i_empresa and
			gp_oficina = @i_oficina and
			gp_area = @i_area and
			gp_cuenta = @i_cuenta)
	begin

		/* 'Ya existe la cuenta con la asociacion en la tabla ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609142
		return 1

        end
        select @flag1 = 1

	begin tran
	while @flag1 > 0
	begin
	        if @i_cuenta_presu IS NOT NULL
	        begin
	                if NOT EXISTS (select * from cb_general_presupuesto
	                where   gp_empresa = @i_empresa and
	                        gp_oficina = @i_oficina and
	                        gp_area    = @i_area and	
	                        gp_cuenta = @i_cuenta_presu)
	                begin

				Begin Tran 

				insert into cob_conta..cb_general_presupuesto
				(gp_empresa,gp_cuenta_presupuesto,gp_oficina_presupuesto,
				 gp_area_presupuesto,gp_cuenta,gp_oficina,gp_area)
				values (@i_empresa,@i_cuenta_presu,@i_oficina,
					@i_area,@i_cuenta_presu,@i_oficina,@i_area)
				if @@error <> 0 
				begin
				/*'Error en insercion de Plan general de presupuesto'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 603054
					rollback
					return 1
				end
				commit tran
			end

	                if NOT EXISTS (select * from cb_plan_general_presupuesto
	                where   pgp_empresa = @i_empresa and
	                        pgp_oficina = @i_oficina and
	                        pgp_area    = @i_area and	
	                        pgp_cuenta = @i_cuenta_presu)
	                begin

				Begin tran

				insert into cob_conta..cb_plan_general_presupuesto
				(pgp_empresa,pgp_cuenta,pgp_oficina,pgp_area)
				values (@i_empresa,@i_cuenta_presu,@i_oficina,@i_area)
				if @@error <> 0 
				begin
				/*'Error en insercion de Plan general de presupuesto'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 603054
					rollback
					return 1
				end
				commit tran
			end

	                select @padre_cta = cu_cuenta_padre
	                from cb_cuenta
	                where   cu_empresa = @i_empresa and
	                        cu_cuenta = @i_cuenta_presu

	                select @i_cuenta_presu = @padre_cta
	                continue
	        end
	        else
	        begin
	             select @flag1 = 0
	             continue
	        end 
	end

	commit tran
	return 0
end
end

/* Eliminacion de cuenta  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
	/*'Codigo de plan general de presupuesto a eliminar NO existe' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607114
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_general_presupuesto
		where 	gp_empresa = @i_empresa and
			gp_cuenta_presupuesto = @i_cuenta_presu and
			gp_oficina_presupuesto = @i_oficina_pre and
			gp_area_presupuesto = @i_area_pre and
			gp_cuenta = @i_cuenta and
			gp_oficina = @i_oficina_pre and
			gp_area = @i_area_pre

		if @@error <> 0
		begin
		/* 'Error en Eliminacion de plan general de presupuesto' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607115
			return 1
		end

  		delete cob_conta..cb_plan_general_presupuesto
		where 	pgp_empresa = @i_empresa and
			pgp_cuenta = @i_cuenta_presu and
			pgp_oficina = @i_oficina_pre and
			pgp_area = @i_area_pre

		if @@error <> 0
		begin
		/* 'Error en Eliminacion de plan general de presupuesto' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607115
			return 1
		end

/*
	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_plan_general_presupuesto
	values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
		@w_empresa,@w_cuenta_presu,@w_cuenta,@w_oficina,
		@w_area)

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
	/****************************************/
*/
         commit tran
	 return 0
end

/******Consulta plan general de presupuesto opcion Query ******/

if @i_operacion = 'Q'
begin
	if @i_modo = 0
	begin
		select 'Cuenta' = gp_cuenta,
		       'Oficina' = gp_oficina,
		       'Area'    = gp_area,
		       'Descripcion' = cu_nombre
		from cob_conta..cb_general_presupuesto,
		     cob_conta..cb_cuenta
		where gp_empresa = @i_empresa and
		      gp_cuenta_presupuesto = @i_cuenta_presu and
		      gp_oficina_presupuesto = @i_oficina_pre and
		      gp_area_presupuesto    = @i_area_pre and
		      gp_empresa = cu_empresa and
                      gp_cuenta  = cu_cuenta
		order by gp_cuenta

		if @@rowcount = 0
		begin
		/*'No existen registros relacionados a la cuenta de presupuesto'*/
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 601143
		  return 1
	        end
	end
	else begin
		select 'Cuenta' = gp_cuenta,
		       'Oficina' = gp_oficina,
		       'Area'    = gp_area,
		       'Descripcion' = cu_nombre
		from cob_conta..cb_general_presupuesto,
		     cob_conta..cb_cuenta
		where gp_empresa = @i_empresa and
		      gp_cuenta_presupuesto = @i_cuenta_presu and
		      gp_oficina = @i_oficina_pre and
		      gp_area    = @i_area_pre and
		      gp_oficina = @i_oficina and
		    ((gp_cuenta = @i_cuenta and
		      gp_oficina = @i_oficina and
		      gp_area > @i_area) or
		     (gp_cuenta = @i_cuenta and
		      gp_oficina > @i_oficina) or
		     (gp_cuenta > @i_cuenta)) and
		      gp_empresa = cu_empresa and
		      gp_cuenta = cu_cuenta
		order by gp_cuenta

		if @@rowcount = 0
		begin
		/*'No existen Mas registros relacionados a la cuenta de presupuesto'*/
		  exec cobis..sp_cerror
		  @t_debug = @t_debug,
		  @t_file	 = @t_file,
		  @t_from	 = @w_sp_name,
		  @i_num	 = 601144
		  return 1
	        end
	end	
	return 0
end
go
