/************************************************************************/
/*      Archivo:            param_cb_codigo_valor.sql                   */
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
/*  en la tabla cb_codigo_valor para el módulo de plazo fijo.           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go
delete cb_codigo_valor where cv_producto=14
go

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 10, 'CAPITAL (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 11, 'CAPITALIZACION DE INTERESES')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 20, 'INTERES POR PAGAR (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 21, 'INTERES VENCIDO (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 25, 'DEVOLUCION CANJE - REV INTERESES')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 30, 'RETENCIONES (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 40, 'GMF. GRAVAMEN MOVIMIENTO FINANCIERO (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 50, 'ICA. IMPUESTO INDUSTRIA Y COMERCIO (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 60, 'PCAP. PENALIZACION CAPITAL (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 70, 'PINT. PENALIZACION INTERES (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 1000, 'FORMAS DE PAGO (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 1001, 'CTAS.PUENTE ORDENES DE PAGO (PLAZO FIJO)')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 1002, 'CANJE PLAZO FIJO')

INSERT INTO cb_codigo_valor (cv_empresa, cv_producto, cv_codval, cv_descripcion)
VALUES (1, 14, 1003, 'DECREMENTRO TRASLADO OFICINA')

go

