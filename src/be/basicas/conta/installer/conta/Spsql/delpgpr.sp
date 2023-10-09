/***********************************************************************/
/*	Archivo: 		delpgpr.sp 				*/
/*	Stored procedure: 	sp_delpgpr 				*/
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
/*	   Eliminacion de registros del plan_general presupuesto        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_delpgpr')
	drop proc sp_delpgpr   

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_delpgpr    (
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
	@i_oficina	smallint = null   ,
	@i_area		smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una cuenta */

	@w_empresa 	tinyint ,
	@w_cuenta 	cuenta,
	@w_oficina 	smallint,
	@w_estado 	char(1) ,
        @flag1 		int, 
	@flag2 		int, 
	@flag3 		int, 
	@padre_cta	char(20), 
	@padre_oficina 	smallint,
	@padre_area 	smallint,
	@temp_area	smallint,
	@temp_oficina	smallint,
	@w_cont 	int,
	@w_nombre	descripcion,
	@w_movimiento	char(1),
	@w_mov		char(1),
	@w_mov1		char(1),
	@w_categoria	char(10)

select @w_today = getdate()
select @w_sp_name = 'sp_delpgpr'



/************************************************/
/*  Tipo de Transaccion = 607X 			*/

if (@t_trn <> 6863 and @i_operacion = 'D') 
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
		i_cuenta 	= @i_cuenta,
		i_oficina 	= @i_oficina  
	exec cobis..sp_end_debug
end


/***** DELETE ******/

if @i_operacion = 'D'
begin
	select  @temp_oficina = @i_oficina,
		@temp_area = @i_area,
		@flag1 = 1

	select @w_cuenta = pgp_cuenta
	from cob_conta..cb_plan_general_presupuesto
	where 	pgp_empresa = @i_empresa and
		pgp_area  = @i_area and
		pgp_oficina = @i_oficina and
		pgp_cuenta = @i_cuenta 

	if @@rowcount = 0
	begin
     	 /* 'Cuenta de Movimiento no existe' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601055
		return 1
	end

/******* Relacion en Plan General *********/
        if exists(select pgp_cuenta from cob_conta..cb_plan_general_presupuesto
		where pgp_empresa = @i_empresa and
		pgp_area = @i_area and
		pgp_oficina in (select of_oficina from 
				cob_conta..cb_oficina
				where of_empresa = @i_empresa and
				of_oficina_padre = @i_oficina) and
		pgp_cuenta = @i_cuenta 
		 )
	begin
     	 /* 'Cuenta a eliminar es nivel superior de otras' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607045
		return 1
        end

	if exists(select pgp_cuenta from cob_conta..cb_plan_general_presupuesto
		  where pgp_empresa = @i_empresa and
			pgp_area in (select ar_area from
				    cob_conta..cb_area
				    where ar_empresa = @i_empresa and
				    ar_area_padre = @i_area) and
			pgp_oficina = @i_oficina and
		 	pgp_cuenta = @i_cuenta)
	begin
     	 /* 'Cuenta a eliminar es nivel superior de otras' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607045
		return 1
        end
/********* Saldos ************/

	select @w_cuenta = sap_cuenta
	from cob_conta..cb_saldo_presupuesto
	where 	sap_empresa = @i_empresa and
		sap_cuenta = @i_cuenta  and
		sap_oficina = @i_oficina and
		sap_area    = @i_area and
                sap_presupuesto <> 0 and
                sap_presupuesto is not null

	if @@rowcount > 0 
	begin
	      /* 'Cuenta de Movimiento relacionado con Saldos de presupuesto' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609141
		return 1
	end

/******** Relacion con plan general de cuentas  de presupuesto ***********/

	select @w_cuenta = gp_cuenta
	from cob_conta..cb_general_presupuesto
	where 	gp_empresa = @i_empresa and
		gp_oficina_presupuesto = @i_oficina and
		gp_area_presupuesto    = @i_area and
		gp_cuenta_presupuesto  = @i_cuenta 

	if @@rowcount > 0 
	begin
	  /*'Cuenta de Movimiento relacion.con cuentas del P.G.Presup.'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607131
		return 1
	end


begin tran

	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_plan_general_presupuesto
	values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa,@i_cuenta,@i_cuenta,@i_oficina,@i_area)

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

while @flag1 > 0
begin
	if @i_cuenta IS NOT NULL
	begin
		   if EXISTS (select 1 from cb_plan_general_presupuesto
		          where pgp_empresa = @i_empresa and
				pgp_area = @i_area and
				pgp_oficina = @i_oficina and
				pgp_cuenta = @i_cuenta )
		   begin
			delete cb_plan_general_presupuesto
			where 	pgp_empresa = @i_empresa and
				pgp_area = @i_area and
				pgp_oficina = @i_oficina and
				pgp_cuenta = @i_cuenta 
		   	if @@error <> 0
		   	begin
		      /* 'Error en la elimin relacion cuenta-oficina-area' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 607052
				return 1
			end
		   end

		 select @padre_cta = cu_cuenta_padre
		 from cb_cuenta       
		 where  cu_empresa   = @i_empresa and
			cu_cuenta = @i_cuenta

		 select @i_cuenta = @padre_cta

		if EXISTS (select 1 from cb_plan_general_presupuesto
			   where pgp_empresa = @i_empresa
				and pgp_oficina = @i_oficina 
				and pgp_area = @i_area
				and pgp_cuenta in 
				  (select cu_cuenta from cob_conta..cb_cuenta
				   where cu_cuenta_padre = @i_cuenta))
		begin
			select @flag1 = 0,
				@i_cuenta = null
		end
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
go
