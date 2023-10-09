USE cob_remesas
go 

declare @w_empresa	int,
		@w_modulo	int,
		@w_fecha	datetime,
		@w_codigo int

if exists (select 1 from cob_remesas..sysobjects where name = 're_concepto_contable')
begin
	select @w_modulo = 4
	select @w_fecha = fp_fecha from cobis..ba_fecha_proceso
	select @w_empresa = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'EMP' and pa_producto = 'ADM'
	
	delete from cob_remesas..re_concepto_contable where cc_producto = @w_modulo
	select @w_codigo = min(cc_secuencial) from cob_remesas..re_concepto_contable
	
	select @w_codigo = isnull(@w_codigo, 0) + 1
	
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 203, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha, 'S', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 203, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'S', @w_fecha, 'S', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, NULL, 'D', 'NDECANCIN', '2', 'tm_valor', NULL, NULL, 'S', @w_fecha, 'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, NULL, 'D', 'NDECIECHG', '3', 'tm_valor', NULL, NULL, 'S', @w_fecha, 'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, NULL, 'D', 'NDECIECON', '0', 'tm_valor', NULL, NULL, 'S', @w_fecha, 'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, NULL, 'D', 'NDECIEEFE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha, 'M', 'V')
	select @w_codigo = @w_codigo + 1
	
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 200, NULL, NULL, 'D', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha, 'S', 'V')
	select @w_codigo = @w_codigo + 1
	
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, 'R', 'D', 'NDEGMF', '0', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, NULL, 'D', 'NDEGMF', '2', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 213, NULL, 'R', 'D', 'NDEGMF', '3', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 221, NULL, NULL, 'C', 'INTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 224, '59', NULL, 'D', 'DREMI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 237, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 237, NULL, NULL, 'D', 'NDETRANS', NULL, 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 240, NULL, NULL, 'D', 'NDEDEVEFE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 240, NULL, NULL, 'D', 'NDEDEVLOC', '2', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 252, NULL, NULL, 'C', 'CH_LOC', NULL, 'tm_chq_locales', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 252, NULL, NULL, 'C', 'CH_OTR', NULL, 'tm_chq_ot_plazas', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 252, NULL, NULL, 'C', 'CH_PRO', NULL, 'tm_chq_propios', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 252, NULL, NULL, 'C', 'EFECTIVO', NULL, 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '106', NULL, 'C', 'NCRTRANS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '107', 'T', 'C', 'DEVGMF', '1', 'tm_valor', 'tm_valor', 'tm_valor', 'N', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '108', 'R', 'C', 'DEVRTEFTE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '109', NULL, 'C', 'NCRCTAEMP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '110', NULL, 'C', 'NCTRDCTOB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '111', NULL, 'C', 'NCRCOMCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '112', NULL, 'C', 'NCDEVCMTD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '114', NULL, 'C', 'NCABONOPAG', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '115', NULL, 'C', 'NCPA INCE', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '116', 'T', 'C', 'NCAJTRNATM', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '117', 'T', 'C', 'NCAJTRNPOS', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '118', 'T', 'C', 'NCAJCOMATM', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '12', NULL, 'C', 'NCRDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '14', NULL, 'C', 'NCRCONV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '16', NULL, 'C', 'REVPOS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '163', NULL, 'D', 'NCRPAGMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '17', NULL, 'C', 'NCRTRNSLD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '170', NULL, 'C', 'NCAJ50RBM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '171', NULL, 'C', 'NCAJ56RBM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '19', NULL, 'C', 'NCABNOEM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '20', NULL, 'C', 'NCRGMFCBCO', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '200', NULL, 'C', 'NCRCORDEP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '203', NULL, 'C', 'NCRDPTCON', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '205', NULL, 'C', 'NCRPAGPROV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '21', NULL, 'C', 'NCRDESPRE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '218', NULL, 'C', 'NCRINTMAN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '219', NULL, 'C', 'NCRDEPTRA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '224', NULL, 'C', 'NCRDESEMB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '227', NULL, 'C', 'NCRDEPPCO', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '229', NULL, 'C', 'NCRMANOPE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '23', NULL, 'C', 'NCABPAVI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '234', NULL, 'C', 'NCRREICHG', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '236', NULL, 'C', 'NCRDPTTES', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '237', NULL, 'C', 'NCRCAMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '242', NULL, 'C', 'NCRWU', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '243', NULL, 'C', 'NCRRETPOS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '244', NULL, 'C', 'NCRRETPOSI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '245', NULL, 'C', 'NCAJUSERRT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '246', NULL, 'C', 'NCAJUSTGMF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '25', NULL, 'C', 'NCRACH', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '26', NULL, 'C', 'REVMEMACH', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '260', NULL, 'C', 'CCCUPOCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '261', NULL, 'C', 'NCRCCCBP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '27', NULL, 'C', 'REVTRACH', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '28', NULL, 'C', 'REVCOMEX', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '30', NULL, 'C', 'NCRRVAPDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '31', NULL, 'C', 'NCRREFERI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '39', NULL, 'C', 'NCRDEPCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '4', NULL, 'C', 'DEVCOMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '42', NULL, 'C', 'NCRREACTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '43', NULL, 'C', 'REVCOMCHG', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '47', NULL, 'C', 'NCRINTREC', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '48', NULL, 'C', 'NCREINPAGC', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '49', NULL, 'C', 'NCRENTMMI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '50', NULL, 'C', 'NCDTN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '51', NULL, 'C', 'NCRRGCCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '52', NULL, 'C', 'NCRAUCCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '6', NULL, 'C', 'CONCHREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '85', NULL, 'C', 'NCRTRSMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '86', NULL, 'C', 'NCRRCMMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '87', NULL, 'C', 'NCRCCMMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 253, '88', NULL, 'C', 'NCRACMMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '141', NULL, 'D', 'CXCCOMATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '142', NULL, 'D', 'CXCCOMATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '156', NULL, 'D', 'CXCPININV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '159', NULL, 'D', 'CXCPDTARJ', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '160', NULL, 'D', 'CXCROTARJ', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '161', NULL, 'D', 'CXCFINSU', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '233', NULL, 'D', 'CXCCSAATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '234', NULL, 'D', 'CXCCSAATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '238', NULL, 'D', 'CXCCUOMAN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '260', NULL, 'D', 'CXCDICCB', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '39', NULL, 'D', 'CXCCMRMOV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 258, '46', NULL, 'D', 'CXCCMUMOV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 261, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 261, NULL, NULL, 'D', 'RET', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 263, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 263, NULL, NULL, 'D', 'RET', NULL, 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, NULL, 'V', 'D', 'NDEIVA', '1', 'tm_valor_comision', 'tm_valor', NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '1', NULL, 'D', 'NDEESTCTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '10', NULL, 'D', 'NDECOMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '11', NULL, 'D', 'NDEREFBAN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '12', NULL, 'D', 'NDECOMCIE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '13', NULL, 'D', 'NDECOMECT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '139', NULL, 'D', 'NDERETATMN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '14', NULL, 'D', 'NDETRASLD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '140', NULL, 'D', 'NDERETATMI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '141', NULL, 'D', 'NDECOMATMN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '142', NULL, 'D', 'NDECOMATMI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '143', NULL, 'D', 'NDERETPOS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '152', NULL, 'D', 'NDECCSMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '156', NULL, 'D', 'NDEPININV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '159', NULL, 'D', 'NDEPDTARJ', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '16', NULL, 'D', 'NDECHQGER', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '160', NULL, 'D', 'NDEROTARJ', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '161', NULL, 'D', 'NDEFINSU', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '162', NULL, 'D', 'NDECMOMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '163', NULL, 'D', 'NDEPAGMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '164', NULL, 'D', 'NDERECMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '165', NULL, 'D', 'NDAJTRNATM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '166', NULL, 'D', 'NDAJTRNPOS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '167', NULL, 'D', 'CXCEXCMONT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '168', NULL, 'D', 'CXCEXCNUMU', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '17', NULL, 'D', 'NDETRAEXT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '170', NULL, 'D', 'NDAJ51RBM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '171', NULL, 'D', 'NDAJ57RBM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '182', 'R', 'D', 'NDERTEFTE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '183', NULL, 'D', 'NDEPORTDEV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '184', NULL, 'D', 'NDERETCHGE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '185', NULL, 'D', 'NDECOMTRF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '20', NULL, 'D', 'NDETRANS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '205', NULL, 'D', 'NDECORDEP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '213', NULL, 'D', 'NDEAUMDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '23', NULL, 'D', 'NDESUSDOC', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '233', NULL, 'D', 'NDECSAATMN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '234', NULL, 'D', 'NDECSAATMI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '236', NULL, 'D', 'NDEMANOPE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '237', NULL, 'D', 'NDEPROVEED', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '238', NULL, 'D', 'NDECUOMAN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '24', NULL, 'D', 'NDECONDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '244', NULL, 'D', 'NDEREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '246', NULL, 'D', 'NDEDEVCHEX', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '248', NULL, 'D', 'NDTRACTOB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '25', NULL, 'D', 'NDECIECTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '26', NULL, 'D', 'NDEPAGCAR', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '260', NULL, 'D', 'CCCUPOCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '261', NULL, 'D', 'NDECCCBP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '27', NULL, 'D', 'NDEPORREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '28', NULL, 'D', 'NDECOMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '30', NULL, 'D', 'NDETRNNAL', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '31', NULL, 'D', 'NDECOMRETV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '32', 'R', 'D', 'NDEGMF', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '33', NULL, 'D', 'NDEIVA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '34', NULL, 'D', 'NDRVCANDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '35', NULL, 'D', 'NDECOMCHGE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '36', NULL, 'D', 'NDCOMDISP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '37', NULL, 'D', 'NDECOMCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '38', NULL, 'D', 'NDERETCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '39', NULL, 'D', 'NDECMRMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '4', NULL, 'D', 'NDECOMCHD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '40', NULL, 'D', 'NDECOMPOSN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '41', NULL, 'D', 'NDECOMPOSI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '44', NULL, 'D', 'NDEPCARMAS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '46', NULL, 'D', 'NDECMUMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '50', NULL, 'D', 'NDEDICCB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '7', NULL, 'D', 'NDECHQREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '75', NULL, 'D', 'NDERETPOSI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '8', NULL, 'D', 'NDEAJUCHL', '3', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '8', NULL, 'D', 'NDEAJUCHP', '2', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '8', NULL, 'D', 'NDEAJUCHR', '4', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '8', NULL, 'D', 'NDEDIFDEP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '84', NULL, 'D', 'NDECOMCHGE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '85', NULL, 'D', 'NDETRSMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '86', NULL, 'D', 'NDERCMMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '87', NULL, 'D', 'NDECCMMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '88', NULL, 'D', 'NDEACMMOV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '9', NULL, 'D', 'NDEEMBARG', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '90', NULL, 'D', 'NDECOMOFI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '91', NULL, 'D', 'NDERECINT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '92', NULL, 'D', 'NDECOMECT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 264, '93', NULL, 'D', 'NDEREIDESC', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--Pignoracion
    INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) VALUES (@w_codigo,  @w_modulo, 217, '18' , NULL, 'D', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha, 'S', 'V')
    select @w_codigo = @w_codigo + 1
    INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) VALUES (@w_codigo,  @w_modulo, 218, '18', NULL, 'D', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha, 'S', 'V')
    select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 271, NULL, NULL, 'C', 'INT', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 300, NULL, NULL, 'D', 'NCRTRANS', NULL, 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '141', NULL, 'D', 'CXCCOMATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '142', NULL, 'D', 'CXCCOMATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '156', NULL, 'D', 'CXCPININV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '159', NULL, 'D', 'CXCPDTARJ', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '160', NULL, 'D', 'CXCROTARJ', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '161', NULL, 'D', 'CXCFINSU', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '233', NULL, 'D', 'CXCCSAATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '234', NULL, 'D', 'CXCCSAATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '238', NULL, 'D', 'CXCCUOMAN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '260', NULL, 'C', 'CXCAUMCB', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '39', NULL, 'D', 'CXCCMRMOV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 303, '46', NULL, 'D', 'CXCCMUMOV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 304, NULL, NULL, 'C', 'INTI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 308, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 308, NULL, 'R', 'D', 'NDERTEFTE', '1', 'tm_valor', 'tm_interes', NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 309, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 309, NULL, 'R', 'D', 'NDERTEFTE', '1', 'tm_valor', 'tm_interes', NULL, 'S', @w_fecha,  'M', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '106', NULL, 'C', 'NCRTRANS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '107', NULL, 'C', 'DEVGMF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '108', 'R', 'C', 'DEVRTEFTE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '12', NULL, 'C', 'NCRDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '14', NULL, 'C', 'NCRCONV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '16', NULL, 'C', 'REVPOS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '17', NULL, 'C', 'NCRTRNSLD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '200', NULL, 'C', 'NCRCORDEP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '203', NULL, 'C', 'NCRDPTCON', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '205', NULL, 'C', 'NCRPAGPROV', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '21', NULL, 'C', 'NCRDESPRE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '218', NULL, 'C', 'NCRINTMAN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '219', NULL, 'C', 'NCRDEPTRA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '224', NULL, 'C', 'NCRDESEMB', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '227', NULL, 'C', 'NCRDEPPCO', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '229', NULL, 'C', 'NCRMANOPE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '234', NULL, 'C', 'NCRREICHG', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '236', NULL, 'C', 'NCRDPTTES', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '237', NULL, 'C', 'NCRCAMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '25', NULL, 'C', 'NCRACH', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '26', NULL, 'C', 'REVMEMACH', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '27', NULL, 'C', 'REVTRACH', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '28', NULL, 'C', 'REVCOMEX', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '4', NULL, 'C', 'DEVCOMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '42', NULL, 'C', 'NCRREACTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '43', NULL, 'C', 'REVCOMCHG', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '47', NULL, 'C', 'NCRINTREC', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 315, '6', NULL, 'C', 'CONCHREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '1', NULL, 'D', 'NDEESTCTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '10', NULL, 'D', 'NDECOMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '11', NULL, 'D', 'NDEREFBAN', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '12', NULL, 'D', 'NDECOMCIE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '13', NULL, 'D', 'NDECOMECT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '14', NULL, 'D', 'NDETRASLD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '16', NULL, 'D', 'NDECHQGER', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '17', NULL, 'D', 'NDETRAEXT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '182', 'R', 'D', 'NDERTEFTE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '185', NULL, 'D', 'NDECOMTRF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '20', NULL, 'D', 'NDETRANS', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '205', NULL, 'D', 'NDECORDEP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '213', NULL, 'D', 'NDEAUMDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '23', NULL, 'D', 'NDESUSDOC', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '236', NULL, 'D', 'NDEMANOPE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '237', NULL, 'D', 'NDEPROVEED', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '24', NULL, 'D', 'NDECONDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '244', NULL, 'D', 'NDEREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '246', NULL, 'D', 'NDEDEVCHEX', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '25', NULL, 'D', 'NDECIECTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '26', NULL, 'D', 'NDEPAGCAR', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '27', NULL, 'D', 'NDEPORREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '28', NULL, 'D', 'NDECOMREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '30', NULL, 'D', 'NDETRNNAL', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '32', 'R', 'D', 'NDEGMF', '1', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '33', NULL, 'D', 'NDEIVA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '34', NULL, 'D', 'NDRVCANDPF', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '4', NULL, 'D', 'NDECOMCHD', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '7', NULL, 'D', 'NDECHQREM', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '8', NULL, 'D', 'NDEAJUCHL', '3', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '8', NULL, 'D', 'NDEAJUCHP', '2', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '8', NULL, 'D', 'NDEAJUCHR', '4', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '8', NULL, 'D', 'NDEDIFDEP', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '84', NULL, 'D', 'NDECOMCHGE', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '9', NULL, 'D', 'NDEEMBARG', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '90', NULL, 'D', 'NDECOMOFI', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '91', NULL, 'D', 'NDERECINT', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 316, '92', NULL, 'D', 'NDECONCTA', '1', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 334, NULL, 'R', 'D', 'NDEGMF', '1', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 334, NULL, NULL, 'D', 'NDERTEICA', '1', 'tm_valor', 'tm_interes', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 367, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 367, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 371, NULL, NULL, 'D', 'NDEAUTFLI', NULL, 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 371, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 373, '114', 'T', 'C', 'NCABONOPAG', '0', 'tm_valor', 'tm_base_gmf', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 373, '19', 'T', 'C', 'NCABNOEM', '0', 'ts_valor', 'ts_interes', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 373, '205', 'T', 'C', 'NCRPAGPROV', '0', 'ts_valor', 'ts_interes', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 373, '23', 'T', 'C', 'NCABPAVI', '0', 'ts_valor', 'ts_interes', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 373, '31', 'T', 'C', 'NCRREFERI', '0', 'ts_valor', 'ts_interes', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 373, '50', 'T', 'C', 'NCDTN', '0', 'ts_valor', 'ts_interes', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 374, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 374, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 375, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 375, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 376, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 376, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 377, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 377, NULL, NULL, 'C', 'INT', NULL, 'ts_interes', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 378, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 379, NULL, 'R', 'D', 'GMFCARBCO', NULL, 'ts_valor', 'ts_interes', NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 380, NULL, 'R', 'D', 'NDEGMF', '0', 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 380, NULL, NULL, 'D', 'NDERETCHGE', '0', 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 392, NULL, NULL, 'D', 'AUTRETINE', NULL, 'tm_valor', NULL, NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 392, NULL, 'R', 'D', 'NDEGMF', NULL, 'tm_monto_imp', 'tm_base_gmf', NULL, 'S', @w_fecha,  'M', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 750, '139', NULL, 'D', 'CMPRETATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 750, '140', NULL, 'D', 'CMPRETATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 750, '143', NULL, 'D', 'CMPRETPOSN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 750, '75', NULL, 'D', 'CMPRETPOSI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 751, '51', NULL, 'C', 'CORRGCCB', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 751, '52', NULL, 'C', 'CORAUCCB', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 752, '50', NULL, 'D', 'CORDICCB', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 753, '243', NULL, 'C', 'CMPANUPOSN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 753, '244', NULL, 'C', 'CMPANUPOSI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '141', NULL, 'D', 'CNDCOMATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '142', NULL, 'D', 'CNDCOMATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '159', NULL, 'D', 'CNDPDTARJ', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '160', NULL, 'D', 'CNDPININV', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '160', NULL, 'D', 'CNDROTARJ', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '161', NULL, 'D', 'CNDFINSU', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '233', NULL, 'D', 'CNDCSAATMN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '234', NULL, 'D', 'CNDCSAATMI', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado) values (@w_codigo,  @w_modulo, 754, '238', NULL, 'D', 'CNDCUOMAN', '1', 'ts_valor', NULL, NULL, 'S', @w_fecha,  'S', 'V')
	--select @w_codigo = @w_codigo + 1
	
	INSERT INTO cob_remesas..re_concepto_contable (cc_secuencial, cc_producto, cc_tipo_tran, cc_causa, cc_tipo_imp, cc_credeb, cc_concepto, cc_indicador, cc_campo1, cc_campo2, cc_campo3, cc_totaliza, cc_fecha, cc_tipo, cc_estado)  values (@w_codigo, @w_modulo, 201, NULL, NULL, 'C', 'CAP', NULL, 'ts_valor', NULL, NULL, 'S', @w_fecha, 'S', 'V')
	select @w_codigo = @w_codigo + 1
