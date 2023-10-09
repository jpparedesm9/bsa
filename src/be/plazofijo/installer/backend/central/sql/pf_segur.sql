/************************************************************************/
/*                 Descripcion                                          */
/*  Script para crear el rol de Administrador de DPF                    */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  11-28-1998    Dolores Guerrero    Emision Inicial                   */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '*********************************'
print '***** CREACION ROLES PFIJO ******'    
print '*********************************' 

print '***** CREACION DE ROL ADMINISTRADOR DE DEPOSITO A PLAZO *****' 

declare @w_rol  smallint

if not exists (select 1 from ad_rol where ro_descripcion = 'ADMINISTRADOR DPF') begin
   select @w_rol = siguiente + 1
   from   cl_seqnos
   where  tabla = 'ad_rol'
   
   update cl_seqnos
   set    siguiente = @w_rol
   where  tabla     = 'ad_rol'
   
   insert into ad_rol(
   ro_rol,     ro_filial,  ro_descripcion,      ro_fecha_crea, 
   ro_creador, ro_estado,  ro_fecha_ult_mod,    ro_time_out)
   values (
   @w_rol,     1,          'ADMINISTRADOR DPF', getdate(),
   1,         'V',         getdate(),           12000)
end
go

print '**** ASIGNACION DE PRODUCTOS AL ROL ADMINISTRADOR DPF ****'
go

declare
@w_rol   smallint,
@w_rol2  smallint   

select @w_rol = isnull(ro_rol,99)
from   ad_rol
where  ro_descripcion = 'ADMINISTRADOR DPF' 

select @w_rol2 = isnull(ro_rol,3)
from   cobis..ad_rol
where  ro_descripcion = 'MENU POR PROCESOS'

create table #rol(rol int null)

insert into #rol values (isnull(@w_rol,99))
insert into #rol values (isnull(@w_rol2,3))

if exists (select 1 from ad_pro_rol where pr_rol = @w_rol)
   delete ad_pro_rol where pr_rol = @w_rol

if exists (select 1 from ad_pro_rol where pr_rol = @w_rol2 and pr_producto = 14)
   delete ad_pro_rol where pr_rol = @w_rol2 and pr_producto = 14

create table #producto (producto int not null)

insert into #producto values (14)
insert into #producto values (1)
insert into #producto values (2)
insert into #producto values (3)
insert into #producto values (7)

insert into ad_pro_rol(
pr_rol,         pr_producto, pr_tipo,          pr_moneda,       pr_fecha_crea, 
pr_autorizante, pr_estado,   pr_fecha_ult_mod, pr_menu_inicial)
select
@w_rol,         producto,    'R',              0,               getdate(),
1,              'V',         getdate(),        null
from #producto

insert into ad_pro_rol(
pr_rol,         pr_producto, pr_tipo,          pr_moneda,       pr_fecha_crea, 
pr_autorizante, pr_estado,   pr_fecha_ult_mod, pr_menu_inicial)
select
@w_rol2,        producto,    'R',              0,               getdate(),
1,              'V',         getdate(),        null
from  #producto
where producto = 14

truncate table cob_pfijo..pf_reg_control

insert into cob_pfijo..pf_reg_control(rc_fecha_inicio_dia,  rc_fecha_final_dia,      rc_fecha_proc_cont,   rc_fecha_fin_mes)
select fp_fecha, dateadd(dd,-1,fp_fecha), fp_fecha, dateadd(dd,-datepart(dd,dateadd(mm,1,fp_fecha)),dateadd(mm,1,fp_fecha))
from   cobis..ba_fecha_proceso

print '--> Eliminacion de transacciones autorizadas al rol'
if exists (select 1 from ad_tr_autorizada where ta_rol = @w_rol)
   delete ad_tr_autorizada where ta_rol = @w_rol 

if exists (select 1 from ad_tr_autorizada where ta_rol = @w_rol2 and ta_producto = 14)
   delete ad_tr_autorizada where ta_rol = @w_rol2 and ta_producto = 14

print '--> Insercion de transacciones autorizadas al rol'   
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 14, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from  ad_pro_transaccion, #rol
where pt_producto = 14
and   rol is not null

