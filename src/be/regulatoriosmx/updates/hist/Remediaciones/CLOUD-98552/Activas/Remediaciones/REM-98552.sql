use cobis
go
-- Se agrega catalogo de Acción para Dispersiones Rechazadas
declare @w_codigo smallint
select @w_codigo = siguiente
  from cl_seqnos
 where tabla = 'cl_tabla'
 
select @w_codigo = @w_codigo + 1
print 'Codigos de Acción para Dispersiones Rechazadas'
delete from cl_tabla where tabla='ca_accion_disperciones'

insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_accion_disperciones', ' Tabla ca_accion_disperciones')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1',  'SIN ACCION', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2',  'REINTENTOS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3',  'CANCELACIONES' , 'V')

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

go

-- Se agrega catalogo de Tipo de dispersion
declare @w_codigo smallint
select @w_codigo = siguiente
  from cl_seqnos
 where tabla = 'cl_tabla'

delete from cl_tabla where tabla='ca_tipo_disperciones'
 
select @w_codigo = @w_codigo + 1
print 'Codigos de Acción para Dispersiones Rechazadas'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ca_tipo_disperciones', ' Tabla ca_tipo_disperciones')
insert into cl_catalogo_pro values ('CCA', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'DES',  'DESEMBOLSO', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'GAR',  'GARANTIAS', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'SOB',  'SOBRANTES' , 'V')

update cl_seqnos
set siguiente = @w_codigo
where tabla = 'cl_tabla'

go

--Opcion en el menu
--Regularizar Dispersiones Rechazadas
declare @num integer, @w_old_menu integer, @w_menu_desc varchar(50), @w_mant_opera integer, @w_mant_cartera integer, @w_rol integer, @w_id_parent INT, @w_orden int, @w_producto int, @w_option_menu varchar(100)

select @w_option_menu = 'MNU_REGULARIZE_REJECTED_DISPERSIONS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'


select @w_orden = max(me_order) from cobis..cew_menu
where me_id_cobis_product = 7

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'FUNCIONARIO OFICINA'
select @w_orden = @w_orden + 1
select @w_old_menu = null, @w_id_parent = null, @num = null
select @w_old_menu = me_id from cobis..cew_menu where me_name= @w_option_menu

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = @w_option_menu

select @w_id_parent=me_id from cobis..cew_menu where me_name= 'MNU_ASSETS'
select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product, me_visible, me_order, me_option,  me_description)
values(@num,@w_id_parent,@w_option_menu,'views/ASSTS/TRNSC/T_ASSTSOSPSJXWE_883/1.0.0/VC_REGULARIOE_732883_TASK.html',@w_producto, 1, @w_orden, 0, 'Regularizar Dispersiones Rechazadas')

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,@w_rol)

go


--Creacion de tablas
use cob_cartera
go
IF object_id('ca_santander_orden_deposito_fallido') is not null 
begin
 drop table ca_santander_orden_deposito_fallido

end

create table ca_santander_orden_deposito_fallido
( 
	odf_fecha				datetime, 		
	odf_consecutivo			int,
	odf_linea			    int,
	odf_cliente   			int,			
	odf_cuenta				cuenta,     	
	odf_banco				cuenta,
	odf_tipo				varchar(10),
    odf_monto				money, 	
	odf_causa_rechazo		varchar(40), 	
	odf_accion				int 			null,
	odf_accion_fecha   		datetime		null,
	odf_accion_user			varchar(24)		null
)
go

IF object_id('ca_santander_orden_deposito_fallido_1') is not null 
   drop index ca_santander_orden_deposito_fallido_1 on ca_santander_orden_deposito_fallido

CREATE UNIQUE INDEX ca_santander_orden_deposito_fallido_1
ON ca_santander_orden_deposito_fallido (odf_fecha, odf_consecutivo, odf_linea)
go
IF object_id('ca_santander_orden_deposito_fallido_2') is not null 
   drop index ca_santander_orden_deposito_fallido_2 on ca_santander_orden_deposito_fallido

CREATE INDEX ca_santander_orden_deposito_fallido_2
ON ca_santander_orden_deposito_fallido (odf_cliente)
go
IF object_id('ca_santander_orden_deposito_fallido_3') is not null 
   drop index ca_santander_orden_deposito_fallido_3 on ca_santander_orden_deposito_fallido

CREATE INDEX ca_santander_orden_deposito_fallido_3
ON ca_santander_orden_deposito_fallido (odf_cuenta)
go
IF object_id('ca_santander_orden_deposito_fallido_4') is not null 
   drop index ca_santander_orden_deposito_fallido_4 on ca_santander_orden_deposito_fallido

