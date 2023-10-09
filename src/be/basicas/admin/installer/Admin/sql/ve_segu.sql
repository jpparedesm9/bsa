/************************************************************************/
/*                   MODIFICACIONES                                     */
/*      FECHA          AUTOR              RAZON                         */
/*      12/ABR/2016     BBO             Migracion SYBASE-SQLServer FAL  */
/************************************************************************/
use cobis
go

print 'Insercion de Transacciones .....CONTROL DE VERSIONES'
go

delete cl_ttransaccion
where tn_trn_code between 28741 and 28749
go 

delete cl_ttransaccion
where tn_trn_code between 150000 and 150016
go 

insert into cl_ttransaccion values(28741,'Ingreso de una nueva version','28741','Ingreso de una nueva version')
go
insert into cl_ttransaccion values(28742,'Eliminar una version','28742','Eliminar una version')
go
insert into cl_ttransaccion values(28743,'Consultar versiones catalogadas','28743','Consultar versiones catalogadas')
go
insert into cl_ttransaccion values(28744,'Verificar una version','28744','Verificar una version')
go
insert into cl_ttransaccion values(28745,'Insertar Producto para Control de Version','28745','Insertar Producto para Control de Version')
go
insert into cl_ttransaccion values(28746,'Consultar Productos para Control de Version','28746','Consultar Productos para Control de Version')
go
insert into cl_ttransaccion values(150000,'Ingreso de Producto Respaldado','150000','Ingreso de Producto Respaldado')
go
insert into cl_ttransaccion values(150001,'Actualización del Producto Respaldado','150001','Actualización del Producto Respaldado')
go
insert into cl_ttransaccion values(150002,'Eliminación del Producto Respaldado','150002','Eliminación del Producto Respaldado')
go
insert into cl_ttransaccion values(150003,'Consulta del Producto Respaldado','150003','Consulta del Producto Respaldado')
go
insert into cl_ttransaccion values(150004,'Búsqueda del Producto Respaldado','150004','Búsqueda del Producto Respaldado')
go
insert into cl_ttransaccion values(150005,'Consulta de Bases de Datos','150005','Consulta de Bases de Datos')
go
insert into cl_ttransaccion values(150006,'Consulta de Productos','150006','Consulta de Productos')
go
insert into cl_ttransaccion values(150007,'Consulta de Tablas','150007','Consulta de Tablas')
go
insert into cl_ttransaccion values(150008,'Inserción de Tabla','150008','Inserción de Tabla')
go

insert into cl_ttransaccion values(150009,'Ingreso de Iniciales','150009','Ingreso de Iniciales')
go
insert into cl_ttransaccion values(150010,'Actualización de Iniciales','150010','Actualización de Iniciales')
go
insert into cl_ttransaccion values(150011,'Eliminación de Iniciales','150011','Eliminación de Iniciales')
go
insert into cl_ttransaccion values(150012,'Consulta de Iniciales','150012','Consulta de Iniciales')
go
insert into cl_ttransaccion values(150013,'Búsqueda de Iniciales','150013','Búsqueda de Iniciales')
go
insert into cl_ttransaccion values(150014,'Búsqueda de Iniciales','150014','Búsqueda de Iniciales')
go
insert into cl_ttransaccion values(150015,'Búsqueda de Iniciales','150015','Búsqueda de Iniciales')
go
insert into cl_ttransaccion values(150016,'Búsqueda de Abreviatura','150016','Búsqueda de Abreviatura')
go


print 'stored_procedures ..... CONTROL DE VERSIONES'
go
delete ad_procedure
where pd_procedure between 28741 and 28749
go

delete ad_procedure
where pd_procedure between 150000 and 150009
go

insert into ad_procedure values(28741,'sp_control_version','cobis','V',getdate(),'vecontrol.sp')
go
insert into ad_procedure values(28742,'sp_producto_version','cobis','V',getdate(),'veproducto.sp')
go
insert into ad_procedure values(150000,'sp_resparam','cobis','V',getdate(),'resparam.sp')
go
insert into ad_procedure values(150001,'sp_cargabdd','master','V',getdate(),'cargabdd.sp')
go
insert into ad_procedure values(150002,'sp_resptabl','cobis','V',getdate(),'resptabl.sp')
go
insert into ad_procedure values(150003,'sp_inicatlg','cobis','V',getdate(),'inicatlg.sp')
go
insert into ad_procedure values(150004,'sp_cargprod','cobis','V',getdate(),'cargprod.sp')
go


print 'ASOCIACION STORED PROCEDURE - TRANSACCION'
go

delete ad_pro_transaccion
where pt_producto = 1 and
pt_transaccion between 28741 and 28749
go

delete ad_pro_transaccion
where pt_producto = 1 and
pt_transaccion between 150000 and 150016
go

declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
and pa_producto = 'ADM'

insert into ad_pro_transaccion values(1,'R',@w_moneda,28741,'V',getdate(),28741,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,28742,'V',getdate(),28741,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,28743,'V',getdate(),28741,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,28744,'V',getdate(),28741,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,28745,'V',getdate(),28742,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,28746,'V',getdate(),28742,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150000,'V',getdate(),150000,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150001,'V',getdate(),150000,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150002,'V',getdate(),150000,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150003,'V',getdate(),150000,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150004,'V',getdate(),150000,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150005,'V',getdate(),150001,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150006,'V',getdate(),150002,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150007,'V',getdate(),150002,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150008,'V',getdate(),150002,NULL)


insert into ad_pro_transaccion values(1,'R',@w_moneda,150009,'V',getdate(),150003,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150010,'V',getdate(),150003,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150011,'V',getdate(),150003,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150012,'V',getdate(),150003,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150013,'V',getdate(),150003,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150014,'V',getdate(),150004,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150015,'V',getdate(),150004,NULL)
insert into ad_pro_transaccion values(1,'R',@w_moneda,150016,'V',getdate(),150004,NULL)
go
