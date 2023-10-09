/************************************************************************/
/*	Archivo: 		relpre.sp				*/
/*	Stored procedure: 	sp_relpre				*/
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
/*	25/Jul/1995	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_relpre')
	drop proc sp_relpre   

go
create proc sp_relpre    (
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
	@i_sinonimo	char(20) = null

)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */

	@w_empresa 	tinyint ,
	@w_cuenta 	cuenta,
	@w_movimiento 	char(1),
	@w_nombre	descripcion,
	@w_estado 	char(1) ,
    @flag1 		int, 
	@flag2 		int, 
	@flag3 		int, 
	@padre_cta	cuenta,
	@padre_area	smallint,
	@padre_oficina	int,
	@temp_oficina	smallint,
	@temp_area	smallint,
	@cuenta_nom 	varchar(64),
	@oficina_nom	varchar(64),
	@w_tipo_plan	char(2),
	@w_depto	char(2),
	@w_moneda	tinyint,
	@w_moneda_base	tinyint,
	@w_extranjera	char(1),
	@w_usadeci	char(1),
	@w_area		smallint,
	@w_cont 	int 

select @w_today = getdate()
select @w_sp_name = 'sp_relpre'

/************************************************/
/*  Tipo de Transaccion = 607X 			*/

if (@t_trn <> 6862 and @i_operacion = 'I') or
   (@t_trn <> 6865 and @i_operacion = 'S') or
   (@t_trn <> 6911 and @i_operacion = 'A') or
   (@t_trn <> 6909 and @i_operacion = 'E') 
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


if @i_operacion = 'I'
begin

     select @temp_oficina = @i_oficina,
	    @temp_area    = @i_area,
       	    @flag1 = 1

     select @w_cuenta = pgp_cuenta
     from cob_conta..cb_plan_general_presupuesto
     where pgp_empresa = @i_empresa 
     and   pgp_oficina = @i_oficina 
     and   pgp_area    = @i_area 
     and   pgp_cuenta  = @i_cuenta 

     if @@rowcount > 0
     begin
      /*'Cuenta de movimiento ya existe' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601053
	return 1
     end

    begin tran
     if @i_transer = 'S'
     begin
	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_plan_general_presupuesto
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
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
     end

     while @flag1 > 0
     begin
	if @i_cuenta IS NOT NULL
	begin
		if NOT EXISTS (select 1 from cb_plan_general_presupuesto
		where 	pgp_empresa = @i_empresa and
			pgp_oficina = @i_oficina and
			pgp_area    = @i_area and
			pgp_cuenta  = @i_cuenta) 
		begin
		 	insert cb_plan_general_presupuesto (pgp_empresa,pgp_cuenta,
                        pgp_oficina,pgp_area)
		   	values (@i_empresa,@i_cuenta,@i_oficina,@i_area)

		        if @@error <> 0
		        begin
		      /* 'Error en la insercion de la relacion cuenta-oficina'*/
			   exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 601054
			   return 1
		   	 end
	   	end

		select @padre_cta = cu_cuenta_padre
		from cb_cuenta
		where 	cu_empresa = @i_empresa and
			cu_cuenta = @i_cuenta

		select @i_cuenta = @padre_cta
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
end       /* operacion 'I' */


if @i_operacion = 'S'    /* Search */
begin
	set rowcount 200
	if @i_modo = 0
	begin
		select pgp_oficina,pgp_area
		from cb_plan_general_presupuesto --(index cb_plan_general_pr_Key)
		where  pgp_empresa = @i_empresa and
			pgp_cuenta = @i_cuenta  
		order by pgp_oficina,pgp_area
		
		if @@rowcount = 0
		begin
		      /* 'No existen Cuentas relacionadas a oficina'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601029
			return 1
		end
	end
	if @i_modo = 1
	begin
		select pgp_oficina,pgp_area
		from cb_plan_general_presupuesto --(index cb_plan_general_pr_Key)
		where 	
			pgp_empresa = @i_empresa and
		        pgp_cuenta = @i_cuenta and
		   	pgp_oficina = @i_oficina1 and 
			pgp_area > @i_area1  
		order by pgp_oficina, pgp_area

		if @@rowcount = 0
		begin
			return 1
		end
	end			
	if @i_modo = 2
	begin
		select pgp_oficina,pgp_area
		from 	cb_plan_general_presupuesto --(index cb_plan_general_pr_Key)
		where 	
			pgp_empresa = @i_empresa and
			pgp_cuenta = @i_cuenta and
			pgp_oficina > @i_oficina1 
		order by pgp_oficina, pgp_area

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
      select 	
      'Cuenta' = pgp_cuenta,
      'Nombre de Cuenta' = substring(cu_nombre,1,32),
      'Oficina'          = pgp_oficina,
      'Area '            = pgp_area						      
      from cob_conta..cb_plan_general_presupuesto
      left outer join cb_cuenta on
            pgp_empresa = cu_empresa and
            pgp_cuenta  = cu_cuenta 
      where pgp_empresa = @i_empresa 
      and	  (pgp_oficina = @i_oficina or @i_oficina is null) 
      and	  (pgp_area = @i_area or @i_area is null) 
      and	   pgp_cuenta like @i_cuenta
			      			      
/*			order by pgp_oficina,pgp_area,pgp_cuenta */
   end /* modo = 0 */
   else begin
      select 	
      'Cuenta' = pgp_cuenta,
      'Nombre de Cuenta' = substring(cu_nombre,1,32),
      'Oficina' = pgp_oficina ,
      'Area' = pgp_area
      from cob_conta..cb_plan_general_presupuesto
      left outer join cb_cuenta on
         pgp_empresa     = cu_empresa 
         and  pgp_cuenta = cu_cuenta
      where pgp_empresa = @i_empresa 
      and  (pgp_oficina = @i_oficina or @i_oficina is null) 
      and  (pgp_area = @i_area or @i_area is null) 
      and   pgp_cuenta like @i_cuenta 
      and  ((pgp_oficina = @i_oficina1 
            and   pgp_area = @i_area1 
            and   pgp_cuenta > @i_cuenta1) or
            (pgp_oficina = @i_oficina1 and
             pgp_area > @i_area1) or
            (pgp_oficina > @i_oficina)) 
/*		order by pgp_oficina,pgp_area,pgp_cuenta */
   end /* modo 1 */

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

   return 0
end

if @i_operacion = 'E'
begin
	select cu_nombre
	from cob_conta..cb_plan_general_presupuesto,cob_conta..cb_cuenta
	where 	pgp_empresa = @i_empresa and
		pgp_oficina = @i_oficina and
		pgp_area = @i_area and
		pgp_cuenta = @i_cuenta and
		pgp_empresa = cu_empresa and
		pgp_cuenta = cu_cuenta
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

go
