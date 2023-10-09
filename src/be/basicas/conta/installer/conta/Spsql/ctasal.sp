/************************************************************************/
/*	Archivo: 		ctasal.sp			        */
/*	Stored procedure: 	sp_busca_cuenta_saldo			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Juan Uria C.                        	*/
/*	Fecha de escritura:     3-Agosto-1993 				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Criterios de busqueda de cuentas                             */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	16/Ago/1993	Juan Uria       Emision Inicial			*/
/*      22/Nov/1997     M. Caludia M    MCM001: Ajuste para consolidado */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_busca_cuenta_saldo')
	drop proc sp_busca_cuenta_saldo  

go
create proc sp_busca_cuenta_saldo   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_empresa		tinyint = null,
	@i_modo			tinyint = null,
	@i_cuenta_padre   	cuenta= null,
	@i_cuenta  	 	cuenta= null,
	@i_fecha		datetime = null ,
	@i_oficina		smallint  = null,
	@i_area			smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_corte	int,
	@w_estado_corte	char(1),
	@w_periodo  	int

select @w_today = getdate()
select @w_sp_name = 'sp_busca_cuenta_saldo'

if (@t_trn <> 6402 and @i_operacion = 'S')  or
   (@t_trn <> 6408 and @i_operacion = 'C')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

/*****************************************************************/
/*********** Busqueda de cuentas dado el padre de las cuentas ****/
/*****************************************************************/
select 	@w_corte = co_corte, 
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
  from 	cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha and
      	co_fecha_fin >= @i_fecha

if @i_operacion = 'S'
begin
	if @w_estado_corte = 'A'
	begin
		if @i_modo = 0
		begin
			set rowcount 20
			select 	cu_cuenta,
		     		cu_nombre,
				sa_saldo,
                        	cu_categoria
			from 	cb_cuenta,
				cb_saldo
			where 	cu_empresa = @i_empresa and
      				cu_cuenta_padre = @i_cuenta_padre and
	     			sa_empresa = @i_empresa and
      				sa_periodo = @w_periodo and
      				sa_corte   = @w_corte   and
      				sa_oficina = @i_oficina and
	      			sa_area    = @i_area and
      				sa_cuenta  = cu_cuenta
			order by cu_cuenta


			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
			return 0
		end
		if @i_modo = 1
		begin
			set rowcount 20
			select 	cu_cuenta,
		     		cu_nombre,
				sa_saldo,
                        	cu_categoria
			from 	cb_cuenta,
				cb_saldo
			where 	cu_empresa = @i_empresa and
      				cu_cuenta_padre = @i_cuenta_padre and
	     			sa_empresa = @i_empresa and
      				sa_periodo = @w_periodo and
      				sa_corte   = @w_corte   and
      				sa_oficina = @i_oficina and
	      			sa_area    = @i_area and
      				sa_cuenta  = cu_cuenta and
				sa_cuenta  > @i_cuenta
			order by cu_cuenta


			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
			return 0
		end
	end
	else
	begin
		if @i_modo = 0
		begin
			set rowcount 20
			select 	cu_cuenta,
		     		cu_nombre,
				hi_saldo,
                        	cu_categoria
			from 	cb_cuenta,
				cob_conta_his..cb_hist_saldo
			where 	cu_empresa = @i_empresa and
      				cu_cuenta_padre = @i_cuenta_padre and
	     			hi_empresa = @i_empresa and
      				hi_periodo = @w_periodo and
      				hi_corte   = @w_corte   and
      				hi_oficina = @i_oficina and
	      			hi_area    = @i_area and
      				hi_cuenta  = cu_cuenta
			order by cu_cuenta


			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
		end
		if @i_modo = 1
		begin
			set rowcount 20
			select 	cu_cuenta,
		     		cu_nombre,
				hi_saldo,
                        	cu_categoria
			from 	cb_cuenta,
				cob_conta_his..cb_hist_saldo
			where 	cu_empresa = @i_empresa and
      				cu_cuenta_padre = @i_cuenta_padre and
	     			hi_empresa = @i_empresa and
      				hi_periodo = @w_periodo and
      				hi_corte   = @w_corte   and
      				hi_oficina = @i_oficina and
	      			hi_area    = @i_area and
      				hi_cuenta  = cu_cuenta and
				hi_cuenta  > @i_cuenta
			order by cu_cuenta


			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
		end
	end
