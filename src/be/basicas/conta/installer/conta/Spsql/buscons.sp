/************************************************************************/
/*	Archivo: 		buscons.sp	    		        */
/*	Stored procedure: 	sp_busca_cons				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Consulta a saldos consolidados                               */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/Oct/1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_busca_cons')
	drop proc sp_busca_cons    
go
create proc sp_busca_cons    (
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
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint  = null,
	@i_cuenta     	cuenta = null,
	@i_cuenta1    	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_periodo      int  = null,
	@i_corte	smallint = null,
	@i_fecha_fin	datetime = null,
	@i_formato_fecha smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta  	cuenta,
	@w_secuencial	smallint,
	@w_operador	int,
	@w_tipo_dinamica	char(1),
	@w_categoria	char(10),
	@w_texto	char(255),
	@w_disp_legal	char(255),
	@w_periodo	int,
	@w_corte	smallint,
	@w_estado       char(1),
	@w_existe	tinyint		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_busca_cons'


/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6577 and @i_operacion = 'A') or
   (@t_trn <> 6575 and @i_operacion = 'S') 
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
		i_cuenta     	= @i_cuenta,
		i_oficina	= @i_oficina,
		i_periodo    	= @i_periodo
	exec cobis..sp_end_debug
end


if @i_operacion = 'A'
   begin
       if NOT EXISTS (select * from cb_plan_general
                where pg_empresa = @i_empresa and
                      pg_oficina = @i_oficina and
                      pg_area = @i_area and
                      pg_cuenta  = @i_cuenta)
       begin
            /* 'Cuenta consultada no existe    ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_num       = 601028
            return 1
       end
	if @i_modo = 0
	begin
		select 	'Corte'  = hi_corte,
			'Saldo'  = sum(hi_saldo) 
		from cob_conta..cb_jerarquia, cob_conta..cb_jerararea, 
		     cob_conta_his..cb_hist_saldo
		where 	je_empresa = @i_empresa and
			je_oficina_padre = @i_oficina and
			ja_empresa = je_empresa and
			ja_area_padre = @i_area and
			hi_empresa = je_empresa and
			hi_cuenta = @i_cuenta and
			hi_oficina = je_oficina and
			hi_area	   = ja_area and
			hi_periodo = @i_periodo and
			hi_corte > 0 
		group by hi_corte, hi_saldo
/*		order by co_fecha_fin*/

		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
		/*	exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065 */
			return 1
		end
	end
	if @i_modo = 1
	begin
		select 	'Corte' = hi_corte,
			'Saldo' = sum(hi_saldo) 
		from cob_conta..cb_jerarquia, cob_conta..cb_jerararea,
		     cob_conta_his..cb_hist_saldo
		where 	je_empresa = @i_empresa and
			je_oficina_padre = @i_oficina and
			ja_empresa = je_empresa and
			ja_area_padre = @i_area and
			hi_empresa = je_empresa and
			hi_cuenta = @i_cuenta and
			hi_oficina = je_oficina and
			hi_area = ja_area and
			hi_periodo = @i_periodo and
			hi_corte > @i_corte
		group by hi_corte, hi_saldo
/*		order by co_fecha_fin*/

		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065
			return 1
		end

	end
        if @i_modo = 2
	begin
		select 	'Corte' = sa_corte,
			'Saldo' = sum(sa_saldo )
		from  cob_conta..cb_jerarquia, cob_conta..cb_jerararea,
			cob_conta..cb_saldo
		where   je_empresa = @i_empresa and
			je_oficina_padre = @i_oficina and
			ja_empresa = je_empresa and
			ja_area_padre = @i_area and	
                        sa_empresa = je_empresa and  
			sa_periodo = @i_periodo and
			sa_oficina = je_oficina and
			sa_area	   = ja_area and
			sa_cuenta = @i_cuenta 
		group by sa_corte, sa_saldo

		if @@rowcount = 0
		begin
			   /*'No existen Saldos para Cuenta Especificada'*/
		   	exec cobis..sp_cerror
			   @t_debug = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 601065
			   return 1
		end
	end
return 0
end

