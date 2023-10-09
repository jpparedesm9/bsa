use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cc_concepto_emision')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cc_concepto_emision')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cc_concepto_emision')
go
----------------------------------------------------------------------------------------------

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'
 
select @w_codigo = @w_codigo + 1

insert into cl_tabla values (@w_codigo,'cc_concepto_emision', 'Conceptos de Emision Cheques')
insert into cl_catalogo_pro values ('CTE', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '000','VENTA O REPOSICION CHQ DESDE S. BANCARIOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '001','PAGO COMPRAS PAPELERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '002','PAGO COMPRAS UTILERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '003','PAGO COMPRAS ELEMENTOS DE ASEO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '004','PAGO COMPRAS ELEMENTOS DE CAFETERIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '005','PAGO COMPRAS ELEMENTOS TECNOLOGIA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '006','PAGO COMPRAS MISCELANEOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '007','PAGO ANTICIPO CONTRATOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '008','PAGO ANTICIPOS PERSONAL','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '009','PAGO SERVICIOS PUBLICOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '010','PAGO ARRENDAMIENTOS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '011','PAGO CAJA MENOR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '021','LIQUIDACION DE VACACIONES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '022','LIQUIDACION DE CONTRATO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '023','LIQUIDACION DE CESANTIAS PARCIALES','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '024','NOMINA 1A. QUINCENA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '025','NOMINA 2A. QUINCENA','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '026','PRIMA DE JUNIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '027','PRIMA DE DICIEMBRE','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '028','LIQUIDACION DE BONIFICACION','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '041','DESEMBOLSO DE CREDITO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '042','PAGO INTERES DPF','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '043','PAGO CAPITAL DPF','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '044','DECREMENTO RENOVACION DPF','V')

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

go
