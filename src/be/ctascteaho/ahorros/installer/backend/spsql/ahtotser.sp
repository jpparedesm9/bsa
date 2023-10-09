use cob_ahorros
go

/************************************************************************/
/*      Archivo:                ahtotser.sp                             */
/*      Stored procedure:       sp_totaliza_tran_serv_ah                */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Jaime Loyo                              */
/*      Fecha de escritura:     29-Mar-2010                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      PROCESO:  Cursor que permite la generacion de comprobantes para */
/*              cuentas de ahorros sobre transacciones de servicio      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      29/Mar/2010     J. Loyo         Personalizacion Bancamia        */
/*      19/Feb/2013     L. Moreno       CCA 355: Nueva transaccion para */
/*                                      cobro de GMF a cargo del banco  */
/*      02/Mayo/2016     Walther Toledo Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select 1
			from   sysobjects
			where  name = 'sp_totaliza_tran_serv_ah')
	drop proc sp_totaliza_tran_serv_ah
go

create proc sp_totaliza_tran_serv_ah
(
	@i_filial       tinyint		= 1,
	@i_fecha        smalldatetime= null,
	@i_param1       datetime	= null,-- Fecha de proceso
	@s_srv          varchar(16) = null,
	@t_show_version bit			= 0,
	@o_procesadas   int			= null out
)
as
set ansi_warnings off

declare
	@w_sp_name      varchar(32),
    @w_return       int,
    @w_descripcion  varchar(60),
    @w_tipo_tran    int,
    @w_causa        char(12),
    @w_concepto     char(16),
    @w_concepto_imp varchar(10),
    @w_campo1       varchar(32),--Valor
    @w_campo2       varchar(32),--Base
    @w_campo3       varchar(32),--Referencia
    @w_totaliza     char(1),
    @w_tipo_imp     varchar(1),
    @w_indicador    tinyint,
    @w_perfilCau    char(10)

----PRMR TEMPORAL QUITAR INICIO
--declare @w_cta_aso        int,
--        @w_cta_asa        int,
--        @w_cta_med        int,
--        @w_cta_aho        int,
--        @w_cta_pro        int
--
---- Producto Menor de Edad
--select @w_cta_med = pa_int
--    from cobis..cl_parametro
--    where pa_producto = 'AHO'
--    and pa_nemonico = 'PCAME'
--
---- Producto Final Aporte Social Ordinario
--select @w_cta_aso  = pa_int
--    from cobis..cl_parametro
--    where pa_producto = 'AHO'
--    and pa_nemonico = 'PCAASO'
--
---- Producto Final Aporte Social Adicional
--select @w_cta_asa = pa_int
--    from cobis..cl_parametro
--    where pa_producto = 'AHO'
--    and pa_nemonico = 'PCAASA'
--	
---- Producto Ahorro Progresivo
--select @w_cta_pro = pa_int
--	from cobis..cl_parametro
--	where pa_producto = 'AHO'
--	and pa_nemonico = 'PAHCT'
--
---- Producto Ahorro NORMAL
--select @w_cta_aho = pa_int
--	from cobis..cl_parametro
--	where pa_producto = 'AHO'
--	and pa_nemonico = 'PCANOR'
--
----PRMR TEMPORAL QUITAR FIN

select @w_sp_name = 'sp_totaliza_tran_serv_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
	print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
end

create table #cotizacion
(
	moneda tinyint,
	valor  money
)

print ' Inicia Totalizacion Monetaria'

select
		ct_moneda     as uc_moneda,
		max(ct_fecha) as uc_fecha
	into #ult_cotiz
	from cob_conta..cb_cotizacion
	where ct_fecha <= @i_param1
	group by ct_moneda

insert into #cotizacion
	select ct_moneda,ct_valor
	from cob_conta..cb_cotizacion,
           #ult_cotiz
    where ct_moneda = uc_moneda
    and ct_fecha	= uc_fecha

select @w_perfilCau = pa_char
	from cobis..cl_parametro
	where pa_producto	= 'AHO'
	and pa_nemonico		= 'PCAU'

if @@rowcount <> 1
begin
	select
		@w_return = 201196,
		@w_descripcion = 'Error en lectura de parametro de perfil de causacion'
	print @w_descripcion
	goto ERRORFIN
end

select c.*
	into #trx_dia
	from cob_remesas..re_concepto_contable c,
		cob_remesas..re_trn_perfil
	where cc_tipo_tran = tp_tipo_tran
	and cc_tipo      = 'S'
	and tp_perfil    <> @w_perfilCau

if exists (select 1
			from cob_remesas..re_trn_contable,
				#trx_dia
            where tc_fecha     = @i_param1
			and tc_estado    = 'CON'
			and tc_tipo      = 'S'
			and tc_tipo_tran = cc_tipo_tran)
begin
	select
		@w_return = 701171,
		@w_descripcion = 'Existen registros diarios Contabilizados en la re_trn_contable para esa fecha'
	print @w_descripcion
	goto ERRORFIN
end

if exists(select 1
			from cob_remesas..re_trn_contable,
				#trx_dia
            where tc_fecha		= @i_param1
            and tc_tipo			= 'S'
             and tc_tipo_tran	= cc_tipo_tran)
begin
	print 'Se borran los registros del dia ' + cast(@i_param1 as varchar) + ' de transacciones de Servicio'
	delete cob_remesas..re_trn_contable
		where tc_fecha	= @i_param1
		and tc_tipo		= 'S'

	if @@error <> 0
    begin
		select
			@w_return = 357502,
			@w_descripcion = 'Error al borrar los registros en re_trn_contable'
		print @w_descripcion
		goto ERRORFIN
	end
end

begin tran

select *
	into #re_trn_contable
	from cob_remesas..re_trn_contable
	where 1 = 2

	/* CARGA LOS CODIGOS DE LAS TRANSACCIONES QUE CONTABILIZAN */
	select distinct cc_tipo_tran
		into #trn_serv
		from cob_remesas..re_concepto_contable
		where cc_tipo	= 'S'
		and cc_causa	is null

	/* Cursor para re_concepto_contable */
	declare ciclo_contable cursor for
		select
				cc_tipo_tran,
				isnull(cc_causa, '0'),
				cc_concepto,
				cc_campo1,
				cc_campo2,
				cc_campo3,
				isnull(cc_indicador, 0),
				cc_totaliza,
				cc_tipo_imp
			from #trx_dia
			where cc_producto = 4
			and cc_tipo     = 'S' -- Transacciones de servicio
			order by cc_tipo_tran, cc_causa

	/* Abrir el cursor para validar las tansacciones contables */
	open ciclo_contable

	/* Ubicar el primer registro para el cursor */
	fetch ciclo_contable 
		into @w_tipo_tran,
			@w_causa,
			@w_concepto,
			@w_campo1,
			@w_campo2,
			@w_campo3,
			@w_indicador,
			@w_totaliza,
			@w_tipo_imp

