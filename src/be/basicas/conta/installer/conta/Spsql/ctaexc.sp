/************************************************************************/
/*	Archivo: 		relcta.sp				*/
/*	Stored procedure: 	sp_relcta_exc				*/
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
/*	   Seleccion de cuentas pertenecientes a una oficina y area     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relcta_exc')
	drop proc sp_relcta_exc   

go
create proc sp_relcta_exc    (
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
	@i_cuenta1	cuenta = null,
	@i_nivel_igual  tinyint = null,
	@i_nivel_menor  tinyint = null,
	@i_proceso	int	= null

)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int 		/* codigo existe = 1 
				               no existe = 0 */
select @w_today = getdate()
select @w_sp_name = 'sp_relcta_exc'

/************************************************/
/*  Tipo de Transaccion = 607X 			*/

if (@t_trn <> 6814 and (@i_operacion = 'A' or @i_operacion = 'G')) 
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
if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Cuenta' = pg_cuenta,
			'Nombre de Cuenta' = substring(cu_nombre,1,32) 
		from cb_cuenta,cb_plan_general
		where	cu_empresa = @i_empresa and
		       (cu_nivel_cuenta = @i_nivel_igual or
			  @i_nivel_igual = 0) and
		       (cu_nivel_cuenta <= @i_nivel_menor or
			  @i_nivel_menor = 0) and 
			pg_empresa = cu_empresa and
                        pg_oficina = @i_oficina  and
		        pg_area = @i_area and
		        pg_cuenta like @i_cuenta and
		        pg_cuenta  = cu_cuenta 
		order by pg_cuenta 
	end /* modo = 0 */
	if @i_modo = 1
	begin
		select 	'Cuenta' = pg_cuenta,
			'Nombre de Cuenta' = substring(cu_nombre,1,32) 
		from cb_cuenta,cb_plan_general
		where	cu_empresa = @i_empresa and
		       (cu_nivel_cuenta = @i_nivel_igual or
			  @i_nivel_igual = 0) and
		       (cu_nivel_cuenta <= @i_nivel_menor or
			  @i_nivel_menor = 0) and 
			pg_empresa = cu_empresa and
		      pg_oficina = @i_oficina  and
		      pg_area = @i_area  and
		      pg_cuenta like @i_cuenta and
		      pg_cuenta > @i_cuenta1 and
                      pg_cuenta = cu_cuenta
		order by pg_cuenta 
	end /* modo 1 */

	if @i_modo = 2
	begin
		select 	'Cuenta' = cp_cuenta,
			'Nombre de Cuenta' = substring(cu_nombre,1,32) 
		from cb_cuenta_proceso,cb_cuenta
		where	cp_empresa = @i_empresa and
			cp_proceso = @i_proceso and
			cu_empresa = @i_empresa and
			cu_cuenta  = cp_cuenta
		order by cp_cuenta

	end /* modo = 2 */

	if @i_modo = 3
	begin
		select distinct	'Cuenta' = cp_cuenta,
			'Nombre de Cuenta' = substring(cu_nombre,1,32) 
		from cb_cuenta_proceso,cb_cuenta
		where	cp_empresa = @i_empresa and
			cp_proceso = @i_proceso and
			cp_cuenta  > @i_cuenta1 and
			cu_empresa = cp_empresa and
			cu_cuenta  = cp_cuenta
		order by cp_cuenta
	end /* modo 3 */

	if @i_modo = 4
	begin
		select distinct pg_cuenta,substring(cu_nombre,1,32) 
		from cb_jerarquia, cb_jerararea,cb_cuenta,cb_plan_general
		where	cu_empresa = @i_empresa and
		       (cu_nivel_cuenta = @i_nivel_igual or
			  @i_nivel_igual = 0) and
		       (cu_nivel_cuenta <= @i_nivel_menor or
			  @i_nivel_menor = 0) and 
			je_empresa = @i_empresa and
			je_oficina_padre = @i_oficina and
			ja_empresa = je_empresa and
			ja_area_padre = @i_area and
			pg_empresa = cu_empresa and
                        pg_oficina = je_oficina  and
		        pg_area = ja_area and
		        pg_cuenta like @i_cuenta and
		        pg_cuenta  = cu_cuenta 
		order by pg_cuenta 
	end /* modo = 4 */

	if @i_modo = 5
	begin
		select 	distinct pg_cuenta,substring(cu_nombre,1,32) 
		from cb_cuenta,cb_jerarquia,cb_jerararea,cb_plan_general
		where	cu_empresa = @i_empresa and
		       (cu_nivel_cuenta = @i_nivel_igual or
			  @i_nivel_igual = 0) and
		       (cu_nivel_cuenta <= @i_nivel_menor or
			  @i_nivel_menor = 0) and 
			je_empresa = cu_empresa and
			je_oficina_padre = @i_oficina and
			ja_empresa = je_empresa and
			ja_area_padre = @i_area and
			pg_empresa = cu_empresa and
		      pg_oficina = je_oficina  and
		      pg_area = ja_area  and
		      pg_cuenta like @i_cuenta and
		      pg_cuenta > @i_cuenta1 and
                      pg_cuenta = cu_cuenta
		order by pg_cuenta 
	end /* modo 5 */




/*
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
*/
	return 0
end

if @i_operacion = 'G'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	distinct 'Cuenta' = pg_cuenta
		from cb_cuenta,cb_plan_general
		where	pg_empresa = @i_empresa and
                        pg_oficina = @i_oficina and
			cu_empresa = @i_empresa and
		        cu_nivel_cuenta <= @i_nivel_igual and
			pg_empresa = cu_empresa and
		        pg_cuenta  = cu_cuenta and
 			pg_area = @i_area
		order by pg_cuenta 
	end /* modo = 0 */
	if @i_modo = 1
	begin
		select 	distinct 'Cuenta' = pg_cuenta
		from cb_cuenta,cb_plan_general
		where	pg_empresa = @i_empresa and
                        pg_oficina = @i_oficina and
			cu_empresa = @i_empresa and
		        cu_nivel_cuenta <= @i_nivel_igual and
			pg_empresa = cu_empresa and
		        pg_cuenta  = cu_cuenta and
		        pg_cuenta > @i_cuenta1 and
 			pg_area = @i_area
		order by pg_cuenta 
	end /* modo 1 */
	return 0
end

go
