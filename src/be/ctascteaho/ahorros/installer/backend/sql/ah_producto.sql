/************************************************************************/
/*  Archivo:            ah_producto.sql                                 */
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
/*  Script de instalación de creación de producto                       */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  02/May/2016     J. Calderon     Migración a CEN                     */
/************************************************************************/

use cobis
go

print '==> cl_producto'
go

delete cobis..cl_producto
where pd_abreviatura = 'AHO'
go

declare @w_moneda tinyint,
        @w_rol    tinyint
    

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'



INSERT INTO cobis..cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
VALUES (4, 'R', 'CUENTA DE AHORROS', 'AHO', getdate(), 'V', 0, 0)


if exists (select 1 from cobis..cl_pro_moneda where pm_producto = 4)
           delete cobis..cl_pro_moneda where pm_producto = 4

insert into cobis..cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion,
                           pm_fecha_aper, pm_estado)
                values (4, 'R',@w_moneda , 'CUENTA DE AHORROS', getdate(), 'V')

select @w_rol = ro_rol
from ad_rol
where ro_descripcion like '%MENU POR PROCESOS%'
-- where ro_descripcion like 'ADMINISTRADOR'

delete cobis..ad_pro_rol
where pr_rol = @w_rol
and pr_producto = 4
and pr_tipo = 'R'
and pr_moneda = @w_moneda

insert into cobis..ad_pro_rol
(pr_rol, pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante,
 pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
 values
(@w_rol,4,'R',@w_moneda,getdate(),1,'V',getdate(),null)

update cobis..cl_seqnos
set siguiente = (select max(pd_producto)+ 1 from cobis..cl_producto)
where tabla = 'cl_producto'
go

