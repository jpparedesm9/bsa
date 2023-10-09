/************************************************************************/
/*	Archivo: 		trasterc.sp                             */
/*	Stored procedure: 	sp_trasterc                             */
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Jose Orlando Forero.              	*/
/*	Fecha de escritura:     11/Sept/2003   				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Genera comprobantes auxiliares a partir de comprobantes         */
/*	definitivos. Proceso de trasalado de terceros.                  */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_trasterc')
	drop proc sp_trasterc
go

create proc sp_trasterc (
	@s_ssn			int      	= null,
	@s_date			datetime 	= null,
	@s_user			login    	= null,
	@s_term			descripcion 	= null,
	@s_corr			char(1)  	= null,
	@s_ssn_corr		int      	= null,
	@s_ofi			smallint  	= null,
	@t_rty			char(1)  	= null,
	@t_trn			smallint 	= null,
	@t_debug		char(1)		= 'N',
	@t_file			varchar(14)	= null,
	@i_empresa		tinyint 	= null
)
as
declare
	@w_sp_name		varchar(32),
	@w_siguiente		int,
	@w_today		datetime,
	@w_comprobante		int,
	@w_fecha_tran		datetime,
	@w_oficina_orig		smallint,
	@w_area_orig		smallint,
	@w_fecha_dig		datetime,
	@w_fecha_mod		datetime,
	@w_digitador		descripcion,
	@w_descripcion		descripcion,
	@w_comp_tipo		int,
	@w_detalles		    int,
	@w_tot_debito		money,
	@w_tot_credito		money,
	@w_tot_debito_me	money,
	@w_tot_credito_me	money,
	@w_automatico		int,
	@w_reversado		char(1),
	@w_autorizado		char(1),
	@w_autorizante		descripcion,
	@w_referencia		varchar(10),
	@w_causa_anula		char(2),
	@w_tipo_compro		char(1),
	@w_estado		char(1),
	@w_return		int,
	@w_est_corte		char(1)

select @w_sp_name = 'sp_trasterc', @w_today = getdate()


CREATE TABLE #sasiento
(sa_producto       tinyint         NULL,
sa_comprobante     int             NULL,
sa_empresa         tinyint         NULL,
sa_fecha_tran      datetime        NULL,
sa_asiento         int             NULL,
sa_cuenta          char(14)        NULL,
sa_oficina_dest    smallint        NULL,
sa_area_dest       smallint        NULL,
sa_credito         money           NULL,
sa_debito          money           NULL,
sa_concepto        varchar(160)    NULL,
sa_credito_me      money           NULL,
sa_debito_me       money           NULL,
sa_cotizacion      money           NULL,
sa_tipo_doc        char(1)         NULL,
sa_tipo_tran       char(1)         NULL,
sa_moneda          tinyint         NULL,
sa_opcion          tinyint         NULL,
sa_ente            int             NULL,
sa_con_rete        char(4)         NULL,
sa_base            money           NULL,
sa_valret          money           NULL,
sa_con_iva         char(4)         NULL,
sa_valor_iva       money           NULL,
sa_iva_retenido    money           NULL,
sa_con_ica         char(4)         NULL,
sa_valor_ica       money           NULL,
sa_con_timbre      char(4)         NULL,
sa_valor_timbre    money           NULL,
sa_con_iva_reten   char(4)         NULL,
sa_con_ivapagado   char(4)         NULL,
sa_valor_ivapagado money           NULL,
sa_documento       char(24)        NULL,
sa_mayorizado      char(1)         NULL,
sa_origen_mvto     varchar(20)     NULL,
sa_con_dptales     char(4)         NULL,
sa_valor_dptales   money           NULL)


declare trasladaterc cursor
for select co_comprobante,convert(varchar(10),co_fecha_tran,101),co_oficina_orig,
co_area_orig,co_fecha_dig,co_fecha_mod,co_digitador,
co_descripcion,co_comp_tipo,co_detalles,co_tot_debito,
co_tot_credito,co_tot_debito_me,co_tot_credito_me,co_automatico,
co_reversado,co_autorizado,co_autorizante,co_referencia,co_causa_anula,
co_tipo_compro,co_estado
from cob_conta..cb_comprobante
where co_empresa = @i_empresa
and   co_mayorizado  = 'S'
and   co_autorizado  = 'S'
and   isnull(co_traslado,'N') <> 'S'
for update

open trasladaterc

fetch trasladaterc into
@w_comprobante,@w_fecha_tran,@w_oficina_orig,
@w_area_orig,@w_fecha_dig,@w_fecha_mod,@w_digitador,
@w_descripcion,@w_comp_tipo,@w_detalles,@w_tot_debito,
@w_tot_credito,@w_tot_debito_me,@w_tot_credito_me,@w_automatico,
@w_reversado,@w_autorizado,@w_autorizante,@w_referencia,@w_causa_anula,
@w_tipo_compro,@w_estado

