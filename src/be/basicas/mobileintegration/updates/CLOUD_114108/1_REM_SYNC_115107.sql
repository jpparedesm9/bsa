use cobis
go


----------------------------------------------------------------
------------              SERVICIOS                  -----------
----------------------------------------------------------------
declare 
@w_rol         int, 
@w_producto    int,
@w_moneda      int,
@w_siguiente   int

declare @w_rol_table    table (
   rol_id               int,
   rol_name             varchar(50)
)

insert into @w_rol_table
select ro_rol, ro_descripcion
from ad_rol
where ro_descripcion in (
'ADMINISTRADOR',
'OPERADOR DE BATCH COBIS',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'OPERADOR SOFOME',
'ASESOR MOVIL',
'PERFIL DE OPERACIONES',
'MESA DE OPERACIONES')

SELECT @w_producto = pd_producto
FROM cobis..cl_producto 
WHERE pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select @w_moneda = 0

--CATALOGO TIPOS DE DOCUMENTOS
delete from cobis..cts_serv_catalog where csc_service_id='MobileManagement.MobileManagement.SearchMobileByFilter'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('MobileManagement.MobileManagement.SearchMobileByFilter','cobiscorp.ecobis.mobilemanagement.service.IMobileManagement','searchMobileByFilter','Consulta dispositivos móviles por filtro',1717)

delete from ad_servicio_autorizado where ts_servicio = 'MobileManagement.MobileManagement.SearchMobileByFilter' and ts_rol in (select rol_id from @w_rol_table)
insert into ad_servicio_autorizado
select 
'MobileManagement.MobileManagement.SearchMobileByFilter',
rol_id,
@w_producto, 
'R', 
@w_moneda, 
getdate(), 
'V',
 getdate()
from @w_rol_table

delete from ad_procedure where pd_procedure = 1717
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (1717,'sp_sincroniza_mobil','cob_credito','V',getdate(),'')

delete cl_ttransaccion where tn_trn_code = 1717
insert into dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (1717, 'CONSULTAR DISPOSITIVOS MÓVILES POR FILTRO', '1717', 'CONSULTAR DISPOSITIVOS MÓVILES POR FILTRO')

delete ad_pro_transaccion where pt_transaccion = 1717
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,1717,'V',getdate(),1717)

delete ad_tr_autorizada where ta_transaccion = 1717 and ta_rol in (select rol_id from @w_rol_table)
insert into ad_tr_autorizada 
select @w_producto, 
'R',
@w_moneda, 
1717, 
rol_id, 
getdate(), 
1, 
'V', 
getdate()
from @w_rol_table

--Secuencial Sincronización
select @w_siguiente = max(si_secuencial)
from cob_sincroniza..si_sincroniza

select @w_siguiente = isnull(@w_siguiente, 1)

DELETE cl_seqnos WHERE bdatos = 'cob_sincroniza' AND tabla = 'si_sincroniza'
insert into cl_seqnos (bdatos, tabla, siguiente, pkey)
values ('cob_sincroniza', 'si_sincroniza', @w_siguiente, 'si_secuencial')


--Parámetros Generales
delete from cl_parametro where pa_nemonico in ('ETACGR', 'ETARVI')
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA APLICAR CUESTIONARIO - GRUPAL', 'ETACGR', 'C', 'APLICAR CUESTIONARIO - GRUPAL', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA REVISAR Y VALIDAR INFORMACIÓN', 'ETARVI', 'C', 'REVISAR Y VALIDAR INFORMACIÓN', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

--Errores
delete from cl_errores where numero in (103192, 103193, 103194)
insert into cobis..cl_errores (numero, severidad, mensaje)
values (103192, 1, 'Error el Parámetro NOMBRE DE LA ETAPA INGRESO DE SOLICITUD no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103193, 1, 'Error el Parámetro NOMBRE DE LA ETAPA APLICAR CUESTIONARIO - GRUPAL no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103194, 1, 'Error el Parámetro NOMBRE DE LA ETAPA REVISAR Y VALIDAR INFORMACIÓN no existe')

go

use cob_sincroniza
go

ALTER TABLE  si_sincroniza
ADD UNIQUE (si_secuencial)

go