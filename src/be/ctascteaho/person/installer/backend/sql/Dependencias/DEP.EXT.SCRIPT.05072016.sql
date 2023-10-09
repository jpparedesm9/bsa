use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('pe_aut_trn_caja')
  and codigo = cp_tabla
 go
 
 delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('pe_aut_trn_caja')
 and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where cl_tabla.tabla in ('pe_aut_trn_caja')
 go
 
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
print 'AUTORIZACION DE TRANSACCIONES POR CAJA'
insert into cl_tabla values (@w_codigo, 'pe_aut_trn_caja', 'AUTORIZACION DE TRANSACCIONES POR CAJA')
insert into cl_catalogo_pro values ('PER', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '237', 'DEBITO TRANSF. DE AHO A AHO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '2519', 'TRANSFERENCIA ENTRE CUENTAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '252', 'DEPOSITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '253', 'NOTA DE CREDITO DE AHORROS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '263', 'RETIRO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '264', 'NOTA DE DEBITO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '300', 'CREDITO TRANSF. DE CTE A CTE','V')


select @w_codigo = @w_codigo + 1


update cl_seqnos set siguiente = @w_codigo
where tabla='cl_tabla'
go



delete cl_ttransaccion where tn_trn_code =728
insert into cl_ttransaccion values(728, 'INSERCION DE AUTORIZACION DE TRANSACCIONES DE CAJA',  'IATC', 'ICREACION DE AUTORIZACION DE TRANSACCIONES DE CAJA')
delete cl_ttransaccion where tn_trn_code =729
insert into cl_ttransaccion values(729, 'MODIFICION DE AUTORIZACION DE TRANSACCIONES DE CAJA', 'MATC', 'MODIFICACION DE AUTORIZACION DE TRANSACCIONES DE CAJA')
delete cl_ttransaccion where tn_trn_code =730
insert into cl_ttransaccion values(730, 'CONSULTA DE AUTORIZACION DE TRANSACCIONES DE CAJA',   'SATC', 'CONSULTA DE AUTORIZACION DE TRANSACCIONES DE CAJA')
delete cl_ttransaccion where tn_trn_code =731
insert into cl_ttransaccion values(731, 'CATALOGO DE AUTORIZACION DE TRANSACCIONES DE CAJA',   'CATC', 'CATALOGO DE AUTORIZACION DE TRANSACCIONES DE CAJA')
go

delete FROM ad_pro_transaccion WHERE pt_transaccion=728 and pt_producto=17
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(17,'R',0,728,'V',getdate(),714)
delete FROM ad_pro_transaccion WHERE pt_transaccion=729 and pt_producto=17 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) values(17,'R',0,729,'V',getdate(),714)
go