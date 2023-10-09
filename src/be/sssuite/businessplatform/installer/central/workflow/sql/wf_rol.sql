set nocount on
go

use cobis
go
/************************************************************/
/*   ARCHIVO:         wf_rol.sql                            */
/*   NOMBRE LOGICO:                                         */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*   Asignacion de Transacciones Autorizadas en WORKFLOW.   */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR              RAZON                 */
/*   27-Mar-2001   Mario Valarezo A.  Emision Inicial.      */
/*   01-Abr-2014   Sergio Hidalgo V.  Ajuste de nuevas      */ 
/*                                    transacciones         */
/************************************************************/

/************************************************************************/
/*                              cl_producto                            */
/************************************************************************/
print '----->  cl_producto'
go

if exists (select 1 from cl_producto where pd_producto = 43)
  delete cl_producto where pd_producto = 43
go

insert into cl_producto
       (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura,
        pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
values  (43, 'R', 'WORKFLOW', 'CWF', getdate(), 'V', null, null)
go

-- Busqueda del rol de instalación
declare @w_rol smallint 
select @w_rol = inst_rol from cobis..platform_installer

-- ***************************************************************
print '===> Asignacion de Transacciones Autorizadas en WORKFLOW'
-- ***************************************************************

-- Transacciones de WorkFlow.
-- DE LA TRANSACCION 31750 A LA 31830.
delete ad_tr_autorizada
 where ta_rol = @w_rol
  and ta_transaccion between 31750 and 31830

/*************/
/* COBIS WEB */
/*************/
delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 1502
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 1502, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15168
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15168, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15227
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15227, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15235
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15235, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15240
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15240, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15244
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15244, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15279
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15279, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15282
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15282, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 43
   and ta_transaccion = 15283
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 15283, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 43 
   and ta_transaccion = 15284
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 15284, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 43
   and ta_transaccion = 15295
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 15295, @w_rol, getdate(), 1, 'V')

-- Autorizaciones de CEN
delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15300
   and ta_rol = @w_rol
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15300, @w_rol, getdate(), 1, 'V')

-- Autorizaciones de CEN
delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15301
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15301, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15302
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15302, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15305
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15305, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15306
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15306, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15307
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15307, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15308
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15308, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15310
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15310, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15311
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15311, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15312
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15312, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15315
   and ta_rol = @w_rol

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15315, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15316
   and ta_rol = @w_rol 
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15316, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15317
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15317, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15318
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15318, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15319
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15319, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15320
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15320, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15321
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15321, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada 
 where ta_producto = 1 
   and ta_transaccion = 15322
   and ta_rol = @w_rol
   
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15322, @w_rol, getdate(), 1, 'V')


-- Transacciones del Editor de WorkFlow.
insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31750, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31751, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31752, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31753, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31754, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31755, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31756, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31757, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31758, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31759, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31760, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31761, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31762, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31763, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31764, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31765, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31766, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31767, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31768, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31769, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31770, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31771, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31772, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31773, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31774, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31775, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31776, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31777, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31778, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31779, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31780, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31781, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31782, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31783, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31784, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31785, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31786, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31787, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31788, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31789, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31790, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31791, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31792, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31793, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31794, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31795, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31796, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31797, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31798, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31799, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31800, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31801, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31802, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31803, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31804, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31805, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31806, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31807, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31808, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31809, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31810, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31811, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31812, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31813, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31814, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31815, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31816, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31817, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31818, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31819, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31820, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31822, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31823, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31824, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31825, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31826, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31827, 3, getdate(), 1, 'V')

delete ad_tr_autorizada
 where ta_rol = @w_rol
  and ta_transaccion = 31901

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31901, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada
 where ta_rol = @w_rol
  and ta_transaccion = 31903

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 31903, @w_rol, getdate(), 1, 'V')


-- Transacciones del Motor de WorkFlow.
-- DE LA TRANSACCION 32001 A LA 32018.
delete ad_tr_autorizada
 where ta_rol = @w_rol
  and ta_transaccion between 32001 and 32018

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32001, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32002, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32003, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32004, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32005, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32006, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32007, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32008, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32009, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32010, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32011, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32012, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32013, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32014, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32015, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32016, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32017, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32018, @w_rol, getdate(), 1, 'V')


-- Transacciones del Monitor de WorkFlow.
-- DE LA TRANSACCION 32251 A LA 32259.
delete ad_tr_autorizada
 where ta_rol = @w_rol
  and ta_transaccion between 32251 and 32259

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32251, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32252, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32253, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32254, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32255, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32256, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32257, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32258, @w_rol, getdate(), 1, 'V')

insert into ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32259, @w_rol, getdate(), 1, 'V')

delete ad_tr_autorizada
 where ta_rol = @w_rol
  and ta_transaccion between 32279 and 32282

insert into cobis..ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32279, @w_rol, getdate(), 1, 'V')

insert into cobis..ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32280, @w_rol, getdate(), 1, 'V')

insert into cobis..ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32281, @w_rol, getdate(), 1, 'V')

insert into cobis..ad_tr_autorizada
       (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
        ta_fecha_aut, ta_autorizante, ta_estado)
values (43, 'R', 0, 32282, @w_rol, getdate(), 1, 'V')


if exists (select 1 from cobis..ad_tr_autorizada  where ta_transaccion = 32283)
    delete cobis..ad_tr_autorizada where ta_transaccion = 32283

if exists (select 1 from cobis..ad_tr_autorizada  where ta_transaccion = 32284)
    delete cobis..ad_tr_autorizada where ta_transaccion = 32284


insert into cobis..ad_tr_autorizada ( ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante,
                                      ta_estado, ta_fecha_ult_mod)
values (43, 'R', 0, 32283, @w_rol, getdate(), 1, 'V', getdate())



insert into cobis..ad_tr_autorizada ( ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante,
                                      ta_estado, ta_fecha_ult_mod)
values (43, 'R', 0, 32284, @w_rol, getdate(), 1, 'V', getdate())

go
