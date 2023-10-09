/************************************************************************/
/*  Archivo:            ah_traut.sql                                    */
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
/*  Script de instalación de creación de transacciones autorizadas      */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

use cobis
go

print '===> ah_traut.sql'
go


set nocount on
go

use cobis
go

if exists (select 1 from cobis..ad_pro_instalado where pi_producto = 'AHO')
    delete cobis..ad_pro_instalado where pi_producto = 'AHO'
    
go

insert into cobis..ad_pro_instalado (pi_producto, pi_bdd, pi_nomfirmas, pi_uso_firmas, pi_qrfirmas, pi_trn_nom, pi_trn_qry)
        values    ('AHO', 'cob_ahorros', 'sp_tr_query_nom_ctahorro', 'S', 'sp_tr_query_clientes_ah', 206, 298)
go

declare 
     @w_rol    int,
     @w_moneda tinyint

select @w_rol = ro_rol
from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'ADMINISTRADOR'

delete cobis..ad_tr_autorizada
where  ta_producto = 4
and    ta_rol = @w_rol


select @w_moneda = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'CMNAC'
and    pa_producto = 'ADM'


INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 201, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 202, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 203, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 204, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 205, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 206, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 207, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 208, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 209, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 210, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 211, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 212, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 213, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 214, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 215, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 216, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 217, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 218, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 220, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 221, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 222, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 227, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 228, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 229, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 230, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 231, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 232, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 233, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 235, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 236, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 237, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 239, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 240, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 241, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 242, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 245, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 246, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 247, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 248, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 249, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 250, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 251, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 252, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 254, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 255, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 256, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 257, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 260, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 261, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 262, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 263, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 265, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 266, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 267, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 268, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 269, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 270, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 272, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 273, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 274, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 275, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 276, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 277, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 278, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 279, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 280, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 281, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 282, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 283, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 284, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 285, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 286, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 287, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 288, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 289, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 290, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 291, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 292, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 293, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 295, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 296, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 297, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 298, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 299, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 301, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 302, @w_rol,  getdate(), 1, 'V',  getdate())
 

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 303, @w_rol,  getdate(), 1, 'V',  getdate())
GO

-------------------------------------------------------------------------------------------------------------------------
declare  @w_rol tinyint

select @w_rol = ro_rol
from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'ADMINISTRADOR'

declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from   cobis..cl_parametro
where  pa_nemonico = 'CMNAC'
and    pa_producto = 'ADM'

delete FROM ad_tr_autorizada 
WHERE ta_transaccion in (305,306,307,313,314,315,316,319,320,321,324,325,326,327,328,329,330,331,
                         332,333,336,337,338,339,340,341,343,344,345,346,347,348,349,350,352,353,
                         354,355,356,357,358,359,360,361,362,363,364,367,368,369,370,371,372,381,
                         385,386,390,394,395,400,1468,2576,4136,4137,4138,4139,4140,4141,4144,4145,
                         4149,4150,4151,4152,4153,4154,4155,4162,4163) and ta_producto = 4 and ta_rol = @w_rol

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 305, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 306, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 307, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 313, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 314, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 315, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 316, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 319, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 320, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 321, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 324, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 325, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 326, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 327, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 328, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 329, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 330, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 331, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 332, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 333, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 336, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 337, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 338, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 339, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 340, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 341, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 343, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 344, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 345, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 346, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 347, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 348, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 349, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 350, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 352, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 353, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 354, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 355, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 356, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 357, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 358, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 359, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 360, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 361, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 362, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 363, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 364, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 367, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 368, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 369, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 370, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 371, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 372, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 381, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 385, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 386, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 390, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 394, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 395, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 400, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 1468, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 2576, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4136, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4137, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4138, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4139, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4140, @w_rol,  getdate(), 1, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4141, @w_rol,  getdate(), 1, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4144, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4145, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4149, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4150, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4151, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4152, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4153, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4154, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4155, @w_rol,  getdate(), 3, 'V',  getdate())

INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4162, @w_rol,  getdate(), 3, 'V',  getdate())
 
INSERT INTO  cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4163, @w_rol,  getdate(), 3, 'V',  getdate())
go 

print 'Transacciones Contabilidad'
use cobis
go

delete ad_tr_autorizada
where  ta_producto = 6
and    ta_transaccion = 6030
and    ta_rol in (1, 18)
go


declare @w_rol    int,
     @w_moneda tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'ADMINISTRADOR'


select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

delete FROM ad_tr_autorizada WHERE ta_transaccion=6030 and ta_producto=6 and ta_rol in (@w_rol,18)

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (6, 'R', @w_moneda, 6030, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (6, 'R', @w_moneda, 6030, 18, getdate(), 1, 'V', getdate())
go

print 'Transacciones cliente'
use cobis
go


declare @w_rol    int,
     @w_moneda tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'ADMINISTRADOR'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

delete FROM ad_tr_autorizada WHERE ta_transaccion in (1181,1182) and ta_producto=2 and ta_rol =@w_rol

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 1181, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (2, 'R', @w_moneda, 1182, @w_rol,  getdate(), 1, 'V', getdate())

go

use cobis
go



declare @w_rol    int,
     @w_moneda tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'ADMINISTRADOR'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

delete FROM ad_tr_autorizada WHERE ta_transaccion=78 and ta_producto = 3 and ta_rol = @w_rol

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (3, 'R', @w_moneda, 78, @w_rol, getdate(), 1, 'V', getdate())
GO

--WTO - 9/Junio/2016 - 'ADMINISTRADOR'
declare @w_rol    int,
     @w_moneda tinyint

select @w_rol = ro_rol
from ad_rol
where ro_descripcion like 'ADMINISTRADOR'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

delete FROM ad_tr_autorizada WHERE ta_transaccion=1181 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 1181, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=424 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 424, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=4093 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4093, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=4097 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 4097, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=734 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 734, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=1227 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 1227, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=92 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 92, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=34 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 34, @w_rol, getdate(), 1, 'V', getdate())

delete FROM ad_tr_autorizada WHERE ta_transaccion=747 and ta_producto = 4 and ta_rol = @w_rol
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (4, 'R', @w_moneda, 747, @w_rol, getdate(), 1, 'V', getdate())
GO
