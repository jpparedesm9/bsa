/* ************************************************************************* */
--                  Historia: 81047
--            Título del Bug: Mantenimiento de Catálogos en Cuentas de Ahorros
--                     Fecha: 15/Agosto/2016
--                     Autor: Ignacio Yupa
/* ************************************************************************* */
use cobis
go

Declare @w_codigo int
select @w_codigo = codigo
  from cl_tabla 
 where tabla = 're_tipo_trn'
 
Delete cl_catalogo_pro where cp_producto = 'AHO' and cp_tabla = @w_codigo
Delete cl_catalogo where tabla = @w_codigo
Delete cl_tabla where codigo = @w_codigo

select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'
 
insert into cl_tabla (codigo, tabla, descripcion) values(@w_codigo,'re_tipo_trn','Tipo de Transacciones')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'CAU', 'CAUSACION DE INTERESES', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'CES', 'CAMBIO DE ESTADO', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'CIE', 'CIERRE DE CUENTA', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'DEP', 'DEPOSITO ', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'DEVREM', 'DEVOLUCION DE REMESAS', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'NCR', 'NOTA DE CREDITO', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'NDE', 'NOTA DE DEBITO', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'RET', 'RETIRO', 'V')
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'TRS', 'TRANSFERENCIAS', 'V')
go