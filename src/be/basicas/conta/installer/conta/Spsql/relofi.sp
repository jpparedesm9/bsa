/************************************************************************/
/*    Archivo:         relofi.sp                                        */
/*    Stored procedure:     sp_relofi                                   */
/*    Base de datos:      cob_conta                                     */
/*    Producto:               contabilidad                              */
/*    Disenado por:           Sandra de la Cruz                         */
/*    Fecha de escritura:     1/Agosto/1995                             */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/*                PROPOSITO                                             */
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento de relaciones entre oficinas Admin-Contabilidad     */
/*                MODIFICACIONES                                        */
/*    FECHA        AUTOR        RAZON                                   */
/*    01/Ago/1995    S. de la Cruz   Emision Inicial                    */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relofi')
	drop proc sp_relofi  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_relofi   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 605,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_filial	tinyint = null,
	@i_empresa	tinyint = null,
	@i_login   	varchar(10) = null,
	@i_ofadmin  	smallint = null ,
	@i_oficina  	smallint = null ,
	@i_ofconta  	smallint = null ,
	@i_ofadmin1  	smallint = null ,
	@i_ofconta1  	smallint = null,
	@i_area		smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_filial	tinyint,
	@w_empresa	tinyint,
	@w_ofadmin	smallint,	
	@w_ofconta	smallint,	
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_relofi'




/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6843 and @i_operacion = 'I') or
   (@t_trn <> 6844 and @i_operacion = 'D') or
   (@t_trn <> 6845 and @i_operacion = 'S') or
   (@t_trn <> 6846 and @i_operacion = 'C') 
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
		i_empresa	= @i_empresa,
		i_oficina	= @i_oficina,
		i_login		= @i_login,
		i_area		= @i_area
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' 
begin
	select 	@w_filial  = re_filial,
	 	@w_empresa = re_empresa,
		@w_ofadmin = re_ofadmin,
		@w_ofconta = re_ofconta
	from cb_relofi
	where 	re_filial = @i_filial and
	 	re_empresa = @i_empresa and
		re_ofadmin = @i_ofadmin and
		re_ofconta = @i_ofconta 

	if @@rowcount <> 0
		select @w_existe = 1
	else
		select @w_existe = 0
end 


/* Validacion de datos para insercion */
/**************************************/

if @i_operacion = 'I' 
begin
	/* Validacion de datos */
	/***********************/

	if	@i_filial  is NULL or 
		@i_empresa is NULL or 
		@i_ofadmin is NULL or
		@i_ofconta is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

end


/* Insercion de organizacion */
/*************************/

if @i_operacion = 'I'
begin
/*	if @w_existe = 1 or exists(select * from cb_relofi
				  where (re_ofadmin=@i_ofadmin
				  or re_ofconta=@i_ofconta) and
				     (re_filial=@i_filial and 
				     re_empresa=@i_empresa))
	
*/

if @w_existe = 1 or exists(select * from cb_relofi
				   where re_ofadmin=@i_ofadmin
				     and re_filial=@i_filial 
				     and re_empresa=@i_empresa)
	

	begin
			/* 'Relacion de oficinas ya existe ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601162
			return 1
		end
	
	/* Insercion del registro */
	/**************************/
	begin tran
		insert into cb_relofi
			(re_filial,re_empresa,re_ofadmin,re_ofconta)
		values  (@i_filial,@i_empresa,@i_ofadmin,@i_ofconta)
		if @@error <> 0 
		begin
			/* 'Error en insercion de relaciones entre oficinas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603063
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_relofi
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_oficina)

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
	commit tran
	return 0
end


/* Eliminacion de relaciones entre oficinas */
/********************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Relacion a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607127
		return 1
	end

/**** Integridad referencial ****/
/********************************/

	/* La relacion ofadmin, ofconta no puede ser eliminada si 
	   existe el plan de cuentas de esa oficina */

