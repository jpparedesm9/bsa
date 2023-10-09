--------------------------------------------------------------
-- CATALOGO DE PREGUNTAS - FORMULARIO KYC - AUTO-ONBOARDING --
--------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_preg_form_kyc_auto_onboard'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'PREGUNTAS - FORMULARIO KYC - AUTO-ONBOARDING')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'OPA','OCUPACION, PROFESION, ACTIVIDAD','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AEG','ACTIVIDAD ECONOMICA GENERICA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AEE','ACTIVIDAD ECONOMICA ESPECIFICA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'ORE','ORIGEN DE LOS RECURSOS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DRE','DESTINO DE LOS RECURSOS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'FEA','FIRMA ELECTRONICA AVANZADA','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'FPU','FUNCIONES PUBLICAS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TIN','TRANSFERENCIAS INTERNACIONALES','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'CVD','COMPRA VENTA DIVISAS','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNEN','TRANSFERENCIAS NACIONALES ENVIADAS NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNEM','TRANSFERENCIAS NACIONALES ENVIADAS MONTO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNRN','TRANSFERENCIAS NACIONALES RECIBIDAS NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'TNRM','TRANSFERENCIAS NACIONALES RECIBIDAS MONTO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DEN','DEPOSITOS EN EFECTIVO NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DEM','DEPOSITOS EN EFECTIVO MONTO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DNEN','DEPOSITOS NO EFECTIVO NUMERO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'DNEM','DEPOSITOS NO EFECTIVO MONTO','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go