end

if @i_operacion = 'C'
begin
select distinct ja_area
into #area_cons
from cob_conta..cb_jerararea
where ja_empresa = @i_empresa and
(ja_area_padre = @i_area or  
	ja_area = @i_area)


select distinct je_oficina
into #oficina_cons 
from cob_conta..cb_jerarquia
where  je_empresa = @i_empresa
and (je_oficina = @i_oficina or
je_oficina_padre = @i_oficina)

select cu_cuenta,cu_nombre,cu_categoria,
cu_cuenta_padre
into #cta_cons
from cob_conta..cb_cuenta
where cu_empresa = @i_empresa
and  cu_cuenta_padre = @i_cuenta_padre
end



if @i_operacion = 'C'
begin
	if @w_estado_corte = 'A'
	begin
		if @i_modo = 0
		begin
			set rowcount 20
			select 	cu_cuenta,
				cu_nombre,
				sum(sa_saldo),
                cu_categoria
		  	 from cb_saldo,#area_cons,#oficina_cons, #cta_cons
        	         where  sa_empresa = @i_empresa
        	           and  sa_periodo = @w_periodo
	                   and  sa_corte   = @w_corte
	                   and  sa_oficina = je_oficina
        	           and  sa_area   =  ja_area 
	                   and  sa_cuenta  = cu_cuenta
                           and  (cu_cuenta_padre = @i_cuenta_padre or @i_cuenta_padre is null)
			 group by cu_cuenta, cu_nombre, cu_categoria
			 order by cu_cuenta

			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,

				@i_num	 = 609136
				return 1
			end
			return 0
		end
		if @i_modo = 1
		begin
			set rowcount 20
			select 	cu_cuenta,
				cu_nombre,
				sum(sa_saldo),
                cu_categoria
		  	 from 	cb_saldo,#area_cons,#oficina_cons, #cta_cons
        	         where  sa_empresa = @i_empresa
        	           and  sa_periodo = @w_periodo
	                   and  sa_corte   = @w_corte
	                   and  sa_oficina = je_oficina
        	           and  sa_area    = ja_area  
	                   and  sa_cuenta  = cu_cuenta
        	           and  cu_cuenta  > @i_cuenta
                           and  (cu_cuenta_padre = @i_cuenta_padre or @i_cuenta_padre is null)
			 group by cu_cuenta, cu_nombre, cu_categoria
			 order by cu_cuenta

			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
			return 0
		end
	end
	else
	begin
		if @i_modo = 0
		begin
			set rowcount 20
			select 	cu_cuenta,
				cu_nombre,
				sum(hi_saldo),
                cu_categoria
		  	  from cob_conta_his..cb_hist_saldo,#area_cons,#oficina_cons, #cta_cons
        	         where  hi_empresa = @i_empresa
        	           and  hi_periodo = @w_periodo
                	   and  hi_corte   = @w_corte
        	           and  hi_oficina = je_oficina 
	                   and  hi_area    = ja_area 
	                   and  hi_cuenta  = cu_cuenta
                           and  (cu_cuenta_padre = @i_cuenta_padre or @i_cuenta_padre is null)
			 group by cu_cuenta, cu_nombre, cu_categoria
			 order by cu_cuenta

			-- print 'ROWCOUNT: '+cast(@@rowcount as varchar(10))
			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
			return 0
		end
		if @i_modo = 1
		begin
			set rowcount 20
			select 	cu_cuenta,
				cu_nombre,
				sum(hi_saldo),
                        	cu_categoria
		  	  from 	cob_conta_his..cb_hist_saldo,#area_cons,#oficina_cons, #cta_cons
        	         where  hi_empresa = @i_empresa
        	           and  hi_periodo = @w_periodo
                	   and  hi_corte   = @w_corte
        	           and  hi_oficina = je_oficina 
	                   and  hi_area    = ja_area 
	                   and  hi_cuenta  = cu_cuenta
                           and  (cu_cuenta_padre = @i_cuenta_padre or @i_cuenta_padre is null)
			           and  cu_cuenta > @i_cuenta
			 group by cu_cuenta, cu_nombre, cu_categoria
			 order by cu_cuenta

			if @@rowcount = 0
			begin
			/* 'Cuenta consultada no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609136
				return 1
			end
			return 0
		end
	end
end
go