if exists (select 1
           from  ad_tr_autorizada
		   where ta_rol in (select rol from #rol)
		   and   ta_producto = 1
		   and   ta_transaccion in (
           584,   585,   568,   1555,  1571,  1578,  1562,  1556,  1577,  1579,
           15021, 1501,  1502,  1503,  1564,  1572,  28744, 1573,  1574,  15069,
           15093, 15080, 15099, 15098, 15222, 15103, 15168, 15031, 15001, 15298,
		   15986)) begin
   delete 
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto = 1
   and   ta_transaccion in (
   584,   585,   568,   1555,  1571,  1578,  1562,  1556,  1577,  1579,
   15021, 1501,  1502,  1503,  1564,  1572,  28744, 1573,  1574,  15069,
   15093, 15080, 15099, 15098, 15222, 15103, 15168, 15031, 15001, 15298,
   15986)
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 1, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from  ad_pro_transaccion, #rol
where rol is not null
and   pt_producto = 1
and   pt_transaccion in (
584,   585,   568,   1555,  1571,  1578,  1562,  1556,  1577,  1579,
15021, 1501,  1502,  1503,  1564,  1572,  28744, 1573,  1574,  15069,
15093, 15080, 15099, 15098, 15222, 15103, 15168, 15031, 15001, 15298,
15986)

if exists (select 1
           from  ad_tr_autorizada
		   where ta_rol in (select rol from #rol)
		   and   ta_producto = 2
		   and   ta_transaccion in (
           1215, 1216, 1229, 1181, 1182, 1190, 1276, 1386, 1318, 1283,
           132,  1218, 1241, 1489, 1490, 1491, 1492, 1493, 1626, 1992)) begin
   delete 
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto = 2
   and   ta_transaccion in (
   1215, 1216, 1229, 1181, 1182, 1190, 1276, 1386, 1318, 1283,
   132,  1218, 1241, 1489, 1490, 1491, 1492, 1493, 1626, 1992)
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 2, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from  ad_pro_transaccion, #rol
where rol is not null
and   pt_producto = 2  
and   pt_transaccion in (
1215, 1216, 1229, 1181, 1182, 1190, 1276, 1386, 1318, 1283,
132,  1218, 1241, 1489, 1490, 1491, 1492, 1493, 1626, 1992)

/*Transacciones Cuenta Corriente*/
if exists (select 1 from ad_tr_autorizada where ta_rol in (select rol from #rol) and ta_producto = 3 and ta_transaccion in (72, 79)) begin
   delete
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto    = 3
   and   ta_transaccion in (72, 79)
end
              
insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 3, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from  ad_pro_transaccion, #rol
where rol is not null
and   pt_producto = 3
and   pt_transaccion in (72, 79)

/*Transacciones Ahorros*/
if exists (select 1 from ad_tr_autorizada where ta_rol in (select rol from #rol) and ta_producto = 4 and ta_transaccion = 230) begin
   delete
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto    = 4
   and   ta_transaccion = 230
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 4, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from  ad_pro_transaccion, #rol
where rol is not null
and   pt_producto    = 4
and   pt_transaccion = 230

/*Transacciones Firmas*/
if exists (select 1 from ad_tr_autorizada where ta_rol in (select rol from #rol) and ta_producto = 5 and ta_transaccion in (3008, 3010, 3016, 3020)) begin
   delete
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto = 5
   and   ta_transaccion in (3008, 3010, 3016, 3020)
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 5, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from   ad_pro_transaccion, #rol
where  rol is not null
and    pt_producto = 5
and    pt_transaccion in (3008, 3010, 3016, 3020)

/*Transacciones Contabilidad*/
if exists (select 1 from  ad_tr_autorizada where ta_rol in (select rol from #rol) and ta_producto = 6 and ta_transaccion in (6077, 6517, 6518)) begin
   delete 
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto = 6
   and   ta_transaccion in (6077, 6517, 6518)
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 6, 'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from   ad_pro_transaccion, #rol
where  rol is not null
and    pt_producto = 6
and    pt_transaccion in (6077, 6517, 6518)

/*Transacciones Caja - Branch*/
if exists (select 1 from  ad_tr_autorizada where ta_rol in (select rol from #rol) and ta_producto = 13 and ta_transaccion = 13011) begin
   delete 
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto    = 13
   and   ta_transaccion = 13011
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 13,'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from   ad_pro_transaccion, #rol
where  rol is not null
and    pt_producto    = 13
and    pt_transaccion = 13011

/*Transacciones Caja - Branch*/
if exists (select 1 from  ad_tr_autorizada where ta_rol in (select rol from #rol) and ta_producto = 17 and ta_transaccion in (4002, 4003)) begin
   delete 
   from  ad_tr_autorizada
   where ta_rol in (select rol from #rol)
   and   ta_producto    = 17
   and   ta_transaccion in (4002, 4003)
end

insert into ad_tr_autorizada(ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 17,'R', pt_moneda, pt_transaccion, rol, getdate(), 1, 'V'
from   ad_pro_transaccion, #rol
where  rol is not null
and    pt_producto = 17
and    pt_transaccion in (4002, 4003)

drop table #producto
drop table #rol
go

print '--> Insercion de transacciones autorizadas para manejo de perfiles'
declare @w_rol smallint
        
select @w_rol = ro_rol
from   ad_rol
where  ro_descripcion = 'ADMINISTRADOR CONTABILIDAD' 
and    ro_filial      = 1

if @@rowcount = 0
   select @w_rol = 6

/*Insercion de transacciones para manejo de perfiles --*/
delete ad_tr_autorizada 
where  ta_producto = 14
and    ta_rol      = @w_rol
and    ta_transaccion in (14932, 14933, 14934, 14936, 14941, 14969, 14970, 14971, 14972, 14973, 14982, 14983, 14985, 14373, 14673)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado)
select distinct 14,'R', pt_moneda, pt_transaccion, isnull(@w_rol,6), getdate(), 1, 'V'
from   ad_pro_transaccion
where  pt_producto = 14
and    pt_transaccion in (14932, 14933, 14934, 14936, 14941, 14969, 14970, 14971, 14972, 14973, 14982, 14983, 14985)
go

