use cobis
go

------------------------------------------------------------------------
----------------------          ELAVON           -----------------------
------------------------------------------------------------------------

---------------------------- SERVICIOS ---------------------------------
DECLARE @w_rol int, @w_producto int

SELECT @w_producto = 7 -- select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

delete cts_serv_catalog where csc_service_id in ('BusinessToBusiness.OperationManagement.SearchOperations', 'BusinessToBusiness.PaymentManagement.ApplyPayment', 'BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName')

--Buscar Y Consultar Operaciones
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', 'cobiscorp.ecobis.businesstobusiness.service.IOperationManagement', 'searchOperations', 'Buscar operaciones por cliente y tipo de cliente', 0, NULL, NULL, NULL)

--Aplicar Pago
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', 'cobiscorp.ecobis.businesstobusiness.service.IPaymentManagement', 'applyPayment', 'Aplicar pago: PG,PI,GL, CI o CG', 0, NULL, NULL, NULL)

--Buscar Cliente/Grupo por nombre
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', 'cobiscorp.ecobis.businesstobusiness.service.IQueryCustomerGroup', 'searchCustomerGroupByName', 'Consultar cliente o grupo por nombre parcial/total y tipo', 0, NULL, NULL, NULL)

delete ad_servicio_autorizado where ts_servicio IN ('BusinessToBusiness.OperationManagement.SearchOperations', 'BusinessToBusiness.PaymentManagement.ApplyPayment', 'BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName')

select @w_rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ADMINISTRADOR'

if @@rowcount <> 0 and @w_rol is not null begin
   --Buscar y consultar operaciones con su detalle
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Aplicar Pago
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Buscar Cliente/Grupo por nombre
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end

select @w_rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ASESOR'

if @@rowcount <> 0 and @w_rol is not null begin
   --Buscar y consultar operaciones con su detalle
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Aplicar Pago
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Buscar Cliente/Grupo por nombre
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
end 

select @w_rol = ro_rol 
from cobis..ad_rol
where ro_descripcion = 'ASESOR MOVIL'

if @@rowcount <> 0 and @w_rol is not null begin

   --Buscar y consultar operaciones con su detalle
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.OperationManagement.SearchOperations', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Aplicar Pago
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.PaymentManagement.ApplyPayment', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
   --Buscar Cliente/Grupo por nombre
   INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
   VALUES ('BusinessToBusiness.QueryCustomerGroup.SearchCustomerGroupByName', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


end
go

----------------------------  ERRORES  ---------------------------------
delete cl_errores where numero in (103200,103201,103202,103203, 70320,70321,70322,70323,70324)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103200, 1, 'Tipo no coincide para un Cliente o Grupo.')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (103201, 1, 'El criterio de búsqueda debe tener mínimo 5 caracteres.')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (103202, 1,'No se encontraron coincidencias para el criterio de búsqueda.')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (103203, 1,'Error el Parámetro DIAS MAXIMO PARA PRECANCELACION no existe')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (70320, 1, 'No existen préstamos asociados a la operación grupal.')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (70321, 1, 'No existe operación para el préstamo ingresado.')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (70322, 1, 'No existe garantía líquida para el trámite ingresado.')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (70323, 1, 'AVISO: Este grupo/persona no tiene cuentas pendientes de cobro')
insert into cobis..cl_errores (numero, severidad, mensaje)
values (70324, 1, 'ERROR: Ocurrió un error al consultar las operaciones del grupo/persona')


-------------------------- PARAMETROS ------------------------------------
delete cl_parametro where pa_nemonico in ('ELACOM','ELABRN', 'ELACON', 'ELAUSR','ELAPWD', 'ELAURL', 'ELAEMA')
--ELAVON
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON COMPANY','ELACOM', 'C', '9249', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON BRANCH', 'ELABRN', 'C', '0135', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON COUNTRY','ELACON', 'C', 'MEX', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON USER',   'ELAUSR', 'C', '9249IIUS0', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON PASSWORD','ELAPWD', 'C', 'CJL79AD6NR', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON URL','ELAURL', 'C', 'https://qa10.mitec.com.mx', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON BUSINESS EMAIL','ELAEMA', 'C', 'test@test.com', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go

