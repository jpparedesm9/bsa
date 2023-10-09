/************************************************************************/
/*      Archivo:            ah_proc.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
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
/*      Este programa realiza la creacion de seguridades                */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cobis
GO


print '===> ah_proc.sql'
go

delete cobis..ad_procedure
where pd_procedure >= 200
and   pd_procedure <= 400
and   pd_base_datos = 'cob_ahorros'
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (200, 'sp_totcaj', 'cob_ahorros', 'V', getdate(), 'ahtotcaj.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (201, 'sp_relaciones_navidad', 'cob_ahorros', 'V', getdate(), 'ahrelnav.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (202, 'sp_crea_cuenta_navidad', 'cob_ahorros', 'V', getdate(), 'ahcrenav.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (203, 'sp_ah_bloqaho_nav', 'cob_ahorros', 'V', getdate(), 'ahblqnav.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (205, 'sp_parametro_dtn', 'cob_ahorros', 'V', getdate(), 'ahparamdtn.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (208, 'sp_ah_cons_valsus', 'cob_ahorros', 'V', getdate(), 'ccpcovas.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (211, 'sp_tr_consah_tasapond', 'cob_ahorros', 'V', getdate(), 'ahcontap.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (214, 'sp_apertura_ah', 'cob_ahorros', 'V', getdate(), 'apertah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (215, 'sp_tr_up_ctahorro', 'cob_ahorros', 'V', getdate(), 'ahpactah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (216, 'sp_tr_up_gral_ctahorro', 'cob_ahorros', 'V', getdate(), 'ahpacgen.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (217, 'sp_tr_bloqueo_mov_ah', 'cob_ahorros', 'V', getdate(), 'ahpblqmv.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (218, 'sp_tr_bloq_val_ah', 'cob_ahorros', 'V', getdate(), 'ahpblqva.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (219, 'sp_tr_ah_embargo', 'cob_ahorros', 'V', getdate(), 'ahtembar.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (220, 'sp_tr_consah_emb', 'cob_ahorros', 'V', getdate(), 'ahtconem.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (221, 'sp_tr_cons_bloq_ah', 'cob_ahorros', 'V', getdate(), 'ahpcoblq.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (222, 'sp_tr_reactivacion_ah', 'cob_ahorros', 'V', getdate(), 'ahpreact.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (223, 'sp_tr_reapertura_ah', 'cob_ahorros', 'V', getdate(), 'ahpreape.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (224, 'sp_tr_cons_lp_ah', 'cob_ahorros', 'V', getdate(), 'ahpcolp.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (225, 'sp_tr_consulta_mov_ah', 'cob_ahorros', 'V', getdate(), 'ahpcomov.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (226, 'sp_tr_ahcoestcta', 'cob_ahorros', 'V', getdate(), 'ahestcta.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (227, 'sp_tr_cons_ah', 'cob_ahorros', 'V', getdate(), 'ahpcocta.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (228, 'sp_tr_cons_gral_ah', 'cob_ahorros', 'V', getdate(), 'ahpcogah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (229, 'sp_tr_solicita_ec_ah', 'cob_ahorros', 'V', getdate(), 'ahpsolec.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (230, 'sp_tr_tot_ofi_adm_ah', 'cob_ahorros', 'V', getdate(), 'ahpcoofi.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (231, 'sp_ah_cototdev', 'cob_ahorros', 'V', getdate(), 'ahpcocaj.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (232, 'sp_ahapertura_caja', 'cob_ahorros', 'V', getdate(), 'ahapercj.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (233, 'sp_ah_cierre', 'cob_ahorros', 'V', getdate(), 'ahcie.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (234, 'sp_tr_query_up_ah', 'cob_ahorros', 'V', getdate(), 'ahpcoact.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (235, 'sp_tr_query_clientes_ah', 'cob_ahorros', 'V', getdate(), 'ahpcocli.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (236, 'sp_tr_query_gral_up_ah', 'cob_ahorros', 'V', getdate(), 'ahpcogac.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (237, 'sp_tr_propietarios_ctahorro', 'cob_ahorros', 'V', getdate(), 'ahppropi.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (238, 'sp_tr_ahsoestcta', 'cob_ahorros', 'V', getdate(), 'ahsosta.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (240, 'sp_cargarpc', 'cob_ahorros', 'V', getdate(), 'cargarpc.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (241, 'sp_cons_bloq_ah', 'cob_ahorros', 'V', getdate(), 'ahpcoblq.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (242, 'sp_tr_cons_cierre_ah', 'cob_ahorros', 'V', getdate(), 'ahpcocie.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (243, 'sp_ficticio', 'cob_ahorros', 'V', getdate(), 'ficticio.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (244, 'sp_capitalizacion', 'cob_ahorros', 'V', getdate(), 'capitali.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (245, 'sp_tr_con_ahr_mon', 'cob_ahorros', 'V', getdate(), 'ahpcomon.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (246, 'sp_desmarcar_lp', 'cob_ahorros', 'V', getdate(), 'ahplpen.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (249, 'sp_ah_deposito', 'cob_ahorros', 'V', getdate(), 'ahdep.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (250, 'sp_ah_depositosl', 'cob_ahorros', 'V', getdate(), 'ahdepsl.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (251, 'sp_ah_depositofe', 'cob_ahorros', 'V', getdate(), 'ahdepfe.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (252, 'sp_ah_retirond', 'cob_ahorros', 'V', getdate(), 'ahret.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (253, 'sp_ah_retirosl', 'cob_ahorros', 'V', getdate(), 'ahretsl.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (254, 'sp_ah_retirofe', 'cob_ahorros', 'V', getdate(), 'ahretfe.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (255, 'sp_ah_actlib', 'cob_ahorros', 'V', getdate(), 'ahactlib.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (256, 'sp_tr_cierre', 'cob_ahorros', 'V', getdate(), 'ahcie.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (257, 'sp_tr_notadebchqdev_ah', 'cob_ahorros', 'V', getdate(), 'ahndcdev.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (259, 'sp_reten_locales_ah', 'cob_ahorros', 'V', getdate(), 'ahtreloc.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (260, 'sp_ah_cons_tot_dev', 'cob_ahorros', 'V', getdate(), 'contodev.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (262, 'sp_tr_ndchqdev_aho', 'cob_ahorros', 'V', getdate(), 'trdevaho.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (263, 'sp_inmoviliza_aho', 'cob_ahorros', 'V', getdate(), 'trahinmo.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (264, 'sp_ah_depdif', 'cob_ahorros', 'V', getdate(), 'ahdepdif.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (265, 'sp_ah_depdifsl', 'cob_ahorros', 'V', getdate(), 'ahdedisl.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (276, 'sp_tr_query_nom_ctahorro', 'cob_ahorros', 'V', getdate(), 'ahpconom.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (278, 'sp_rev_tran_monet', 'cob_ahorros', 'V', getdate(), 'rev_tran.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (281, 'sp_qry_histm_ah', 'cob_ahorros', 'V', getdate(), 'ahqryhim.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (282, 'sp_qry_trnsrv_ah', 'cob_ahorros', 'V', getdate(), 'ahqrytrs.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (283, 'sp_qry_hists_ah', 'cob_ahorros', 'V', getdate(), 'ahqryhis.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (284, 'sp_ah_deposito_inicial', 'cob_ahorros', 'V', getdate(), 'ahdepini.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (285, 'sp_maestro_ah', 'cob_ahorros', 'V', getdate(), 'ahtmaest.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (286, 'sp_banred_ah', 'cob_ahorros', 'V', getdate(), 'ahtbanre.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (287, 'sp_personifica_libreta', 'cob_ahorros', 'V', getdate(), 'ahtbanre.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (288, 'sp_tr_con_ahr_ref', 'cob_ahorros', 'V', getdate(), 'ahpconre.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (289, 'sp_ahop_superiores_a', 'cob_ahorros', 'V', getdate(), 'ahopesup.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (290, 'sp_tr_notadc_ah', 'cob_ahorros', 'V', getdate(), 'ahpnotad.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (291, 'sp_cobro_vsah', 'cob_ahorros', 'V', getdate(), 'ahcobves.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (292, 'sp_ahconsumo', 'cob_ahorros', 'V', getdate(), 'ahconsum.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (293, 'sp_tr_lev_ah_consumo', 'cob_ahorros', 'V', getdate(), 'ahplevco.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (294, 'sp_ahconsulta_saldo', 'cob_ahorros', 'V', getdate(), 'ahconatm.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (295, 'sp_tr_ndchqdev_aho_ot_bancos', 'cob_ahorros', 'V', getdate(), 'trdvobah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (296, 'sp_tr_ahcoestcta_cb', 'cob_ahorros', 'V', getdate(), 'ahcoescb.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (297, 'sp_mant_oficina_cifrada', 'cob_ahorros', 'V', getdate(), 'ahoficif.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (298, 'sp_tr_reingreso_chq_ah', 'cob_ahorros', 'V', getdate(), 'ahreinch.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (299, 'sp_beneficiario_ahorros', 'cob_ahorros', 'V', getdate(), 'ahbencta.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (301, 'sp_nav_apertura_ah', 'cob_ahorros', 'V', getdate(), 'nvaperah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (302, 'sp_nav_ah_cierre', 'cob_ahorros', 'V', getdate(), 'nvcierah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (303, 'sp_helpcta_ah', 'cob_ahorros', 'V', getdate(), 'ahthpcta.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (305, 'sp_valida_titularidad', 'cob_ahorros', 'V', getdate(), 'ahvaltitula.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (306, 'sp_datos_adic_aho', 'cob_ahorros', 'V', getdate(), 'ahdataah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (307, 'sp_ahndc_indicador', 'cob_ahorros', 'V', getdate(), 'ahautndc.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (308, 'sp_valida_menor', 'cob_ahorros', 'V', getdate(), 'ahvalmenor.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (309, 'sp_solicitud_apertura', 'cob_ahorros', 'V', getdate(), 'ahtsolap.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (310, 'sp_deposito_chq_conv_visa', 'cob_ahorros', 'V', getdate(), 'ahdepccv.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (311, 'sp_tr_inactivacion_ah', 'cob_ahorros', 'V', getdate(), 'cctinacti.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (312, 'sp_mant_equiv', 'cob_ahorros', 'V', getdate(), 'ahmaneq.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (314, 'sp_cons_nom_ctahorro', 'cob_ahorros', 'V', getdate(), 'cconctah.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (315, 'sp_imprime_plan_pago', 'cob_ahorros', 'V', getdate(), 'ahimpapa.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (316, 'sp_reporte_ahorro_plan', 'cob_ahorros', 'V', getdate(), 'ccrepaho.sp')
GO

INSERT INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (399, 'sp_cons_mov_cb', 'cob_ahorros', 'V', getdate(), 'ah_conmovcb.sp')
GO

-- ----------------------------------------------------------------------------------------------------------------------
delete cobis..ad_procedure
where pd_base_datos = 'cob_ahorros'
and pd_procedure in ( 4048, 4049, 4052, 4053, 4057, 4058, 4059,18380,18381,18382,
                     18383,18384,18385,18386,26003,26004,26008,26016,26026,26040,
                     26041,26042,26043,26054,26055,26078,26079,26106,26107,26108,
                     26109,26319,26333,26405,26428,26429,26430, 4067,  501,  502,
					 26434,26431,26432,26433,  483)
go
insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4048, 'sp_calcula_gmf', 'cob_ahorros', 'V', getdate(), 'ahcalgmf.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4049, 'sp_upd_gmf_ac', 'cob_ahorros', 'V', getdate(), 'ahcupgmf.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4052, 'sp_cambio_categoria', 'cob_ahorros', 'V', getdate(), 'ahcamcat.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4053, 'sp_aut_retiro_oficina', 'cob_ahorros', 'V', getdate(), 'ahretofi.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4057, 'sp_activa_cta_provisional', 'cob_ahorros', 'V', getdate(), 'ahaccupr.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4058, 'sp_ah_trn_depo_inicial', 'cob_ahorros', 'V', getdate(), 'ahtdepini.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4059, 'sp_valida_tiempo_activa', 'cob_ahorros', 'V', getdate(), 'ahvalact.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18380, 'sp_tr04_cons_saldo', 'cob_ahorros', 'V', getdate(), 'bv04csld.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18381, 'sp_tr04_cons_movimientos', 'cob_ahorros', 'V', getdate(), 'bv04cmov.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18382, 'sp_tr04_cons_ultnmovs', 'cob_ahorros', 'V', getdate(), 'bv04cumo.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18383, 'sp_tr04_cons_estcuenta', 'cob_ahorros', 'V', getdate(), 'bv04cecu.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18384, 'sp_tr04_cons_trnmondet', 'cob_ahorros', 'V', getdate(), 'bv.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18385, 'sp_tr04_depositochqs_ah', 'cob_ahorros', 'V', getdate(), 'bv04dpch.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (18386, 'sp_tr04_cons_estcta_fax', 'cob_ahorros', 'V', getdate(), 'bv04cefx.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26003, 'sp_depdifsl_ah_local', 'cob_ahorros', 'V', getdate(), 'ahdedisl.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26004, 'sp_depini_ah_local', 'cob_ahorros', 'V', getdate(), 'ahdepini.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26008, 'sp_notacresl_ah_local', 'cob_ahorros', 'V', getdate(), 'ahncsl.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26016, 'sp_ah_actlib_local', 'cob_ahorros', 'V', getdate(), 'ahactlib.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26026, 'sp_ah_depdifsl_local', 'cob_ahorros', 'V', getdate(), 'ahdedisl.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26040, 'sp_depclib_ah_local', 'cob_ahorros', 'V', getdate(), 'depclib.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26041, 'sp_depclibdif_ah_local', 'cob_ahorros', 'V', getdate(), 'depclibdif.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26042, 'sp_ciecuent_ah_local', 'cob_ahorros', 'V', getdate(), 'ciecuent.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26043, 'sp_retclib_ah_local', 'cob_ahorros', 'V', getdate(), 'retclib')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26054, 'sp_ah_depositofe_local', 'cob_ahorros', 'V', getdate(), 'ahdepfeloc.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26055, 'sp_ah_retirofe_local', 'cob_ahorros', 'V', getdate(), 'ahretfeloc.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26078, 'sp_avmaster_cre_aho_local', 'cob_ahorros', 'V', getdate(), 'avmastercreah.')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26079, 'sp_master_aho_local', 'cob_ahorros', 'V', getdate(), 'pagmaster.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26106, 'sp_notadebsl_ah_local', 'cob_ahorros', 'V', getdate(), 'ahretsl.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26107, 'sp_retirosl_ah_local', 'cob_ahorros', 'V', getdate(), 'retsl.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26108, 'sp_notdebchqdev_ah_local', 'cob_ahorros', 'V', getdate(), 'trdevaho.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26109, 'sp_retirocc_ah_local', 'cob_ahorros', 'V', getdate(), 'retahcom.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26319, 'sp_ah_depositosl_local', 'cob_ahorros', 'V', getdate(), 'ahdeploc.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26333, 'sp_ah_retirosl_local', 'cob_ahorros', 'V', getdate(), 'trahoret.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26405, 'sp_ah_depositosl_local_ext', 'cob_ahorros', 'V', getdate(), 'ahdeplocext.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26428, 'sp_ah_depositofe_local', 'cob_ahorros', 'V', getdate(), 'ahdepfeloc.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26429, 'sp_ah_retirofe_local', 'cob_ahorros', 'V', getdate(), 'ahretfeloc.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26430, 'sp_ah_retiroemb_local', 'cob_ahorros', 'V', getdate(), 'ahretembloc.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (4067, 'sp_autndc_aho', 'cob_ahorros', 'V', getdate(), 'autndc_aho.sp')
go

insert INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (501, 'sp_valida_prod_menoredad', 'cob_ahorros', 'V',  getdate(), 'valpromedad.sp')
go

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (502, 'sp_cons_datos_cuenta', 'cob_ahorros', 'V', getdate(), 'ahcondatcta.sp')
go

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (483,'sp_ah_datos_bco','cob_ahorros', 'V', getdate(), 'ahdatbco.sp')
GO

-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete cobis..ad_procedure
 where pd_base_datos = 'cob_interfase'
   and pd_procedure in (26434, 26431, 26432, 26433)

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26434, 'sp_ahdeposito', 'cob_interfase', 'V', getdate(), 'ahdeposito.sp')

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26431, 'sp_ahconsmov', 'cob_interfase', 'V', getdate(), 'ahconsmov.sp')

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26432, 'sp_tr_con_saldos', 'cob_interfase', 'V', getdate(), 'trconsaldos.sp')

insert INTO  ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (26433, 'sp_ahretiro', 'cob_interfase', 'V', getdate(), 'ahretiro.sp')

go

-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
delete cobis..ad_procedure
where pd_base_datos = 'cob_remesas'
and pd_procedure in (4066, 4068,720,423,472,630,406,436,630,482,4055, 716)
GO

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (4066, 'sp_tr_mant_fun_aut', 'cob_remesas', 'V', getdate(), 'mantfunaut.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (4068, 'sp_tr_autndc_ccah', 'cob_remesas', 'V', getdate(), 'autndcccah.sp')

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (720, 'sp_relacion_cta_canal', 'cob_remesas', 'V', getdate(), 'rerelctacan.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (423, 'sp_rem_chequexofi', 'cob_remesas', 'V', '2016-07-29 15:01:21.447', 'remcheqxofi.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (472, 'sp_cons_carta_remesas', 'cob_remesas', 'V', '2016-07-29 15:01:21.48', 'recocart.sp')
GO

--INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
--VALUES (630, 'sp_rem_cons_chq_eofi', 'cob_remesas', 'V', '2016-07-29 15:01:21.447', 'remconcheof.sp')
--GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (406, 'sp_rem_consulcar', 'cob_remesas', 'V', '2016-07-29 15:01:21.443', 'remconscar.sp')
GO

INSERT INTO cobis..ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (436, 'sp_rem_ayuda', 'cob_remesas', 'V', '2016-07-29 15:01:21.44', 'remayuda.sp')
GO

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (630, 'sp_rem_cons_chq_eofi', 'cob_remesas', 'V', getdate(), 'remconcheof.sp')
GO

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (482, 'sp_detallecheque', 'cob_remesas', 'V', getdate(), 'detcheq.sp')
GO

INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (716, 'sp_mto_aho_contractual', 'cob_remesas', 'V', getdate(), 'remaahco.sp')
GO

-- ----------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------COB_AHORROS_HIS---------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------
delete cobis..ad_procedure
where pd_base_datos = 'cob_ahorros_his'
and pd_procedure in ( 304 )
go
INSERT INTO dbo.ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (304, 'sp_consdetint_ah', 'cob_ahorros_his', 'V', getdate(), 'condetint.sp')
GO



