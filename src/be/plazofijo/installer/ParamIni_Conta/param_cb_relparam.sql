/************************************************************************/
/*      Archivo:            param_cb_relparam.sql                       */
/*      Base de datos:      cob_conta                                   */
/*      Producto:           Plazo Fijo                                  */
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
/*  en la tabla cb_relparam para el módulo de plazo fijo.               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go
------PARAMETRÍA cb_relparam
delete cb_relparam
 where re_empresa=1
   and re_producto =14

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '+540D.0.OF', '21153000010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '+540D.0.PA', '21153000005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-180D.0.OF', '21150500010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-180D.0.PA', '21150500005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-360D.0.OF', '21151500010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-360D.0.PA', '21151500005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-540D.0.OF', '21152500010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_CAP_21', '-540D.0.PA', '21152500005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'AHO.0.0', '27049500903', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.000829390', '11150500245', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.005602022864', '11150500225', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.04305674476', '11150500050', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.04846913136', '11150500180', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.059000166', '11150500120', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.060031903', '11150500125', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.07009290730', '11150500060', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.09144480711', '11150500065', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.09798552203', '11150500055', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.10332654658', '11150500110', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.13050187020000', '11150500175', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.202033171', '11150500170', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.21002631546', '11150500165', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.21500241120', '11150500220', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.26235451881', '11150500070', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.309005569', '11150500160', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.313200000617', '11150500205', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.336181292', '11150500255', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.348086794', '11150500130', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.35235451828', '11150500075', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.37131383220', '11150500080', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.39223904719', '11150500085', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.449019272', '11150500250', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.449022219', '11150500260', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.525024113', '11150500200', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.596251116', '11150500135', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.616119566', '11150500140', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.64526036103', '11150500090', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.66124397', '11150500235', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.70625691878', '11150500100', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.716007067', '11150500115', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.74428487208', '11150500105', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.895000412', '11150500145', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHC.0.9725971710', '11150500190', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHG.0.0', '21651500010', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'CHQL.0.0', '11051000005', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'EFEC.0.0', '11050500005', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'FFR.0.0', '19909500604', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'OTROS.0.0', '19909500600', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'PCHC.0.0', '19909500603', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'RENINC.0.0', '27049500903', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'SEBRA.0.0', '27049500954', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'SEBRA.0.0000000000', '27049500954', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_FOPAGO', 'VXP.0.0', '25050500050', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_GMF_25', '0', '25301500015', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_GMF_51', '0', '51403500015', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_ICA_25', '0', '25550500410', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '+540D.0.OF', '25050500026', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '+540D.0.PA', '25050500025', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-180D.0.OF', '25050500012', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-180D.0.PA', '25050500011', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-360D.0.OF', '25050500016', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-360D.0.PA', '25050500015', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-540D.0.OF', '25050500021', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_25', '-540D.0.PA', '25050500020', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '+540D.0.OF', '51020700010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '+540D.0.PA', '51020700005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-180D.0.OF', '51020500010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-180D.0.PA', '51020500005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-360D.0.OF', '51020600010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-360D.0.PA', '51020600005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-540D.0.OF', '51020700010', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_INT_51', '-540D.0.PA', '51020700005', 14, 'CTB_OF', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_ORPAGO', '0', '25050500050', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_PCA_42', '0', '42959500005', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_PIN_42', '0', '42959500005', 14, 'CTB_OP', 'O')

INSERT INTO cb_relparam (re_empresa, re_parametro, re_clave, re_substring, re_producto, re_tipo_area, re_origen_dest)
VALUES (1, 'DPF_RET_25', '0', '25550500018', 14, 'CTB_OP', 'O')

go