--------------------------- CORRESPONSAL  --------------------------
use cob_cartera
go


if not exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'co_tiempo_aplicacion_pag_rev'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal')) begin
   ALTER TABLE ca_corresponsal
   ADD co_tiempo_aplicacion_pag_rev INT null 
end

if exists (SELECT 1 
               FROM sys.columns 
               WHERE Name = 'co_trn_id_corresp'
               AND Object_ID = Object_ID('cob_cartera..ca_corresponsal_trn')) begin
   ALTER TABLE ca_corresponsal_trn
   ALTER column co_trn_id_corresp varchar(25) null 
end

go

declare
@w_co_id                 int,
@w_ctr_id                int

UPDATE ca_corresponsal 
set co_tiempo_aplicacion_pag_rev = 5
WHERE co_nombre <> 'OXXO'

select @w_co_id = co_id from ca_corresponsal where co_nombre = 'ELAVON'
if @w_co_id  is not null begin
   delete ca_corresponsal_tipo_ref WHERE ctr_co_id = @w_co_id
   delete ca_corresponsal where co_id = @w_co_id
end

select @w_co_id = max(co_id) from ca_corresponsal
select @w_co_id = isnull(@w_co_id,0) +1

INSERT INTO ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
VALUES (convert(varchar(10),@w_co_id) , 'ELAVON', 'ELAVON', NULL, 'cob_cartera..sp_santander_gen_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)


select @w_ctr_id = max(ctr_id) from ca_corresponsal_tipo_ref
select @w_ctr_id = isnull(@w_ctr_id,0) + 1
INSERT INTO  ca_corresponsal_tipo_ref(ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (@w_ctr_id, '00', 'GL', 'GARANTIA LIQUIDA', convert(varchar(10),@w_co_id) , '9742')

select @w_ctr_id = isnull(@w_ctr_id,0) + 1
INSERT INTO ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (@w_ctr_id, '20', 'PG', 'PAGO DE CREDITO GRUPAL', convert(varchar(10),@w_co_id) , '9744')

select @w_ctr_id = isnull(@w_ctr_id,0) + 1
INSERT INTO ca_corresponsal_tipo_ref  (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (@w_ctr_id, '02', 'CG', 'PAGO PARA CANCELACION DE CREDITO GRUPAL', convert(varchar(10),@w_co_id) , '9744')

select @w_ctr_id = isnull(@w_ctr_id,0) + 1
INSERT INTO ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (@w_ctr_id, '03', 'PI', 'PAGO DE CREDITO INDIVIDUAL REVOLVENTE', convert(varchar(10),@w_co_id) , '9744')

select @w_ctr_id = isnull(@w_ctr_id,0) + 1
INSERT INTO ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
VALUES (@w_ctr_id, '04', 'CI', 'PAGO PARA CANCELACION DE CREDITO INDIVIDUAL REVOLVENTE', convert(varchar(10),@w_co_id) , '9742')

--Referencias Garantias Liquidas: ca_infogaragrupo_det
IF OBJECT_ID ('dbo.ca_infogaragrupo_det') IS NOT NULL
    DROP TABLE dbo.ca_infogaragrupo_det
GO

create table ca_infogaragrupo_det(
   ind_grupo_id              int not null FOREIGN KEY REFERENCES ca_infogaragrupo(in_grupo_id),
   ind_corresponsal          varchar(10) not null,
   ind_institucion           varchar(20) not null,
   ind_referencia            varchar(40) not null,
   ind_convenio              varchar(30) null,
   CONSTRAINT pk_ca_infogaragrupo_det PRIMARY KEY (ind_referencia, ind_corresponsal)
)
go
GO