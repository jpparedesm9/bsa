/************************************************************************/
/*  Archivo:            ah_protran.sql                                  */
/*  Base de datos:      cobis                                           */
/*  Producto:           Cuentas Ahorros                                 */
/*  Disenado por:       Javier Calderon                                 */
/*  Fecha de escritura: 02/May/2016                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Script de instalación de creación de producto?trnsaccion            */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

use cobis
GO


print '===> ah_protran.sql'
 


set nocount on
 

delete cobis..ad_pro_transaccion
where  pt_producto = 4
 

delete cobis..ad_pro_transaccion
where  pt_producto = 6 AND pt_transaccion = 6030

delete cobis..ad_pro_transaccion
where  pt_producto = 3 AND pt_transaccion = 78

delete cobis..ad_pro_transaccion
where  pt_producto = 2 AND pt_transaccion in (1181,1182)


declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'


INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 201, 'V', getdate(), 214, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 202, 'V', getdate(), 215, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 203, 'V', getdate(), 222, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 204, 'V', getdate(), 223, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 205, 'V', getdate(), 216, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 206, 'V', getdate(), 276, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 207, 'V', getdate(), 264, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 208, 'V', getdate(), 237, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 209, 'V', getdate(), 243, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 210, 'V', getdate(), 261, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 211, 'V', getdate(), 217, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 212, 'V', getdate(), 217, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 213, 'V', getdate(), 233, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 214, 'V', getdate(), 242, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 215, 'V', getdate(), 232, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 216, 'V', getdate(), 241, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 217, 'V', getdate(), 218, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 218, 'V', getdate(), 218, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 220, 'V', getdate(), 245, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 221, 'V', getdate(), 244, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 222, 'V', getdate(), 239, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 223, 'V', getdate(), 238, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 227, 'V', getdate(), 200, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 228, 'V', getdate(), 253, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 229, 'V', getdate(), 250, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 230, 'V', getdate(), 227, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 231, 'V', getdate(), 221, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 232, 'V', getdate(), 226, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 233, 'V', getdate(), 224, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 234, 'V', getdate(), 229, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 235, 'V', getdate(), 228, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 236, 'V', getdate(), 238, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 237, 'V', getdate(), 33, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 239, 'V', getdate(), 33, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 240, 'V', getdate(), 262, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 241, 'V', getdate(), 246, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 242, 'V', getdate(), 263, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 245, 'V', getdate(), 225, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 246, 'V', getdate(), 265, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 247, 'V', getdate(), 208, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 248, 'V', getdate(), 284, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 249, 'V', getdate(), 201, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 250, 'V', getdate(), 202, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 251, 'V', getdate(), 249, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 252, 'V', getdate(), 250, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 253, 'V', getdate(), 307, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 254, 'V', getdate(), 251, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 255, 'V', getdate(), 249, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 256, 'V', getdate(), 287, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 257, 'V', getdate(), 251, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 260, 'V', getdate(), 203, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 261, 'V', getdate(), 252, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 262, 'V', getdate(), 252, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 263, 'V', getdate(), 253, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 264, 'V', getdate(), 307, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 265, 'V', getdate(), 255, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 266, 'V', getdate(), 254, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 267, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 268, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 269, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 270, 'V', getdate(), 230, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 272, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 273, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 274, 'V', getdate(), 286, NULL)
 GO


declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'


INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 275, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 276, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 277, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 278, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 279, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 280, 'V', getdate(), 280, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 281, 'V', getdate(), 281, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 282, 'V', getdate(), 282, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 283, 'V', getdate(), 283, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 284, 'V', getdate(), 285, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 285, 'V', getdate(), 285, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 286, 'V', getdate(), 285, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 287, 'V', getdate(), 285, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 288, 'V', getdate(), 285, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 289, 'V', getdate(), 286, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 290, 'V', getdate(), 290, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 291, 'V', getdate(), 231, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 292, 'V', getdate(), 260, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 293, 'V', getdate(), 285, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 295, 'V', getdate(), 237, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 296, 'V', getdate(), 237, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 297, 'V', getdate(), 236, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 298, 'V', getdate(), 235, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 299, 'V', getdate(), 234, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 301, 'V', getdate(), 288, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 302, 'V', getdate(), 289, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 303, 'V', getdate(), 291, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 305, 'V', getdate(), 292, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 306, 'V', getdate(), 293, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 307, 'V', getdate(), 294, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 313, 'V', getdate(), 295, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 314, 'V', getdate(), 296, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 315, 'V', getdate(), 251, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 316, 'V', getdate(), 254, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 319, 'V', getdate(), 297, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 320, 'V', getdate(), 214, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 321, 'V', getdate(), 298, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 322, 'V', getdate(), 204, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 324, 'V', getdate(), 2607, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 325, 'V', getdate(), 2607, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 326, 'V', getdate(), 2607, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 327, 'V', getdate(), 219, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 328, 'V', getdate(), 219, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 329, 'V', getdate(), 220, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 330, 'V', getdate(), 211, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 331, 'V', getdate(), 259, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 332, 'V', getdate(), 259, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 333, 'V', getdate(), 299, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 336, 'V', getdate(), 2627, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 337, 'V', getdate(), 2627, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 338, 'V', getdate(), 301, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 339, 'V', getdate(), 302, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 340, 'V', getdate(), 303, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 341, 'V', getdate(), 250, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 343, 'V', getdate(), 304, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 344, 'V', getdate(), 305, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 345, 'V', getdate(), 306, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 346, 'V', getdate(), 306, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 347, 'V', getdate(), 306, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 348, 'V', getdate(), 306, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 349, 'V', getdate(), 310, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 350, 'V', getdate(), 308, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 352, 'V', getdate(), 309, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 353, 'V', getdate(), 309, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 354, 'V', getdate(), 309, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 355, 'V', getdate(), 309, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 356, 'V', getdate(), 309, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 357, 'V', getdate(), 309, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 358, 'V', getdate(), 219, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 359, 'V', getdate(), 219, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 360, 'V', getdate(), 201, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 361, 'V', getdate(), 201, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 362, 'V', getdate(), 201, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 363, 'V', getdate(), 201, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 364, 'V', getdate(), 201, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 367, 'V', getdate(), 311, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 368, 'V', getdate(), 215, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 369, 'V', getdate(), 215, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 370, 'V', getdate(), 238, NULL)
GO


declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM' 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 371, 'V', getdate(), 253, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 372, 'V', getdate(), 314, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 380, 'V', getdate(), 253, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 381, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 385, 'V', getdate(), 205, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 386, 'V', getdate(), 205, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 387, 'V', getdate(), 205, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 388, 'V', getdate(), 205, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 389, 'V', getdate(), 205, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 390, 'V', getdate(), 205, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 393, 'V', getdate(), 315, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 394, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 395, 'V', getdate(), 316, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 396, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 397, 'V', getdate(), 397, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 398, 'V', getdate(), 398, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 399, 'V', getdate(), 399, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 400, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 1468, 'V', getdate(), 1158, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 1503, 'V', getdate(), 240, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4130, 'V', getdate(), 4052, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4131, 'V', getdate(), 4053, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4132, 'V', getdate(), 4053, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4133, 'V', getdate(), 4053, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4134, 'V', getdate(), 4053, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4135, 'V', getdate(), 4052, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4136, 'V', getdate(), 4055, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4137, 'V', getdate(), 4055, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4138, 'V', getdate(), 4055, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4139, 'V', getdate(), 4055, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4140, 'V', getdate(), 4055, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4141, 'V', getdate(), 4056, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4142, 'V', getdate(), 4049, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4144, 'V', getdate(), 719, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4145, 'V', getdate(), 4057, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4146, 'V', getdate(), 4059, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4148, 'V', getdate(), 4049, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4149, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4150, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4151, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4152, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4153, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4154, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4155, 'V', getdate(), 396, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4162, 'V', getdate(), 1240, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4163, 'V', getdate(), 312, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4164, 'V', getdate(), 312, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4165, 'V', getdate(), 312, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4166, 'V', getdate(), 312, NULL)
 

INSERT INTO  cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (4,  'R', @w_moneda, 4167, 'V', getdate(), 312, NULL)


-- tarsaccion para cota empresa
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', @w_moneda, 6030, 'V', getdate(), 6150, NULL)


INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (2, 'R', @w_moneda, 1181, 'V', getdate(), 1024, NULL)


INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (2, 'R', @w_moneda, 1182, 'V', getdate(), 1027, NULL)

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (3, 'R', @w_moneda, 78, 'V', getdate(), 79, NULL)
GO