if @@fetch_status = -1
begin
	print 'Error -1'
	close ciclo_contable
	deallocate ciclo_contable
	/*exec cobis..sp_cerror
	@i_num = 251062*/
	select @o_procesadas = 0
	select @w_descripcion = 'ERROR EN LECTURA DE TRANSACCIONES MONETARIAS'
	select @w_return = 251062
	goto ERRORFIN
end
else if @@fetch_status = -2
begin
	print 'Error -2'
	close ciclo_contable
	deallocate ciclo_contable
	select @o_procesadas = 0
	return 0
end

/* Barrer todas las cuentas para actualizacion de saldos */
while @@fetch_status = 0
begin
	select @w_concepto_imp = null
	select @w_concepto_imp = ci_concepto
		from cob_remesas..re_concepto_imp
		where ci_producto	= 4
		and ci_tran			= @w_tipo_tran
		and ci_causal		= isnull(@w_causa, '0')
		and ci_impuesto		= @w_tipo_imp
		and ci_contabiliza	= @w_campo1

    print 'Transaccion :' + cast(@w_tipo_tran as varchar) + ' Causa :' + cast (isnull(@w_causa, '') as varchar) + 
		  '- Concepto : ' + isnull(@w_concepto , '')
    print 'Concepto_contable : ' + cast (isnull(@w_concepto_imp, '') as varchar) + ' Tipo_imp :' + cast(isnull(@w_tipo_imp, '') as varchar)
    
    delete #re_trn_contable

    if @w_causa = '0' or @w_causa is null
	begin
		/**** Busqueda de las transacciones sin causal ****************/
		if @w_totaliza = 'N'
		begin
			print '........1'
			/***** Adicionalmente, Que esten agrupadas por cliente ***************/
			insert into #re_trn_contable
					(tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
					tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
					tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
					tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
					tc_estado,tc_estcta,tc_concepto_imp)
				select
					4,isnull(ts_moneda, 0), ts_tipo_transaccion, ts_causa, ts_oficina,
					isnull(ts_oficina_cta, ts_oficina), 
					isnull((select tp_perfil
							from cob_remesas..re_trn_perfil
							where tp_producto  = 4
							and tp_tipo_tran = @w_tipo_tran), 'NO DEFIN'), @w_concepto, 
					case ts_moneda /**** Valor ****/
						when 0 
						then
							case @w_campo1
								when 'ts_valor' then sum(isnull(ts_valor, 0))
								when 'ts_saldo' then sum(isnull(ts_saldo, 0))
								when 'ts_interes' then sum(isnull(ts_interes, 0))
								when 'ts_monto' then sum(isnull(ts_monto, 0))
								else 0
							end
						else 0
					end,
					case ts_moneda /**** Valor_ME ****/
					when 0 then 0
					else
						case @w_campo1
						  when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
						  when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
						  when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
						  when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
						  else 0
						end
					end,
					count(1),'S', ts_prod_banc, isnull(ts_clase_clte, 'X'), ts_tipocta_super,
					isnull(ts_cliente, 0),
					case @w_campo2 /**** Base ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
						when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
						when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
						when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
						else 0
					end,
					@w_tipo_imp,
					case @w_campo3 /**** Referencia ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
						when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
						when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
						when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
						else 0
					end,
					ts_tsfecha, 'ING',
					case
						when ts_tipo_transaccion = 271 and 
								exists(select 1
									from cob_remesas..re_tesoro_nacional,
										cob_ahorros..ah_cuenta
									where tn_cuenta = ts_cta_banco
									and tn_estado = 'P'
									and tn_cuenta = ah_cta_banco
									and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion = 367
								and exists (select 1
									from cob_remesas..re_tesoro_nacional,
										cob_ahorros..ah_cuenta
									where  tn_cuenta = ts_cta_banco
									and tn_estado = 'P'
									and tn_cuenta = ah_cta_banco
									and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion in (201, 200)  then
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
						when exists(select 1
									from #trn_serv
									where cc_tipo_tran = ts_tipo_transaccion) 
							then isnull (ts_causa, (select ah_estado
														from cob_ahorros..ah_cuenta
														where ah_cta_banco = ts_cta_banco))
						else 
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
					end,
					@w_concepto_imp
				from cob_ahorros..ah_tran_servicio_tmp t,
					#cotizacion
				where  ts_tipo_transaccion	= @w_tipo_tran
				--          and    isnull(ts_causa,'')    = @w_causa
				and isnull(ts_indicador, 0) = @w_indicador
				and (ts_estado is null or @w_tipo_tran = 201)
				and isnull(ts_moneda, 0)    = moneda
				
				--and ts_prod_banc in (@w_cta_aho, @w_cta_pro, @w_cta_med, @w_cta_aso, @w_cta_asa) --PRMR TEMPORAL QUITAR
				
				group by ts_tipo_transaccion, ts_causa, ts_moneda, ts_oficina, ts_prod_banc, ts_clase_clte,
                    ts_oficina_cta, ts_tsfecha, ts_tipocta_super, ts_estado, ts_cta_banco, ts_cliente
		end
		else
		begin
			print '........2'
			/******* Busqueda sin Causal y con Agrupamiento por Cliente *************************/
			insert into #re_trn_contable
					(tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
					tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
					tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
					tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
					tc_estado,tc_estcta,tc_concepto_imp)
				select
					4, isnull(ts_moneda, 0),ts_tipo_transaccion, ts_causa, ts_oficina,
					isnull(ts_oficina_cta, ts_oficina), 
					isnull((select tp_perfil
								from cob_remesas..re_trn_perfil
								where tp_producto  = 4
								and tp_tipo_tran = @w_tipo_tran), 'NO DEFIN'),@w_concepto,
					case ts_moneda /**** Valor ****/
						when 0 then
							case @w_campo1
								when 'ts_valor' then sum(isnull(ts_valor, 0))
								when 'ts_saldo' then sum(isnull(ts_saldo, 0))
								when 'ts_interes' then sum(isnull(ts_interes, 0))
								when 'ts_monto' then sum(isnull(ts_monto, 0))
								else 0
							end
						else 0
					end,
					case ts_moneda /**** Valor_ME ****/
						when 0 then 0
						else
						case @w_campo1
							when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
							when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
							when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
							when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
							else 0
						end
					end,
					count(1), 'S', ts_prod_banc,isnull(ts_clase_clte, 'X'),
					isnull(ts_tipocta_super, 0), 0, 
					case @w_campo2 /**** Base ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
						when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
						when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
						when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
						else 0
					end,
					@w_tipo_imp,
					case @w_campo3 /**** Referencia ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0))
						when 'ts_saldo' then sum(isnull(ts_saldo, 0))
						when 'ts_interes' then sum(isnull(ts_interes, 0))
						when 'ts_monto' then sum(isnull(ts_monto, 0))
						else 0
					end,
					ts_tsfecha, 'ING', 
					case
						when ts_tipo_transaccion = 271 and 
								exists(select 1
									from cob_remesas..re_tesoro_nacional,
										cob_ahorros..ah_cuenta
									where tn_cuenta = ts_cta_banco
									and tn_estado = 'P'
									and tn_cuenta = ah_cta_banco
									and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion = 367
								and exists (select 1
									from cob_remesas..re_tesoro_nacional,
										cob_ahorros..ah_cuenta
									where  tn_cuenta = ts_cta_banco
									and tn_estado = 'P'
									and tn_cuenta = ah_cta_banco
									and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion in (201, 200) then
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
						when exists(select 1
									from #trn_serv
									where cc_tipo_tran = ts_tipo_transaccion) 
							then isnull (ts_causa, (select ah_estado
														from cob_ahorros..ah_cuenta
														where ah_cta_banco = ts_cta_banco))
						else 
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
					end,
					@w_concepto_imp
				from cob_ahorros..ah_tran_servicio_tmp t,
					#cotizacion
				where ts_tipo_transaccion	= @w_tipo_tran
				and (ts_estado is null or @w_tipo_tran = 201)
				and isnull(ts_moneda, 0)	= moneda
				
				--and ts_prod_banc in (@w_cta_aho, @w_cta_pro, @w_cta_med, @w_cta_aso, @w_cta_asa) --PRMR TEMPORAL QUITAR
								
				group by ts_tipo_transaccion, ts_causa, ts_moneda, ts_oficina, ts_prod_banc,
                    ts_clase_clte, ts_oficina_cta, ts_tsfecha, ts_cta_banco, ts_tipocta_super
                    
			if @@rowcount = 0
				print '...............0 ' + cast (@w_indicador as varchar)
		end
	end
	else
    begin
		if @w_totaliza = 'S'
		begin
			print '........3'
			/****** Busqueda de las transaccion con causal y agrupadas *****************/
			insert into #re_trn_contable
						(tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
						 tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
						 tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
						 tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
						 tc_estado,tc_estcta,tc_concepto_imp)
			  select
					4,isnull(ts_moneda, 0), ts_tipo_transaccion, ts_causa, ts_oficina,
					isnull(ts_oficina_cta, ts_oficina), 
					isnull((select tp_perfil
								from cob_remesas..re_trn_perfil
								where tp_producto	= 4
								and tp_tipo_tran	= @w_tipo_tran), 'NO DEFIN'), @w_concepto,
					case ts_moneda /**** Valor ****/
						when 0 then
							case @w_campo1
								when 'ts_valor' then sum(isnull(ts_valor, 0))
								when 'ts_saldo' then sum(isnull(ts_saldo, 0))
								when 'ts_interes' then sum(isnull(ts_interes, 0))
								when 'ts_monto' then sum(isnull(ts_monto, 0))
								else 0
							end
						else 0
					end,
					case ts_moneda /**** Valor_ME ****/
						when 0 then 0
						else
							case @w_campo1
								when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
								when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
								when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
								when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
								else 0
							end
					end,
					count(1),'S',ts_prod_banc,isnull(ts_clase_clte, 'X'), ts_tipocta_super, 0,
					case @w_campo2 /**** Base ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
						when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
						when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
						when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
						else 0
					end,
					@w_tipo_imp,
					case @w_campo3 /**** Referencia ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0))
						when 'ts_saldo' then sum(isnull(ts_saldo, 0))
						when 'ts_interes' then sum(isnull(ts_interes, 0))
						when 'ts_monto' then sum(isnull(ts_monto, 0))
						else 0
					end,
					ts_tsfecha, 'ING',
					case
						when ts_tipo_transaccion = 271 and 
								exists(select 1
									from cob_remesas..re_tesoro_nacional,
										cob_ahorros..ah_cuenta
									where tn_cuenta = ts_cta_banco
									and tn_estado = 'P'
									and tn_cuenta = ah_cta_banco
									and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion = 367
								and exists (select 1
									from cob_remesas..re_tesoro_nacional,
										cob_ahorros..ah_cuenta
									where  tn_cuenta = ts_cta_banco
									and tn_estado = 'P'
									and tn_cuenta = ah_cta_banco
									and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion in (201, 200) then
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
						when exists(select 1
									from #trn_serv
									where cc_tipo_tran = ts_tipo_transaccion) 
							then isnull (ts_causa, (select ah_estado
														from cob_ahorros..ah_cuenta
														where ah_cta_banco = ts_cta_banco))
						else 
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
					end,
					@w_concepto_imp
				from cob_ahorros..ah_tran_servicio_tmp t,
					#cotizacion
				where ts_tipo_transaccion	= @w_tipo_tran
				and isnull(ts_causa, '0')   = @w_causa
				and isnull(ts_indicador, 0) = @w_indicador
				and (ts_estado is null or @w_tipo_tran = 201)
				and isnull(ts_moneda, 0)    = moneda
				
				--and ts_prod_banc in (@w_cta_aho, @w_cta_pro, @w_cta_med, @w_cta_aso, @w_cta_asa) --PRMR TEMPORAL QUITAR
								
				group by ts_tipo_transaccion, ts_causa, ts_moneda, ts_oficina,
					ts_prod_banc, ts_clase_clte, ts_oficina_cta, ts_tsfecha, ts_cta_banco, ts_tipocta_super
		end
		else
		/****** Busqueda de las transaccion con causal sin totalizar  *****************/
		begin
			print '........4'
			insert into #re_trn_contable
					(tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
					tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
					tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
					tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
					tc_estado,tc_estcta,tc_concepto_imp)
				select
					4,isnull(ts_moneda, 0), ts_tipo_transaccion, ts_causa, ts_oficina,
					isnull(ts_oficina_cta, ts_oficina), 
					isnull((select tp_perfil
								from cob_remesas..re_trn_perfil
								where tp_producto  = 4
								and tp_tipo_tran = @w_tipo_tran), 'NO DEFIN'),
					@w_concepto,
					case ts_moneda /**** Valor ****/
						when 0 then
							case @w_campo1
								when 'ts_valor' then sum(isnull(ts_valor, 0))
								when 'ts_saldo' then sum(isnull(ts_saldo, 0))
								when 'ts_interes' then sum(isnull(ts_interes, 0))
								when 'ts_monto' then sum(isnull(ts_monto, 0))
								else 0
							end
						else 0
					end,
					case ts_moneda /**** Valor_ME ****/
						when 0 then 0
						else
							case @w_campo1
								when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
								when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
								when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
								when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
								else 0
							end
					end,
					count(1),'S', ts_prod_banc, isnull(ts_clase_clte, 'X'), ts_tipocta_super,
					isnull(ts_cliente, 0),
					case @w_campo2 /**** Base ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0) * valor)
						when 'ts_saldo' then sum(isnull(ts_saldo, 0) * valor)
						when 'ts_interes' then sum(isnull(ts_interes, 0) * valor)
						when 'ts_monto' then sum(isnull(ts_monto, 0) * valor)
						else 0
					end,
					@w_tipo_imp,
					case @w_campo3 /**** Referencia ****/
						when 'ts_valor' then sum(isnull(ts_valor, 0))
						when 'ts_saldo' then sum(isnull(ts_saldo, 0))
						when 'ts_interes' then sum(isnull(ts_interes, 0))
						when 'ts_monto' then sum(isnull(ts_monto, 0))
						else 0
					end,
					ts_tsfecha, 'ING',
					case when ts_tipo_transaccion = 271
								and exists(select 1
											from cob_remesas..re_tesoro_nacional, cob_ahorros..ah_cuenta
											where tn_cuenta = ts_cta_banco
											and tn_estado	= 'P'
											and tn_cuenta	= ah_cta_banco
											and ah_estado	= 'I') 
							then 'T'
						when ts_tipo_transaccion = 367
								and exists (select 1
											from cob_remesas..re_tesoro_nacional, cob_ahorros..ah_cuenta
											where  tn_cuenta = ts_cta_banco
											and tn_estado = 'P'
											and tn_cuenta = ah_cta_banco
											and ah_estado = 'I') 
							then 'T'
						when ts_tipo_transaccion in (201, 200) then
							(select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
						when exists(select 1
									from #trn_serv
									where cc_tipo_tran = ts_tipo_transaccion) 
							then isnull (ts_causa, (select ah_estado
													from cob_ahorros..ah_cuenta
													where ah_cta_banco = ts_cta_banco))
						else (select ah_estado
								from cob_ahorros..ah_cuenta
								where ah_cta_banco = ts_cta_banco)
					end, @w_concepto_imp
				from cob_ahorros..ah_tran_servicio_tmp t, #cotizacion
				where ts_tipo_transaccion    = @w_tipo_tran
				and isnull(ts_causa, '0')   = @w_causa
				and isnull(ts_indicador, 0) = @w_indicador
				and (ts_estado is null or @w_tipo_tran = 201)
				and isnull(ts_moneda, 0)    = moneda
				
				--and ts_prod_banc in (@w_cta_aho, @w_cta_pro, @w_cta_med, @w_cta_aso, @w_cta_asa) --PRMR TEMPORAL QUITAR
								
				group by ts_tipo_transaccion, ts_causa, ts_moneda, ts_oficina, ts_prod_banc, ts_clase_clte, 
				ts_oficina_cta, ts_tsfecha, ts_tipocta_super, ts_estado, ts_cta_banco, ts_cliente
		end
	end
    
    update #re_trn_contable
		set tc_estcta = tc_causa
    where tc_tipo_tran in (203, 367, 374, 375, 376)
    
	delete from #re_trn_contable
	where (tc_tipo_tran in (217) 
				and tc_causa not in (select b.codigo
										from cobis..cl_tabla a, cobis..cl_catalogo b
										where a.codigo = b.tabla 
										and a.tabla = 'ah_causa_bloq_contb'
										and b.estado = 'V')
			or tc_tipo_tran in (218)
				and tc_causa not in (select b.codigo
										from cobis..cl_tabla a, cobis..cl_catalogo b
										where a.codigo = b.tabla 
										and a.tabla = 'ah_causa_desbloq_contb'
										and b.estado = 'V'))

    if @@rowcount > 0
		print ' Se modificaron los estados de ' + cast (@@rowcount as varchar) + ' registros '

    print ' insert --->'
    insert into cob_remesas..re_trn_contable
				(tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
				tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
				tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
				tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
				tc_estado,tc_estcta,tc_concepto_imp)
		select
				tc_producto,tc_moneda,tc_tipo_tran,tc_causa,tc_ofic_orig,
				tc_ofic_dest,tc_perfil,tc_concepto,tc_valor,tc_valor_me,
				tc_numtran,tc_tipo,tc_prod_banc,tc_clase_clte,tc_tipo_cta,
				tc_cliente,tc_base,tc_tipo_impuesto,tc_referencia,tc_fecha,
				tc_estado,tc_estcta,tc_concepto_imp
			from #re_trn_contable
			where tc_valor <> 0
			or tc_valor_me <> 0

	print ' Insercion de Registro: ' + cast (@@rowcount as varchar)

    LEER:
    /* Localizar el siguiente registro de cuenta sobregirada ocasionalmente */
    fetch ciclo_contable 
		into @w_tipo_tran,
			@w_causa,
			@w_concepto,
			@w_campo1,
			@w_campo2,
			@w_campo3,
			@w_indicador,
			@w_totaliza,
			@w_tipo_imp

	/* Validar el Status del Cursor */
	if @@fetch_status = -2
	begin
		print 'ERROR EN LECTURA DE TRANSACCIONES 1'
		rollback tran
		close ciclo_contable
		deallocate ciclo_contable
		return 251062
	end
	
	if @@fetch_status = -1
	begin
		close ciclo_contable
		deallocate ciclo_contable
		commit tran
		return 0
	end
end

print ' Termina la Totalizacion de Servicios'
commit tran

/* Cerrar y liberar cursor */
close ciclo_contable
deallocate ciclo_contable
goto FIN

ERRORFIN:

while @@trancount > 0
	rollback tran

exec sp_errorlog
	@i_fecha       = @i_param1,
	@i_error       = @w_return,
	@i_usuario     = 'batch',
	@i_tran        = 4223,-- Codigo del proceso Batch
	@i_cuenta      = null,
	@i_descripcion = @w_descripcion,
	@i_programa    = 'sp_totaliza_tran_serv_ah'
return @w_return

FIN:
return 0

go

