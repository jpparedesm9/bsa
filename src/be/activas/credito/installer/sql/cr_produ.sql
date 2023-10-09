/************************************************************************/
/*  Archivo:            cr_produ.sql                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:           Credito                                         */
/*  Disenado por:       Ma. Jose Taco                                   */
/*  Fecha de escritura: 31/May/2017                                     */
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
/*  Script de instalación de creación de producto CREDITO               */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/*  FECHA           AUTOR             RAZON                             */
/*  31/May/2017     M.Taco         Emision inicial                      */
/************************************************************************/
/* insercion en tablas de producto y producto por moneda */

use cobis
go

delete  from cl_producto
where pd_producto = 21
go

INSERT INTO cl_producto VALUES (21,'R','CREDITO','CRE',getdate(),'V',NULL,NULL)
go

print 'CREANDO EL PRODUCTO DE CREDITO (cl_pro_instalado)'

delete ad_pro_instalado where pi_producto = 'CRE'

insert into ad_pro_instalado (
pi_producto, pi_bdd,       pi_uso_firmas)
values(
'CRE',      'cob_credito', 'N')
go

delete  from cl_pro_moneda
where pm_producto = 21
go

INSERT INTO cl_pro_moneda VALUES (21,'R',0,'CREDITO',getdate(),'V')
go