CREATE INDEX ca_santander_orden_deposito_fallido_4
ON ca_santander_orden_deposito_fallido (odf_banco)

go


use cob_cartera
go

IF not EXISTS(SELECT *
          FROM   INFORMATION_SCHEMA.COLUMNS
          WHERE  TABLE_NAME = 'ca_santander_orden_deposito'
                 AND COLUMN_NAME = 'sod_monto') 
alter table ca_santander_orden_deposito add sod_monto     money
IF not EXISTS(SELECT *
          FROM   INFORMATION_SCHEMA.COLUMNS
          WHERE  TABLE_NAME = 'ca_santander_orden_deposito'
                 AND COLUMN_NAME = 'sod_cliente') 

alter table ca_santander_orden_deposito add sod_cliente   INT
IF not EXISTS(SELECT *
          FROM   INFORMATION_SCHEMA.COLUMNS
          WHERE  TABLE_NAME = 'ca_santander_orden_deposito'
                 AND COLUMN_NAME = 'sod_cuenta') 

alter table ca_santander_orden_deposito add sod_cuenta    cuenta

go

--------- autoriazacion de trn sp_santander_orden_dep_fallido -------

---
declare  @trn int

select @trn  = 77502

if exists(select 1 from cobis..cl_ttransaccion where tn_trn_code= @trn)
	delete cobis..cl_ttransaccion where tn_trn_code= @trn
	
if exists(select 1 from cobis..ad_procedure where pd_procedure = @trn)
	delete cobis..ad_procedure where pd_procedure = @trn
	
if exists(select 1 from cobis..ad_pro_transaccion where pt_transaccion = @trn)
	delete cobis..ad_pro_transaccion where pt_transaccion = @trn

if exists(select 1 from cobis..ad_tr_autorizada where ta_transaccion = @trn)
	delete cobis..ad_tr_autorizada where ta_transaccion = @trn

insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values(@trn,'sp_santander_orden_dep_fallido','cob_cartera','V',getdate(),'SOrdDepFall.sp')

insert into cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values
(@trn,'CONSULTA DE DISPERSIONES RECHAZADAS','CDDR','CONSULTA DE DISPERSIONES RECHAZADAS')

insert into cobis..ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion, pt_estado,pt_fecha_ult_mod,pt_procedure) values
(7,'R',0,@trn,'V',getdate(),@trn)


go

---
declare  @trn int

select @trn  = 77503

if exists(select 1 from cobis..cl_ttransaccion where tn_trn_code= @trn)
	delete cobis..cl_ttransaccion where tn_trn_code= @trn
	
if exists(select 1 from cobis..ad_procedure where pd_procedure = @trn)
	delete cobis..ad_procedure where pd_procedure = @trn
	
if exists(select 1 from cobis..ad_pro_transaccion where pt_transaccion = @trn)
	delete cobis..ad_pro_transaccion where pt_transaccion = @trn

if exists(select 1 from cobis..ad_tr_autorizada where ta_transaccion = @trn)
	delete cobis..ad_tr_autorizada where ta_transaccion = @trn

insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values(@trn,'sp_santander_orden_dep_fallido','cob_cartera','V',getdate(),'SOrdDepFall.sp')

insert into cobis..cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) values
(@trn,'ACCIONES PARA DISPERSIONES RECHAZADAS','APDR','ACCIONES PARA DISPERSIONES RECHAZADAS')

insert into cobis..ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion, pt_estado,pt_fecha_ult_mod,pt_procedure) values
(7,'R',0,@trn,'V',getdate(),@trn)


go

declare @w_rol tinyint,  
		@trn int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion like 'FUNCIONARIO OFICINA'
select @trn  = 77503

insert into cobis..ad_tr_autorizada values 
(7,'R',0 ,@trn,@w_rol,getdate(), 1 ,'V',getdate())

go

declare @w_rol tinyint,  
		@trn int

select @w_rol = ro_rol
from cobis..ad_rol
where ro_descripcion like 'FUNCIONARIO OFICINA'
select @trn  = 77502

insert into cobis..ad_tr_autorizada values 
(7,'R',0 ,@trn,@w_rol,getdate(), 1 ,'V',getdate())

go
--PARAMETRO DPDES

if not exists (select 1 from cobis..cl_parametro where pa_nemonico='DPDES' and pa_producto='CCA')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico,pa_tipo,pa_tinyint,pa_producto)
values('DIAS DE PROCESO PARA DESEMBOLSO','DPDES','T',15,'CCA')