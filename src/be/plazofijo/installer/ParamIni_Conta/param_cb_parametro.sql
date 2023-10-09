/************************************************************************/
/*      Archivo:            param_cb_parametro.sql                      */
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
/*  en la tabla cb_parametro para el módulo de plazo fijo.              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go
---parametria  cb_parametro
delete cb_parametro
 where pa_empresa = 1
   and pa_parametro IN (select distinct re_parametro
                          from cb_relparam 
                         where re_producto=14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_CAP_21', 'CAPITAL CON QUE SE CONSTITUYE EL CDT', 'sp_pf01_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_FOPAGO', 'FORMA DE PAGO (EFECTIVO, CHEQUE, ETC.)', 'sp_pf02_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_GMF_25', 'GRAVAMEN M.FINANCIEROS(CTAxPAGAR)', 'sp_pf03_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_GMF_51', 'GRAVAMEN M.FINANCIEROS(GASTO)', 'sp_pf03_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_ICA_25', 'IMPUESTO INDUSTRIA Y COMERCIO(CTAxPAGAR)', 'sp_pf03_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_INT_25', 'INTERES POR PAGAR (CTAxPAGAR)', 'sp_pf01_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_INT_51', 'INTERES POR PAGAR (GASTO)', 'sp_pf01_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_ORPAGO', 'ORDEN DE PAGO (CTA.PUENTE)', 'sp_pf03_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_PCA_42', 'PENALIZACION CAPITAL (GANANCIA)', 'sp_pf03_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_PIN_42', 'PENALIZACION INTERES (GANANCIA)', 'sp_pf03_pf', 14)

INSERT INTO cb_parametro (pa_empresa, pa_parametro, pa_descripcion, pa_stored, pa_transaccion)
VALUES (1, 'DPF_RET_25', 'RETENCION EN LA FUENTE (CTAxPAGAR)', 'sp_pf03_pf', 14)

go

