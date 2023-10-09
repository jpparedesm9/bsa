/************************************************************************/
/*   Archivo:              Create                                       */
/*   Stored procedure:                                                  */
/*   Base de datos:        cob_conta_super                              */
/*   Producto:             Regulatorios                                 */
/*   Disenado por:         Juan Esteban Osorio                          */
/*   Fecha de escritura:   Enero 2022                                   */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                                   PROPOSITO                          */
/*   Creación de tabla para reporte de seguimiento				        */
/************************************************************************/
/*                          MODIFICACIONES                              */
/* FECHA           AUTOR       DESCRICIPCION                            */
/* 03/02/2022      JEOM        Caso #172727                             */
/************************************************************************/

USE [cob_conta_super]
GO

IF OBJECT_ID ('dbo.sb_banxico_lcr') IS NOT NULL
	DROP TABLE dbo.sb_banxico_lcr
GO

CREATE TABLE dbo.sb_banxico_lcr
	(
	sb_foliocredito           VARCHAR (24),
	sb_folio_cliente          INT,
	sb_id_producto            INT,
	sb_fecha_originacion      VARCHAR (24),
	sb_fecha_iniprograma      VARCHAR (24),
	sb_fecha_finprograma      VARCHAR (24),
	sb_tip_est_cuenta         INT,
	sb_est_cue_papel          INT,
	sb_banca_internet         INT,
	sb_clascont               INT,
	sb_reestructura           INT,
	sb_med_adqui              INT,
	sb_qcbd                   VARCHAR (24),
	sb_tasarev                VARCHAR (24),
	sb_limcreditoa            VARCHAR (24),
	sb_limcredito             VARCHAR (24),
	sb_limcredito_calc        VARCHAR (24),
	sb_saldopagar             VARCHAR (24),
	sb_saldotot               VARCHAR (24),
	sb_saldo_msi              INT,
	sb_saldoc_msi             INT,
	sb_saldocont              VARCHAR (24),
	sb_saldorev_ant           VARCHAR (24),
	sb_saldopmsi_ant          VARCHAR (24),
	sb_saldopci_ant           VARCHAR (24),
	sb_saldorev               VARCHAR (24),
	sb_saldopmsi              VARCHAR (24),
	sb_saldopci               VARCHAR (24),
	sb_interesrev             VARCHAR (24),
	sb_interespci             VARCHAR (24),
	sb_pagoexigepsi_ini       INT,
	sb_pagoexigec_ini         INT,
	sb_pagoexigepsi           INT,
	sb_pagoexigec             INT,
	sb_pagoexige_ini          VARCHAR (24),
	sb_pme_cap_ini            VARCHAR (24),
	sb_pme_int_ini            VARCHAR (24),
	sb_pme_int_ini_com        VARCHAR (24),
	sb_pme_int_ini_com_cob    VARCHAR (24),
	sb_pme_otro_ini           VARCHAR (24),
	sb_pagoexige              VARCHAR (24),
	sb_pagomin_corte          VARCHAR (24),
	sb_pme_cap_corte          VARCHAR (24),
	sb_pme_int_ini_act        VARCHAR (24),
	sb_pme_int__com_corte     VARCHAR (24),
	sb_pme_int_corte          VARCHAR (24),
	sb_pme_otro_corte         VARCHAR (24),
	sb_pagongi                VARCHAR (24),
	sb_pagoreal_ant           VARCHAR (24),
	sb_pagoreal_corte         VARCHAR (24),
	sb_pagoreal_cap_corte     VARCHAR (24),
	sb_pagoreal_int_corte_cap VARCHAR (24),
	sb_pagoreal_int_corte     VARCHAR (24),
	sb_pagoreal_int_corte_com VARCHAR (24),
	sb_pagoreal_otro_corte    VARCHAR (24),
	sb_catcuenta              VARCHAR (24),
	sb_indicadorcat           VARCHAR (1),
	sb_tipo_met               INT,
	sb_indicador_sic          INT,
	sb_meses_cons_sic         INT,
	sb_segmento               VARCHAR (1),
	sb_garantia               VARCHAR (1),
	sb_relacion               INT,
	sb_meses                  INT,
	sb_montopagarinst         VARCHAR (24),
	sb_montopagarsic          VARCHAR (4),
	sb_mesantig               VARCHAR (4),
	sb_mesesic                VARCHAR (4),
	sb_mesapert               VARCHAR (24),
	sb_plazo_remanente        VARCHAR (24),
	sb_gveces                 VARCHAR (4),
	sb_impagosc               VARCHAR (4),
	sb_impagosum              VARCHAR (4),
	sb_etapa_cred             VARCHAR (1),
	sb_tasa_cobrada           VARCHAR (24),
	sb_probinc                VARCHAR (4),
	sb_sevper                 VARCHAR (4),
	sb_expinc                 VARCHAR (4),
	sb_rvas_12                VARCHAR (4),
	sb_rvas_vida              VARCHAR (4),
	sb_rvas_total             VARCHAR (4),
	sb_etapa_cred_interna     INT,
	sb_fact_cred              INT,
	sb_tasa_met_cobrada       INT,
	sb_tasa_int_cobrada       INT,
	sb_tasa_prep_cobrada      INT,
	sb_probabint              INT,
	sb_severint               INT,
	sb_exposint               INT,
	sb_rvasint_12             INT,
	sb_rvas_vida_int          INT,
	sb_rvas_total_int         INT,
	sb_probabinc_cap          INT,
	sb_sevper_cap             INT,
	sb_expinc_cap             INT,
	sb_rvas_total_cap         INT,
	sb_rvas_adicionales       INT
	)
GO

CREATE CLUSTERED INDEX index01
	ON dbo.sb_banxico_lcr (sb_foliocredito)
GO

