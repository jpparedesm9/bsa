USE cob_conta_super
go


IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'sb_mov_mes_tmp_tti')
	DROP TABLE sb_mov_mes_tmp_tti
GO
CREATE TABLE sb_mov_mes_tmp_tti(	
	mmt_concepto     VARCHAR(160), 
	mmt_fecha_tran   VARCHAR(10),  
	mmt_comprobante  VARCHAR(20),  
	mmt_cuenta       VARCHAR(32),   
	mmt_oficina_dest VARCHAR(20),  
	mmt_area_dest    VARCHAR(20),  
	mmt_debito       VARCHAR(20),  
	mmt_credito      VARCHAR(20),
	mmt_prestamo	 VARCHAR(20),
	mmt_grupo	 	 VARCHAR(20)
	)
	
GO