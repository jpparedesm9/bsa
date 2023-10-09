/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Transacciones Autorizadas                   */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  02/08/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cobis
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '***************************************************'
print '*****   CREACION DE PRODUCTO, TRANS y PROCS  ******'
print '***************************************************' 
print ''
print 'Inicio Ejecucion Creacion de Producto de Dependendencias Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Transaccion Autorizada: Producto-Moneda'
delete
from  cobis..cl_pro_moneda 
where pm_producto = 10
go

insert into cl_pro_moneda(pm_producto, pm_tipo, pm_moneda, pm_descripcion, pm_fecha_aper,pm_estado)
values (10,'R',0, 'REMESAS Y CAMARA',getdate(),'V')
go

print '-->Transaccion Autorizada: Transaccion'
delete
from  cl_ttransaccion 
where tn_trn_code = 452
go

insert into cobis..cl_ttransaccion values (452, 'CONSULTA DE BANCOS PARA CAMARA', 'CBPC', 'CONSULTA DE LOS BANCOS EXISTENTES PARA CAMARA')

print '-->Transaccion Autorizada: Procedimientos'
delete 
from   ad_procedure 
where  pd_procedure = 440
go

insert into cobis..ad_procedure values (440, 'sp_cat_bancos', 'cob_remesas', 'V', '07/21/2008', convert(varchar(14), 'cmcatban.sp'   ))

print '-->Transaccion Autorizada: Procedimiento-Transaccion'
delete
from  cobis..ad_pro_transaccion
where pt_producto    = 10
and   pt_transaccion = 452
and   pt_procedure   = 440
go

insert into cobis..ad_pro_transaccion values (10, 'R', 0, 452, 'V', getdate(), 440, NULL)
go

print '-->Transaccion Autorizada: Transaccion Autorizada'

declare @w_rol smallint

select  @w_rol = isnull(ro_rol,3)
from    ad_rol
where   ro_descripcion = 'MENU POR PROCESOS' 
and     ro_filial      = 1

delete 
from  cobis..ad_tr_autorizada
where ta_transaccion = 452
and   ta_rol         = isnull(@w_rol,3)

insert into ad_tr_autorizada values (10, 'R', 0, 452, isnull(@w_rol,3), getdate(), 1, 'V', getdate())
go

print '-->Transaccion Autorizada: Banco Remesas'
delete cob_remesas..re_banco
where ba_banco in (0,1,2,6,7,8,9,10,12,13,14,19,23,32,40,51,52,53,58,59,60,61,62,63,64,65,66,67)
go

insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (0, 'BANCO REPUBLICA', 'V', 1, '8600052167', NULL)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (1, 'BOGOTA', 'V', 1, '8001423837', 805350)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (2, 'POPULAR', 'V', 1, '8600077389', 236533)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (6, 'BANCO CORPBANCA', 'V', 1, '8909039370', 618094)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (7, 'BANCOLOMBIA S A', 'V', 1, '8909039388', 236540)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (8, 'SCOTIABANK COLOMBIA S A', 'V', 1, '8600517052', 237675)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (9, 'CITIBANK COLOMBIA', 'V', 1, '8600511354', 1229747)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (10, 'BANCO GNB COLOMBIA S A', 'V', 1, '8600509309', 1756770)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (12, 'GNB SUDAMERIS S A', 'V', 1, '8600507501', 236534)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (13, 'BBVA COLOMBIA', 'V', 1, '8600030201', 236531)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (14, 'HELM BANK S A', 'V', 1, '8600076603', 237729)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (19, 'COLPATRIA', 'V', 1, '8600345941', 236535)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (23, 'OCCIDENTE', 'V', 1, '8903002794', 236541)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (32, 'CAJA SOCIAL BCSC S A', 'V', 1, '8600073354', 236536)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (40, 'AGRARIO DE COLOMBIA S A', 'V', 1, '8000378008', 237742)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (51, 'DAVIVIENDA S A', 'V', 1, '8600343137', 358272)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (52, 'AV VILLAS', 'V', 1, '8600358275', NULL)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (53, 'BANCO WWB S A', 'V', 1, '9003782122', 1072831)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (58, 'PROCREDIT', 'V', 1, '9002009609', 898234)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (59, 'BANCAMIA', 'V', 1, '9002150711', 345785)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (60, 'INVERSORA PICHINCHA', 'V', 1, '8902007567', NULL)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (61, 'BANCOOMEVA', 'V', 1, '9001721483', NULL)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (62, 'BANCO FALABELLA S A', 'V', 1, '9000174478', 636597)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (63, 'BANCO FINANDINA S A', 'V', 1, '8600518946', 1267836)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (64, 'MULTIBANK SA', 'V', 1, '8600244141', NULL)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (65, 'BANCO SANTANDER DE NEGOCIOS COLOMBIA SA', 'V', 1, '9006281103', NULL)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (66, 'BANCO COOPERATIVO COOPCENTRAL', 'V', 1, '8902030889', 1724982)
insert into cob_remesas..re_banco (ba_banco, ba_descripcion, ba_estado, ba_filial, ba_nit, ba_ente)
values (67, 'BANCOMPARTIR S A', 'V', 1, '8600259715', 237746)
go

print ''
print 'Fin Ejecucion Creacion de Producto de Dependendencias Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

