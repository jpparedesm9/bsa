/************************************************************************/
/*      Archivo:            param_cb_perfil.sql                         */
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
/*  en la tabla cb_perfil para el módulo de plazo fijo.                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go
-------parametria cb_perfil

delete cb_perfil 
 where pe_empresa= 1 
   and pe_producto = 14

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'APE_DPF', 'APERTURA DE UNA OPERACION (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'BOC_DPF', 'BALANCE OPERATIVO CONTABLE (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'CAN_DPF', 'CANCELACION / PAGO / RENOVACION (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'CAU_DPF', 'CAUSACION DE INTERESES (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'DEV_DPF', 'DEVOLUCION DE RETENCIONES (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'END_DPF', 'ENDOSO (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'ENJ_DPF', 'ENAJENACION (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'ORD_DPF', 'ORDENES DE PAGO (PLAZO FIJO)')

INSERT INTO cb_perfil (pe_empresa, pe_producto, pe_perfil, pe_descripcion)
VALUES (1, 14, 'TOP_DPF', 'TRASLADO DE OPERACION (PLAZO FIJO)')

go