/*   Esta validacion no se debe hacer, se debe validar con cb_comprobante
       SYR 20/Mayo/1998 */

/*	if exists(select * from cb_plan_general
		  where pg_empresa=@i_empresa and
			pg_oficina=@i_ofconta)
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607131
			return 1
		end*/
		
	begin tran
		delete cb_relofi
		where re_filial = @i_filial and
		      re_empresa = @i_empresa and
		      re_ofadmin = @i_ofadmin and
		      re_ofconta = @i_ofconta 

		if @@error <> 0
		begin
		/* 'Error en eliminacion de control de ingreso de comp' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607128
			return 1
		end
		

		insert into ts_relofi
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_oficina)

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
	commit tran
	return 0
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
	--set rowcount 20
	if @i_modo = 0
	begin
--		select 	'Filial' = re_filial,
--			'Of. Admin' = re_ofadmin,
--			'Empresa' = re_empresa,
--			'Of. Conta' = re_ofconta
--		from cob_conta..cb_relofi
--		where 	re_filial = @i_filial and
--		 	re_empresa = @i_empresa /* and
--			(re_ofadmin = @i_ofadmin or @i_ofadmin is null) and	
--			(re_ofconta = @i_ofconta or @i_ofconta is null) */
--		order by re_filial,re_empresa,re_ofadmin,re_ofconta

		select 	'Filial' = re_filial,
			'Of. Admin' = re_ofadmin,
			'Empresa' = re_empresa,
			'Of. Conta' = re_ofconta,
                        'Nombre' = of_descripcion
		from cob_conta..cb_relofi, 
                     cob_conta..cb_oficina
		where 	re_filial = @i_filial and
		 	re_empresa = @i_empresa and 
                        of_empresa = @i_empresa and
                        of_oficina = re_ofconta 
		order by re_filial,re_empresa,re_ofadmin,re_ofconta

		if @@rowcount = 0
		begin
			/* 'No existen registros para la consulta dada'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
--		select 	'Filial' = re_filial,
--			'Of. Admin' = re_ofadmin,
--			'Empresa' = re_empresa,
--			'Of. Conta' = re_ofconta
--		from cob_conta..cb_relofi
--		where 	re_filial = @i_filial and
--			re_empresa = @i_empresa and
--			(re_ofadmin = @i_ofadmin or @i_ofadmin is null) and	
--			(re_ofconta = @i_ofconta or @i_ofconta is null) and
--		        (re_ofadmin = @i_ofadmin1 and
--			 re_ofconta > @i_ofconta1) or
--			(re_ofadmin > @i_ofadmin1)
--		order by re_filial,re_empresa,re_ofadmin,re_ofconta

		select 	'Filial' = re_filial,
			'Of. Admin' = re_ofadmin,
			'Empresa' = re_empresa,
			'Of. Conta' = re_ofconta,
                        'Nombre' = of_descripcion
		from cob_conta..cb_relofi,
                     cob_conta..cb_oficina
		where 	re_filial = @i_filial and
			re_empresa = @i_empresa and
			(re_ofadmin = @i_ofadmin or @i_ofadmin is null) and	
			(re_ofconta = @i_ofconta or @i_ofconta is null) and
		        (re_ofadmin = @i_ofadmin1 and
			 re_ofconta > @i_ofconta1) or
			(re_ofadmin > @i_ofadmin1) and
                        of_empresa = @i_empresa and
                        of_oficina = re_ofconta 
		order by re_filial,re_empresa,re_ofadmin,re_ofconta

		if @@rowcount = 0
		begin
			/* 'No existen Mas registros'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
			return 1
		end
		set rowcount 0
		return 0
	end
end

if @i_operacion = 'C'
begin
	select re_empresa,re_ofconta
	from cb_relofi
	where re_filial=@i_filial and
	      re_ofadmin=@i_ofadmin
	if @@rowcount=0
		begin
			/* 'No existen registros para la consulta dada'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
			return 1
		end
end
go
