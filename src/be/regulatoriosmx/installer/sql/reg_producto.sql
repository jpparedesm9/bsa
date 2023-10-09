/************************************************************************/
/*  Archivo:            reg_producto.sql                                */
/*  Base de datos:      cob_conta_super                                 */
/*  Producto:           REC                                             */
/*  Disenado por:       Jorge Salazar                                   */
/*  Fecha de escritura: 31/Ago/2016                                     */
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
/*  Instalación de creación de producto 36: REPORTES SUPER BANCARIA     */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  02/May/2016     J. Salazar        Emision Inicial                   */
/************************************************************************/
use cobis
go

print '==> cl_producto'
go

delete cobis..cl_producto
 where pd_producto = 36
   and pd_tipo     = 'R'
go

delete cobis..ba_fecha_cierre
where fc_producto = 36 
go

declare @w_moneda tinyint,
        @w_rol    tinyint,
        @w_fecha_cierre datetime
    

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

SELECT @w_fecha_cierre = fp_fecha FROM ba_fecha_proceso

INSERT INTO cobis..cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
VALUES (36, 'R', 'REPORTES SUPER BANCARIA', 'REC', getdate(), 'V', 0, 0)

INSERT INTO cobis..ba_fecha_cierre (fc_producto, fc_fecha_cierre, fc_fecha_propuesta)
VALUES (36, @w_fecha_cierre, NULL)


delete cobis..cl_pro_moneda where pm_producto = 36

insert into cobis..cl_pro_moneda (pm_producto, pm_tipo, pm_moneda, pm_descripcion, pm_fecha_aper, pm_estado)
values (36, 'R', @w_moneda, 'REPORTES SUPER BANCARIA', getdate(), 'V')

select @w_rol = ro_rol
  from cobis..ad_rol
 where ro_descripcion like '%MENU POR PROCESOS%'

delete cobis..ad_pro_rol
 where pr_rol      = @w_rol
   and pr_producto = 36
   and pr_tipo     = 'R'
   and pr_moneda   = @w_moneda

insert into cobis..ad_pro_rol
(pr_rol, pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante,
 pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
 values
(@w_rol,36,'R',@w_moneda,getdate(),1,'V',getdate(),null)

update cobis..cl_seqnos
set siguiente = (select case when max(pd_producto) >= 36 
                             then max(pd_producto) 
                             else 36
                        end
                   from cobis..cl_producto)
where tabla = 'cl_producto'
go


