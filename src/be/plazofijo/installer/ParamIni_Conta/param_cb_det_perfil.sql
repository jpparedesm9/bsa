/************************************************************************/
/*      Archivo:            param_cb_det_perfil.sql                     */
/*      Base de datos:      cob_conta                                   */
/*      Producto:           Contabilidad                                */
/*      Disenado por:       Karen Meza                                  */
/*      Fecha de escritura: 22/Sept/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa realiza la creación de la parametrización contable    */
/*  en la tabla cb_det_perfil para el módulo de plazo fijo.             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go
---------parametria cb_det_perfil
delete cb_det_perfil 
 where dp_empresa=1
   and dp_producto = 14

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'APE_DPF', 1, 'DPF_CAP_21', 'CTB_OP', '2', 10, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'APE_DPF', 2, 'DPF_INT_25', 'CTB_OP', '2', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'APE_DPF', 3, 'DPF_FOPAGO', 'CTB_OP', '1', 1000, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'BOC_DPF', 1, 'DPF_CAP_21', 'CTB_OP', '2', 10, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'BOC_DPF', 2, 'DPF_INT_25', 'CTB_OP', '2', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 1, 'DPF_CAP_21', 'CTB_OP', '1', 10, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 2, 'DPF_INT_25', 'CTB_OP', '1', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 3, 'DPF_INT_51', 'CTB_OP', '1', 21, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 4, 'DPF_RET_25', 'CTB_IMP', '2', 30, 'N', 'C', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 5, 'DPF_GMF_25', 'CTB_IMP', '2', 40, 'N', 'C', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 6, 'DPF_GMF_51', 'CTB_IMP', '1', 40, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 7, 'DPF_ICA_25', 'CTB_IMP', '2', 50, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 8, 'DPF_PCA_42', 'CTB_OP', '2', 60, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 9, 'DPF_PIN_42', 'CTB_OP', '2', 61, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 10, 'DPF_FOPAGO', 'CTB_OP', '2', 1000, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 11, 'DPF_ORPAGO', 'CTB_OP', '2', 1001, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 12, 'DPF_CAP_21', 'CTB_OP', '2', 11, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAN_DPF', 13, '19909500777', 'CTB_OP', '2', 1002, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAU_DPF', 1, 'DPF_INT_25', 'CTB_OP', '2', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAU_DPF', 2, 'DPF_INT_51', 'CTB_OP', '1', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAU_DPF', 3, 'DPF_INT_25', 'CTB_OP', '1', 25, 'N', 'D', '', 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'CAU_DPF', 4, 'DPF_INT_51', 'CTB_OP', '2', 25, 'N', 'D', '', 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'DEV_DPF', 1, 'DPF_RET_25', 'CTB_IMP', '1', 30, 'N', 'C', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'DEV_DPF', 2, 'DPF_FOPAGO', 'CTB_OP', '2', 1000, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'DEV_DPF', 3, 'DPF_ORPAGO', 'CTB_OP', '2', 1001, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'END_DPF', 1, 'DPF_CAP_21', 'CTB_OP', '2', 10, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'END_DPF', 2, 'DPF_INT_25', 'CTB_OP', '2', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ENJ_DPF', 1, 'DPF_RET_25', 'CTB_IMP', '1', 30, 'N', 'C', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ENJ_DPF', 2, 'DPF_FOPAGO', 'CTB_OP', '2', 1000, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ORD_DPF', 1, 'DPF_ORPAGO', 'CTB_OP', '1', 1000, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ORD_DPF', 2, 'DPF_FOPAGO', 'CTB_OP', '2', 1000, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ORD_DPF', 3, 'DPF_ICA_25', 'CTB_IMP', '2', 50, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ORD_DPF', 4, 'DPF_GMF_25', 'CTB_OP', '2', 40, 'N', 'C', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'ORD_DPF', 5, 'DPF_GMF_51', 'CTB_OP', '1', 40, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 1, 'DPF_CAP_21', 'CTB_OP', '1', 10, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 2, 'DPF_CAP_21', 'CTB_OP', '2', 10, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 3, 'DPF_ORPAGO', 'CTB_OP', '1', 1001, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 4, 'DPF_ORPAGO', 'CTB_OP', '2', 1001, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 5, 'DPF_INT_25', 'CTB_OP', '1', 20, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 6, 'DPF_INT_25', 'CTB_OP', '2', 20, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 7, 'DPF_ORPAGO', 'CTB_OP', '1', 1003, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 8, 'DPF_ORPAGO', 'CTB_OP', '2', 1003, 'N', 'D', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 9, 'DPF_ORPAGO', 'CTB_OP', '1', 1000, 'N', 'O', NULL, 'L')

INSERT INTO cb_det_perfil (dp_empresa, dp_producto, dp_perfil, dp_asiento, dp_cuenta, dp_area, dp_debcred, dp_codval, dp_tipo_tran, dp_origen_dest, dp_constante, dp_fuente)
VALUES (1, 14, 'TOP_DPF', 10, 'DPF_ORPAGO', 'CTB_OP', '2', 1000, 'N', 'D', NULL, 'L')

GO

