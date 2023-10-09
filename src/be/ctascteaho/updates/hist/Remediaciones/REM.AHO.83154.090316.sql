



/*************************************************/
-- No Bug: Bug 83154
-- Título de la BUG: No permite crear cuentas con clientes registrados en la tabla refinh - FUN
-- Fecha: 03/Sept/2016
-- Descripción del la Historia: N/A
-- Descripción de la Solución: Se inserta catalogo faltantes 'cl_mreqv', 'cl_mrmsg'
-- Autor: Walther Toledo
/*************************************************/



use cobis
go

/*************/
/*   TABLA   */
/*************/

-- \Clientes\Backend\sql\cl_insnv.sql
delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cl_mreqv', 'cl_mrmsg')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cl_mreqv', 'cl_mrmsg')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cl_mreqv', 'cl_mrmsg')
go
----------------------------------------------------------
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
-------------------------------------------------

select @w_codigo= @w_codigo + 1 

print 'Equivalencia Mensaje malas referencias'
insert into cl_tabla values (@w_codigo, 'cl_mreqv', 'Equivalencia Mensaje malas referencias')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '000', '003','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '002', '007','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '003', '007','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '004', '010','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '007', '001','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '008', '001','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '009', '002','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '011', '009','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '019', '004','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '020', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '021', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '022', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '023', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '024', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '025', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '026', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '027', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '028', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '029', '006','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '030', '005','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '031', '004','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '999', '008','V')

-------------------------------------------------
select @w_codigo = @w_codigo + 1

print 'Mensaje malas referencias'
insert into cl_tabla values (@w_codigo, 'cl_mrmsg', 'Mensaje malas referencias')
insert into cl_catalogo_pro values ('MIS', @w_codigo)
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '001', 'FAVOR COMUNICARSE CON SARLAFT','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '002', 'CLIENTE EN EVALUACION, FAVOR COMUNICARSE CON SARLAFT','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '003', 'LISTA NO ESTABLECIDA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '004', 'CLIENTE NO OBJETIVO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '005', 'CLIENTE REQUIERE AUTORIZACION - CONSULTE AL DIRECTOR DE OFICINA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '006', 'CLIENTE PEP - SOLICITAR AUTORIZACION','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '007', 'ESTADO DOCUMENTO CON PROBLEMAS','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '008', 'CLIENTE CON MALAS REFERENCIAS DE MERCADO','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '009', 'OBJETIVO A VERIFICAR POR SEGURIDAD BANCARIA','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '010', 'CLIENTE EN COBRO JURIDICO COMUNICARSE A SEGUIM Y RECUP','V')


update cl_seqnos 
   set siguiente = @w_codigo 
 where tabla = 'cl_tabla'   

go

-- Para depurar Data de Pruebas, no debe estar en el instalador
UPDATE cobis..cl_refinh SET in_origen = '002'

GO
