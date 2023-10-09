

print '-----------> cb_causa_anula'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_causa_anula')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_causa_anula'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_causa_anula'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_causa_anula', 'Causa de anulacion del comprobante')

insert into cl_catalogo values (@w_sig_tabla, '4', 'DOBLE CONTABILIZACION', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '3', 'COMPROBANTE EXTRAVIADO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '2', 'ORDEN SUPERIOR', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '1', 'IMPUTACIONES ERRONEAS', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_cpt_retencion'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_cpt_retencion')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_cpt_retencion'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_cpt_retencion'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_cpt_retencion', 'Conceptos de retencion')

insert into cl_catalogo values (@w_sig_tabla, '1', 'SALARIOS Y PAGOS LABORABLES', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '2', 'HONORARIOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '3', 'COMISIONES', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '4', 'SERVICIOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '5', 'ARRENDAMIENTOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '6', 'COMPRAS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '7', 'IMPUESTO DE TIMBRE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '8', 'OTROS', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_procesos_ficticios'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_procesos_ficticios')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_procesos_ficticios'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_procesos_ficticios'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_procesos_ficticios', 'Procesos Ficticios')

insert into cl_catalogo values (@w_sig_tabla, 'D', '6980', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'F', '6960', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'P', '6970', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_regimen_fiscal'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_regimen_fiscal')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_regimen_fiscal'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_regimen_fiscal'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_regimen_fiscal', 'Regimen Fiscal')

insert into cl_catalogo values (@w_sig_tabla, '00', 'REVERSION PRUEBA 01062006- NO USAR', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '000', 'PRUEBA 01062006-NO USAR', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0001', 'PERSONA NATURAL- MIGRACION-APLICAN TODOS LOS IMPUESTOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0002', 'PERSONA JURIDICA- MIGRACION- APLICAN TODOS LOS IMPUESTOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0003', 'PERSONA NATURAL', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0004', 'PERSONA NATURAL INSCRITA ANTE LA DIAN EN EL REGIMEN SIMPLIFICADO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0005', 'PERSONA NATURAL-RESPONSABLE DEL IVA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0006', 'PERSONA NATURAL-NACIONALIDAD EXTRANJERO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0021', 'PERSONA JURIDICA REGIMEN COMUN', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '009', 'PRUEBAS 22122005 11.19AM', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0046', 'USO EXCLUSIVO FIDUCIARIAS (CXP SI RETEFTE. AHO Y PLAZO FIIJO NO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0045', 'VIGILADAS SUPERFINANCIERA - DIFERENTES A FIDUCIAS (CXP Y AHORROS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0044', 'PER. JUR. GRAN CONTRIBUYENTE- VIGILADA POR LA SUPERBANCARIA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0043', 'PERSONA JURIDICA-REGIMEN COMUN-GRAN CONTRIBUYENTE-AUTORRETENEDOR', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0042', 'PERSONA JURIDICA-REGIMEN COMUN-GRAN CONTRIBUYENTE NO SUJETO DE R', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0041', 'PERSONA JURIDICA-REGIMEN COMUN-GRAN CONTRIBUYENTE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '003', 'PRUEBA 2 221205 11.19AM', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0026', 'PERSONA JURIDICA - USO EXCLUSIVO COOPERATIVAS (SOLO RETEFTE PLAZ', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0025', 'PERSONA JURIDICA - NACIONALIDAD EXTRANJERO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0024', 'PERSONA JURIDICA ENTIDAD NO CONTRIBUYENTE- ART 22- LOS DEL ART 1', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0023', 'PERSONA JURIDICA-REGIMEN COMUN-AUTORRETENEDOR DE RETENCION EN LA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0022', 'PERSONA JURIDICA-REGIMEN COMUN-NO SUJETO DE RETENCION EN LA FUEN', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_actividad'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_actividad')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_actividad'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_actividad'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_actividad', 'Actividad')

insert into cl_catalogo values (@w_sig_tabla, '1', 'SERVICIOS', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)
insert into cl_catalogo_pro values ('MIS',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_banco'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_banco')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_banco'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_banco'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_banco', 'Bancos')

insert into cl_catalogo values (@w_sig_tabla, '001', 'BANCO DE LA REPUBLICA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '002', 'BANCO DE BOGOTA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '003', 'BANCO DE OCCIDENTE', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_operacion_entidad'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_operacion_entidad')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_operacion_entidad'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_operacion_entidad'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_operacion_entidad', 'Asociacion de operaciones bancarias con contables')

insert into cl_catalogo values (@w_sig_tabla, '1', 'INVERSIONES', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '10', 'TRASPASOS COMPENSACION', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '11', 'CANJE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '12', 'DEPOSITOS JUDICIALES', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '13', 'REMUNERACION CANJE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '14', 'IMPUESTO GMF', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '15', 'COMISION E IVA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '16', 'REMESAS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '17', 'PAGOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '18', 'CARGOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '19', 'DEBITOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '2', 'TRASLADO DE SALDOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '20', 'INTERESES SOBREGIROS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '21', 'NOTAS DEBITO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '22', 'ABONOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '23', 'CONSIGNACION', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '24', 'CREDITOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '25', 'NOTAS CREDITOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '3', 'COMPRA-VENTA DIVISAS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '4', 'PROVISION', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '5', 'CENIT', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '6', 'REDESCUENTOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '7', 'ISS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '8', 'IMPUESTOS DIAN', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '9', 'CREDIBANCO VISA', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_tipo_impuesto'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_tipo_impuesto')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_tipo_impuesto'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_tipo_impuesto'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_tipo_impuesto', 'Tipo de Impuesto')

insert into cl_catalogo values (@w_sig_tabla, 'C', 'ICA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'E', 'ESTAMPILLAS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'I', 'IVA RETENIDO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'P', 'IVA PAGADO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'R', 'RETEFUENTE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'T', 'TIMBRE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'V', 'IVA COBRADO', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_concepto_iva'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_concepto_iva')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_concepto_iva'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_concepto_iva'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_concepto_iva', 'Parametrizacion de conceptos de iva para certificados')

insert into cl_catalogo values (@w_sig_tabla, '0200', '25350000200', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0320', '25550500320', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0325', '25550500325', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0330', '25550500330', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0335', '25550500335', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0340', '25550500340', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0355', '25550500336', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '0390', '25550500390', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '9999', '25550500320', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_declaraciones'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_declaraciones')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_declaraciones'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_declaraciones'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_declaraciones', 'declaraciones de impuestos')

insert into cl_catalogo values (@w_sig_tabla, '01', 'DECLARACION DE RETENCION INDUSTRIA Y COMERCIO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '02', 'DECLARACION DE INDUSTRIA Y COMERCIO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '03', 'DECLARACION DEPARTAMENTAL DE ESTAMPILLAS', 'V', null, null, null)


update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_calbomberil'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_calbomberil')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_calbomberil'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_calbomberil'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_calbomberil', 'Calculo de impuesto bomberil')

insert into cl_catalogo values (@w_sig_tabla, '01', 'SOBRE ICA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '02', 'SOBRE ICA MAS TABLEROS', 'V', null, null, null)


update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_unidad_indicador'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_unidad_indicador')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_unidad_indicador'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_unidad_indicador'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_unidad_indicador', 'unidades de indicadores tributarios')

insert into cl_catalogo values (@w_sig_tabla, '01', '%', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '02', '$', 'V', null, null, null)


update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_conc_movimipro'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_conc_movimipro')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_conc_movimipro'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_conc_movimipro'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_conc_movimipro', 'concepto movimiento provisiones')

insert into cl_catalogo values (@w_sig_tabla, '01', 'Causacion de provision', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '02', 'Revision provisi¢n por exceso', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '03', 'Pago con cargo a provision', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '04', 'Reclasificacion de provisiones', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '05', 'Reintegro provision anios anteriores', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '06', 'Ajuste de causacion de provision por defecto', 'V', null, null, null)


update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_decl_pago_ret'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_decl_pago_ret')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_decl_pago_ret'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_decl_pago_ret'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_decl_pago_ret', 'DECLARACIONES PAGO DE RETENCION')

