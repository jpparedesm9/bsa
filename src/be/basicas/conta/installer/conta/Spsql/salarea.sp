/************************************************************************/
/*      Archivo:                salarea.sp                              */
/*      Stored procedure:       sp_salarea                              */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           L. Tandazo                              */
/*      Fecha de escritura:     03/Jun/96                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      03/Jun/96       L. Tandazo      Emision Inicial                 */
/*      25/Jul/96       L. Tandazo      Consolidacion de saldos         */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_salarea')
	drop proc sp_salarea
go

create proc sp_salarea    (
	@s_ssn          int = null,
	@s_date         datetime = null,
	@s_user         login = null,
	@s_term         descripcion = null,
	@s_corr         char(1) = null,
	@s_ssn_corr     int = null,
	@s_ofi          smallint = null,
	@t_rty          char(1) = null,
	@t_trn          smallint = null,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null,
	@t_from         varchar(30) = null,
	@i_operacion    char(1),
	@i_modo         smallint = null,
	@i_empresa      tinyint  = null,
	@i_oficina	smallint	 = 0,
	@i_oficina1	smallint	 = null,
	@i_cuenta       cuenta = null,
	@i_fecha_fin        datetime = null,
	@i_formato_fecha smallint = null
)
as 
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_siguiente    tinyint,
	@w_empresa      tinyint,
	@w_cuenta       cuenta,
	@w_secuencial   smallint,
	@w_operador     int,
	@w_tipo_dinamica        char(1),
	@w_categoria    char(10),
	@w_texto        char(255),
	@w_disp_legal   char(255),
	@w_periodo      int,
	@w_corte        int,
	@w_estado 	char(1),
	@w_existe       tinyint

select @w_today = getdate()
select @w_sp_name = 'sp_salarea'


/************************************************/
/*  Tipo de Transaccion =                       */

if (@t_trn <> 6847 and @i_operacion = 'A')
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
	@i_num   = 601077
	return 1
end
/************************************************/

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_empresa       = @i_empresa,
		i_cuenta        = @i_cuenta,
		i_fecha         = @i_fecha_fin
	exec cobis..sp_end_debug
end

if @i_operacion = 'A'
begin
	select @w_categoria = cu_categoria
	from cob_conta..cb_cuenta
	where   cu_empresa = @i_empresa and
		cu_cuenta = @i_cuenta 

	if @w_categoria in ('2','3','4','9') 
		select @w_operador = -1
	else
		select @w_operador = 1

	select @w_corte = co_corte,
		@w_estado = co_estado,
		@w_periodo = co_periodo
	from cb_corte
	where co_empresa = @i_empresa
	   and co_fecha_ini = @i_fecha_fin

	if @@rowcount = 0
	begin
		/* 'No existe Corte para esa fecha' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601065
		return 1
	end

	if @i_oficina != 0
	begin
		if not exists (select of_oficina
			from cb_oficina
			where of_empresa = @i_empresa
	   		and of_oficina = @i_oficina
			and of_movimiento = 'S')
		begin
			/* 'No existe esa oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 101016
			return 1
		end
	end

	if @i_modo = 0
	begin
		if @w_estado = 'A'
			select  'Oficina' = sa_oficina,
				'Area'    = sa_area,
				'Saldo'   = sa_saldo * @w_operador,
				'Saldo ME'= sa_saldo_me * @w_operador
			from cb_oficina, cb_area, cb_saldo
			where sa_empresa = @i_empresa
				and sa_periodo = @w_periodo
				and sa_corte = @w_corte
				and (sa_oficina = @i_oficina or @i_oficina = 0)
				and sa_cuenta = @i_cuenta
				and sa_saldo <> 0
		else
			select  'Oficina' = hi_oficina,
				'Area'    = hi_area,
				'Saldo'   = hi_saldo * @w_operador,
				'Saldo ME'= hi_saldo_me * @w_operador
			from cb_oficina, cb_area, cob_conta_his..cb_hist_saldo
			where hi_empresa = @i_empresa
				and hi_periodo = @w_periodo
				and hi_corte = @w_corte
				and (hi_oficina = @i_oficina or @i_oficina = 0)
				and hi_cuenta = @i_cuenta
				and hi_saldo <> 0
			
		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601065
			return 1
		end
	end
	else
	begin
		if @w_estado = 'A'
			select  'Oficina' = sa_oficina,
				'Area'    = sa_area,
				'Saldo'   = sa_saldo * @w_operador,
				'Saldo ME'= sa_saldo_me * @w_operador
			from cb_oficina, cb_area, cb_saldo
			where sa_empresa = @i_empresa
				and sa_periodo = @w_periodo
				and sa_corte = @w_corte
				and ((sa_oficina = @i_oficina and @i_oficina <> 0)
				or (sa_oficina !< @i_oficina1 and @i_oficina = 0))
				and sa_cuenta = @i_cuenta
				and sa_saldo <> 0
		else
			select  'Oficina' = hi_oficina,
				'Area'    = hi_area,
				'Saldo'   = hi_saldo * @w_operador,
				'Saldo ME'= hi_saldo_me * @w_operador
			from cb_oficina, cb_area, cob_conta_his..cb_hist_saldo
			where hi_empresa = @i_empresa
				and hi_periodo = @w_periodo
				and hi_corte = @w_corte
				and ((hi_oficina = @i_oficina and @i_oficina <> 0)
				or (hi_oficina !< @i_oficina1 and @i_oficina = 0))
				and hi_cuenta = @i_cuenta
				and hi_saldo <> 0
			
		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601065
			return 1
		end
	end
end
return 0
go
