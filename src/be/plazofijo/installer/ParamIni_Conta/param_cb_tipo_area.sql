/************************************************************************/
/*      Archivo:            param_cb_tipo_area.sql                      */
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
/*  en la tabla cb_tipo_area para el módulo de plazo fijo.              */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go

delete cb_tipo_area where ta_producto=14

INSERT INTO cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 14, 'CTB_IMP', 'S', 31, 'IMPUESTOS PLAZO FIJO', 4069)

INSERT INTO cb_tipo_area (ta_empresa, ta_producto, ta_tiparea, ta_utiliza_valor, ta_area, ta_descripcion, ta_ofi_central)
VALUES (1, 14, 'CTB_OP', 'S', 31, 'CTB_OP', 4069)
GO