end
else
	print 'NO EXISTE TABLA re_concepto_contable'

----TABLA: cob_remesas..re_trn_perfil 
if exists (select 1 from cob_remesas..sysobjects where name = 're_trn_perfil')
begin
	delete from cob_remesas..re_trn_perfil where tp_producto = @w_modulo
	
	select @w_codigo = min(tp_secuencial) from cob_remesas..re_trn_perfil
	
	select @w_codigo = isnull(@w_codigo, 0) + 1
	
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 203, 'EST_AHO', 'CES')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 213, 'NDB_AHO', 'CIE')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 221, 'NCR_AHO', 'NCR')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 224, 'NDB_AHO', 'NDE')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 237, 'NDB_AHO', 'TRS')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 240, 'NDB_AHO', 'DEVLOC')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 251, 'NCR_AHO', 'DEP')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 252, 'NCR_AHO', 'DEP')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 253, 'NCR_AHO', 'NCR')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 258, 'VAL_SUS', 'CXC')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 261, 'NDB_AHO', 'RET')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 263, 'NDB_AHO', 'RET')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 264, 'NDB_AHO', 'NDE')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 271, 'CAU_AHO', 'CAU')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 300, 'NCR_AHO', 'TRS')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 303, 'COB_SUS', 'CXC')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 304, 'NCR_AHO', 'NCR')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 308, 'NDB_AHO', 'NDE')
	select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 309, 'NDB_AHO', 'NDE')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 315, 'NCR_AHO', 'NCR')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 316, 'NDB_AHO', 'NDE')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 334, 'NDB_AHO', 'NDE')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 367, 'EST_AHO', 'CES')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 371, 'NDB_AHO', 'RET')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 373, 'GMFBCOCAU', 'RET')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 374, 'TRAS_AHO', 'CES')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 375, 'EST_AHO', 'CES')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 376, 'EST_AHO', 'CES')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 377, 'EST_AHO', 'CES')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 378, 'EST_AHO', 'CES')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 379, 'GMFCARBCO', 'RET')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 380, 'NDB_AHO', 'RET')
	--select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 391, 'NDB_AHO', 'DEVREM')
	select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 392, 'NDB_AHO', 'RET')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 750, 'COMPRBMAHO', 'CXP')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 751, 'AUM_CUPO', 'COR')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 752, 'DIS_CUPO', 'COR')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 753, 'COMCRBMAHO', 'CXP')
	--select @w_codigo = @w_codigo + 1
	--INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 754, 'COND_AHO', 'CXC')
	--select @w_codigo = @w_codigo + 1
    INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 201, 'APER_AHO', 'DEP')
    select @w_codigo = @w_codigo + 1
    INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) values (@w_codigo,  @w_modulo, 200, 'APER_AHO', 'DEP')
    select @w_codigo = @w_codigo + 1
	
	--Pignoracion 
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) VALUES (@w_codigo,  @w_modulo, 217, 'BLOQ_PIGNO', 'CES')
    select @w_codigo = @w_codigo + 1
	INSERT INTO cob_remesas..re_trn_perfil (tp_secuencial, tp_producto, tp_tipo_tran, tp_perfil, tp_tipo) VALUES (@w_codigo,  @w_modulo, 218, 'LEVA_PIGNO', 'CES')
    select @w_codigo = @w_codigo + 1
	
    update cobis..cl_seqnos set siguiente = @w_codigo where tabla = 're_trn_perfil'
end
else
	print 'NO EXISTE TABLA re_trn_perfil' 
