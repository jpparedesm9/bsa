 --Cambios iniciales subido en Changeset 218824 successfully checked in.
/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S132610 Nuevos Formatos a Imprimir
--Descripción del Problema   : Se crea el reporte de pagaré para individual y grupal mismo formato a diferencia de la parte 
--                             de aval donde en el grupal se deben en listarse los otros integrantes del grupo.
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_services_authorization.sql

use cobis
go

declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

print 'registro de PaymentDetail'
    if not exists (select 1 from ad_servicio_autorizado where 
        ts_servicio = 'LoanGroup.ReportMaintenance.PaymentDetail'  and ts_rol = @w_rol and ts_moneda = @w_moneda)
    insert into ad_servicio_autorizado values ('LoanGroup.ReportMaintenance.PaymentDetail', @w_rol, @w_producto, 'R', 
    @w_moneda, getdate(), 'V', getdate() )
	
	if not exists (select 1 from cts_serv_catalog where csc_service_id = 'LoanGroup.ReportMaintenance.PaymentDetail')
    insert into cts_serv_catalog 
    (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
    values ('LoanGroup.ReportMaintenance.PaymentDetail','cobiscorp.ecobis.loangroup.service.IReportMaintenance','paymentDetail', '',0, null, null, null)
		
--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_segur.sql
use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 74668
select @w_producto = 7
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_reportes','cob_cartera','V',getdate(),'sp_reportes.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'CONSULTAS PARA REPORTES', convert(varchar,@w_numero), 'CONSULTAS PARA REPORTES')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
go

--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql

PRINT '--->> Registro de catalogos-cr_dividendo_report'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_dividendo_report'

if isnull(@w_tabla,0) = 0
BEGIN
 PRINT 'va a crear tabla'
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_dividendo_report', 'FRECUENCIA REPORTES')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'D', 'DIARIOS', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'ANUALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'M', 'MENSUALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'T', 'TRIMESTRALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'S', 'SEMESTRALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'BIMESTRALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'W', 'SEMANALES', 'V' )
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'Q', 'QUINCENALES', 'V' )

go