if @i_operacion = 'S'
begin
	set rowcount 20
	
	select @w_corte = co_corte,
		@w_periodo = co_periodo,
		@w_estado = co_estado
	from cob_conta..cb_corte
	where @i_fecha_fin between co_fecha_ini and co_fecha_fin and
		co_empresa = @i_empresa

	if @w_estado = 'A'
	begin
		if @i_modo = 0
		begin
			select 	'Cuenta' = sa_cuenta,
				'Nombre Cuenta'= cu_nombre,
				'Saldo MN' = sum(sa_saldo), 
				'Saldo ME' = sum(sa_saldo_me) ,
                                'Naturaleza' = cu_categoria
			from cb_jerarquia,cb_jerararea,cb_cuenta,
				cob_conta..cb_saldo
			where 	je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
				sa_empresa = je_empresa and
				sa_oficina = je_oficina and
				sa_area    = ja_area and
				sa_cuenta like @i_cuenta and
				sa_periodo = @w_periodo and
				sa_corte = @w_corte and
				sa_empresa = cu_empresa and
				sa_cuenta = cu_cuenta
			group by sa_cuenta,cu_nombre, sa_saldo, sa_saldo_me, cu_categoria
	
			if @@rowcount = 0
			begin
				/* 'No existen Saldos para la Cuenta Especificada' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end
		end
		else
		begin
			set rowcount 20
			select 	'Cuenta' = sa_cuenta,
				'Nombre Cuenta'= cu_nombre,
				'Saldo MN' = sum(sa_saldo), 
				'Saldo ME' = sum(sa_saldo_me),
                                'Naturaleza' = cu_categoria
			from cb_jerarquia,cb_jerararea,cb_cuenta,
				cob_conta..cb_saldo
			where	je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
				sa_empresa = je_empresa and
				sa_oficina = je_oficina and
				sa_area = ja_area and
				sa_cuenta like @i_cuenta and
				sa_cuenta > @i_cuenta1 and
				sa_periodo = @w_periodo and
				sa_corte = @w_corte and
				sa_empresa = cu_empresa and
				sa_cuenta = cu_cuenta
			group by sa_cuenta,cu_nombre, sa_saldo, sa_saldo_me, cu_categoria
	
			if @@rowcount = 0
			begin
				/* 'No existen mas Saldos para la Cuenta Especificada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end
	
		end
	end
	else begin

		if @i_modo = 0
		begin
			select 	'Cuenta' = hi_cuenta,
				'Nombre Cuenta'= cu_nombre,
				'Saldo MN' = sum(hi_saldo), 
				'Saldo ME' = sum(hi_saldo_me) 
			from cb_jerarquia,cb_jerararea,cb_cuenta,
				cob_conta_his..cb_hist_saldo
			where 	je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
				hi_empresa = je_empresa and
				hi_oficina = je_oficina and
				hi_area    = ja_area and
				hi_cuenta like @i_cuenta and
				hi_periodo = @w_periodo and
				hi_corte = @w_corte and
				hi_empresa = cu_empresa and
				hi_cuenta = cu_cuenta
			group by hi_cuenta,cu_nombre, hi_saldo, hi_saldo_me
	
			if @@rowcount = 0
			begin
				/* 'No existen Saldos para la Cuenta Especificada' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end
		end
		else
		begin
			set rowcount 20
			select 	'Cuenta' = hi_cuenta,
				'Nombre Cuenta'= cu_nombre,
				'Saldo MN' = sum(hi_saldo), 
				'Saldo ME' = sum(hi_saldo_me)
			from cb_jerarquia,cb_jerararea,cb_cuenta,
				cob_conta_his..cb_hist_saldo
			where	je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
				hi_empresa = je_empresa and
				hi_oficina = je_oficina and
				hi_area = ja_area and
				hi_cuenta like @i_cuenta and
				hi_cuenta > @i_cuenta1 and
				hi_periodo = @w_periodo and
				hi_corte = @w_corte and
				hi_empresa = cu_empresa and
				hi_cuenta = cu_cuenta
			group by hi_cuenta,cu_nombre, hi_saldo, hi_saldo_me
	
			if @@rowcount = 0
			begin
				/* 'No existen mas Saldos para la Cuenta Especificada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end
	
		end
	end

return 0
end
go