insert into cl_catalogo values (@w_sig_tabla, '01', 'DECLARACION DE RETENCION DE ICA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, '03', 'DECLARACION DE RETENCION DE ESTAMPILLAS', 'V', null, null, null)


update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_valores_conc'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_valores_conc')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_valores_conc'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_valores_conc'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_valores_conc', 'valores para conciliacion')

insert into cl_catalogo values (@w_sig_tabla, 'C', 'NOTAS CREDITO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'C_INT', 'CREDITOS RENDIMIENTOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D', 'NOTAS DEBITO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_CCH', 'CARGO CHEQUERAS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_COM', 'DEBITO COMISION', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_GMF', 'DEBITO GRAVAMEN MOVIMIENTO FINANCIERO', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_INT', 'DEBITO INTERESES', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_IVA', 'DEBITO IVA', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_RET', 'DEBITO RETENCION', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D_TRA', 'DEBITO TRASLADO ELECTRONICO DE SALDOS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'P', 'PAGOS EN CHEQUE', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'Q', 'CONSIGNACIONES', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_interfaz'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_interfaz')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_interfaz'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_interfaz'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_interfaz', 'CATALOGO DE INTERFACES')

insert into cl_catalogo values (@w_sig_tabla, 'B', 'BANCOR', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'D', 'DYNAMICS', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'F', 'PAFIN', 'V', null, null, null)
insert into cl_catalogo values (@w_sig_tabla, 'P', 'PEOPLENET', 'V', null, null, null)

insert into cl_catalogo_pro values ('CON',@w_sig_tabla)

update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go


print '-----------> cb_productos_cb'
use cobis
go

set nocount on
go

declare @w_sig_tabla int

if exists (select 1 from cobis..cl_tabla where tabla = 'cb_productos_cb')
begin
	set @w_sig_tabla = 0
	select @w_sig_tabla = codigo from cobis..cl_tabla where tabla = 'cb_productos_cb'

	delete from cobis..cl_tabla where codigo = @w_sig_tabla
	delete from cobis..cl_catalogo where tabla = @w_sig_tabla
	delete from cobis..cl_catalogo_pro where cp_tabla = @w_sig_tabla
	delete from cobis..cl_seqnos where tabla = 'cb_productos_cb'
end
else
begin
	select @w_sig_tabla = max(codigo) + 1 from cobis..cl_tabla
end

insert into cl_tabla values (@w_sig_tabla, 'cb_productos_cb', 'PRODUCTOS COBIS')

insert into cl_catalogo values (@w_sig_tabla, '7', 'CARTERA', 'V', null, null, null)


update cl_seqnos set siguiente = @w_sig_tabla where tabla = 'cl_tabla'
go