while (@@fetch_status = 0)
begin
	select @w_est_corte = isnull(co_estado,'N')
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_fecha_ini <= @w_fecha_tran
	and co_fecha_fin >= @w_fecha_tran
	if (@@rowcount = 0) or (@w_est_corte <> 'A' and @w_est_corte <> 'V')
	begin	/* 'Periodo o Corte no vigente o Cerrado' */
--		rollback tran
		return 603023
	end

	delete #sasiento

	begin tran

	exec @w_return = cob_conta..sp_cseqcomp
		@i_tabla     = 'cb_scomprobante',
		@i_empresa   = @i_empresa,
		@i_fecha     = @w_fecha_tran,
		@i_modulo    = 6,
		@i_modo	     = 0, /* 0 para numerar por empresa */
		@o_siguiente = @w_siguiente out
	if @w_return <> 0
	begin	/* Error en insercion de header de comprobante en tabla temporal */
		rollback tran
		return 603019
	end


	insert into cob_conta_tercero..ct_scomprobante (
		sc_producto,sc_comprobante,sc_empresa,sc_fecha_tran,
		sc_oficina_orig,sc_area_orig,sc_fecha_gra,sc_digitador,
		sc_descripcion,sc_perfil,sc_detalles,sc_tot_debito,
		sc_tot_credito,sc_tot_debito_me,sc_tot_credito_me,sc_automatico,
		sc_reversado,sc_estado,sc_mayorizado,sc_observaciones,
		sc_comp_definit,sc_usuario_modulo,sc_causa_error,sc_comp_origen,
		sc_tran_modulo)
	values (6,@w_siguiente,@i_empresa,@w_fecha_tran,
		@w_oficina_orig,@w_area_orig,@w_today,@w_digitador,
		@w_descripcion,' ',@w_detalles,@w_tot_debito,
		@w_tot_credito,@w_tot_debito_me,@w_tot_credito_me,@w_automatico,
		@w_reversado,'P','N',null,
		@w_comprobante,@w_digitador,null,null,null)
	if @@error <> 0 or @@rowcount = 0
	begin	/* Error en insercion de header de comprobante en tabla temporal */
		rollback tran
		return 603019
	end


	insert #sasiento
		(sa_producto,sa_comprobante,sa_empresa,sa_fecha_tran,
		sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
		sa_credito,sa_debito,sa_concepto,sa_credito_me,
		sa_debito_me,sa_cotizacion,sa_tipo_doc,sa_tipo_tran,
		sa_moneda,sa_opcion,sa_ente,sa_con_rete,
		sa_base,sa_valret,sa_con_iva,sa_valor_iva,
		sa_iva_retenido,sa_con_ica,sa_valor_ica,sa_con_timbre,
		sa_valor_timbre,sa_con_iva_reten,sa_con_ivapagado,sa_valor_ivapagado,
		sa_documento,sa_mayorizado,sa_origen_mvto,sa_con_dptales,
		sa_valor_dptales)
	select  6,@w_comprobante,as_empresa,as_fecha_tran,
		as_asiento,as_cuenta,as_oficina_dest,as_area_dest,
		as_credito,as_debito,as_concepto,as_credito_me,
		as_debito_me,as_cotizacion,as_tipo_doc,isnull(as_tipo_tran,'N'),
		as_moneda,as_opcion,NULL,NULL,
		NULL,NULL,NULL,NULL,
		NULL,NULL,NULL,NULL,
		NULL,NULL,NULL,NULL,
		NULL,'N',NULL,NULL,
		NULL
	from cob_conta..cb_asiento
	where as_empresa	= @i_empresa
	and as_fecha_tran	= @w_fecha_tran
	and as_comprobante	= @w_comprobante
	and as_asiento		>= 0
	and as_oficina_orig	= @w_oficina_orig
	if @@error <> 0 or @@rowcount = 0
	begin	/* 'Error en insercion de Detalle de Comprobante en tabla temporal' */
		rollback tran
		return 603020
	end


	update #sasiento set
		sa_ente			= re_ente,
		sa_con_rete		= re_concepto,
		sa_base			= re_base,
		sa_valret		= re_valret,
		sa_con_iva		= re_con_iva,
		sa_valor_iva		= re_valor_iva,
		sa_iva_retenido		= re_iva_retenido,
		sa_con_ica		= re_con_ica,
		sa_valor_ica		= re_valor_ica,
		sa_con_timbre		= re_con_timbre,
		sa_valor_timbre		= re_valor_timbre,
		sa_con_iva_reten	= re_con_iva_reten,
		sa_con_ivapagado	= re_con_ivapagado,
		sa_valor_ivapagado	= re_valor_ivapagado,
		sa_documento		= isnull(re_documento,'.'),
		sa_con_dptales		= re_con_dptales,
		sa_valor_dptales	= re_valor_dptales
	from #sasiento, cob_conta..cb_retencion
	where re_empresa	= sa_empresa
	and re_comprobante	= sa_comprobante
	and re_asiento		= sa_asiento
	and re_fecha		= sa_fecha_tran
	and re_oficina_orig	= @w_oficina_orig
	if @@error <> 0
	begin	/* 'Error en insercion de Detalle de Comprobante en tabla temporal' */
		rollback tran
		return 603020
	end


	insert cob_conta_tercero..ct_conciliacion (
	cl_producto,cl_comprobante,cl_empresa,cl_fecha_tran,
	cl_asiento,cl_cuenta,cl_oficina_dest,cl_area_dest,
	cl_debcred,
	cl_valor,
	cl_oper_banco,cl_doc_banco,cl_banco,cl_fecha_est,
	cl_cuenta_cte,cl_detalle,cl_relacionado,cl_modulo,
	cl_beneficiario,cl_cheque,cl_refinterna,cl_fecha_conc)
	
	select 6, @w_siguiente, sa_empresa, sa_fecha_tran,
	sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest,
	case sa_debito_me - sa_credito_me when 0 then
		case sa_debito when 0 then 'C' else 'D' end	--ES MN
	else
		case sa_debito_me when 0 then 'C' else 'D' end	--ES ME
	end,
	case sa_debito_me - sa_credito_me when 0 then
		case sa_debito when 0 then sa_credito else sa_debito end           --ES MN
	else
		case sa_debito_me when 0 then sa_credito_me else sa_debito_me end  --ES ME
	end,
	cl_operacion, null, ba_banco, null,
	ba_ctacte, null, 'N', null,
	null,cl_cheque,null,null
	from cob_conta..cb_conciliacion, cob_conta..cb_banco, #sasiento
	where cl_empresa	= sa_empresa
	and cl_fecha		= sa_fecha_tran
	and cl_comprobante	= sa_comprobante
	and cl_asiento		= sa_asiento
	and cl_oficina_orig	= @w_oficina_orig
	and cl_operacion	is not null
	and isnull(cl_traslado, 'N') = 'N'
	and ba_empresa		= sa_empresa
	and ba_cuenta		= sa_cuenta
	if @@error <> 0
	begin	/* 'Error en insercion de datos de conciliacion' */
		rollback tran
		return 603060
	end

	update #sasiento set sa_comprobante = @w_siguiente
	if @@error <> 0
	begin	/* 'Error en la actualizacion de Asiento' */
		rollback tran
		return 605088
	end

	insert cob_conta_tercero..ct_sasiento
	(sa_producto,sa_comprobante,sa_empresa,sa_fecha_tran,
	sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
	sa_credito,sa_debito,sa_concepto,sa_credito_me,
	sa_debito_me,sa_cotizacion,sa_tipo_doc,sa_tipo_tran,
	sa_moneda,sa_opcion,sa_ente,sa_con_rete,
	sa_base,sa_valret,sa_con_iva,sa_valor_iva,
	sa_iva_retenido,sa_con_ica,sa_valor_ica,sa_con_timbre,
	sa_valor_timbre,sa_con_iva_reten,sa_con_ivapagado,sa_valor_ivapagado,
	sa_documento,sa_mayorizado,sa_origen_mvto,sa_con_dptales,
	sa_valor_dptales)
	select 
	sa_producto,sa_comprobante,sa_empresa,sa_fecha_tran,
	sa_asiento,sa_cuenta,sa_oficina_dest,sa_area_dest,
	sa_credito,sa_debito,sa_concepto,sa_credito_me,
	sa_debito_me,sa_cotizacion,sa_tipo_doc,sa_tipo_tran,
	sa_moneda,sa_opcion,sa_ente,sa_con_rete,
	sa_base,sa_valret,sa_con_iva,sa_valor_iva,
	sa_iva_retenido,sa_con_ica,sa_valor_ica,sa_con_timbre,
	sa_valor_timbre,sa_con_iva_reten,sa_con_ivapagado,sa_valor_ivapagado,
	sa_documento,sa_mayorizado,sa_origen_mvto,sa_con_dptales,
	sa_valor_dptales
	from #sasiento
	if @@error <> 0
	begin	/* 'Error en insercion de Detalle de Comprobante en tabla temporal' */
		rollback tran
		return 603020
	end

	update cob_conta..cb_comprobante set co_traslado = 'S'
	where  co_empresa	= @i_empresa
	and    co_fecha_tran	= @w_fecha_tran
	and    co_comprobante	= @w_comprobante
	and    co_oficina_orig	= @w_oficina_orig
	if @@error <> 0
	begin	/* 'Error en actualizacion de estado del comprobante' */
		rollback tran
		return 603022
	end

	commit tran

	fetch trasladaterc into
	@w_comprobante,@w_fecha_tran,@w_oficina_orig,
	@w_area_orig,@w_fecha_dig,@w_fecha_mod,@w_digitador,
	@w_descripcion,@w_comp_tipo,@w_detalles,@w_tot_debito,
	@w_tot_credito,@w_tot_debito_me,@w_tot_credito_me,@w_automatico,
	@w_reversado,@w_autorizado,@w_autorizante,@w_referencia,@w_causa_anula,
	@w_tipo_compro,@w_estado
end

close trasladaterc
deallocate trasladaterc

return 0

go
