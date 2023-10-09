/************************************************************************/
/*      Archivo:            param_cb_area.sql                           */
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
/*  en la tabla cb_area para el módulo de plazo fijo.                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR        RAZON                              */
/*  22/Sept/2016      Karen Meza     Emision Inicial                    */
/************************************************************************/
use cob_conta
go

delete cb_area 
 WHERE ar_area IN (SELECT distinct ta_area 
                     FROM cb_tipo_area
                    WHERE ta_producto=14)
go

INSERT INTO cb_area (ar_empresa, ar_area, ar_descripcion, ar_area_padre, ar_estado, ar_fecha_estado, ar_nivel_area, ar_consolida, ar_movimiento)
VALUES (1, 31, 'RED DE OFICINAS', 1011, 'V', '2008-10-10', 3, 'N', 'S')

GO


