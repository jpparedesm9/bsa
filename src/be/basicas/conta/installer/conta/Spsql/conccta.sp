/************************************************************************/
/*	Archivo: 			conccta.sp 			*/
/*	Stored procedure: 	sp_conciliacion  			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:           contabilidad                		*/
/*	Disenado por:       Claudia M. De Orcajo                   	*/
/*	Fecha de escritura: 30-Marzo-1999 				*/
/************************************************************************/
/*							IMPORTANTE	*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*							PROPOSITO	*/
/*	Este programa realiza la consulta del Resumen de la             */
/*	Conciliaci¢n Bancaria.                                          */
/************************************************************************/
/*							MODIFICACIONES	*/
/*	FECHA			AUTOR			RAZON		*/
/*	30/Mar/1999		C. De orcajo    Emision Inicial         */
/*                                  Especificacion COR063    		*/
/*	12/May/2003							*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_conciliacion')
	drop proc sp_conciliacion  
go

create proc sp_conciliacion(
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
    	@s_ofi			smallint = null,
	@t_rty			char(1) = null,
    	@t_trn			smallint = 605,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion    	char(1) = null,
    	@i_empresa		tinyint = null,
	@i_banco 		varchar(3) = null,
	@i_cuenta       	cuenta = null,
    	@i_cuenta_contable	cuenta = null,
    	@i_fecha        	datetime = null,
    	@i_formato_fecha        smallint = null
)
as 
declare
	@w_today 		datetime,  	/* fecha del dia */
	@w_return		int,		/* valor que retorna */
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_empresa		tinyint,
    	@w_banco        	varchar(3),
	@w_cuenta		cuenta,
	@cuenta_sob		cuenta,
    	@w_existe       	int,               /*Codigo existe = 1*/
    	@w_es_saldo_fin 	money,              /*no existe = 0*/ 
	@w_es_saldo_ini 	money,
    	@w_oficina      	smallint,
    	@w_area         	smallint,
    	@w_corte        	int,
    	@w_periodo      	int,
	@w_moneda		smallint,
    	@w_estado       	char(1),
	@w_saldo_me		money,
    	@w_saldo_sob    	money,
	@w_saldo_sob_me		money,
    	@w_saldo_libro  	money

select @w_today = getdate()
select @w_sp_name = 'sp_conciliacion'

select @w_oficina = 255
select @w_area = 255

/************************************************/
/*  		Tipo de Transaccion       	*/
/************************************************/
if (@t_trn <> 6763 and @i_operacion = 'Q') 
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
		i_empresa	= @i_empresa,
		i_banco 	= @i_banco,
		i_cuenta    	= @i_cuenta,
        	i_fecha     	= @i_fecha  
	exec cobis..sp_end_debug
end


if @i_operacion <> 'S' 
begin
	select  @w_empresa = ba_empresa,
		@w_cuenta = ba_cuenta,
		@w_banco = ba_banco
	from cob_conta..cb_banco
	where	ba_empresa = @i_empresa and
		ba_ctacte = @i_cuenta and
		ba_banco = @i_banco
	if @@rowcount > 0
		select @w_existe = 1
	else
		select @w_existe = 0
end


