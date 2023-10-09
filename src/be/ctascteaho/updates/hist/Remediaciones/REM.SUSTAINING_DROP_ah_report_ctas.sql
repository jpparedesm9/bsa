USE cob_ahorros_his
go

IF EXISTS (SELECT 1 FROM cob_ahorros_his..ah_report_ctas)
BEGIN

  DROP TABLE cob_ahorros_his..ah_report_ctas
  
end

GO


USE cob_ahorros
GO




IF EXISTS (SELECT 1 FROM cob_ahorros..ah_report_ctas)
BEGIN

  DROP TABLE cob_ahorros..ah_report_ctas
  
end



CREATE TABLE cob_ahorros..ah_report_ctas
	(
	w_ah_cuenta          CHAR(12),
	w_ah_cta_banco       CHAR(20),
	w_ah_oficina         CHAR(6),
	w_nomb_oficina       CHAR(40),
	w_ah_moneda          CHAR(5),
	w_descp_moneda       CHAR(35),
	w_ah_prod_banc       CHAR(5),
	w_descp_prod         CHAR(50),
	w_ah_origen          CHAR(5),
	w_desc_origen        CHAR(50),
	w_ah_categoria       CHAR(1),
	w_desc_categoria     CHAR(50),
	w_ah_titularidad     CHAR(1),
	w_desc_titularidad   CHAR(50),
	w_ah_oficial         CHAR(5),
	w_nomb_oficial       CHAR(64),
	w_ah_cliente         CHAR(10),
	w_ah_nombre          CHAR(80),
	w_ah_ced_ruc         CHAR(20),
	w_ah_descripcion_dv  CHAR(64),
	w_ah_fecha_ult_mov   CHAR(10),
	w_ah_fecha_prx_capita CHAR(10),
	w_ah_numsol          CHAR(10),
	w_ah_plazo           CHAR(10),
    w_perfil             CHAR(10),
	w_ca_cta_banco_mig   CHAR(16),
	w_ah_disponible      CHAR(18),
	w_ah_12h             CHAR(18),
	w_ah_24h             CHAR(18),
	w_slado_contable     CHAR(18),
	w_ah_saldo_interes   CHAR(18),
	w_ah_tasa_hoy        CHAR(6),
	w_ah_creditos_hoy    CHAR(18),
	w_ah_debitos_hoy     CHAR(18),
	w_ah_num_deb_mes     CHAR(6),
	w_ah_num_cred_mes    CHAR(6),
	w_ah_prom_disponible CHAR(18),
	w_ah_promedio1       CHAR(18),
	w_ah_promedio2       CHAR(18),
	w_ah_promedio3       CHAR(18),
	w_ah_promedio4       CHAR(18),
	w_ah_promedio5       CHAR(18),
	w_ah_promedio6       CHAR(18),
	w_ah_monto_bloq      CHAR(18),
	w_monto_bloq1        CHAR(18),
	w_fecha_bloq1        CHAR(10),
	w_monto_bloq2        CHAR(18),
	w_fecha_bloq2        CHAR(10),
	w_monto_bloq3        CHAR(18),
	w_fecha_bloq3        CHAR(10),
	w_existe_bloq1       CHAR(1),
	w_fecha_bloqm1       CHAR(10),
	w_existe_bloq2       CHAR(1),
	w_fecha_bloqm2       CHAR(10),
	w_existe_bloq3       CHAR(1),
	w_fecha_bloqm3       CHAR(10),
	w_ah_estado          CHAR(6),
	w_descip_estado      CHAR(50),
	w_ah_fecha_aper      CHAR(10),
	w_ah_fecha_inacti    CHAR(10),
	w_ah_fecha_cierre    CHAR(10),
    w_ah_fecha_reacti    CHAR(10)
	)
go