if @i_operacion = 'Q'
begin
	if @w_existe = 1
	begin
		select @w_es_saldo_fin = es_saldo_fin,
			@w_es_saldo_ini = es_saldo_ini
		from cob_conta_tercero..ct_estcta
		where es_empresa = @i_empresa
		and es_banco = @i_banco
		and es_fecha = @i_fecha  
		and es_cuenta = @i_cuenta

		if @@rowcount > 0
		begin
			--select @w_es_saldo_fin * -1  /*RETORNO DEL SALDO SEGUN EXTRACTO*/
			--select @w_es_saldo_ini * -1

			select @w_es_saldo_fin /*RETORNO DEL SALDO SEGUN EXTRACTO*/
			select @w_es_saldo_ini 

 
			/****RETORNO DE PENDIENTES EN LIBROS****/
			/*select                   
			"Operacion Banco" = cl_oper_banco,
			"Valor" = sum(cl_valor),
			" D/C " = '   ' + cl_debcred 
			from  cob_conta_tercero..ct_conciliacion
			where cl_empresa = @i_empresa
			and   cl_banco   = @i_banco
			and   cl_cuenta   = @i_cuenta_contable
			and   cl_cuenta_cte  = @i_cuenta
			and   cl_relacionado = 'N'
			and   cl_fecha_tran <= @i_fecha
			group by cl_oper_banco,cl_debcred*/

			select	"Concepto"	= cc_concepto,
				"Descripcion "	= cc_descripcion,
				"Fecha"		= convert(char(10),cl_fecha_tran,@i_formato_fecha),
				"Valor"		= sum(cl_valor),
				"Operacion"	= cc_operacion,
				"Naturaleza"	= cl_debcred
			from  cob_conta_tercero..ct_conciliacion,
			cb_conceptos_movimientos, cb_conceptos_conciliacion
			where cl_empresa = @i_empresa
			and cl_banco = @i_banco
			and cl_cuenta = @i_cuenta_contable
			and cl_cuenta_cte = @i_cuenta
			and isnull(cl_relacionado,'N') = 'N'
			and cl_fecha_tran <= @i_fecha
			and cc_banco = 'N'
			and cl_oper_banco = cm_operacion
			and cm_concepto = cc_concepto
			group by cc_concepto,cc_descripcion,  cl_fecha_tran,cc_operacion,cl_debcred
		end
		else
		begin
		   	/* 'No existe extracto de conciliaci¢n bancaria' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603068
			--return 1
	  	end

		/*****RETORNO DE SALDO SEGUN LIBROS****/
		/****CALCULAR CORTE****/
		select	@w_corte = co_corte,
			@w_periodo = co_periodo,
			@w_estado = co_estado
		from cob_conta..cb_corte
		where co_fecha_ini >= @i_fecha
		and co_fecha_fin <= @i_fecha
		and co_empresa = @i_empresa

		select @w_moneda = cu_moneda
		from cb_cuenta
		where cu_empresa = @i_empresa
		and cu_cuenta = @i_cuenta_contable
	
		select @cuenta_sob = ca_cta_asoc
		from cb_cuenta_asociada
		where ca_empresa = @i_empresa
		and ca_proceso = 6130
		and ca_cuenta = @i_cuenta_contable
	
	        /****OBTENER SALDO SEGUN LIBROS***/
		select	@w_saldo_libro = 0,	@w_saldo_me = 0,
			@w_saldo_sob = 0,	@w_saldo_sob_me = 0
	
		if @w_estado = 'A'
		begin
			select  @w_saldo_libro = sum(isnull(sa_saldo,0)),
				@w_saldo_me = sum(isnull(sa_saldo_me,0))
			from cb_saldo
			where sa_empresa = @i_empresa and
			sa_periodo = @w_periodo and
			sa_corte = @w_corte and
			sa_cuenta = @i_cuenta_contable
	
			select  @w_saldo_sob = sum(isnull(sa_saldo,0)),
				@w_saldo_sob_me = sum(isnull(sa_saldo_me,0))
			from cb_saldo
			where sa_empresa = @i_empresa and
			sa_periodo = @w_periodo and
			sa_corte = @w_corte and
			sa_cuenta = @cuenta_sob
		end
		else
		begin        
			select  @w_saldo_libro = sum(isnull(hi_saldo,0)),
				@w_saldo_me = sum(isnull(hi_saldo_me,0))
			from cob_conta_his..cb_hist_saldo
			where hi_empresa = @i_empresa and
			hi_periodo = @w_periodo and
			hi_corte = @w_corte and
			hi_cuenta = @i_cuenta_contable

			select  @w_saldo_sob = sum(isnull(hi_saldo,0)),
				@w_saldo_sob_me = sum(isnull(hi_saldo_me,0))
			from cob_conta_his..cb_hist_saldo
			where hi_empresa = @i_empresa and
			hi_periodo = @w_periodo and
			hi_corte = @w_corte and
			hi_cuenta = @cuenta_sob
		end

		if @w_moneda = 0
			select @w_saldo_libro + isnull(@w_saldo_sob,0)  /**SALDO SEGUN LIBROS**/ 
		else
			select @w_saldo_me + isnull(@w_saldo_sob_me,0)  /**SALDO SEGUN LIBROS**/
	        
	        /****PENDIENTES EN EXTRACTO*****/
	        /* select "Operaci¢n Banco" = de_operacion,
	        "Valor" = sum(de_valor),
	        " D/C " = '   ' + de_debcred
	        from cob_conta_tercero..ct_detest
	        where de_fecha <= @i_fecha
	        and de_cuenta = @i_cuenta
	        and de_banco = @i_banco
	        and de_empresa = @i_empresa
	        and de_relacionado = NULL
	        group by de_operacion,de_debcred*/
	
		select	"Concepto"	= cc_concepto,
			"Descripcion "	= cc_descripcion,
			"Fecha"		= convert(char(10),de_fecha_tran,@i_formato_fecha),
			"Valor"		= sum(de_valor),
			"Operacion"	= cc_operacion,
			"Naturaleza"	= de_debcred
		from cob_conta_tercero..ct_detest,
			cb_conceptos_movimientos, cb_conceptos_conciliacion
		where 	de_empresa = @i_empresa
			and de_cuenta = @i_cuenta
			and de_banco = @i_banco
			and de_fecha <= @i_fecha
			and isnull(de_relacionado,'N') = 'N'
			and cc_banco = 'S'
			and de_operacion = cm_operacion
			and cm_concepto = cc_concepto
		group by cc_concepto,cc_descripcion, de_fecha_tran, cc_operacion,de_debcred
	end
end

return 0
go
